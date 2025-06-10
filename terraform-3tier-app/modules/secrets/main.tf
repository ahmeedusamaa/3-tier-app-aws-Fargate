resource "aws_kms_key" "secrets_key" {
  description         = "KMS key for encrypting Secrets Manager secrets"
  enable_key_rotation = true
  deletion_window_in_days = 10
}

resource "aws_secretsmanager_secret" "db_user" {
  name = "database-username-secret"
  #   recovery_window_in_days = 30
  recovery_window_in_days = 0
  kms_key_id              = aws_kms_key.secrets_key.arn
}

resource "aws_secretsmanager_secret_version" "db_user_value" {
  secret_id     = aws_secretsmanager_secret.db_user.id
  secret_string = var.username
}

resource "aws_secretsmanager_secret" "db_pass" {
  name = "database-password-secret"
  #   recovery_window_in_days = 30
  recovery_window_in_days = 0
  kms_key_id              = aws_kms_key.secrets_key.arn
}

resource "aws_secretsmanager_secret_version" "db_pass_value" {
  secret_id     = aws_secretsmanager_secret.db_pass.id
  secret_string = var.password
}

