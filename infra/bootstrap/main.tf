provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "mrbeefy-terraform-state"

  lifecycle {
    prevent_destroy = true
    ignore_changes = all
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "mrbeefy-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = all
  }
}