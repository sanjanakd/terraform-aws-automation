resource "aws_iam_server_certificate" "test_cert" {
  name_prefix      = "example-cert"
  certificate_body = "${file("../certs/cert.pem")}"
  private_key      = "${file("../certs/key.pem")}"

  lifecycle {
    create_before_destroy = true
  }
}