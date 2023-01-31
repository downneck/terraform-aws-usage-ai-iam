# Terraform AWS Usage.ai IAM module 

This module creates the IAM components necessary to support Usage.ai's AWS cost optimization service.

## Usage

````terraform
module "usage-ai-iam" {
  source      = "downneck/usage-ai-iam/aws"
  version     = "x.x.x"
  external_id = "XXXXXXXXXXX"
}
````

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.usage_ai](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.usage_ai](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.usage_ai](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.usage_ai](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | The unique ID provided by Usage.ai on the 'Add an IAM Role' page. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the UsageAI role. For use in linking to Usage.ai. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
