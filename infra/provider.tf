provider "aws" {
  region = var.region
  profile = var.profile

  default_tags {
    tags = {
      Project     = var.app_name
      Environment = terraform.workspace
      ManagedBy   = "Terraform"
    }
  }
}
