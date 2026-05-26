output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the EC2 instance"
  value       = try(aws_instance.this[0].id, null)
}

output "arn" {
  description = "ARN of the EC2 instance"
  value       = try(aws_instance.this[0].arn, null)
}

output "private_ip" {
  description = "Private IP address"
  value       = try(aws_instance.this[0].private_ip, null)
}

output "public_ip" {
  description = "Public IP address (if applicable)"
  value       = try(aws_instance.this[0].public_ip, null)
}
