variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "devops-bootstrap"
}

variable "github_repo" {
  description = "GitHub repo (owner/name) allowed to assume the CI roles"
  type        = string
  default     = "your-github-username/aws-eks-devops-platform"
}

variable "github_environment" {
  description = "GitHub Environment used (with required reviewers) for infra apply/destroy"
  type        = string
  default     = "production"
}

variable "ecr_repository_name" {
  description = "ECR repository the deploy role may push to (created by terraform/ec2-k8s)"
  type        = string
  default     = "k8s-ansible-app"
}

variable "k8s_project_name" {
  description = "project_name used by terraform/ec2-k8s (security group is named <project>-sg)"
  type        = string
  default     = "k8s-ansible"
}

variable "terraform_role_policy_arn" {
  description = "Policy attached to the Terraform role. AdministratorAccess keeps the demo simple - scope this down for real use."
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}
