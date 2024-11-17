# VPC Variables
variable "vpc_name" {
    description = "Name of the VPC"
}

variable "vpc_cidr_block" {
    description = "The VPC Cidr block"
}

variable "subnet_count" {
  description = "Subnet count"
}

variable "public_subnet_cidrs" {
    description = "Public subnet cidr"
    type        = list(string)
}

variable "subnet_azs" {
    description = "Public/Private subnet Availability Zone"
    type        = list(string)
}

variable "private_subnet_cidrs" {
    description = "Private subnet cidr"
    type        = list(string)
}