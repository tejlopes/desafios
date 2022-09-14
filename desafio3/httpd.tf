# Create key par for aws ec2
resource "aws_key_pair" "key_challenge_empresa3" {
  key_name   = "challenge-empresa3"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDaAyaZNGiCrduAeBz9m9by754QRjazi2YQh7g0xJ5cqasfwXiQmh8rijAWTM/YEcKyR2L4YHHZxBrchkDOM1zjenXF3DLekfDZ7VDsJRFJibZY1yHs/PCP9UtdY5yHP2TIK7rYlWEC07BteeV15Nu37u6lhD5FHH2L7LkogCz940SeZaOd0Wcpsfe3k5499VLNXA+mDmj15mWT2kNAvnPoT3y6GnW1mX9CKxZcKCvaV5/a58XaN5K/B0FjaRZcmVbf3VewXo0yluLmfqvlMJzSb6vGV7NQtNXR7NlLJq4ll14zogEA/522IbWoN2DkdUf4ihFC+cfRr5hEwHVEoswOnjx6Ajf5D65MklDaQRjvi3sC7eVbouWqIyBLJpdSckyHsm6ASsbcLQP1Qc1Lhzd7S26sz9o8Yf0GTJH+7q+vMk29zwkFWxsg551QawJSE8WVw36tsBcriACXh1vJLsbQdW7BS7s64rDIVMKZR7goDByYDxN9hOpyARSJf43zXHk= thales@thales-lopes"
}

# Create ssm parameter
resource "aws_ssm_parameter" "cw_agent" {
  description = "Cloudwatch agent config to configure custom log and httpd"
  name        = "/cloudwatch-agent/config"
  type        = "String"
  value       = file("files/cw_agent_config.json")
}

# Create iam instance profile
resource "aws_iam_instance_profile" "empresa3_profile" {
  name = "empresa3_profile"
  role = aws_iam_role.challenge_empresa3_role.name
}

# Create iam role
resource "aws_iam_role" "challenge_empresa3_role" {
  name = "challenge_empresa3_role"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

# Attach policys to role
resource "aws_iam_role_policy_attachment" "challenge_empresa3_attach" {
  count = length(local.role_policy_arns)

  role       = aws_iam_role.challenge_empresa3_role.name
  policy_arn = element(local.role_policy_arns, count.index)
}

# Create iam role policy
resource "aws_iam_role_policy" "challenge_empresa3_role_policy" {
  name = "challenge_empresa3_role_policy"
  role = aws_iam_role.challenge_empresa3_role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:GetParameter"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

# Create aws instance ec2
resource "aws_instance" "web_instance" {
  ami                         = data.aws_ami.amazon_linux_ec2.image_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key_challenge_empresa3.key_name
  vpc_security_group_ids      = [aws_security_group.allow_vpc_challenge_empresa3_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.empresa3_profile.name
  user_data                   = local.userdata
  subnet_id                   = element(module.vpc-challenge-empresa3.public_subnets, 0)
}

# Create memory alarm
resource "aws_cloudwatch_metric_alarm" "memory" {
  alarm_name          = "memory-available-alarm-challenge-empresa3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "mem_available_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "This metric monitors ec2 memory utilization"
}

# Create cpu alarm
resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "cpu-utilization-alarm-challenge-empresa3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "cpu_usage_idle"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
}

# Create swap alarm
resource "aws_cloudwatch_metric_alarm" "swap" {
  alarm_name          = "swap-utilization-alarm-challenge-empresa3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "swap_used"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 swap_used utilization"
}