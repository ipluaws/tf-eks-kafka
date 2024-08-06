provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source                    = "./modules/vpc"
  vpc_name                  = "united"
  vpc_cidr                  = "10.0.0.0/16"
  public_subnet_cidr_blocks = ["10.0.10.0/24", "10.0.20.0/24"]
  private_subnet_cidr_blocks = ["10.0.30.0/24", "10.0.40.0/24"]
  availability_zones        = ["eu-central-1a", "eu-central-1b"]
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

module "eks" {
  source        = "./modules/eks"
  cluster_name  = var.cluster_name
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.public_subnet_ids
}


