{{
  config(
    materialized='table'
  )
}}

SELECT
  product_id,
  event_type,
  date(created_at) as event_date,
  count(*) as total_per_day
FROM {{ ref('stg_events') }} 
GROUP BY 1,2,3