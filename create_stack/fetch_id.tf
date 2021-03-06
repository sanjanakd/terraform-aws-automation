data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "tag:Name"
    values = ["${var.filter_ami}"]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name = "tag:${var.subnet_tag_name}"
    values = ["${var.subnet_tag_value}_B"]
  }
}

data "aws_subnet" "public_b" {

  filter {
    name = "tag:${var.subnet_tag_name}"
    values = ["${var.subnet_tag_value}_B"]
  }
}

data "aws_iam_instance_profile" "role_pro" {
  name = "test_profile"
}

data "aws_iam_instance_profile" "destroy_pro" {
  name = "test_destroy_profile"
}

data "aws_iam_instance_profile" "hook_pro" {
  name = "test_hook_profile"
}


