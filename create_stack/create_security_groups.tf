resource "aws_security_group" "webappsg" {
  name = "webapp-security"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${data.aws_subnet.public_a.vpc_id}"

  tags {
    Name = "WebAppSG_${var.environment}"
  }
  depends_on = ["aws_autoscaling_group.selfdistructsg"]
}

resource "aws_security_group" "destory_sg" {
  name = "destroyer-security"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${data.aws_subnet.public_a.vpc_id}"

  tags {
    Name = "destroySG"
  }
}

resource "aws_security_group" "elb" {
  name = "elb-security"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "WebAppELB_${var.environment}"
  }
  vpc_id = "${data.aws_subnet.public_a.vpc_id}"
  depends_on = ["aws_autoscaling_group.selfdistructsg"]
}
