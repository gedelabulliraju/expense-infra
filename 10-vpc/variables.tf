variable "project_name" {
  description = "The name of the project."
  type        = string
  default = "expense"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}
variable "comman_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "public_subnet_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "database_subnet_cidrs" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}
variable "is_peering_required" {
    default = true
}

variable "mysql_sg_tags" {
    default = {
       Component = "mysql"
    }
}
variable "sg_name" {
    default = "mysql"
}