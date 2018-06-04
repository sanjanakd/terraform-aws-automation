variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "region" {
  default = "us-east-1"
}

variable "filter_ami" {
  default = "apache-tomcat-"
}

variable "vpc_id" {
  default = "vpc-f00e7588"
}

variable "availability-zones" {
  default = [
    "us-east-1a",
    "us-east-1b"
  ]

  type = "list"
}

variable "instance_type" {
  default = "t2.micro"
}

