WITH SOURCE AS (SELECT
    EXTRACT(MONTH FROM creation_date_datetime_utc) as month,
    CASE
        WHEN EXTRACT(MONTH FROM creation_date_datetime_utc) BETWEEN 1 AND 3 THEN 1
        WHEN EXTRACT(MONTH FROM creation_date_datetime_utc) BETWEEN 4 AND 6 THEN 2
        WHEN EXTRACT(MONTH FROM creation_date_datetime_utc) BETWEEN 7 AND 9 THEN 3
        WHEN EXTRACT(MONTH FROM creation_date_datetime_utc) BETWEEN 10 AND 12 THEN 4
    END as quarter,
    EXTRACT(YEAR FROM creation_date_datetime_utc) as year,
    organization as organization_name,
    COUNT(DISTINCT question_id) as post_count,
    SUM(answer_count) as answer_count,
    AVG(answer_count) as avg_answer_count,
    SUM(comment_count) as comment_count,
    AVG(comment_count) as avg_comment_count,
    SUM(favorite_count) as favorite_count,
    AVG(favorite_count) as avg_favorite_count,
    SUM(view_count) as view_count,
    AVG(view_count) as avg_view_count,
    COUNT(accepted_answer_id) AS accepted_answer_count,
    COUNT(case when answer_count = 0 then 1 end) as no_answer_count, 
    CAST(COUNT(case when answer_count = 0 then 1 end) as FLOAT64)/(COUNT(DISTINCT question_id)) AS avg_no_answer_count,
    AVG(score * 10) as score,
    MAX(last_activity_date_datetime_utc) as last_activity_date_datetime_utc,
    MAX(last_edit_date_datetime_utc) as last_edit_date_datetime_utc
    
FROM {{ ref('dim_questions') }}
GROUP BY organization_name, month, quarter, year)
SELECT     
    {{ dbt_utils.generate_surrogate_key(['month','organization_name']) }} as _pk,
    *

FROM source    
Order by month, organization_name