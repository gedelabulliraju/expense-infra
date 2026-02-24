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


variable "zone_name" {
    default = "buddymarket.shop"
}

variable "zone_id" {
    default = "Z07950251V046B94J8759"
}