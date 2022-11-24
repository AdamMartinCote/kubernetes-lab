resource "aws_key_pair" "remote_access" {
  key_name   = "access-key"
  public_key = tls_private_key.local_key.public_key_openssh
}