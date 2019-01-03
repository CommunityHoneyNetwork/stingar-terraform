resource "aws_instance" "dionaea_server" {
  ami           = "${data.aws_ami.ubuntu.id}"
  count         = "${lookup(var.honeypot_counts, "dionaea", var.honeypot_counts["undefined"])}"
  instance_type = "${var.instance_type}"
  user_data = "${data.template_file.cloud_init.rendered}"
  vpc_security_group_ids = [
    "${aws_security_group.dionaea-server-sg.id}",
    "${aws_security_group.generic-honeypot-sg.id}"
  ]

  tags {
    Name    = "dionaea-server-${count.index}"
    Stingar_Type = "dionaea_server"
  }

}

resource "aws_security_group" "dionaea-server-sg" {
  name        = "dionaea-server-sg"
  description = "Cowrie Server Security Group"

  ingress {
    from_port = "21"
    to_port = "21"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "23"
    to_port = "23"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "445"
    to_port = "445"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
