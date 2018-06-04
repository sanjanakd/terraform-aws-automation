output "id" {
  description = "List of IDs of instances"
  value = ["${aws_autoscaling_group.webappscale.id}"]
}

output "elb_dns_name" {
  value = "${aws_elb.webappelb.dns_name}"
}