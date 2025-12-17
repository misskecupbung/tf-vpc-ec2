# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.server.id
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.server.private_ip
}