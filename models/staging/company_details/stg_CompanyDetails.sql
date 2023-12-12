SELECT Organization, Tags, L1_type, L2_type, Repository_name, Repository_account, Open_source_available
FROM {{ source('companies', 'v3') }}