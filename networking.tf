data "external" "caller_ip_address" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

locals {
  caller_ip_address = data.external.caller_ip_address.result.ip
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = aws_default_vpc.default.id

  ingress {
    description = "Security group to provide SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "${local.caller_ip_address}/32"
    ]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_vpc_traffic" {
  name        = "allow_tls"
  description = "Allow SSH traffic between instances"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = {
    Name = "allow_vpc_traffic"
  }
}