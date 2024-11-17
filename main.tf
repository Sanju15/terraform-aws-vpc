# Create VPC
module "vpc" {
    source = "./modules/vpc"
    subnet_count = var.subnet_count
    vpc_name = var.vpc_name
    vpc_cidr_block = var.vpc_cidr_block
    subnet_azs = var.subnet_azs
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
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

module "eks" {
  source = "./modules/eks"
  eks_cluster_name = var.eks_cluster_name
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_id
}