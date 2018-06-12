resource "aws_iam_instance_profile" "profile" {
  name = "test_profile"
  role = "${aws_iam_role.role.id}"
}

resource "aws_iam_instance_profile" "destroy_profile" {
  name = "test_destroy_profile"
  role = "${aws_iam_role.destroy_role.id}"
}

resource "aws_iam_instance_profile" "hook_profile" {
  name = "test_hook_profile"
  role = "${aws_iam_role.hook_role.id}"
}



resource "aws_iam_role_policy" "service_role_policy" {
  name = "service-role-policy"
  role = "${aws_iam_role.role.id}"
  policy = "${file("test-role-policy.json")}"
}


resource "aws_iam_role_policy" "destory_stack_role_policy" {
  name = "destroy-service-role-policy"
  role = "${aws_iam_role.destroy_role.id}"
  policy = "${file("test-destroy-role-policy.json")}"
}

resource "aws_iam_role_policy" "hook_role_policy" {
  name = "hook-role-policy"
  role = "${aws_iam_role.hook_role.id}"
  policy = "${file("test-hook-role-policy.json")}"
}



resource "aws_iam_role" "role" {
  name = "test_role"
  description = "My custom role"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

}


resource "aws_iam_role" "destroy_role" {
  name = "test_destory_role"
  description = "My custom role"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

}

resource "aws_iam_role" "hook_role" {
  name = "test_hook_role"
  description = "My custom role"
  force_detach_policies = true
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF


}