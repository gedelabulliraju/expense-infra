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

variable "web_alb_tags" {
    default = {
        Component = "web-alb"
    }
}


variable "zone_name" {
    default = "buddymarket.shop"
}