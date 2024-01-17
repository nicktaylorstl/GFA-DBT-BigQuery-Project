{{ config(
    tags=['github']
) }}

with g as (
SELECT 
    *,
    SPLIT(repo_name, '/')[SAFE_OFFSET(0)] AS repo_account,
    SPLIT(repo_name, '/')[SAFE_OFFSET(1)] AS repo_name_only

from {{ ref('stg_github') }}
), 
final as (
    SELECT 
        g._pk,
        g.repo_account as repository_account,
        g.repo_name_only as repository_name,
        g.actor_id as user_id,
        g.id as event_id,
        g. type,
        c.organization as organization_name,
        g.created_at_datetime_utc
    FROM g 
    JOIN
    (select * from {{ ref('stg_company_details') }}) as c ON g.repo_account = c.repository_account AND g.repo_name_only = c.repository_name
)
SELECT * FROM final