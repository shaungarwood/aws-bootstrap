data "aws_iam_policy_document" "power_dev" {
  statement {
    actions   = ["s3:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions   = ["ec2:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions   = ["elasticloadbalancing:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions   = ["acm:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions   = ["iam:CreateAccessKey", "iam:ListAccessKeys"]
    resources = ["*"]
    effect = "Allow"
  }
}
