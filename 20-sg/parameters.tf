resource "aws_ssm_parameter" "mysql_sg_id" {
  # /expense/dev/mysql_sg_id
  name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql_sg.id
}

resource "aws_ssm_parameter" "backend_sg_id" {
  # /expense/dev/mysql_sg_id
  name  = "/${var.project_name}/${var.environment}/backend_sg_id"
  type  = "String"
  value = module.backend_sg.id
}

resource "aws_ssm_parameter" "frontend_sg_id" {
  # /expense/dev/mysql_sg_id
  name  = "/${var.project_name}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend_sg.id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
  # /expense/dev/mysql_sg_id
  name  = "/${var.project_name}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion_sg.id
}

resource "aws_ssm_parameter" "ansible_sg_id" {
  # /expense/dev/mysql_sg_id
  name  = "/${var.project_name}/${var.environment}/ansible_sg_id"
  type  = "String"
  value = module.ansible_sg.id
}

resource "aws_ssm_parameter" "app_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/app_alb_sg_id"
  type  = "String"
  value = module.app_alb_sg.id
}

resource "aws_ssm_parameter" "web_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/web_alb_sg_id"
  type  = "String"
  value = module.web_alb_sg.id
}

resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.project_name}/${var.environment}/vpn_sg_id"
  type  = "String"
  value = module.vpn_sg.id
}