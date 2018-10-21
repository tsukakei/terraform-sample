terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "tsukakei-example-terraform-state"
    region = "us-east-1"
    key = "terraform.tfstate"
    encrypt = true
    dynamodb_table = "terraform_state_lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tsukakei-example-terraform-state"
  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "terraform_state_lock"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
