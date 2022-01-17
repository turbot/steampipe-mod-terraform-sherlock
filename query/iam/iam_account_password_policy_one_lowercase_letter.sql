select
  type || ' ' || name as resource,
  case
    when (arguments -> 'require_lowercase_characters') is null then 'alarm' 
    when (arguments -> 'require_lowercase_characters')::bool then 'ok'
    else 'alarm'
  end as status,
  name || case
    when (arguments -> 'require_lowercase_characters') is null then ' lowercase character not set to required'
    when (arguments -> 'require_lowercase_characters')::bool then ' lowercase character set to required'
    else ' lowercase character not set to required'
  end || '.' as reason,
  path
from
  terraform_resource
where
  type = 'aws_iam_account_password_policy';
