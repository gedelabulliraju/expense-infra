variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "backend_tags" {
    default = {
        Component = "backend"
    }
}

variable "zone_name" {
    default = "buddymarket.shop"
}