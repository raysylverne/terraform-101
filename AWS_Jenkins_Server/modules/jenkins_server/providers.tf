#Create a providers file 
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.70.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}