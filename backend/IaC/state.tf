terraform {
  backend "s3" {
    bucket         = "mrbeefy-terraform-state"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mrbeefy-terraform-locks"
    encrypt        = true
  }
}