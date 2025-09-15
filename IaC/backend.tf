terraform {
  backend "s3" {
    bucket         = "terraform-state-mba-devops-2025"  # Usar o nome do bucket criado pelo Terraform
    key            = "terraform.tfstate"
    region         = "us-east-1"      # Substitua pela sua região
    encrypt        = true
  }
}