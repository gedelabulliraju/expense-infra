terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
 backend "s3" {
    bucket         = "aws-expense-buck"
    key            = "expense-infra-ecr"
    region         = "us-east-1"
    use_lockfile = true
    encrypt = true  
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}