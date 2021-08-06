resource "aws_organizations_account" "account" {
  name  = var.account_email
  email = var.account_email
}

locals {
  role = "arn:aws:iam::${aws_organizations_account.account.id}:role/OrganizationAccountAccessRole"
}

resource "aws_iam_policy" "root_admin_policy" {
  name        = "Assume${var.account_key}AccountOrganizationAccountAccessRole"
  description = "Allow assume OrganizationAccountAccessRole in ${var.account_key} account"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "${local.role}"
        }
    ]
}
EOF
}

resource "aws_iam_group" "root_admins_group" {
  name = "${var.account_key}RootAdminsUserGroup"
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  group = aws_iam_group.root_admins_group.name
  policy_arn = aws_iam_policy.root_admin_policy.arn
}
