{{ config(
    materialized='table',
    schema='intermediate'
) }}

WITH q AS (
    SELECT *
    FROM {{ ref('stg_questions') }},
    UNNEST(SPLIT(Tags, '|')) AS tag
),
c AS (
    SELECT
        organization,
        tag
    FROM {{ ref('stg_company_details') }},
    UNNEST(SPLIT(Tags, ',')) AS tag
), 
final as (
SELECT q._pk,
        q.question_id,
        q.title,
        q.accepted_answer_id,
        q.answer_count,
        q.comment_count,
        q.community_owned_date_datetime_utc,
        q.creation_date_datetime_utc,
        q.favorite_count,
        q.last_activity_date_datetime_utc,
        q.last_edit_date_datetime_utc,
        q.last_editor_display_name,
        q.last_editor_user_id,   
        q.owner_display_name,
        q.owner_user_id,
        q.parent_id,
        q.post_type_id,
        q.score,
        q.tag,
        q.tags,
        q.view_count,
        c.organization
FROM q
JOIN c ON q.tag = c.tag)

select * from final