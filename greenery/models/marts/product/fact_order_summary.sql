{{
  config(
    materialized='table'
  )
}}

SELECT
    user_id,
    num_orders,
    num_diff_products,
    total_items,
    total_spent,
    total_items / num_orders as avg_num_orders,
    total_spent / num_orders as avg_spend_per_order
  
FROM 
    {{ ref('int_orders_agg') }} 