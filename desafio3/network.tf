# Create module vpc vpc-challenge-empresa3
module "vpc-challenge-empresa3" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-challenge-empresa3"
  cidr = var.vpc_cidr_challenge_empresa3

  single_nat_gateway   = true
  azs                  = var.azs_challenge_empresa3
  private_subnets      = var.private_subnets_challenge_empresa3
  public_subnets       = var.public_subnets_challenge_empresa3
  enable_dns_hostnames = true

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

# Create security group of vpc-challenge-empresa3
resource "aws_security_group" "allow_vpc_challenge_empresa3_sg" {
  name        = "allow_vpc_challenge_empresa3_sg"
  description = "Allow inbound traffic to VPC challenge empresa3"
  vpc_id      = module.vpc-challenge-empresa3.vpc_id

  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description = "Web traffic"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}