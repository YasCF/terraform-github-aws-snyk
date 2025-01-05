# Implementación de Soluciones DevOps

## Descripción del Proyecto

Este proyecto está diseñado para aplicar los principios de DevOps mediante la implementación de infraestructura como código (IaC) con Terraform, la automatización de despliegues con GitHub Actions, escaneo de seguridad, y configuración de contenedores Docker.

## Requisitos Previos

1. **Terraform** (v1.5.0 o superior) instalado en tu sistema.
2. **AWS CLI** configurado con credenciales válidas.
3. Un **bucket S3** ya creado para almacenar el archivo de estado remoto de Terraform.
4. Configuración de los siguientes secretos en el repositorio de GitHub:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `SNYK_TOKEN`

## Configuración Inicial

### Cambios en `terraform.tfvars`

Antes de ejecutar cualquier comando de Terraform, actualiza las variables en el archivo `terraform.tfvars`:

```hcl
bucket_name = "mi-terraform-state-bucket1" # Nombre del bucket S3 creado
region = "us-east-1"                      # Región del bucket
key = "state/terraform.tfstate"           # Ruta del archivo de estado
Cambios en Otros Archivos
main.tf

Asegúrate de que las configuraciones del backend en la sección terraform coincidan con las variables definidas en terraform.tfvars.
variables.tf
Verifica y personaliza las variables declaradas según tus necesidades, como los CIDR blocks y nombres de recursos.
Módulos (modules/*)
Revisa y ajusta las configuraciones específicas de cada módulo si es necesario.
Estructura del Proyecto
plaintext
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
Flujo de Trabajo con GitHub Actions
Workflows Configurados
Terraform Workflow (terraform.yml)

Permite ejecutar init, plan, apply, y destroy directamente desde GitHub Actions.
Snyk Scan Workflow (snyk-scan.yml)

Realiza análisis de seguridad en archivos Terraform.
Docker Image Scan Workflow (docker-image-scan.yml)

Escanea imágenes Docker almacenadas en Amazon ECR.
Ejecución
Despliegue de Infraestructura:
Selecciona el workflow terraform.yml en la pestaña Actions.
Elige la opción all para ejecutar init, plan, y apply en conjunto.
Escaneo de Seguridad:
Selecciona el workflow snyk-scan.yml para escanear archivos Terraform.
Selecciona el workflow docker-image-scan.yml para escanear imágenes Docker.
Destrucción de Infraestructura:
Selecciona el workflow terraform.yml y elige la opción destroy.
Recomendaciones Finales
Seguridad del Bucket S3:
Asegúrate de que el bucket utilizado para almacenar el estado remoto de Terraform tenga políticas de acceso restringidas.
Pruebas en Entornos Aislados:
Antes de desplegar en producción, prueba la infraestructura en un entorno de desarrollo.
Revisiones de Código:
Realiza revisiones de los cambios en GitHub antes de ejecutar los workflows.
