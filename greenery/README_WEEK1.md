How many users do we have? 130

    select distinct count(user_id)
    from stg_users


On average, how many orders do we receive per hour? 7.52
    with order_hour as (
        select
            order_id,
            date(created_at) as date,
            hour(created_at) as hour
        from stg_orders
    ),

    hour_count as (
        select 
            date,
            hour,
            count(hour) as num_per_hour
        from order_hour
        group by 1,2
    ),

    hour_avg as (
        select avg(num_per_hour)
        from hour_count
    )

    select *
    from hour_avg


On average, how long does an order take from being placed to being delivered? 3.89 days

    select
        avg(timestampdiff(day,created_at,delivered_at)) as days_to_deliver
    from stg_orders
    where delivered_at is not null


How many users have only made one purchase? Two purchases? Three+ purchases?
    1 purchase: 25
    2 purchases: 28
    3 or more purchases: 71

    with order_counts as (
        select
            user_id,
            count(order_id) as orders_per_user,
            case
                when orders_per_user = 1 then one_order
                when orders_per_user = 2 then two_orders
                when orders_per_user > 2 then three_plus_orders
            end as order_groups
        from stg_orders
        group by 1
    ),

    group_totals as (
        select
            order_groups,
            count(user_id) as user_count
        from order_counts
        group by 1
        order by 1
    )

    select *
    from group_totals


On average, how many unique sessions do we have per hour? 61.3
    
    with session_counts as (
        select distinct
            count(session_id) as unique_sessions_per_hour,
            date(created_at) as date,
            hour(created_at) as hour
        from stg_events
        group by 2,3
    ),

    avg_per_hour as (
        select
            avg(unique_sessions_per_hour) as avg_sessions_per_hr
        from session_counts
    )

    select *
    from avg_per_hour

