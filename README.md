# Implementación de Soluciones DevOps

## Descripción del Proyecto

Este proyecto está diseñado para aplicar los principios de DevOps mediante la implementación de infraestructura como código (IaC) con Terraform, la automatización de despliegues con GitHub Actions.

## Requisitos Previos

1. **Terraform** (v1.5.0 o superior) instalado en tu sistema.
2. **AWS CLI** configurado con credenciales válidas.
3. Un **bucket S3** ya creado para almacenar el archivo de estado remoto de Terraform.
4. Configuración de los siguientes secretos en el repositorio de GitHub:

   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `SNYK_TOKEN`

## Configuración Inicial

### Creación DynamoDB

Terraform utiliza una tabla DynamoDB para gestionar los bloqueos del estado remoto, garantizando que múltiples ejecuciones no modifiquen el estado al mismo tiempo. Asegúrate de que la tabla DynamoDB esté configurada correctamente antes de ejecutar los workflows.

 **Configuración de la Tabla DynamoDB**
   
   - Crea manualmente una tabla DynamoDB con las siguientes características:
     - **Nombre:** `terraform-lock` (o el nombre que definas en tu archivo `main.tf`).
     - **Clave de Partición:** `LockID` (tipo `String`).
   - Asegúrate de que la tabla se encuentre en la misma región que el bucket S3 configurado.

### Creación S3

Terraform utiliza un bucket S3 para almacenar el estado remoto de la infraestructura, lo que permite la colaboración y el control de versiones en equipos. Antes de ejecutar cualquier workflow, es necesario crear manualmente este bucket y configurar las políticas de acceso adecuadas.
     
### Cambios en `terraform.tfvars`

Antes de ejecutar cualquier comando de Terraform, actualiza las variables en el archivo `terraform.tfvars`:

```hcl
bucket_name = "mi-terraform-state-bucket1" # Nombre del bucket S3 creado
region = "us-east-1"                      # Región del bucket
key = "state/terraform.tfstate"           # Ruta del archivo de estado
dynamodb_table = "terraform-lock"  # Nombre de la tabla DynamoDB
```
     
### Ajustes en los Archivos de Workflow

Los workflows de GitHub Actions dependen del DynamoDB, bucket S3 configurado para almacenar el archivo de estado remoto de Terraform y del repositorio de imágenes Docker en ECR. Antes de ejecutar cualquier flujo de trabajo, asegúrate de ajustar las variables 

1. **Workflow `terraform.yml`**
   
   `S3`: Cambia `mi-terraform-state-bucket1` y `us-east-1` por los valores específicos de tu bucket.
   
   ```hcl
     run: |
       terraform init -backend-config="bucket=mi-terraform-state-bucket1" -backend-config="key=state/terraform.tfstate" -backend-config="region=us-east-1" -reconfigure
     ```
    `DynamoDB`: El flujo de trabajo `terraform.yml` ya considera automáticamente el uso de la tabla DynamoDB configurada en el backend. No necesitas realizar ajustes adicionales, pero asegúrate de que la        tabla esté creada antes de ejecutar el workflow.

3. **Workflow `docker-image-scan.yml`**
   
   Cambia `202533506302.dkr.ecr.us-east-1.amazonaws.com/mi-app-web` por tu repositorio ECR.

     ```hcl
     run: |
       docker pull 202533506302.dkr.ecr.us-east-1.amazonaws.com/mi-app-web:latest
     ```

5. **Workflow `snyk-scan.yml`**

    No es necesario ajustar directamente el bucket aquí, pero asegúrate de que el archivo de infraestructura que se escaneará (`main.tf` en la carpeta `Terraform`) esté correctamente configurado.

### Recomendaciones

- Si el bucket S3 aún no está creado, configúralo manualmente antes de ejecutar los workflows.
- Mantén las claves y tokens necesarios como secretos en el repositorio de GitHub para una configuración segura.

Con estos ajustes realizados, tus workflows estarán correctamente vinculados al bucket y al repositorio de imágenes, garantizando que las ejecuciones se lleven a cabo sin problemas.

## Estructura del Proyecto
```hcl
terraform-github-aws-devops/
│
├── .github/workflows/
│   ├── terraform.yml        # Workflow para despliegue y destrucción de infraestructura.
│   ├── snyk-scan.yml        # Workflow para escaneo de seguridad con Snyk.
│   ├── docker-image-scan.yml # Workflow para escaneo de imágenes Docker.
│
├── Terraform/
│   ├── modules/
│   │   ├── vpc/             # Configuración modular para la VPC.
│   │   ├── ec2/             # Configuración modular para EC2.
│   │   ├── lambda_sqs_sns/  # Configuración modular para Lambda, SQS y SNS.
│   │   ├── cloudwatch/      # Configuración modular para CloudWatch.
│   │
│   ├── main.tf              # Archivo principal para la infraestructura.
│   ├── variables.tf         # Variables globales de la infraestructura.
│   ├── outputs.tf           # Salidas de la infraestructura.
│   ├── terraform.tfvars     # Valores específicos del entorno.
│   ├── resources/
│       ├── bootstrap.sh     # Script para inicializar instancias EC2.
│       ├── lambda_function.zip # Código comprimido para funciones Lambda.
│
└── README.md                # Documentación del proyecto.
``` 

## Flujo de Trabajo con GitHub Actions

### Workflows Configurados

 - Terraform Workflow (terraform.yml): Permite ejecutar init, plan, apply, y destroy directamente desde GitHub Actions.

 - Snyk Scan Workflow (snyk-scan.yml): Realiza análisis de seguridad en archivos Terraform.

 - Docker Image Scan Workflow (docker-image-scan.yml): Escanea imágenes Docker almacenadas en Amazon ECR.

## Ejecución

### Despliegue de Infraestructura:

- Selecciona el workflow terraform.yml en la pestaña Actions.
- Elige la opción all para ejecutar init, plan, y apply en conjunto.

### Escaneo de Seguridad:

- Selecciona el workflow snyk-scan.yml para escanear archivos Terraform.
- Selecciona el workflow docker-image-scan.yml para escanear imágenes Docker.
  
### Destrucción de Infraestructura:

- Selecciona el workflow terraform.yml y elige la opción destroy.
  
## Recomendaciones Finales

- Seguridad del Bucket S3: Asegúrate de que el bucket utilizado para almacenar el estado remoto de Terraform tenga políticas de acceso restringidas.

- Pruebas en Entornos Aislados: Antes de desplegar en producción, prueba la infraestructura en un entorno de desarrollo.

- Revisiones de Código: Realiza revisiones de los cambios en GitHub antes de ejecutar los workflows.
