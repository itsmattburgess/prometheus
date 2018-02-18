output "master_dns" {
  value = "${aws_instance.master.public_dns}"
}

output "ansible_inventory" {
  value = "${data.template_file.ansible_inventory.rendered}"
}
