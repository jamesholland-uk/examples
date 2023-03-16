# Project Variables
name_prefix = "lab"

# AWS Provider Variables
aws_region     = "us-east-1"
aws_access_key = "ABCDE"
aws_secret_key = "a1b2c3d4e5"

# VPC Variables
vpc_supernet          = "10.1.0.0/16"
mgmt_subnet           = "10.1.2.0/24"
outside_subnet        = "10.1.3.0/24"
inside_subnet         = "10.1.4.0/24"
vpc_availability_zone = "us-east-1c"
security_vpc_security_groups = {
  vmseries_mgmt = {
    name = "vmseries_mgmt"
    rules = {
      all_outbound = {
        description = "Permit All traffic outbound"
        type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
      https = {
        description = "Permit HTTPS"
        type        = "ingress", from_port = "443", to_port = "443", protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ssh = {
        description = "Permit SSH"
        type        = "ingress", from_port = "22", to_port = "22", protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}

# PAN-OS VM-Series Variables
ssh_key                = "ssh-rsa AAA...5z4rE user@machine" # This is an SSH public key. On Mac/Linux you may find this with "cat ~/.ssh/id_rsa.pub", or you may need/want to create a new SSH keypair first
vm_series_product_code = "hd44w1chf26uv4p52cdynb2o"         # Product codes from https://docs.paloaltonetworks.com/vm-series/11-0/vm-series-deployment/set-up-the-vm-series-firewall-on-aws/deploy-the-vm-series-firewall-on-aws/obtain-the-ami/get-amazon-machine-image-ids
vm_series_version      = "10.2.3"
