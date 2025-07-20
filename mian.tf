terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
#Create the S3 bucket if it doesn't already 
resource "aws_s3_bucket" "cost_report_bucket" {
  bucket = var.s3_bucket_name

  force_destroy = true

  tags = {
    Name        = "AWS Cost Monitoring report "
    Environment = "Production"
  }
}
#Block public access for safety 
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.cost_report_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#Create report folder prefix 
resource "aws_s3_object" "reports_folder" {
  bucket  = aws_s3_bucket.cost_report_bucket.id
  key     = "reports/placeholder.txt"
  content = "This is a placeholder for the reports folder."
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.cost_report_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}