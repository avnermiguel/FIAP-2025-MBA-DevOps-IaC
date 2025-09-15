output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.allow_ssh_http.id # Adjust "main" if your resource has a different name
}