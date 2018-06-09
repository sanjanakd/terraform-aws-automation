terraform {
  backend "s3" {
    bucket = "stack-creation-state"
    key = "terraformvpc.tfstate"
    region = "us-east-1"
    encrypt = true
    //role_arn = "arn:aws:iam::014279457395:role/S3bucketAccess"
  }
}