output "state_bucket" {
  description = "Repository variable TF_STATE_BUCKET"
  value       = aws_s3_bucket.state.bucket
}

output "lock_table" {
  description = "Repository variable TF_LOCK_TABLE"
  value       = aws_dynamodb_table.lock.name
}

output "terraform_role_arn" {
  description = "Repository variable TF_ROLE_ARN"
  value       = aws_iam_role.terraform.arn
}

output "deploy_role_arn" {
  description = "Repository variable AWS_ROLE_ARN (Path B app deployments)"
  value       = aws_iam_role.deploy.arn
}

output "backend_hcl" {
  description = "Contents for terraform/backend.hcl"
  value       = <<-EOT
    bucket         = "${aws_s3_bucket.state.bucket}"
    region         = "${var.region}"
    dynamodb_table = "${aws_dynamodb_table.lock.name}"
    encrypt        = true
  EOT
}
