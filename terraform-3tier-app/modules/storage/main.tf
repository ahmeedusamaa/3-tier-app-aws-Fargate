data "aws_secretsmanager_secret_version" "db_user_value" {
  secret_id = var.sm_secret_db_user_id
}

data "aws_secretsmanager_secret_version" "db_pass_value" {
  secret_id = var.sm_secret_db_pass_id
}

resource "aws_db_instance" "app_db" {
  identifier             = "three-tier-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = "appdb"

  username               = data.aws_secretsmanager_secret_version.db_user_value.secret_string
  password               = data.aws_secretsmanager_secret_version.db_pass_value.secret_string

  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [var.db_sg_id]
  db_subnet_group_name   = var.db_subnet_group
}
