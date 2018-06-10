resource "aws_launch_configuration" "webapp" {
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  user_data = "${file("../provision_ami/playbook/roles/apache-tomcat/files/userDataApp.sh")}"
  security_groups = ["${aws_security_group.webappsg.id}"]
  key_name = "${aws_key_pair.developer.id}"
  associate_public_ip_address= true

  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_autoscaling_group.selfdistructsg"]
}

resource "aws_autoscaling_group" "webappscale" {
  name = "apache-asg"
  launch_configuration = "${aws_launch_configuration.webapp.id}"
  availability_zones = "${var.availability-zones}"
  max_size = 2
  min_size = 2
  desired_capacity = 2
  load_balancers = ["${aws_elb.webappelb.name}"]
  vpc_zone_identifier = ["${data.aws_subnet.public_a.id}", "${data.aws_subnet.public_b.id}"]
 # health_check_type = "ELB"

  tag = [
    {
      key                 = "Name"
      value               = "myInstance"
      propagate_at_launch = "true"

    },
    {
      key                 = "name"
      value               = "myAppInstance"
      propagate_at_launch = "true"

    }
  ]

  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_autoscaling_group.selfdistructsg"]
}



