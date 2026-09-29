terraform {
  required_version = ">= 1.5.0"

  # Remote state in S3 with DynamoDB locking. Values are supplied at init time:
  #   terraform init -backend-config=../backend.hcl -backend-config="key=eks/terraform.tfstate"
  # (bucket, table and region come from the bootstrap stack outputs)
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = var.project_name
      ManagedBy = "terraform"
    }
  }
}
