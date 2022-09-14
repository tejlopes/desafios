module "vpc-desafio" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-desafio"
  cidr = var.vpc_cidr_desafio

  single_nat_gateway   = true
  azs                  = var.azs_desafio
  private_subnets      = var.private_subnets_desafio
  public_subnets       = var.public_subnets_desafio
  enable_dns_hostnames = true

  enable_nat_gateway = true
  enable_vpn_gateway = true
}