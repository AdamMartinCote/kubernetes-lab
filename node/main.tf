data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  remote_key_path = "/home/ubuntu/.ssh/id_rsa"
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.size
  key_name               = var.keyname
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "K8S-${var.hostname}"
  }

  connection {
    user        = "ubuntu"
    private_key = var.private_key
    host        = self.public_dns
  }
  provisioner "file" {
    # Upload generated private SSH key to all instance to enable lateral connection
    # between instances
    destination = local.remote_key_path
    source      = "./secret_key"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 ${local.remote_key_path}",
    ]
  }
}