variable "region" {
  default = "us-east-1"
}

variable "prefix" {
  description = "Prefix for all entities"
  default = ""
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

variable "real_ssh_port" {
  description = "This is real SSH, not a honeypot"
  default = 4222
}

variable "authorized_keys" {
  description = "List of authorized keys used to do the deploy and log in as root"
  type = "list"
}

variable "honeypot_counts" {
  description = "Number of each type of honeypot to deploy"
  type = "map"
  default = {
    "cowrie" = 2
    "undefined" = 1
  }
}

variable "chn_version_tag" {

  description = "Tag for CHN release"
  default = "latest"

}
