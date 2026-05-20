variable "aws_region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "gitops-eks-cluster"
}

variable "repository_name" {
  default = "argo-app"
}

variable "slack_webhook_url" {
  type = string
  sensitive = true

}