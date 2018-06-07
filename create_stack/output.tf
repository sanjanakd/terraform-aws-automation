output "id" {
  description = "List of IDs of instances"
  value = ["${aws_autoscaling_group.webappscale.id}"]
}

output "elb_dns_name" {
  value = "${aws_elb.webappelb.dns_name}"
}

output "subnet_id_a" {
  value = "${data.aws_subnet.public_a.id}"
}

output "subnet_id_b" {
  value = "${data.aws_subnet.public_b.id}"
}