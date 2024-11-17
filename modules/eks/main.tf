module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.29.0"
  cluster_name = var.eks_cluster_name
  cluster_version = var.eks_cluster_version
  vpc_id = var.vpc_id
  enable_irsa = true
  tags = {
    cluster = "var.eks_cluster_name"
  }
  subnet_ids = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

  eks_managed_node_group_defaults = {
    ami_type = var.eks_node_instance_ami
    instance_types = [var.eks_node_ec2_instance_types]
  }

  eks_managed_node_groups = {
    node_group = {
        min_size = 2
        max_size = 3
        desired_size = 2
    }
  }
  enable_cluster_creator_admin_permissions = true
}