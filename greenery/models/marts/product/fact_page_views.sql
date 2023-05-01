{{
  config(
    materialized='table'
  )
}}

SELECT
  product_id,
  date,
  total_per_day as total_views_per_day
FROM {{ ref('int_events_agg') }} 
WHERE event_type = 'page_view'