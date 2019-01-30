data "template_file" "ansible_cfg" {

  template = "${file("ansible.cfg.tpl")}"

  vars {
      real_ssh_port = "${var.real_ssh_port}"
  }

}

resource "local_file" "write_ansible_cfg" {

    filename = "ansible.cfg"
    content = "${data.template_file.ansible_cfg.rendered}"

}
resource "null_resource" "deploy_app" {

  provisioner "local-exec" {
    command = "ansible-playbook -i $(which terraform-inventory) site.yaml --extra-vars=internal_chn_ip=${aws_instance.chn_server.private_ip} --extra-vars=ansible_ssh_port=${var.real_ssh_port} prefix=${prefix}"
  } 

  depends_on = [
    "aws_instance.*.*",
    "local_file.write_ansible_cfg"
  ]

}
