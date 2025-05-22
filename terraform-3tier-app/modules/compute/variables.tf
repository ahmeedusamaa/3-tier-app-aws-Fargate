variable "vpc_id" {
  description = "VPC ID"
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


variable "frontend_sg" {
  description = "Security group for frontend instances"
  type        = string
}
variable "backend_sg" {
  description = "Security group for backend instances"
  type        = string
}

variable "frontend_alb_sg" {
  description = "Security group for frontend ALB"
  type        = string
}
variable "backend_alb_sg" {
  description = "Security group for backend ALB"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  
}

variable "db_address" {
  description = "Database address"
  type        = string
  
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "admin"
  
}