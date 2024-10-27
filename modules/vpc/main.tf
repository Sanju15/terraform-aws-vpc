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
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_subnet_az
    map_public_ip_on_launch = true
    tags = {
      Name = var.public_subnet_name
    }
}

# private Subnet
resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.private_subnet_az
    tags = {
      Name = var.private_subnet_name
    }
}