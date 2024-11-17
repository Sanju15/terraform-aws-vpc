# VPC Variables
variable "vpc_name" {
    description = "Name of the VPC"
}

variable "vpc_cidr_block" {
    description = "The VPC Cidr block"
}

variable "public_subnet_cidr" {
    description = "Public subnet cidr"
}

variable "public_subnet_az" {
    description = "Public subnet Availability Zone"
}

variable "private_subnet_cidr" {
    description = "Private subnet cidr"
}

variable "private_subnet_az" {
    description = "Private subnet Availability Zone"
}

variable "internet_gateway_name" {
    description = "Internet gateway name"
}

variable "route_table_publlc_cidr" {
  description = "Route table public cidr"
}

variable "route_table_name" {
  description = "Route table name"
}

variable "subnet_count" {
  description = "Subnet count"
}

variable "subnet_azs" {
    description = "Public/Private subnet Availability Zone"
    type        = list(string)
}

variable "private_subnet_cidrs" {
    description = "Private subnet cidr"
    type        = list(string)
}

variable "public_subnet_cidrs" {
    description = "Public subnet cidr"
    type        = list(string)
}

variable "eks_cluster_name" {
  description = "EKS Cluster name"
}