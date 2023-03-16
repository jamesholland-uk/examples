# Create a VPC
module "the_vpc" {
  source  = "PaloAltoNetworks/vmseries-modules/aws//modules/vpc"
  version = "0.4.1"

  name                    = "${var.name_prefix}_vpc"
  cidr_block              = var.vpc_supernet
  create_internet_gateway = true
}

# Create subnets
resource "aws_subnet" "mgmt_subnet" {
  vpc_id            = module.the_vpc.id
  cidr_block        = var.mgmt_subnet
  availability_zone = var.vpc_availability_zone
}

resource "aws_subnet" "outside_subnet" {
  vpc_id            = module.the_vpc.id
  cidr_block        = var.outside_subnet
  availability_zone = var.vpc_availability_zone
}

resource "aws_subnet" "inside_subnet" {
  vpc_id            = module.the_vpc.id
  cidr_block        = var.inside_subnet
  availability_zone = var.vpc_availability_zone
}

# Create route table
resource "aws_route_table" "internet_route_table" {
  vpc_id = module.the_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.the_vpc.internet_gateway.id
  }
}

# Assign route table to subnet
resource "aws_route_table_association" "route_table_association_mgmt" {
  subnet_id      = aws_subnet.mgmt_subnet.id
  route_table_id = aws_route_table.internet_route_table.id
}

# Create Security Group
resource "aws_security_group" "vmseries_mgmt_access" {
  name   = "vmseries_mgmt_access"
  vpc_id = module.the_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create key pair for initial SSH to VM-Series
resource "aws_key_pair" "ssh_key_pair" {
  key_name   = "vmseries_ssh_key_pair"
  public_key = var.ssh_key
}

# Create the VM-Series
module "the_vmseries" {
  source  = "PaloAltoNetworks/vmseries-modules/aws//modules/vmseries"
  version = "0.4.1"

  name                  = var.name_prefix
  vmseries_product_code = var.vm_series_product_code
  vmseries_version      = var.vm_series_version
  ssh_key_name          = aws_key_pair.ssh_key_pair.key_name

  interfaces = {
    mgmt = {
      device_index       = 0
      subnet_id          = aws_subnet.mgmt_subnet.id
      name               = "mgmt"
      create_public_ip   = true
      security_group_ids = [aws_security_group.vmseries_mgmt_access.id]
    },
    public = {
      device_index       = 1
      subnet_id          = aws_subnet.outside_subnet.id
      name               = "outside"
      create_public_ip   = true
      security_group_ids = []
    },
    private = {
      device_index       = 2
      subnet_id          = aws_subnet.inside_subnet.id
      name               = "inside"
      create_public_ip   = false
      security_group_ids = []
    },
  }
}
