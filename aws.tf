provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "stingar" {
  cidr_block                       = "${var.vpc_cidr}"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  assign_generated_ipv6_cidr_block = "false"

  tags {
    Name = "Stingar VPC"
  }
}

resource "aws_internet_gateway" "stingar" {
  vpc_id = "${aws_vpc.stingar.id}"

  tags {
    Name = "stingar-gateway"
  }
}

resource "aws_route_table" "stingar" {
  vpc_id = "${aws_vpc.stingar.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.stingar.id}"
  }

  tags {
    Name = "stingar-public-rt"
  }
}

resource "aws_subnet" "stingar" {
  vpc_id                  = "${aws_vpc.stingar.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  map_public_ip_on_launch = false

  tags {
    Name = "stingar-subnet"
  }

}

resource "aws_route_table_association" "stingar" {
  subnet_id      = "${aws_subnet.stingar.id}"
  route_table_id = "${aws_route_table.stingar.id}"
}
