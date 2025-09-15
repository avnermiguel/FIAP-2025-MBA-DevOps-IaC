resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = var.security_groups
  subnet_id      = var.subnet_id
  associate_public_ip_address = true
  key_name      = var.key_name

  tags = {
    Name = var.name
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = var.ssh_key
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline  = [
      "sudo yum update -y",
      "sudo yum install -y ansible",
      "echo '[hml]' > /home/ec2-user/hosts",
      "echo '${var.nginx_hml_ip}' >> /home/ec2-user/hosts",
      "echo '[prd]' >> /home/ec2-user/hosts",
      "echo '${var.nginx_prd_ip}' >> /home/ec2-user/hosts",
      "echo '[nginx:children]' >> /home/ec2-user/hosts",
      "echo 'hml' >> /home/ec2-user/hosts",
      "echo 'prd' >> /home/ec2-user/hosts",
      "echo '${var.ssh_key}' > /home/ec2-user/.ssh/id_rsa",
      "chmod 400 /home/ec2-user/.ssh/id_rsa",
      "git clone https://github.com/avnermiguel/FIAP-2025-MBA-DevOps-IaC",
      "ansible-playbook -i /home/ec2-user/hosts FIAP-2025-MBA-DevOps-IaC/Ansible/playbook-nginx.yml --ssh-extra-args='-o StrictHostKeyChecking=no'"
    ]
  }
} 