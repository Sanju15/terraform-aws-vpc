# internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = var.vpc_id
    tags = {
      Name = var.internet_gateway_name
    }
}

# route table
resource "aws_route_table" "public-route" {
    vpc_id = var.vpc_id
    route{
        cidr_block = var.route_table_publlc_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "${var.route_table_name}-public"
    }
}

resource "aws_route_table" "private-route" {
    vpc_id = var.vpc_id
    route{
        cidr_block = var.route_table_publlc_cidr
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
      Name = "${var.route_table_name}-private"
    }
}

# route table association
# public
resource "aws_route_table_association" "public_rt_a" {
  count = length(var.public_subnet_id)
  subnet_id = var.public_subnet_id[count.index]
  route_table_id = aws_route_table.public-route.id
}

#private
resource "aws_route_table_association" "private_rt_a" {
  count = length(var.private_subnet_id)
  subnet_id = var.private_subnet_id[count.index]
  route_table_id = aws_route_table.private-route.id
}

# eip for nat gateway
resource "aws_eip" "pro_nat_eip" {
  domain = "vpc"
}

# natgateway
resource "aws_nat_gateway" "nat_gw" {
  subnet_id = var.private_subnet_id[0]
  allocation_id = aws_eip.pro_nat_eip.id
  depends_on = [aws_internet_gateway.igw, aws_eip.pro_nat_eip]
}