locals {
  sagemaker_compliance_common_tags = merge(local.compliance_common_tags, {
    service = "sagemaker"
  })
}

benchmark "sagemaker" {
  title    = "SageMaker"
  children = [
    control.sagemaker_endpoint_configuration_encryption_at_rest_enabled,
    control.sagemaker_notebook_instance_direct_internet_access_disabled,
    control.sagemaker_notebook_instance_encryption_at_rest_enabled
  ]
  tags          = local.sagemaker_compliance_common_tags
}

control "sagemaker_endpoint_configuration_encryption_at_rest_enabled" {
  title       = "SageMaker endpoint configuration encryption should be enabled"
  description = "To help protect data at rest, ensure encryption with AWS Key Management Service (AWS KMS) is enabled for your SageMaker endpoint."
  sql           = query.sagemaker_endpoint_configuration_encryption_at_rest_enabled.sql

  tags = local.sagemaker_compliance_common_tags
}

control "sagemaker_notebook_instance_direct_internet_access_disabled" {
  title       = "SageMaker notebook instances should not have direct internet access"
  description = "Manage access to resources in the AWS Cloud by ensuring that Amazon SageMaker notebooks do not allow direct internet access."
  sql           = query.sagemaker_notebook_instance_direct_internet_access_disabled.sql

  tags = local.sagemaker_compliance_common_tags
}

control "sagemaker_notebook_instance_encryption_at_rest_enabled" {
  title       = "SageMaker notebook instance encryption should be enabled"
  description = "To help protect data at rest, ensure encryption with AWS Key Management Service (AWS KMS) is enabled for your SageMaker notebook."
  sql           = query.sagemaker_notebook_instance_encryption_at_rest_enabled.sql

  tags = local.sagemaker_compliance_common_tags
}