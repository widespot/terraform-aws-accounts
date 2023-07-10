variable "accounts" {
  description = "Map of account description map, sorted by name, with required email "
  type = map(object({
    email = string
  }))
}

variable "iam_account_email" {
  description = "email address used for the Iam account. No Iam account is created if no email is provided"
  type = string
  default = null
}
