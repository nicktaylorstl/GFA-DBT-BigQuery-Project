{{ config(
    materialized='table',
    schema='intermediate'
) }}

WITH a AS (
    SELECT *
    FROM {{ ref('stg_answers') }}
),
q AS (
    SELECT
        question_id,
        organization,
        tag,
        tags
    FROM {{ ref('dim_questions') }}
), 
final as (
SELECT a._pk,
        a.id,
        a.title,
        a.comment_count,
        a.community_owned_date_datetime_utc,
        a.creation_date_datetime_utc,
        a.favorite_count,
        a.last_activity_date_datetime_utc,
        a.last_edit_date_datetime_utc,
        a.last_editor_display_name,
        a.last_editor_user_id,   
        a.owner_display_name,
        a.owner_user_id,
        a.parent_id,
        a.post_type_id,
        a.score,
        a.view_count,
        q.organization,
        q.tag,
        q.tags
FROM a
JOIN q ON a.parent_id = q.question_id )

select * from final