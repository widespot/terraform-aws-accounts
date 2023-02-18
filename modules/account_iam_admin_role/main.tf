terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

locals {
  tags = merge({TerraformModule = "git::https://github.com/raphaeljoie/terraform-aws-accounts//modules/account_iam_admin_role"}, var.tags)
}

resource "aws_iam_role" "iam_admin_access_role" {
  name = "IamAccountAdminAccessRole"

  description = ""

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

  tags = local.tags
}

data "aws_iam_policy" "builtin_admin_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "iam_admin_access_role_policy" {
  policy_arn = data.aws_iam_policy.builtin_admin_policy.arn
  role = aws_iam_role.iam_admin_access_role.name
}
