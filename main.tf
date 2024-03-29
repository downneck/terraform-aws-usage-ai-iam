# usage.ai's default terraform requests the following permissions that we believe are
# overly broad at present and have been omitted:
# - "servicequotas:RequestServiceQuotaIncrease",
# - "organizations:InviteAccountToOrganization" 

data "aws_iam_policy_document" "usage_ai" {
  statement {
    sid       = "1"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "account:GetAccountInformation",
      "application-autoscaling:Describe*",
      "autoscaling:Describe*",
      "billing:Get*",
      "billing:ListBillingViews",
      "consolidatedbilling:List*",
      "consolidatedbilling:Get*",
      "ce:Describe*",
      "ce:Get*",
      "ce:List*",
      "cloudwatch:GetMetricData",
      "consolidatedbilling:GetAccountBillingRole",
      "consolidatedbilling:ListLinkedAccounts",
      "cur:Get*",
      "cur:ValidateReportDestination",
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
      "organizations:List*",
      "organizations:Describe*",
      "pricing:DescribeServices",
      "pricing:GetAttributeValues",
      "pricing:GetProducts",
      "savingsplans:Describe*",
      "savingsplans:List*",
      "savingsplans:*",
      "servicequotas:Get*",
      "servicequotas:List*",
      "sts:AssumeRole",
      "rds:Describe*",
      "rds:List*",
      "rds:PurchaseReservedDbInstancesOffering",
      "elasticache:Describe*",
      "elasticache:List*",
      "elasticache:PurchaseReservedCacheNodesOffering",
      "es:Describe*",
      "es:List*",
      "es:PurchaseReservedInstanceOffering",
      "redshift:Describe*",
      "redshift:PurchaseReservedNodeOffering",
      "redshift:AcceptReservedNodeExchange",
      "redshift:GetReservedNodeExchangeOfferings",
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
          "AWS" : var.role_principal
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
