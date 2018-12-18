resource "null_resource" "deploy_app" {

  provisioner "local-exec" {
    command = "ansible-playbook -i $(which terraform-inventory) site.yaml --extra-vars=internal_chn_ip=${aws_instance.chn_server.private_ip}"
  } 

  depends_on = [
    "aws_instance.chn_server",
    "aws_instance.cowrie_server"
  ]

}
