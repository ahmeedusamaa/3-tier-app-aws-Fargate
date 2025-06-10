output "secret_db_user_arn" {
  value = aws_secretsmanager_secret.db_user.arn
  
}
output "secret_db_pass_arn" {
  value = aws_secretsmanager_secret.db_pass.arn
  
}

output "secret_db_user_id" {
  value = aws_secretsmanager_secret.db_user.id

}

output "secret_db_pass_id" {
  value = aws_secretsmanager_secret.db_pass.id
  
}


output "keys_arn" {
  value = aws_kms_key.secrets_key.arn
  
}

output "secret_db_user_name" {
  value = aws_secretsmanager_secret.db_user.name
}

output "secret_db_pass_name" {
  value = aws_secretsmanager_secret.db_pass.name
}


