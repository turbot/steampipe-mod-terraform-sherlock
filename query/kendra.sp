query "kendra_index_server_side_encryption_uses_kms_cmk" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when (arguments -> 'server_side_encryption_configuration' ->> 'kms_key_id') is not null then 'ok'
        else 'alarm'
      end status,
      name || case
        when (arguments -> 'server_side_encryption_configuration' ->> 'kms_key_id') is not null then ' uses KMS CMK'
        else ' does not use KMS CMK'
      end || '.' reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      terraform_resource
    where
      type = 'aws_kendra_index';
  EOQ
}