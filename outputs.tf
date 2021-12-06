output "firehose-arn" {
  description = "ARN of the created firehose"
  value       = aws_kinesis_firehose_delivery_stream.datadog.arn
}

output "firehose-role-arn" {
  description = "ARN of the created role for the firehose"
  value       = aws_iam_role.firehose.arn
}

output "cloudwatch-stream-arn" {
  description = "ARN of the created cloudwatch metric stream"
  value       = aws_cloudwatch_metric_stream.datadog.arn
}

output "cloudwatch-role-arn" {
  description = "ARN of the created role for the cloudwatch metric stream"
  value       = aws_iam_role.cloudwatch.arn
}
