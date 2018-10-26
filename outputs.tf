output "threatstack_cloudtrail_arn" {
  value = "${aws_cloudtrail.threatstack.arn}"
}

output "threatstack_iam_role_arn" {
  value = "${aws_iam_role.threatstack.arn}"
}

output "threatstack_s3_bucket_arn" {
  value = "${aws_s3_bucket.threatstack.arn}"
}

output "threatstack_sns_topic_arn" {
  value = "${aws_sns_topic.threatstack.arn}"
}

output "threatstack_sqs_queue_arn" {
  value = "${aws_sqs_queue.threatstack.arn}"
}
