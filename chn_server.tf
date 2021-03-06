resource "aws_instance" "chn_server" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  user_data = "${data.template_file.cloud_init.rendered}"
  vpc_security_group_ids = [
    "${aws_security_group.chn-server-sg.id}"
  ]

  tags {
    Name    = "chn-server-${count.index}"
    Stingar_Type = "chn_server"
  }
}

resource "aws_security_group" "chn-server-sg" {
  name        = "chn-server-sg"
  description = "CHN Server Security Group"

  # TODO: How do we want to limit ssh access in?
  ingress {
    from_port = "${var.real_ssh_port}"
    to_port = "${var.real_ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["${var.trusted_network}"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "${var.trusted_network}",
    ]
    security_groups = [
      "${aws_security_group.generic-honeypot-sg.id}"
    ]
  }

  ingress {
    from_port = 10000
    to_port = 10000
    protocol = "tcp"
    cidr_blocks = [
      "${var.trusted_network}",
    ]
    security_groups = [
      "${aws_security_group.generic-honeypot-sg.id}"
    ]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.trusted_network}"]
  }

  # Outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
