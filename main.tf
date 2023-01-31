data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "usage_ai" {
  statement {
    sid       = "1"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "application-autoscaling:Describe*",
      "autoscaling:Describe*",
      "aws-portal:ViewBilling",
      "aws-portal:ViewUsage",
      "ce:Describe*",
      "ce:Get*",
      "ce:List*",
      "ec2:Describe*",
      "ec2:AcceptReservedInstancesExchangeQuote",
      "ec2:CancelReservedInstancesListing",
      "ec2:CreateReservedInstancesListing",
      "ec2:DeleteQueuedReservedInstances",
      "ec2:ModifyReservedInstances",
      "ec2:PurchaseHostReservation",
      "ec2:PurchaseReservedInstancesOffering",
      "ecs:Describe*",
      "ecs:List*",
      "eks:Describe*",
      "eks:List*",
      "pricing:DescribeServices",
      "pricing:GetAttributeValues",
      "pricing:GetProducts",
      "savingsplans:Describe*",
      "savingsplans:List*",
      "savingsplans:*",
      "servicequotas:Get*",
      "servicequotas:List*",
      "sts:AssumeRole",
      "support:*"
    ]
  }
}

resource "aws_iam_policy" "usage_ai" {
  name        = "usage_ai"
  description = "Provides access for Usage.ai to make RI purchases based on usage patterns"
  policy      = data.aws_iam_policy_document.usage_ai.json
}

resource "aws_iam_role" "usage_ai" {
  # Usage.ai's integration fails to work correctly if you don't call the role exactly "UsageAI".
  name        = "UsageAI"
  description = "Provides access for Usage.ai to make RI purchases based on usage patterns"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Effect" : "Allow",
        "Condition" : {
          "StringEquals" : {
            "sts:ExternalId" : var.external_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "usage_ai" {
  role       = aws_iam_role.usage_ai.name
  policy_arn = aws_iam_policy.usage_ai.arn
}
