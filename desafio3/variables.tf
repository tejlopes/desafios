# Global
variable "region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}

# VPC
variable "vpc_cidr_challenge_empresa3" {
  description = "CIDR of vpc challenge empresa3"
  type        = string
}

variable "azs_challenge_empresa3" {
  description = "azs of challenge empresa3"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "private_subnets_challenge_empresa3" {
  description = "private subnets of challenge empresa3"
  type        = list(string)
}

variable "public_subnets_challenge_empresa3" {
  description = "public subnets of challenge empresa3"
  type        = list(string)
}