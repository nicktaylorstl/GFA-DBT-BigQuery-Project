-- Create a model for date spine
WITH date_spine AS (
    {{ 
        dbt_utils.date_spine(
            datepart="day",
            start_date="cast('2022-01-01' as date)",
            end_date="cast('2022-03-31' as date)"
        )
    }}
)
SELECT EXTRACT(date from date_day) as date FROM date_spine
