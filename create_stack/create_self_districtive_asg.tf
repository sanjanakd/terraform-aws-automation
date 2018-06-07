resource "aws_launch_configuration" "selfdistruct" {
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.webappsg.id}"]
  key_name = "${aws_key_pair.developer.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "selfdistructsg" {
  name = "self-distruct-asg"
  launch_configuration = "${aws_launch_configuration.selfdistruct.id}"
  availability_zones = "${var.availability-zones}"
  vpc_zone_identifier = ["${data.aws_subnet.public_a.id}", "${data.aws_subnet.public_b.id}"]
  max_size = 1
  min_size = 1

//  desired_capacity = 1

  tag = [
    {
      key                 = "Name"
      value               = "selfDistruct"
      propagate_at_launch = "true"

    },
    {
      key                 = "name"
      value               = "mySelfDistructInstace"
      propagate_at_launch = "true"

    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_schedule" "destory_scheduler" {
  scheduled_action_name = "destroyer"
  autoscaling_group_name = "${aws_autoscaling_group.selfdistructsg.name}"
  min_size = 0
//  max_size = 1
  desired_capacity = 0
//  recurrence = "0 10 * * SAT"
  start_time = "${timeadd(timestamp(), "5m")}"
  end_time = "${timeadd(timestamp(), "10m")}"
//  end_time = "2018-06-6T11:38:00Z"

}

resource "aws_autoscaling_lifecycle_hook" "on_terminate_hook" {
  name                   = "send-destory-message"
  autoscaling_group_name = "${aws_autoscaling_group.selfdistructsg.name}"
  default_result         = "CONTINUE"
  heartbeat_timeout      = 600
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${aws_sqs_queue.destroyer_queue.arn}"
  role_arn                = "arn:aws:iam::014279457395:role/hook_role"
}