data "aws_ami" "amzn_linux" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-2017.09.1.*-x86_64-gp2"
    ]
  }

  filter {
    name = "owner-alias"
    values = [
      "amazon"
    ]
  }
}

resource "aws_instance" "master" {
  ami = "${data.aws_ami.amzn_linux.id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_pair}"
  vpc_security_group_ids = [
    "${aws_security_group.prometheus_http.id}",
    "${aws_security_group.allow_all_egress.id}",
    "${aws_security_group.allow_ssh_ingress.id}"
  ]
  iam_instance_profile = "${aws_iam_instance_profile.prometheus_master.name}"

  tags {
    PrometheusEnabled = true
  }
}

resource "aws_instance" "nodes" {
  count = 2
  ami = "${data.aws_ami.amzn_linux.id}"
  instance_type = "t2.micro"
  key_name = "${var.key_pair}"
  vpc_security_group_ids = [
    "${aws_security_group.allow_all_egress.id}",
    "${aws_security_group.allow_ssh_ingress.id}",
    "${aws_security_group.prometheus_node.id}"
  ]

  tags {
    PrometheusEnabled = true
  }
}

