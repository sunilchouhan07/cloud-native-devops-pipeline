module "postgres" {
  source             = "../modules/RDS"
  private_subnet_ids = module.vpc.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  env                = local.env
  vpc_id             = module.vpc.id
  vpc_cidr           = module.vpc.vpc_cidr
}