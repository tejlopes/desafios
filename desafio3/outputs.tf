# Show account id
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Show arn account id
output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

# Show user id 
output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

# Show create apache IP
output "ec2_global_ips" {
  value = ["${aws_instance.web_instance.*.public_ip}"]
}