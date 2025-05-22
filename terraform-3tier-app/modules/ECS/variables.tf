variable "db_address" {
  description = "Database address"
  type        = string
  
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "admin"
  
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "backend_alb_dns_name" {
  description = "Backend ALB DNS name"
  type        = string
}

variable "ecs_tasks_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
  
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}
variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "frontend_target_group_arn" {
  description = "Frontend target group ARN"
  type        = string
  
}

variable "backend_target_group_arn" {
  description = "Backend target group ARN"
  type        = string
  
}


variable "backend_image_name" {
  description = "Docker image name"
  type        = string
  
}

variable "frontend_image_name" {
  description = "Docker image name"
  type        = string
  
}