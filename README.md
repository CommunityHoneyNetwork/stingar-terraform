Stingar-Terraform
=================

Most of this config and documentation comes from
[CloudDeploy](https://github.com/CommunityHoneyNetwork/cloud-deploy).  This new
repo config implements pushing the actual honeypot containers out and
registering them with the CHNServer

This repository contains tools to provision and configure infrastructure for
[CommunityHoneyNetwork](https://communityhoneynetwork.readthedocs.io/)
honeypots and management servers in cloud hosting services like Amazon
Webservices.

## Prerequesites

Infrastructure is described and created using a
[Terraform](https://www.terraform.io/) _configuration_, and the resulting
instances/servers are setup with [Ansible](https://www.ansible.com/)
_playbooks_.

  * [Terraform](https://www.terraform.io/) >= v0.10.6
  * [Ansible](https://www.ansible.com/) >= 2.4.0.0
  * [Terraform-Inventory](https://github.com/adammck/terraform-inventory) >= 0.6.1.
  * A cloud provider account

Currently only AWS is supported, but support for other providers is comming.

## Credentials

There are a number of ways to provide your AWS account credentials for
Terraform to use: specified statically in the .tf config in the `provider
"aws"` object, as environment variables, in a shared credentials file, etc.
See the [Terraform AWS Provider Credentials
documentation](https://www.terraform.io/docs/providers/aws/) for more info. It
is generally recommended to create an IAM user and credentials specifically for
this use case.

## Deployment

If you have a greenfield (no existing AWS infrastructure), just hit go (see
below). Otherwise, customize the default.tfvars to fit within your environment.
Special care should be taken with the VPC CIDR (making sure it doesn't overlap
with any existing AWS infrastructure you may have) and traffic ingress rules.
Most importantly, set the `ssh_ingress_blocks` variable to be an array
containing the IPs or Subnets (in CIDR notation) from which your hosts should
allow SSH connections.  This *must* include the host that will perform the
Ansible configuration.

Note that any files matching `*.auto.tfvars` can be automatically loaded as
var-files

An example default.auto.tfvars file:

```
trusted_network = "1.2.3.4/24"
authorized_keys = [
    "ssh-ed25519 my-key-blahblah user@example.com"
]
```

Once your `.auto.tfvars` file is setup, build the infrastructure by running:

    terraform apply

This will run through the process of creating the VPC, Subnets, Security groups
and EC2 instances described in the Terraform configuration files.

## Additional Information

### Listing honeypot public IPs

You can view a list of your honeypots using the terraform-inventory tool, like
so:

```
terraform-inventory --list | jq
```

This will give you a nice view of each honeypot group and IP

### Real SSH

By default, the real ssh port for each honeypot is 4222.  If you would like to
change this, add the following to your custom tfvars file:

```
real_ssh_port = 2323
```

### Logging in

CHN-Server will be listning on port 80 (for now).  To retrieve the default
username/password and IP of this host, run the following ansible playbook:

```
ansible-playbook -i $(which terraform-inventory) ./admin_password.yaml
```
