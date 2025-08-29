# modules/vpc/main.tf
module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "5.5.3"
  name                = var.name
  cidr                = var.cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  enable_dns_support  = var.enable_dns_support
  enable_dns_hostnames= var.enable_dns_hostnames
  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  tags                = var.tags
}
