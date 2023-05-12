{{
  config(
    materialized='table'
  )
}}

SELECT
    USER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    ADDRESS,
    ZIPCODE,
    STATE,
    COUNTRY,
    CREATED_AT,
    UPDATED_AT
FROM 
    {{ ref('stg_users') }} as users
    join {{ ref('stg_addresses') }} as addresses
    on users.address_id = addresses.address_id