resource "aws_sqs_queue" "threatstack" {
  name = "${var.threatstack_sqs_queue_name}"
}

resource "aws_sqs_queue_policy" "threatstack" {
  queue_url = "${aws_sqs_queue.threatstack.id}"
  policy    = "${data.aws_iam_policy_document.threatstack_sqs.json}"
}

data "aws_iam_policy_document" "threatstack_sqs" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
    ]

    effect    = "Allow"
    resources = ["${aws_sqs_queue.threatstack.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${aws_sns_topic.threatstack.arn}",
      ]
    }
  }
}
