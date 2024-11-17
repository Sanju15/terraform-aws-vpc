variable "eks_cluster_name" {
  description = "EKS cluster name"
}

variable "eks_cluster_version" {
  default = 1.31
  description = "EKS cluster version"
}

variable "vpc_id" {
  description = "EKS VPC id"
}

variable "subnet_ids" {
  description = "EKS subnet ids"
  type = list(string)
}

variable "eks_node_ec2_instance_types" {
  description = "EKS node EC2 instance types"
  default = "t3.medium"
}

variable "eks_node_instance_ami" {
  description = "EKS node EC2 instance ami"
  default = "AL2023_x86_64_STANDARD"
}