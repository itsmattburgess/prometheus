resource "aws_iam_role" "prometheus_master" {
  name = "prometheus_master"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "prometheus_ec2_readonly" {
  role = "${aws_iam_role.prometheus_master.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "prometheus_master" {
  name = "prometheus_master"
  role = "${aws_iam_role.prometheus_master.name}"
}

