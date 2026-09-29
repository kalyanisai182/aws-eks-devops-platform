output "control_plane_public_ip" {
  value = aws_instance.control_plane.public_ip
}

output "worker_public_ips" {
  value = aws_instance.worker[*].public_ip
}

output "next_step" {
  value = "cd ../../ansible && ansible-playbook playbooks/site.yml"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}
