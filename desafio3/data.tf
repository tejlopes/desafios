# Ports of http and https
locals {
  ports_in = [
    443,
    80
  ]
}

# Locals userdata
locals {
  userdata = templatefile("files/user_data.sh", {
    ssm_cloudwatch_config = aws_ssm_parameter.cw_agent.name
  })
}

# Locals role policy arn needed
locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
}

# GET ACCOUNT THAT TERRAFORM WILL BE RUN
data "aws_caller_identity" "current" {}

# Get image amazon linux 2 most recent
data "aws_ami" "amazon_linux_ec2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}