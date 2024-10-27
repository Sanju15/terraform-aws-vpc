# Create VPC
module "vpc" {
    source = "./modules/vpc"
    vpc_name = var.vpc_name
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_name = var.public_subnet_name
    public_subnet_az = var.public_subnet_az
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_name = var.private_subnet_name
    private_subnet_az = var.private_subnet_az
    private_subnet_cidr = var.private_subnet_cidr
}


# Create Network for VPC - IGW, RouteTable, Nat GW
module "network" {
  source = "./modules/network"
  vpc_id = module.vpc.vpc_id
  internet_gateway_name = var.internet_gateway_name
  route_table_publlc_cidr = var.route_table_publlc_cidr
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  route_table_name = var.route_table_name
}