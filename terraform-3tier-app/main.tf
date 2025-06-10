module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids = module.networking.public_subnet_ids
  frontend_sg = module.security_group.frontend_sg_id
  backend_sg = module.security_group.backend_sg_id
  frontend_alb_sg = module.security_group.frontend_alb_sg_id
  backend_alb_sg = module.security_group.backend_alb_sg_id
  db_password = var.db_password
  db_address = module.storage.database_address
}

module "networking" {
  source = "./modules/networking"
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs = var.azs
}

module "security_group" {
  source = "./modules/securitygroup"
  vpc_id = module.networking.vpc_id
  
}

module "storage" {
  source = "./modules/storage"
  db_sg_id = module.security_group.db_sg_id
  sm_secret_db_user_id = module.secrets.secret_db_user_id
  sm_secret_db_pass_id = module.secrets.secret_db_pass_id
  db_subnet_group = module.networking.database_subnet_group
  
}

module "ECS" {
  source = "./modules/ECS"
  db_address = module.storage.database_address
  frontend_target_group_arn = module.compute.frontend_target_group_arn
  backend_target_group_arn = module.compute.backend_target_group_arn
  backend_alb_dns_name = module.compute.backend_alb_dns_name
  ecs_tasks_sg_id = module.security_group.ecs_tasks_sg_id
  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids = module.networking.public_subnet_ids
  backend_image_name = var.backend_image_name
  frontend_image_name = var.frontend_image_name
  secret_db_pass_arn = module.secrets.secret_db_pass_arn
  secret_db_user_arn = module.secrets.secret_db_user_arn
  ecs_task_execution_arn = module.iam.ecs_task_role_arn
}

module "secrets" {
  source = "./modules/secrets"
  username = var.db_user
  password = var.db_password
  
}

module "iam" {
  source = "./modules/iam"
  secret_db_pass_arn = module.secrets.secret_db_pass_arn
  secret_db_user_arn = module.secrets.secret_db_user_arn
  kms_key_arn = module.secrets.keys_arn
}