output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.webserver.private_ip
}

output "instance_private_dns" {
  description = "The private DNS name of the EC2 instance"
  value       = aws_instance.webserver.private_dns
}

output "instance_id" {
  description = "The Instance ID for ex. i-23492380sdfsdfsdf"
  value = aws_instance.webserver.id
}