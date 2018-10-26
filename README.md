# terraform-threatstack-module

Creates all of the necessary resources to integrate an AWS account with Threatstack.

## Usage

```
provider "aws" {
  region = "us-east-1"
}

module "threatstack" {
  source = ".."
  threatstack_account_id = "12345"
  threatstack_external_id = "123abc"
  threatstack_s3_bucket_name = "threatstack_terraform_example"
}
```

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| threatstack_account_id | The AWS account ID provided by Threatstack | `` | yes |
| threatstack_external_id | The external ID provided by Threatstack | `` | yes |
| threatstack_s3_bucket_name | Unique name for the S3 bucket | `` | yes |
| threatstack_sns_topic_name | Name used for the SNS topic | `threatstack` | no |
| threatstack_iam_role_name | Name used for IAM role | `threatstack` | no
| threatstack_iam_policy_name | Name used for the IAM policy | `threatstack` | no |
| threatstack_cloudtrail_name | Name used for the Cloudtrail | `threatstack` | no |
| threatstack_sqs_queue_name | Name used for the SQS queue | `threatstack` | no |

## Outputs
| Name |
|------|
| threatstack_cloudtrail_arn |
| threatstack_iam_role_arn |
| threatstack_s3_bucket_arn |
| threatstack_sns_topic_arn |
| threatstack_sqs_queue_arn |
