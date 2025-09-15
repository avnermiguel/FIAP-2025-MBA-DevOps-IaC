output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "subnet1_id" {
  description = "The ID of the first subnet."
  value       = aws_subnet.subnet1.id
}