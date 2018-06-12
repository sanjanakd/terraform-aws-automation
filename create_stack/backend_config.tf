terraform {
  backend "s3" {
    bucket = "stack-creation-state"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}