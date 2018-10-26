resource "aws_cloudtrail" "threatstack" {
  name                          = "${var.threatstack_cloudtrail_name}"
  s3_bucket_name                = "${aws_s3_bucket.threatstack.id}"
  sns_topic_name                = "${aws_sns_topic.threatstack.name}"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}
