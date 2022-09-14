resource "aws_iam_role" "iam_eks_role_desafio" {
  name = "eks_cluster_role_desafio"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_desafio" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_eks_role_desafio.name
}

resource "aws_iam_role" "iam_eks_node_group_desafio" {
  name = "eks_node_group_desafio"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "node_group_node_policy_desafio" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam_eks_node_group_desafio.name
}

resource "aws_iam_role_policy_attachment" "node_group_cni_policy_desafio" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam_eks_node_group_desafio.name
}

resource "aws_iam_role_policy_attachment" "node_group_container_registry_policy_desafio" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam_eks_node_group_desafio.name
}

resource "aws_eks_cluster" "eks_cluster_desafio" {
  name     = "eks_desafio"
  role_arn = aws_iam_role.iam_eks_role_desafio.arn

  vpc_config {
    subnet_ids = module.vpc-desafio.private_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_desafio
  ]
}

resource "aws_eks_node_group" "node_group_desafio" {
  cluster_name    = aws_eks_cluster.eks_cluster_desafio.name
  node_group_name = "node_group_desafio"
  node_role_arn   = aws_iam_role.iam_eks_node_group_desafio.arn
  subnet_ids      = module.vpc-desafio.private_subnets

  scaling_config {
    desired_size = var.eks_nodes_desired_desafio
    max_size     = var.eks_nodes_max_desafio
    min_size     = var.eks_nodes_min_desafio
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_node_policy_desafio,
    aws_iam_role_policy_attachment.node_group_cni_policy_desafio,
    aws_iam_role_policy_attachment.node_group_container_registry_policy_desafio
  ]
}