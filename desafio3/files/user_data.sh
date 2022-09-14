#! /bin/bash
set -e

exec > >(tee /var/log/user-data.log|logger -t user-data-extra -s 2>/dev/console) 2>&1

yum update -y
yum upgrade -y

yum install amazon-cloudwatch-agent httpd -y

systemctl start httpd
systemctl enable httpd

echo "<h1>This is a test from $(hostname -f) for empresa3 challenge </h1>" > /var/www/html/index.html

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s

echo 'Done initialization'