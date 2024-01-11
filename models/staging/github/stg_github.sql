{{ config(
    materialized='view',
    schema='staging'
) }}

with source as (
    select * from {{source("github","20220101")}}
),

final as (
    Select 
        id as _pk, 
        type,
        public as is_public, 
        payload,
        repo.id as repo_id,
        repo.name as repo_name,
        repo.url as repo_url,
        actor.id as actor_id,
        actor.login as actor_login,
        actor.gravatar_id as actor_gravatar_id,
        actor.avatar_url as actor_avatar_url,
        actor.url as actor_url, 
        org.id as org_id,
        org.gravatar_id as org_gravatar_id,
        org.avatar_url as org_avatar_url,
        org.url as org_url, 
        created_at as created_at_datetime_utc,
        id,
        other
    from source
)
select * from final
LIMIT 100