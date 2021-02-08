// TBD
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami = "ami-0a91cd140a1fc148a"
  instance_type = "t2.micro"

  tags = {
    Name = "Wordpress"
  }
}

resource "aws_iam_role" "Wordpress_EC2" {
  name = "Wordpress_EC2"

  assume_role_policy = <<EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": [
                  "rds:*",
                  "application-autoscaling:DeleteScalingPolicy",
                  "application-autoscaling:DeregisterScalableTarget",
                  "application-autoscaling:DescribeScalableTargets",
                  "application-autoscaling:DescribeScalingActivities",
                  "application-autoscaling:DescribeScalingPolicies",
                  "application-autoscaling:PutScalingPolicy",
                  "application-autoscaling:RegisterScalableTarget",
                  "cloudwatch:DescribeAlarms",
                  "cloudwatch:GetMetricStatistics",
                  "cloudwatch:PutMetricAlarm",
                  "cloudwatch:DeleteAlarms",
                  "ec2:DescribeAccountAttributes",
                  "ec2:DescribeAvailabilityZones",
                  "ec2:DescribeCoipPools",
                  "ec2:DescribeInternetGateways",
                  "ec2:DescribeLocalGatewayRouteTables",
                  "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
                  "ec2:DescribeLocalGateways",
                  "ec2:DescribeSecurityGroups",
                  "ec2:DescribeSubnets",
                  "ec2:DescribeVpcAttribute",
                  "ec2:DescribeVpcs",
                  "ec2:GetCoipPoolUsage",
                  "sns:ListSubscriptions",
                  "sns:ListTopics",
                  "sns:Publish",
                  "logs:DescribeLogStreams",
                  "logs:GetLogEvents",
                  "outposts:GetOutpostInstanceTypes"
              ],
              "Effect": "Allow",
              "Resource": "*"
          },
          {
              "Action": "pi:*",
              "Effect": "Allow",
              "Resource": "arn:aws:pi:*:*:metrics/rds/*"
          },
          {
              "Action": "iam:CreateServiceLinkedRole",
              "Effect": "Allow",
              "Resource": "*",
              "Condition": {
                  "StringLike": {
                      "iam:AWSServiceName": [
                          "rds.amazonaws.com",
                          "rds.application-autoscaling.amazonaws.com"
                      ]
                  }
              }
          }
      ]
  }
  EOF
}
