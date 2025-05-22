variable "db_sg_id" {
  description = "The ID of the database security group"
  type        = string
  
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "db_subnet_group" {
  description = "The name of the database subnet group"
  type        = string
}