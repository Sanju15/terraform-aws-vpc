resource "aws_iam_role" "Eks_cluster_role" {
  name = "Eks_cluster_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role = aws_iam_role.Eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "Eks_node_role" {
  name = "Eks_node_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  role = aws_iam_role.Eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  role = aws_iam_role.Eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_readonly_policy" {
  role = aws_iam_role.Eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.29.0"
  cluster_name = var.eks_cluster_name
  cluster_version = var.eks_cluster_version
  vpc_id = var.vpc_id
  iam_role_arn = aws_iam_role.Eks_cluster_role.arn
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
        max_size = 2
        desired_size = 1
        iam_role_arn = aws_iam_role.Eks_node_role.arn
    }
  }
  enable_cluster_creator_admin_permissions = true
}