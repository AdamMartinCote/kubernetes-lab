terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

module "control_plane" {
  source = "./node"
  hostname = "control_plane"
}

module "worker_1" {
  source = "./node"
  hostname = "worker_1"
}