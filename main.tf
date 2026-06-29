module "networking" {
  source = "./modules/networking"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.networking.vpc_id
  vpc_cidr     = var.vpc_cidr
}

module "database" {
  source = "./modules/database"

  project_name       = var.project_name
  private_subnet_ids = module.networking.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
}

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  eks_sg_id          = module.security.eks_sg_id
  node_instance_type = var.node_instance_type
  node_min_size      = var.node_min_size
  node_max_size      = var.node_max_size
  node_desired_size  = var.node_desired_size
  lab_role_arn = var.lab_role_arn
}

module "kubernetes" {
  source = "./modules/kubernetes"

  app_version      = var.app_version
  db_host          = module.database.rds_endpoint
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password

  depends_on = [module.eks]
}