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

//variable "vpc_id" {
//  default = "vpc-f00e7588"
//}

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


