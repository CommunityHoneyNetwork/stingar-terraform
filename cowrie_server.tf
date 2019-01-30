resource "aws_instance" "${prefix}cowrie_server" {
  ami           = "${data.aws_ami.ubuntu.id}"
  count         = "${lookup(var.honeypot_counts, "cowrie", var.honeypot_counts["undefined"])}"
  instance_type = "${var.instance_type}"
  user_data = "${data.template_file.cloud_init.rendered}"
  vpc_security_group_ids = [
    "${aws_security_group.cowrie-server-sg.id}",
    "${aws_security_group.generic-honeypot-sg.id}"
  ]

  tags {
    Name    = "cowrie-server-${count.index}"
    Stingar_Type = "cowrie_server"
  }

}

resource "aws_security_group" "${prefix}cowrie-server-sg" {
  name        = "cowrie-server-sg"
  description = "Cowrie Server Security Group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
