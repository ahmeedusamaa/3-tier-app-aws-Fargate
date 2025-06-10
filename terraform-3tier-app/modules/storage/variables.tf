variable "db_sg_id" {
  description = "The ID of the database security group"
  type        = string
  
}

variable "db_subnet_group" {
  description = "The name of the database subnet group"
  type        = string
}

variable "sm_secret_db_user_id" {
  description = "The Secrets Manager secret for the database username"
  type        = string
  
}

variable "sm_secret_db_pass_id" {
  description = "The Secrets Manager secret for the database password"
  type        = string
}