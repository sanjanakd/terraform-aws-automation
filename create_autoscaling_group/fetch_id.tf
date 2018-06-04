
data "aws_availability_zones" "available" {}

data "aws_ami" "linux" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "tag:Name"
    values = ["${var.filter_ami}"]
  }
}