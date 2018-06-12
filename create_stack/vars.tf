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


variable "subnet_tag_name" {
  default = "Name"
}

variable "subnet_tag_value" {
  default = "public_subnet"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "192.168.0.0/22"
}

variable "subnet_cidr_a" {
  description = "CIDR for the Public Subnet AZ A"
  default = "192.168.0.0/27"
}

variable "subnet_cidr_b" {
  description = "CIDR for the Public Subnet AZ B"
  default = "192.168.0.32/27"
}


variable "DBRemoteStateBucket" {
  default = "stack-creation-state"
}

variable "DBRemoteStateKey" {
  type = "map"
  default = {
    dev = "myapp/dev/terraform.tfstate"
    prod = "myapp/prod/terraform.tfstate"
  }
}

variable "environment" {
  description = "Please enter your environment : dev, prod"
  default = "dev"
}

variable "stack-ttl" {
  description = "Please enter ttl for your stack"
  default = "2"
}