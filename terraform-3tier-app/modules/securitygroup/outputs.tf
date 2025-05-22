output "frontend_sg_id" {
  value = aws_security_group.frontend_sg.id
  description = "The ID of the security group"
  
}

output "backend_sg_id" {
  value = aws_security_group.backend_sg.id
  description = "The ID of the security group"
  
}
output "backend_alb_sg_id" {
  value = aws_security_group.backend_alb_sg.id
  description = "The ID of the security group"
  
}
output "frontend_alb_sg_id" {
  value = aws_security_group.frontend_alb_sg.id
  description = "The ID of the security group"
  
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
  description = "The ID of the security group"
  
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks_sg.id
  description = "The ID of the security group"
  
}