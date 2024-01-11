{% snapshot company_details_snapshot %}

{{
    config(
      
      target_database='nickgreenfoxproject',
      target_schema='snapshots',
      materialized = 'snapshot',
      unique_key='_pk',
        invalidate_hard_deletes = True,
      strategy='check',
      check_cols=["Tags", "L1_type", "L2_type", "L3_type", "Organization", "Repository_name", "Repository_account", "Open_source_available"]
    )
}}

select {{ dbt_utils.generate_surrogate_key(['Organization']) }} as _pk,* 
from {{ source('companies','company_details') }}

{% endsnapshot %}