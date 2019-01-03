data "template_file" "cloud_init" {

  template = "${file("user-data.tpl")}"

  vars {
      authorized_keys = "${jsonencode(var.authorized_keys)}"
      ssh_port = "${var.real_ssh_port}"
  }

}
