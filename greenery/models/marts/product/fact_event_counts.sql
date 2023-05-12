{{
  config(
    materialized='table'
  )
}}

SELECT distinct
    product_id,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as cart_adds,
    sum(case when event_type = 'checkout' then 1 else 0 end) as cust_checked_out

FROM {{ ref('stg_events') }} 
GROUP BY 1