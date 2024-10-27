# VPC Variables
variable "vpc_name" {
    description = "Name of the VPC"
}

variable "vpc_cidr_block" {
    description = "The VPC Cidr block"
}

variable "public_subnet_name" {
    description = "Name of the Public Subnet"
}

variable "public_subnet_cidr" {
    description = "Public subnet cidr"
}

variable "public_subnet_az" {
    description = "Public subnet Availability Zone"
}

variable "private_subnet_name" {
    description = "Name of the Private Subnet"
}

variable "private_subnet_cidr" {
    description = "Private subnet cidr"
}

variable "private_subnet_az" {
    description = "Private subnet Availability Zone"
}