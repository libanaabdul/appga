
module "libvpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = "vpc-lib"
  cidr = "10.1.96.0/24"

  azs                  = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets      = ["10.1.96.128/28", "10.1.96.144/28", "10.1.96.160/28"]
  public_subnets       = ["10.1.96.0/28", "10.1.96.16/28"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
  }
}
