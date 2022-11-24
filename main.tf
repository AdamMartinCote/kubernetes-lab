terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

module "control_plane" {
  source   = "./node"
  hostname = "control_plane"
  keyname  = aws_key_pair.remote_access.key_name
  size     = "t2.nano" #"t2.medium"
  security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_vpc_traffic.id,
  ]
  private_key = tls_private_key.local_key.private_key_pem
}

module "worker_nodes" {
  count    = 1
  source   = "./node"
  hostname = "worker_${count.index}"
  keyname  = aws_key_pair.remote_access.key_name
  size     = "t2.nano" #"t2.micro"
  security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_vpc_traffic.id,
  ]
  private_key = tls_private_key.local_key.private_key_pem
}
