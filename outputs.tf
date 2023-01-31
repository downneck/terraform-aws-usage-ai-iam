output "role_arn" {
  value       = aws_iam_role.usage_ai.arn
  description = "The ARN of the UsageAI role. For use in linking to Usage.ai."
}
