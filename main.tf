resource "aws_organizations_organization" "org" {
}

module "iam_account" {
  count = var.iam_account_email == null ? 0 : 1

  source   = "./modules/account"

  account_email = var.iam_account_email
  account_key = "Iam"

  depends_on = [aws_organizations_organization.org]
}

module "accounts" {
  for_each = var.accounts

  source   = "./modules/account"

  account_email = each.value.email
  account_key = each.key

  depends_on = [aws_organizations_organization.org]
}

## Create global root admin user group and users

resource "aws_iam_group" "global_root_admins_group" {
  name = "GlobalRootAdmins"
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  for_each = module.accounts

  group = aws_iam_group.global_root_admins_group.name
  policy_arn = each.value.root_admin_policy_arn
}

resource "aws_iam_group_policy_attachment" "iam_root_admin_policy_global_attachment" {
  count = var.iam_account_email == null ? 0 : 1

  group = aws_iam_group.global_root_admins_group.name
  policy_arn = module.iam_account[0].root_admin_policy_arn
}

data "aws_caller_identity" "current" {}

locals {
  username = replace(data.aws_caller_identity.current.arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/", "")
}

resource "aws_iam_group_membership" "global_root_admins" {
  group = aws_iam_group.global_root_admins_group.name
  name = "global_root_admins"

  users = [local.username]
}
