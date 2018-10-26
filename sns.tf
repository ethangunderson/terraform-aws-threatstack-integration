resource "aws_sns_topic" "threatstack" {
  name = "${var.threatstack_sns_topic_name}"
}

resource "aws_sns_topic_subscription" "threatstack" {
  topic_arn = "${aws_sns_topic.threatstack.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.threatstack.arn}"
}

resource "aws_sns_topic_policy" "threatstack" {
  arn    = "${aws_sns_topic.threatstack.arn}"
  policy = "${data.aws_iam_policy_document.threatstack_sns.json}"
}

data "aws_iam_policy_document" "threatstack_sns" {
  statement {
    principals = {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    actions = [
      "SNS:Publish",
    ]

    effect    = "Allow"
    resources = ["${aws_sns_topic.threatstack.arn}"]
  }
}
