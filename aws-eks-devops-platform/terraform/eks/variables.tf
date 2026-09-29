variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix used for resource names"
  type        = string
  default     = "eks-devops"
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "github_repo" {
  description = "GitHub repo allowed to assume the CI role, in the form owner/name"
  type        = string
  default     = "your-github-username/aws-eks-devops-platform"
}

variable "create_oidc_provider" {
  description = "Set to false if the GitHub OIDC provider already exists in the account (e.g. created by terraform/bootstrap)"
  type        = bool
  default     = true
}
