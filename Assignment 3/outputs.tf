output "instance_id" {
  description = "The unique identifier of the provisioned EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "The public IPv4 address assigned to the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "instance_private_ip" {
  description = "The private IPv4 address of the EC2 instance"
  value       = aws_instance.app_server.private_ip
}

output "instance_arn" {
  description = "The Amazon Resource Name (ARN) of the EC2 instance"
  value       = aws_instance.app_server.arn
}

output "instance_state" {
  description = "The current lifecycle state of the instance"
  value       = aws_instance.app_server.instance_state
}
