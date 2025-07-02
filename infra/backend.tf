terraform {
  backend "s3" {
    bucket  = "samequemendes-terraform-tf-states"
    key     = "bedrock-automation/terraform.tfstate"
    region  = us-east-1
    #encrypt = true
    #dynamodb_table = "terraform-lock-table"
  }
}
