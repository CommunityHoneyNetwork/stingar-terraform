resource "aws_security_group" "generic-honeypot-sg" {
  name        = "generic-honeypot-sg"
  description = "SG Shared between all honeypots"

  # Outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.real_ssh_port}"
    to_port = "${var.real_ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
