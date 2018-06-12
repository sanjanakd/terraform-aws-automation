resource "aws_elb" "webappelb" {
  name = "webapp-elb"

  subnets = ["${data.aws_subnet.public_a.id}", "${data.aws_subnet.public_b.id}"]
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    instance_port = 8080
    instance_protocol = "http"
    #lb_port = 80
    lb_port = 443
    #lb_protocol = "http"
    lb_protocol = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.test_cert.arn}"
  }

  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:8080/"
    timeout = 3
    unhealthy_threshold = 3
  }
  connection_draining = true

  tags {
    name = "webappelb_${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_autoscaling_group.selfdistructsg"]

}