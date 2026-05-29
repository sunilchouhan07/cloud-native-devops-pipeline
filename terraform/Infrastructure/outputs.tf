output "ecr_repo_url" {
  value = module.ecr_repo.ecr_url
}

# output "repository_name" {
#   value = aws_ecr_repository.app_repo.name
# }

output "eks_cluster_name" {
  value = module.eks_main.cluster_name
}

output "rds_endpoint" {
  value = module.postgres.rds_endpoint
}