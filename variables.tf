variable "external_id" {
  type        = string
  description = "The unique ID provided by Usage.ai on the 'Add an IAM Role' page."
}

variable "role_principal" {
  type        = string
  description = "The role Principal provided by Usage.ai on the 'Add an IAM Role' page. Of the format 'arn:aws:iam::XXXXXXXXXXXX:user/awsconnector'. The included default works at the moment, but is a variable in case Usage.ai ever changes it from the default."
  default     = "arn:aws:iam::826182721854:user/awsconnector"
}
