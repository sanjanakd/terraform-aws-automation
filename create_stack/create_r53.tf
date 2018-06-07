resource "aws_route53_zone" "bar" {
  name = "myapp.example.org"
}


resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.bar.zone_id}"
  name = "www.myapp.example.org"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.webappelb.dns_name}"]
}