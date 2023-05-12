{{
  config(
    materialized='table'
  )
}}

WITH PURCHASES as (
    SELECT distinct 
        session_id,
        1 as checkouts
    from {{ ref('stg_events') }}
    where event_type = 'checkout'
),

cart_and_page_counts as (
    SELECT distinct
        events.session_id
        , products.product_id
        , products.name as product_name
        {{ event_types('stg_events', 'event_type') }}
        
    FROM 
        {{ ref('stg_events') }} as events
        join {{ ref('stg_products') }} as products
        on events.product_id = products.product_id
    GROUP BY 1,2,3
)

select
    cart_and_page_counts.product_name,
    sum(cart_and_page_counts.page_views) as num_page_views,
    sum(cart_and_page_counts.add_to_carts) as num_add_to_cart,
    sum(purchases.checkouts) as num_checkout
from
    cart_and_page_counts
    left join purchases
    on cart_and_page_counts.session_id = purchases.session_id
group by 1