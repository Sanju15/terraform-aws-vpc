variable "internet_gateway_name" {
    description = "Internet gateway name"
}

variable "route_table_publlc_cidr" {
    description = "route table public internet cidr"
}
variable "vpc_id" {
    description = "VPC identity"
}
variable "private_subnet_id" {
    description = "Private Subnet Id"
}
variable "public_subnet_id" {
    description = "Public Subnet Id"
}

variable "route_table_name" {
    description = "Public/Private route table name"
}