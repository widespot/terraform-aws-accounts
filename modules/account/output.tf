output "account_id" {
  description = "Identifier of the account created"
  value = aws_organizations_account.account.id
}
output "account_key" {
  description = "Key identifier of the account created"
  value = var.account_key
}
output "account_arn" {
  description = "ARN of the account created"
  value = aws_organizations_account.account.arn
}
output "account_email" {
  description = "Email associated to the account created"
  value = aws_organizations_account.account.name
}
output "root_admin_role_arn" {
  description = "ARN of the admin role to be assumed by users in root account"
  value = local.role
}
output "root_admins_group_id" {
  description = "ID of the user group created in the root account, allowed to assume Admin role in the new account"
  value = aws_iam_group.root_admins_group.id
}
output "root_admins_group_name" {
  description = "name of the user group created in the root account, allowed to assume Admin role in the new account"
  value = aws_iam_group.root_admins_group.name
}
output "root_admins_group_arn" {
  description = "ARN of the user group created in the root account, allowed to assume Admin role in the new account"
  value = aws_iam_group.root_admins_group.arn
}
output "root_admin_policy_arn" {
  description = "ARN of the policy created in the root account to allow Admin role usage in the new account"
  value = aws_iam_policy.root_admin_policy.arn
}
