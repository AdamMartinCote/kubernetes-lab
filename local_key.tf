resource "tls_private_key" "local_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.local_key.private_key_pem
  filename        = "secret_key"
  file_permission = "400"
}