resource "aws_s3_bucket" "threatstack" {
  bucket = "${var.threatstack_s3_bucket_name}"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "threatstack" {
  bucket = "${aws_s3_bucket.threatstack.id}"
  policy = "${data.aws_iam_policy_document.threatstack_s3.json}"
}

data "aws_iam_policy_document" "threatstack_s3" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = ["${aws_s3_bucket.threatstack.arn}"]
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.threatstack.arn}/*"]
  }
}
