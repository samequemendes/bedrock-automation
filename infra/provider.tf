provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.app_name
      Environment = terraform.workspace
      ManagedBy   = "Terraform"
    }
  }
}
