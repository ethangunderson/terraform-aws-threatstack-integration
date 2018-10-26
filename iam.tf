resource "aws_iam_role" "threatstack" {
  name               = "${var.threatstack_iam_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.threatstack_role.json}"
}

data "aws_iam_policy_document" "threatstack_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.threatstack_account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["${var.threatstack_external_id}"]
    }
  }
}

resource "aws_iam_policy" "threatstack_sqs" {
  name        = "${var.threatstack_iam_policy_name}"
  path        = "/"
  description = "Allows threatstack role to consume from the threatstack sqs queue"
  policy      = "${data.aws_iam_policy_document.threatstack_role_sqs.json}"
}

data "aws_iam_policy_document" "threatstack_role_sqs" {
  statement {
    actions   = ["sqs:ListQueues"]
    resources = ["*"]
  }

  statement {
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
    ]

    resources = ["${aws_sqs_queue.threatstack.arn}"]
  }

  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = ["${aws_s3_bucket.threatstack.arn}/*"]
  }
}

resource "aws_iam_policy" "threatstack_general" {
  name        = "threatstack_general"
  path        = "/"
  description = "Permissions for threatstack to audit our AWS env"
  policy      = "${data.aws_iam_policy_document.threatstack_general.json}"
}

data "aws_iam_policy_document" "threatstack_general" {
  statement {
    resources = ["*"]

    actions = [
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetTrailStatus",
      "cloudtrail:ListPublicKeys",
      "cloudtrail:ListTags",
      "ec2:Describe*",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "iam:GenerateCredentialReport",
      "iam:GetAccountPasswordPolicy",
      "iam:GetCredentialReport",
      "iam:GetAccountSummary",
      "iam:ListAttachedUserPolicies",
      "iam:ListUsers",
      "kms:GetKeyRotationStatus",
      "kms:ListKeys",
      "rds:DescribeAccountAttributes",
      "rds:DescribeCertificates",
      "rds:DescribeEngineDefaultClusterParameters",
      "rds:DescribeEngineDefaultParameters",
      "rds:DescribeDBClusterParameterGroups",
      "rds:DescribeDBClusterParameters",
      "rds:DescribeDBClusterSnapshots",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeDBLogFiles",
      "rds:DescribeDBParameterGroups",
      "rds:DescribeDBParameters",
      "rds:DescribeDBSecurityGroups",
      "rds:DescribeDBSnapshotAttributes",
      "rds:DescribeDBSnapshots",
      "rds:DescribeDBEngineVersions",
      "rds:DescribeDBSubnetGroups",
      "rds:DescribeEventCategories",
      "rds:DescribeEvents",
      "rds:DescribeEventSubscriptions",
      "rds:DescribeOptionGroups",
      "rds:DescribeOptionGroupOptions",
      "rds:DescribeOrderableDBInstanceOptions",
      "rds:DescribePendingMaintenanceActions",
      "rds:DescribeReservedDBInstances",
      "rds:DescribeReservedDBInstancesOfferings",
      "rds:ListTagsForResource",
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "sns:GetEndpointAttributes",
      "sns:GetPlatformApplicationAttributes",
      "sns:GetSMSAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:GetTopicAttributes",
      "sns:ListEndpointsByPlatformApplication",
      "sns:ListPlatformApplications",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "threatstack_sqs" {
  role       = "${aws_iam_role.threatstack.name}"
  policy_arn = "${aws_iam_policy.threatstack_sqs.arn}"
}

resource "aws_iam_role_policy_attachment" "threatstack_general" {
  role       = "${aws_iam_role.threatstack.name}"
  policy_arn = "${aws_iam_policy.threatstack_general.arn}"
}
