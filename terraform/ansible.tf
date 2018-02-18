data "template_file" "ansible_inventory" {
  template = "${file("${path.module}/ansible_inventory.tpl")}"

  vars {
    master = "${aws_instance.master.public_dns}"
    nodes = "${join("\n", aws_instance.nodes.*.public_dns)}"
  }
}

