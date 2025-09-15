variable "ami" {
  type = string
  description = "AMI da instância EC2"
}

variable "instance_type" {
  type = string
  description = "Tipo da instância EC2"
}

variable "security_groups" {
  type = list(string)
  description = "Lista de Security Groups"
}

variable "name" {
  type = string
  description = "Nome da instância EC2"
}

variable "subnet_id" {
  type = string
  description = "ID da Subnet"
}

variable "key_name" {
  type = string
  description = "Nome da chave SSH"
}

variable "ssh_key" {
  type        = string
  description = "Chave privada SSH para acesso à instância"
}

variable "nginx_hml_ip" {
  type = string
}

variable "nginx_prd_ip" {
  type = string
}