{{
  config(
    materialized='table'
  )
}}

SELECT
  orders.user_id,
  count(distinct orders.order_id) as num_orders,
  count(distinct items.product_id) as num_diff_products,
  count(items.quantity) as total_items,
  sum(orders.order_total) as total_spent
  
FROM 
    {{ ref('stg_orders') }} as orders
    join {{ ref('stg_order_items') }} as items
    on orders.order_id = items.order_id
GROUP BY 1