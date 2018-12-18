resource "aws_instance" "cowrie_server" {
  ami           = "${data.aws_ami.ubuntu.id}"
  count         = "${var.honeypot_counts["cowrie"]}"
  instance_type = "${var.instance_type}"
  user_data = "${file(var.user_data_file)}"
  vpc_security_group_ids = [
    "${aws_security_group.cowrie-server-sg.id}"
  ]

  tags {
    Name    = "cowrie-server-${count.index}"
    Stingar_Type = "cowrie_server"
  }

}

resource "aws_security_group" "cowrie-server-sg" {
  name        = "cowrie-server-sg"
  description = "Cowrie Server Security Group"

  # TODO: How do we want to limit ssh access in?
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
