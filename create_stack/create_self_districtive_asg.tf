resource "aws_launch_configuration" "selfdistruct" {
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${data.aws_iam_instance_profile.role_pro.name}"
  user_data = "${file("../provision_ami/playbook/roles/apache-tomcat/files/userData.sh")}"
  security_groups = [
    "${aws_security_group.destory_sg.id}"]
  key_name = "${aws_key_pair.destroyerkey.id}"
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "selfdistructsg" {
  name = "self-distruct-asg"
  launch_configuration = "${aws_launch_configuration.selfdistruct.id}"
  availability_zones = "${var.availability-zones}"
  vpc_zone_identifier = [
    "${data.aws_subnet.public_a.id}",
    "${data.aws_subnet.public_b.id}"]
  max_size = 1
  min_size = 1
  tag = [
    {
      key = "Name"
      value = "selfDistruct"
      propagate_at_launch = "true"

    },
    {
      key = "name"
      value = "mySelfDistructInstace"
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
  desired_capacity = 0
  start_time = "${timeadd(timestamp(), "${var.stack-ttl}h")}"
  end_time = "${timeadd(timestamp(), "${var.stack-ttl+30}h")}"
}

resource "aws_autoscaling_lifecycle_hook" "on_terminate_hook" {
  name = "send-destory-message"
  autoscaling_group_name = "${aws_autoscaling_group.selfdistructsg.name}"
  default_result = "CONTINUE"
  heartbeat_timeout = 3000
  lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${aws_sqs_queue.destroyer_queue.arn}"
  role_arn = "arn:aws:iam::014279457395:role/hook_role"
}