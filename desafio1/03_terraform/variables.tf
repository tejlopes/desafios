variable "region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_desafio" {
  description = "CIDR desafio"
  type        = string
}

variable "azs_desafio" {
  description = "azs desafio"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "private_subnets_desafio" {
  description = "private subnets desafio"
  type        = list(string)
}

variable "public_subnets_desafio" {
  description = "public subnets desafio"
  type        = list(string)
}

variable "eks_nodes_max_desafio" {
  description = "Número máximo de nodes do eks"
  type        = number
  default     = 1
}

variable "eks_nodes_min_desafio" {
  description = "Número mínimo de nodes do eks"
  type        = number
  default     = 1
}

variable "eks_nodes_desired_desafio" {
  description = "Número desired de nodes do eks"
  type        = number
  default     = 1
}