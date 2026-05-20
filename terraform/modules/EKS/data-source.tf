data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.eks.name
}

data "tls_certificate" "eks_certificate" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}