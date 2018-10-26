variable threatstack_s3_bucket_name {}
variable threatstack_account_id {}
variable threatstack_external_id {}

variable threatstack_sns_topic_name {
  default = "threatstack"
}

variable threatstack_iam_role_name {
  default = "threatstack"
}

variable threatstack_iam_policy_name {
  default = "threatstack"
}

variable threatstack_cloudtrail_name {
  default = "threatstack"
}

variable threatstack_sqs_queue_name {
  default = "threatstack"
}
