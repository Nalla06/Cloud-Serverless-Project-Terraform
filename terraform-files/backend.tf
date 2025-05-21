terraform {
  backend "s3" {
    bucket         = "my-eks-bucket6"
    region         = "us-east-1"
    key            = "terraform-files/terraform.tfstate"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}