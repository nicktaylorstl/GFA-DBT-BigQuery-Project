with source as(
    SELECT * 
    FROM {{source("stack_overflow","posts_answers")}}
    WHERE creation_date > '2022-01-01T00:00:00.040000+00:00' and creation_date < '2023-01-01T00:00:00.040000+00:00'
    Order by creation_date
),

final as (
    SELECT 
        id as _pk,
        id,
        title,
        body, 
        comment_count,
        community_owned_date as community_owned_date_datetime_utc,
        creation_date as creation_date_datetime_utc,
        favorite_count,
        last_activity_date as last_activity_date_datetime_utc,
        last_edit_date as last_edit_date_datetime_utc,
        last_editor_display_name,
        last_editor_user_id,   
        owner_display_name,
        owner_user_id,
        parent_id,
        post_type_id,
        score,
        view_count
    FROM source
)

SELECT * from final
LIMIT 100