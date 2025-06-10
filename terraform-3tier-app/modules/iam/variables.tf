variable "secret_db_user_arn" {
  description = "secret for the database username"
  type        = string

}

variable "secret_db_pass_arn" {
  description = "secret for the database password"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN for encrypting secrets"
  type        = string
}