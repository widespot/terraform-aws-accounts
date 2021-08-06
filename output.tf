output "iam_account_id" {
  value = var.iam_account_email == null ? null : module.iam_account[0].account_id
}

output "account_ids" {
  value ={for v in module.accounts : v.account_key => v.account_id}
}

output "root_admin_role_arns" {
  value ={for v in module.accounts : v.account_key => v.root_admin_role_arn}
}
