terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket               = "gitops-bucket-7"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "env"
    region               = "ap-south-1"
    use_lockfile         = true
    encrypt              = true
  }
}

