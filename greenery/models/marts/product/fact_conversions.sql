{{
  config(
    materialized='table'
  )
}}

SELECT distinct
    product_name,
    num_page_views,
    num_add_to_cart,
    num_checkout

FROM {{ ref('int_products_agg') }} 