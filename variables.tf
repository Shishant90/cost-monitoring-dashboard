variable "aws_region" {
  description = "AWS region "
  type = string
  default = "eu-north-1"
}
variable "start_date" {
  description = "Start date for cost report in YYYY-MM-DD"
  type = string
  default = "2025-07-1"
}
variable "end_date" {
  description = "End date for cost report in YYYY-MM-DD"
  type = string
  default = "2025-07-13"
}
variable "granularity" {
  description = "DAILY or MONTHLY"
  type = string
  default = "DAILY"
}
variable "metrics" {
  description = "List of metrics to fetch"
  type = list(string)
  default = ["UnblendedCost"]
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket to upload the reports"
  type = string
  default = "shishant"
}