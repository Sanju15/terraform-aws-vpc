#create VPC
resource "aws_vpc" "pro-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "pro-vpc"
  }
}

resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.pro-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "pro-public-subnet_us-east-1a"
    }
}

resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.pro-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "pro-private-subnet_us-east-1a"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.pro-vpc.id
    tags = {
      Name = "pro-igw"
    }
}

resource "aws_route_table" "rttable" {
    vpc_id = aws_vpc.pro-vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
}

resource "aws_route_table_association" "ratableassocia" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rttable.id
}

resource "aws_eip" "pro_nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id = aws_subnet.private_subnet.id
  allocation_id = aws_eip.pro_nat_eip.id
  depends_on = [aws_internet_gateway.igw]
}