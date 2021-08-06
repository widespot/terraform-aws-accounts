terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

resource "aws_iam_role" "iam_admin_access_role" {
  provider = "aws.account"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        Effect= "Allow",
        Principal= {
          "AWS": "arn:aws:iam::${var.iam_account_id}:root"
        },
        Action= "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_admin_access_role_policy" {
  provider = "aws.account"

  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.iam_admin_access_role
}
