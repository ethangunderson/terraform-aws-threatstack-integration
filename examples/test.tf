provider "aws" {
  region = "us-east-1"
}

module "threatstack" {
  source = ".."
  threatstack_account_id = "12345"
  threatstack_external_id = "123abc"
  threatstack_s3_bucket_name = "threatstack_terraform_example"
}
