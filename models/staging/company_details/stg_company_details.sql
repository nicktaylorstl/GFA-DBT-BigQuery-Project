{{ config(
    materialized='view',
    schema='staging'
) }}


SELECT {{ dbt_utils.generate_surrogate_key(['Organization']) }} as _pk,
    _airbyte_extracted_at as extracted_at_datetime_utc, 
    Organization, 
    Tags, 
    L1_type, 
    L2_type, 
    L3_type,
    Repository_name, 
    Repository_account, 
    CASE 
        WHEN Open_source_available = 'Yes' THEN true
        WHEN Open_source_available = 'No' THEN false
        ELSE NULL
    END as is_open_source_available
    
FROM {{ source('companies', 'company_details') }}