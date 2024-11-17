# VPC, Subnet Modules 
# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# public Subnet
resource "aws_subnet" "public_subnet"{
    count = var.subnet_count
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(var.subnet_azs, count.index)
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-${element(var.subnet_azs, count.index)}"
    }
}

# private Subnet
resource "aws_subnet" "private_subnet"{
    count = var.subnet_count
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.private_subnet_cidrs, count.index)
    availability_zone = element(var.subnet_azs, count.index)
    tags = {
      Name = "private-subnet-${element(var.subnet_azs, count.index)}"
  }
}