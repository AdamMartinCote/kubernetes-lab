locals {
  username          = "ubuntu"
  control_plane_dns = module.control_plane.public_dns
  private_key_path  = "./secret_key"
}

output "control_plane_connection_command" {
  value = <<EOT

    ssh -i ${local.private_key_path} ${local.username}@${local.control_plane_dns}
  EOT
}

output "control_plane_public_dns" {
  description = "Public DNS name for the control-plane node"
  value       = [module.control_plane.public_dns]
}

output "worker_nodes_public_dns" {
  description = "Public DNS name for the control-plane node"
  value       = module.worker_nodes[*].public_dns
}

