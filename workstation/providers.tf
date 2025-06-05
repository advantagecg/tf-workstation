provider "aws" {
  alias  = "new_account"
  region = var.region
  profile = var.profile   


  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.new_account[0].id}:role/OrganizationAccountAccessRole"
  }
}