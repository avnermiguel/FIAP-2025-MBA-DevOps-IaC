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



module "vpc" {
  source = "./modules/vpc"
  cidr   = "10.0.0.0/16"
  name   = "main_vpc"
}

module "security_group" {
  source = "./modules/security_group"
  name   = "allow_ssh_http"
  vpc_id = module.vpc.vpc_id # Substitua pelo ID da sua VPC
  depends_on = [module.vpc]
}


module "nginx_instance_hml" {
  source = "./modules/ec2"

  ami           = "ami-0de716d6197524dd9" # Substitua pela AMI da sua região
  instance_type = "t2.micro"
  security_groups = [module.security_group.security_group_id]
  name          = "Nginx Server HML"
  depends_on    = [module.vpc, module.security_group]
  subnet_id     = module.vpc.subnet1_id
  key_name      = "teste-remote-exec"
}

module "nginx_instance_prd" {
  source = "./modules/ec2"

  ami           = "ami-0de716d6197524dd9" # Substitua pela AMI da sua região
  instance_type = "t2.micro"
  security_groups = [module.security_group.security_group_id]
  name          = "Nginx Server PRD"
  depends_on    = [module.vpc, module.security_group]
  subnet_id     = module.vpc.subnet1_id
  key_name      = "teste-remote-exec"
}

data "aws_secretsmanager_secret_version" "ssh_key" {
  secret_id = "ssh-key" # Substitua pelo nome ou ARN do seu segredo
}

module "ansible_server" {
  source = "./modules/ansible"

  ami           = "ami-0de716d6197524dd9" # Substitua pela AMI da sua região
  instance_type = "t2.micro"
  security_groups = [module.security_group.security_group_id]
  name          = "Ansible Server"
  subnet_id     = module.vpc.subnet1_id
  key_name      = "teste-remote-exec"
  ssh_key       = data.aws_secretsmanager_secret_version.ssh_key.secret_string
  nginx_hml_ip  = module.nginx_instance_hml.public_ip
  nginx_prd_ip  = module.nginx_instance_prd.public_ip

  depends_on    = [module.vpc, module.security_group,module.nginx_instance_hml, module.nginx_instance_prd]

}

output "nginx_hml_public_ip" {
  value = module.nginx_instance_hml.public_ip
}

output "nginx_prd_public_ip" {
  value = module.nginx_instance_prd.public_ip
}

output "ansible_server_public_ip" {
  value = module.ansible_server.public_ip
}