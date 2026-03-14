terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }

 backend "s3" {
    bucket         = "aws-expense-buck"
    key            = "expense-infra-vpc"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
