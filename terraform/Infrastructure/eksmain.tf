module "eks_main" {
  source             = "../modules/EKS"
  env                = local.env
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  cluster_name       = "${local.env}-gitops-cluster"
  node_group_name    = "${local.env}-gitops-node-group"
  desired_size       = 5
  max_size           = 7
  min_size           = 1
  instance_types     = ["t3.small"]
  capacity_type      = "ON_DEMAND"
}