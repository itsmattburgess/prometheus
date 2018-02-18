resource "aws_security_group" "prometheus_http" {
  name = "prometheus_http"
  description = "Allow prometheus traffic"

  ingress {
    from_port = 9090
    to_port = 9090
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "prometheus_node" {
  name = "prometheus_node"
  description = "Allow prometheus metric traffic to the master prometheus servers"

  ingress {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    security_groups = [
      "${aws_security_group.prometheus_http.id}"
    ]
  }
}

resource "aws_security_group" "allow_all_egress" {
  name = "allow_all_egress"
  description = "Allow all outbound traffic"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "allow_ssh_ingress" {
  name = "allow_ssh_ingress"
  description = "Allow all SSH"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

