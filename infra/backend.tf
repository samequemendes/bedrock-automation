terraform {
  backend "s3" {
    bucket = "samequemendes-terraform-tf-states"
    key    = "4linux-devos-essentials/devops-samequemendes/terraform.tfstate"
    #region         = us-east-1
    encrypt = true
    #dynamodb_table = "terraform-lock-table"
  }
}
