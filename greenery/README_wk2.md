**Models**
-

What is our user repeat rate? **79.8%**
```
  with orders_per_customer as (
    select
        user_id,
        count(order_id) as num_orders,
        case
            when num_orders = 1 then 'single_order'
            when num_orders >1 then 'repeat_customer'
        end as order_group
    from stg_orders
    group by 1
  ),

  order_group_counts as (
    select
        case
            when order_group = 'single_order' then 1
            else 0
        end as single_order_count,
        case
            when order_group = 'repeat_customer' then 1
            else 0
        end as repeat_customer_count
    from orders_per_customer
  )

  select
    sum(single_order_count) as num_single_orders,
    sum(repeat_customer_count) as num_repeat_customers,
    num_single_orders + num_repeat_customers as total_customers,
    num_repeat_customers / total_customers as repeat_rate
  from order_group_counts
```

**What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

Likely to purchase again:
- length of time between first and second order is small
- num of orders so far is > 1
- large purchase(s)

Unlikely to purchase again:
- only one order so far
- length of time between first and second order is large
- small purchase(s)
- all orders include discounts

More data:
- referral source


**Explain the product mart models you added. Why did you organize the models in the way you did?**
- I created an intermediate folder for ease of separating all intermediate models
- Then I created folders for product, marketing, core (but only created fact/dim models in the product folder)
- My models aim to simplify the process of analyzing the performance of specific products (fact_page_views) and user purchase behavior (fact_order_summary)

**DAG image:**

<img width="558" alt="Image 2023-04-30 at 10 20 24 PM" src="https://user-images.githubusercontent.com/52301223/235392509-6885b669-724e-4d71-8601-4a5cfd884fcb.png">

Tests
-

**Assumptions:**
- Used unique, not_null, and positive_values tests to ensure data is accurate and my models are written correctly

**Bad data?**
- Yes, I found some! I had one test fail because I included a not_null test. As it turns out, there can be null_values because some rows did not include a product_id. That was helpful in my understanding of my intermediate table and will help with further analysis

**State of the data each day**
- I would set dbt test to run every night to ensure any errors are located quickly.
- If I receive an alert that any test failed overnight, I will investigate to determine if the data is indeed bad or perhaps a test needs to adjusted.
- If the data is bad, I will alert the affected team(s).


**dbt snapshot**
-

Which products had their inventory change from week 1 to week 2? 
- Increase: none
- Decrease: Monstera, Philodendron, Pothos, String of Pearls
