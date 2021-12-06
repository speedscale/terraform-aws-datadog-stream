resource "aws_kinesis_firehose_delivery_stream" "datadog" {
  name        = "${local.prefix}metrics-to-datadog"
  destination = "http_endpoint"

  http_endpoint_configuration {
    url                = var.ingest_url
    name               = "Datadog"
    access_key         = var.datadog_key
    buffering_size     = 4
    buffering_interval = 60
    role_arn           = aws_iam_role.firehose.arn
    s3_backup_mode     = "FailedDataOnly"
    retry_duration     = 30

    request_configuration {
      content_encoding = "GZIP"
    }
  }
  s3_configuration {
    role_arn           = aws_iam_role.firehose.arn
    bucket_arn         = var.bucket_arn
    buffer_size        = 4
    buffer_interval    = 60
    compression_format = "GZIP"
  }

  tags = var.tags
}

resource "aws_iam_role" "firehose" {
  name = "${local.prefix}datadog-firehose"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    name = "policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:AbortMultipartUpload",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:ListBucketMultipartUploads",
            "s3:PutObject"
          ],
          "Resource" : [
            "${var.bucket_arn}",
            "${var.bucket_arn}/*"
          ]
        }
      ]
    })
  }

  tags = var.tags
}


resource "aws_cloudwatch_metric_stream" "datadog" {
  name          = "${local.prefix}metrics-to-datadog"
  role_arn      = aws_iam_role.cloudwatch.arn
  firehose_arn  = aws_kinesis_firehose_delivery_stream.datadog.arn
  output_format = "opentelemetry0.7"

  tags = var.tags
}

resource "aws_iam_role" "cloudwatch" {
  name = "${local.prefix}datadog-cloudwatch-stream"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "streams.metrics.cloudwatch.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  inline_policy {
    name = "policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect" : "Allow",
          "Action" : [
            "firehose:PutRecord",
            "firehose:PutRecordBatch"
          ],
          "Resource" : "${aws_kinesis_firehose_delivery_stream.datadog.arn}"
        }
      ]
    })
  }

  tags = var.tags
}
