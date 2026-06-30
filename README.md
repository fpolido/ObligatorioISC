# Obligatorio ISC

Despliegue de la aplicación de microservicios **Online Boutique** (demo de Google) sobre **AWS**, usando **Terraform** como herramienta de Infraestructura como Código y **Amazon EKS** como plataforma de orquestación de contenedores.

## Arquitectura

![Diagrama de arquitectura](docs/diagrama-arquitectura.png)

El diagrama editable (draw.io) está disponible en [`docs/diagrama-arquitectura.drawio`](docs/diagrama-arquitectura.drawio).

La solución despliega:

- Una **VPC** con subnets públicas y privadas distribuidas en **2 Availability Zones** (`us-east-1a` y `us-east-1b`), para tolerancia a fallas.
- Un **Internet Gateway** para las subnets públicas y un **NAT Gateway** para que los nodos en subnets privadas tengan salida a internet sin estar expuestos.
- Un **cluster EKS** (Kubernetes 1.31) con sus nodos worker desplegados en las subnets privadas, con autoescalado configurado.
- Los microservicios de Online Boutique corriendo como `Deployments`/`Services` de Kubernetes dentro del cluster.
- El frontend expuesto a internet mediante un `Service` de tipo `LoadBalancer`, que es el único punto de entrada público a la aplicación.
- Una base de datos **RDS MySQL Multi-AZ**, alojada en las subnets privadas, sin acceso público.
- Un módulo de **monitoreo y logging** con CloudWatch, CloudTrail y un bucket S3 para centralizar logs.

## Dependencias y requerimientos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado con credenciales de AWS Academy
- [kubectl](https://kubernetes.io/docs/tasks/tools/) para interactuar con el cluster una vez desplegado
- Cuenta de **AWS Academy** levantada

## Instructivo de uso

### 1. Clonar el repositorio

```bash
git clone https://github.com/fpolido/ObligatorioISC.git
cd ObligatorioISC
```

### 2. Configurar las variables

```bash
cp terraform.tfvars.example variables.tfvars
```

Editar `variables.tfvars` y completar:

- `lab_role_arn`: ARN del `LabRole` de la sesión activa de AWS Academy (IAM → Roles → LabRole). **Cambia en cada sesión del lab.**
- `db_password`: una contraseña propia.

### 3. Desplegar la infraestructura

```bash
terraform init
terraform apply -var-file="variables.tfvars"
```

### 4. Configurar kubectl

```bash
terraform output configure_kubectl
# ejecutar el comando que devuelve
aws eks update-kubeconfig --region us-east-1 --name <project_name>-cluster
```

### 5. Verificar el despliegue

```bash
kubectl get pods
kubectl get svc frontend
```

### 6. Acceder a la aplicación

```bash
terraform output app_url
```

Copiar la URL en cualquier navegador para acceder a la aplicación

## Mejoras implementadas

- **Módulo de monitoreo custom** (`modules/monitoreo`): CloudWatch Log Groups para el cluster y la aplicación, alarma de CPU sobre el Auto Scaling Group de los nodos, CloudTrail multi-evento, y bucket S3 con política de ciclo de vida (transición a Glacier a los 30 días, expiración a los 90).
- **Multi-AZ** en RDS y distribución de subnets en 2 Availability Zones para tolerancia a fallas.
- **Autoescalado** del Node Group de EKS para soportar picos de tráfico.
- **Firewalling restrictivo**: la base de datos solo acepta conexiones desde el Security Group de los nodos EKS, nunca desde internet.
