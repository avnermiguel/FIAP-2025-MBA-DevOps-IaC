resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = var.security_groups
  subnet_id      = var.subnet_id
  associate_public_ip_address = true
  key_name      = var.key_name
  # vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
} 