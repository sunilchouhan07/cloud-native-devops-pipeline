module "vpc" {
  source          = "../modules/VPC"
  vpc_cidr        = "10.0.0.0/16"
  env             = local.env
  nat_subnet_name = "pub1"
  public_subnets = {
    pub1 = {
      cidr = "10.0.1.0/24"
      az   = "ap-south-1a"
    }

    pub2 = {
      cidr = "10.0.2.0/24"
      az   = "ap-south-1b"
    }
  }

  private_subnets = {
    pri1 = {
      cidr = "10.0.3.0/24"
      az   = "ap-south-1a"
    }

    pri2 = {
      cidr = "10.0.4.0/24"
      az   = "ap-south-1b"
    }
  }
}