variable "datadog_key" {
  type        = string
  description = "A Datadog API key"
}

variable "prefix" {
  type        = string
  description = "An optional prefix for created resources"
  default     = ""
}

locals {
  prefix = var.prefix != "" ? "${var.prefix}-" : ""
}

variable "ingest_url" {
  type        = string
  description = "The Datadog URL used for ingest which varies by region, defaults to US"
  default     = "https://awsmetrics-intake.datadoghq.com/v1/input"
}

variable "bucket_arn" {
  type        = string
  description = "ARN for the bucket where failed requests will be sent"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to all created resources"
  default     = {}
}
