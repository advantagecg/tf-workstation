module "create_new_account" {
  source = "git@github.com:advantagecg/tf-blueprint.git//modules/accounts?ref=master"

  new_account_is_enabled  = true
  name_account            = "dev-automation"
  email_account           = "dev-automation@example.com"
  account_env             = "dev"
  account_team            = "automation"
  new_account_user_name   = "automation-user"
  region                  = var.region

  
}



-rw-r--r--   1 root root 2358 May 29 01:43 79c585a2557910d.crt
-rw-r--r--   1 root root 2358 May 29 01:43 79c585a2557910d.pem
-rw-r--r--   1 root root 3095 May 29 01:43 gd_bundle-g2.crt
