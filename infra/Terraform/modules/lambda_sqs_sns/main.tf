# Subir el archivo ZIP de Lambda al bucket S3
resource "aws_s3_object" "lambda_zip" {
  bucket = var.terraform_bucket_name            # Usar el bucket de Terraform
  key    = "lambda/${var.lambda_zip_file_name}" # Guardar en un subdirectorio llamado "lambda"
  source = "${path.root}/resources/${var.lambda_zip_file_name}" # Ruta local al archivo ZIP
  etag   = filemd5("${path.root}/resources/${var.lambda_zip_file_name}") # Verificar hash del archivo

  tags = {
    Environment = var.environment
    Name        = "LambdaCode"
  }
}

# Crear el tema SNS con encriptación
resource "aws_sns_topic" "sns_topic" {
  name              = var.sns_topic_name
  kms_master_key_id = "alias/aws/sns"

  tags = {
    Environment = var.environment
    Name        = var.sns_topic_name
  }
}

# Crear la cola SQS con encriptación
resource "aws_sqs_queue" "sqs_queue" {
  name                      = var.sqs_queue_name
  kms_master_key_id         = "alias/aws/sqs"
  message_retention_seconds = 1209600  # 14 días

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq_queue.arn
    maxReceiveCount     = 5
  })

  tags = {
    Environment = var.environment
    Name        = var.sqs_queue_name
  }
}

# Crear la cola SQS Dead Letter (DLQ) con encriptación
resource "aws_sqs_queue" "dlq_queue" {
  name              = "${var.sqs_queue_name}-dlq"
  kms_master_key_id = "alias/aws/sqs"

  tags = {
    Environment = var.environment
    Name        = "${var.sqs_queue_name}-dlq"
  }
}

# Crear la función Lambda
resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_name
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler
  role          = aws_iam_role.lambda_role.arn

  # Usar el archivo desde S3
  s3_bucket = var.terraform_bucket_name
  s3_key    = "lambda/${var.lambda_zip_file_name}"

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.sqs_queue.id
      SNS_TOPIC_ARN = aws_sns_topic.sns_topic.arn
    }
  }

  timeout      = var.lambda_timeout
  memory_size  = var.lambda_memory
}

# Asociar Lambda con la cola SQS
resource "aws_lambda_event_source_mapping" "lambda_to_sqs" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  function_name    = aws_lambda_function.lambda_function.arn
}

# Configurar SNS como destino para la función Lambda
resource "aws_lambda_function_event_invoke_config" "sns_destination" {
  function_name = aws_lambda_function.lambda_function.function_name

  destination_config {
    on_success {
      destination = aws_sns_topic.sns_topic.arn
    }
    on_failure {
      destination = aws_sns_topic.sns_topic.arn
    }
  }

  maximum_retry_attempts      = 2
  maximum_event_age_in_seconds = 60
}

# Crear el rol para Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Asociar políticas al rol de Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "${var.lambda_name}_policy"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_name}:*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = [
          aws_sqs_queue.sqs_queue.arn,
          aws_sqs_queue.dlq_queue.arn
        ]
      },
      {
        Effect   = "Allow",
        Action   = "sns:Publish",
        Resource = aws_sns_topic.sns_topic.arn
      },
      {
        Effect   = "Allow",
        Action   = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
      }
    ]
  })
}

# Data source para obtener el ID de la cuenta
data "aws_caller_identity" "current" {}
