terraform {
  backend "s3" {
    bucket = "stack-creation-state"
    key = "terraformvpc.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}