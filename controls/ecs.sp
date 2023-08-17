locals {
  ecs_compliance_common_tags = merge(local.terraform_aws_compliance_common_tags, {
    service = "AWS/ECS"
  })
}

benchmark "ecs" {
  title       = "ECS"
  description = "This benchmark provides a set of controls that detect Terraform AWS ECS resources deviating from security best practices."

  children = [
    control.ecs_cluster_container_insights_enabled,
    control.ecs_cluster_logging_enabled,
    control.ecs_cluster_logging_encrypted_with_kms_cmk,
    control.ecs_service_fargate_uses_latest_version,
    control.ecs_task_definition_encryption_in_transit_enabled,
    control.ecs_task_definition_role_check
  ]

  tags = merge(local.ecs_compliance_common_tags, {
    type = "Benchmark"
  })
}

control "ecs_cluster_container_insights_enabled" {
  title       = "ECS cluster container insights should be enabled"
  description = "One of the best practices when using AWS ECS is to enable cluster container insights for better visibility."
  query       = query.ecs_cluster_container_insights_enabled

  tags = local.ecs_compliance_common_tags
}

control "ecs_task_definition_encryption_in_transit_enabled" {
  title       = "ECS task definition encryption in transit should be enabled"
  description = "Ensure encryption in transit is enabled for EFS volumes in ECS Task definitions."
  query       = query.ecs_task_definition_encryption_in_transit_enabled

  tags = local.ecs_compliance_common_tags
}

control "ecs_cluster_logging_enabled" {
  title       = "ECS cluster logging should be enabled"
  description = "This control checks whether logging is enabled for the ECS cluster."
  query       = query.ecs_cluster_logging_enabled

  tags = local.ecs_compliance_common_tags
}

control "ecs_cluster_logging_encrypted_with_kms_cmk" {
  title       = "ECS cluster logging should be encrypted with KMS CMK"
  description = "This control checks whether logging is encrypted with KMS CMK for the ECS cluster."
  query       = query.ecs_cluster_logging_encrypted_with_kms_cmk

  tags = local.ecs_compliance_common_tags
}

control "ecs_task_definition_role_check" {
  title       = "ECS Task definition should have different Execution Role ARN and Task Role ARN"
  description = "This control checks whether the Execution Role ARN and the Task Role ARN are different in ECS Task definitions."
  query       = query.ecs_task_definition_role_check

  tags = local.ecs_compliance_common_tags
}

control "ecs_service_fargate_uses_latest_version" {
  title       = "ECS Fargate services should run on the latest Fargate platform version"
  description = "This control checks whether ECS Fargate services run on the latest Fargate platform version."
  query       = query.ecs_service_fargate_uses_latest_version

  tags = local.ecs_compliance_common_tags
}
