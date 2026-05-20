provider "aws" {
  region = "ap-south-1"
}

provider "helm" {

  kubernetes = {
    host = data.aws_eks_cluster.eks.endpoint

    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.eks.certificate_authority[0].data
    )

    token = data.aws_eks_cluster_auth.eks.token
  }
}