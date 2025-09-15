terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Criar um bucket S3 para armazenar o State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-mba-devops-2025" # Substitua pelo nome desejado do bucket (deve ser globalmente único)

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}