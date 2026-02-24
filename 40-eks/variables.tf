variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "expense"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "eks_version" {
  default = "1.31"
}

variable "enable_blue" {
  default = true
}

variable "nodegroup_version" {
  default = "1.33"
}