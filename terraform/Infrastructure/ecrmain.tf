module "ecr_repo" {
  source               = "../modules/ECR"
  env                  = local.env
  repository_name      = "${local.env}-gitops-repo"
  image_tag_mutability = "IMMUTABLE"

}