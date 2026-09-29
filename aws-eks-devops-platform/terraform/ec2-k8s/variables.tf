variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "k8s-ansible"
}

variable "admin_cidr" {
  description = "Your public IP in CIDR form (e.g. 203.0.113.10/32). Only this range can SSH and reach the Kubernetes API."
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key uploaded as the EC2 key pair"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the matching private key (written into the Ansible inventory)"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "instance_type" {
  description = "kubeadm needs at least 2 vCPU and 2 GB RAM"
  type        = string
  default     = "t3.medium"
}

variable "worker_count" {
  type    = number
  default = 2
}

variable "jenkins_enabled" {
  description = "Also create a Jenkins server (configured by playbook 05)"
  type        = bool
  default     = false
}

variable "extra_admin_cidrs" {
  description = "Additional CIDRs allowed to SSH (used by CI to open access for the current runner only)"
  type        = list(string)
  default     = []
}
