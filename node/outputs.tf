output "public_dns" {
  description = "Publicly accessible DNS name"
  value = aws_instance.instance.public_dns
}