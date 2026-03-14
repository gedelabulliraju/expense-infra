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
    default = "calculatorss.online"
}

variable "zone_id" {
    default = "Z0003357GCY38E92ZDT3"
}
