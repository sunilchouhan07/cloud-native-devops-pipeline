data "aws_eks_cluster" "eks" {
  name = "${local.env}-gitops-cluster"
}

data "aws_eks_cluster_auth" "eks" {
  name = "${local.env}-gitops-cluster"
}