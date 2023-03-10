# Retrieve the VPC Endpoint deployed by Cloud NGFW
data "aws_vpc_endpoint" "the_vpc_endpoint" {
  vpc_id = local.aws_vpc_id
}

# Create routes to steer traffic into Cloud NGFW (uncomment once Cloud NGFW is successfully deployed with VPC endpoint(s))
resource "aws_route" "to_dmz2" {
  route_table_id         = local.dmz1_routetable_id
  destination_cidr_block = local.dmz2_subnet_cidr_block
  vpc_endpoint_id        = data.aws_vpc_endpoint.the_vpc_endpoint.id
}

resource "aws_route" "to_dmz1" {
  route_table_id         = local.dmz2_routetable_id
  destination_cidr_block = local.dmz1_subnet_cidr_block
  vpc_endpoint_id        = data.aws_vpc_endpoint.the_vpc_endpoint.id
}
