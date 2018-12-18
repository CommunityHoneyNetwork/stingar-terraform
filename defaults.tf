variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "user_data_file" {
  default = "userdata.txt"
}

variable "trusted_network" {
  default = "0.0.0.0/0"
}

variable "vpc_cidr" {
  default = "10.99.0.0/26"
}

variable "public_subnet_cidr" {
  default = "10.99.0.16/28"
}

variable "honeypot_counts" {
  default = {
    "cowrie" = 2
  }
}
