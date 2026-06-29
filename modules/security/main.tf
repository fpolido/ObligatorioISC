resource "aws_security_group" "eks" {
  name        = "${var.project_name}-sg-eks"
  description = "Security Group para los nodos del cluster EKS"
  vpc_id      = var.vpc_id

  ingress {
    description = "Comunicacion interna entre nodos"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "HTTPS desde internet (kubectl + ALB)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Todo el trafico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-sg-eks" }
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-sg-rds"
  description = "Permite acceso MySQL solo desde los nodos EKS"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL desde nodos EKS"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.eks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-sg-rds" }
}