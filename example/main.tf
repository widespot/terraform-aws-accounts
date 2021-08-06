module "accounts" {
  source = "../"

  accounts = [{
    email = "aws.prod@domain.com"
    name = "Prod"
  }]

  iam_account_email = "aws.iam@domain.com"
}

module "prod_account_iam_admin_role" {
  source = "../modules/account_iam_role"

  account_id = module.accounts.account_ids[0]
}
