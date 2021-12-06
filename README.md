# terraform-aws-datadog-stream
This Terraform module sets up the AWS to Datadog integration using metric streams as described [here](https://docs.datadoghq.com/integrations/guide/aws-cloudwatch-metric-streams-with-kinesis-data-firehose/).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_stream.datadog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream) | resource |
| [aws_iam_role.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kinesis_firehose_delivery_stream.datadog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_arn"></a> [bucket\_arn](#input\_bucket\_arn) | ARN for the bucket where failed requests will be sent | `string` | n/a | yes |
| <a name="input_datadog_key"></a> [datadog\_key](#input\_datadog\_key) | A Datadog API key | `string` | n/a | yes |
| <a name="input_ingest_url"></a> [ingest\_url](#input\_ingest\_url) | The Datadog URL used for ingest which varies by region, defaults to US | `string` | `"https://awsmetrics-intake.datadoghq.com/v1/input"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | An optional prefix for created resources | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to all created resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch-role-arn"></a> [cloudwatch-role-arn](#output\_cloudwatch-role-arn) | ARN of the created role for the cloudwatch metric stream |
| <a name="output_cloudwatch-stream-arn"></a> [cloudwatch-stream-arn](#output\_cloudwatch-stream-arn) | ARN of the created cloudwatch metric stream |
| <a name="output_firehose-arn"></a> [firehose-arn](#output\_firehose-arn) | ARN of the created firehose |
| <a name="output_firehose-role-arn"></a> [firehose-role-arn](#output\_firehose-role-arn) | ARN of the created role for the firehose |
<!-- END_TF_DOCS -->
