**Part 1: Conversion Rates**
-

What is our overall conversion rate? 62.5%
```
with checkout_sessions as (
    select distinct session_id
    from fact_conversions
    where event_type = 'checkout'
),

unique_sessions as (
    select distinct session_id
    from fact_conversions
)

select
    count(checkout_sessions.session_id) / count(unique_sessions.session_id) as overall_conversion_rate
from unique_sessions
    left join checkout_sessions
    on unique_sessions.session_id = checkout_sessions.session_id
```

What is our conversion rate by product?
```
select
    product_name,
    num_add_to_cart,
    num_page_views,
    num_add_to_cart / num_page_views as conversion_rate
from fact_conversions
order by conversion_rate


==============  =================  ================  =================
 PRODUCT_NAME    NUM_ADD_TO_CART    NUM_PAGE_VIEWS    CONVERSION_RATE
==============  =================  ================  =================
Pothos			24		64		0.375000
Ponytail Palm		30		71		0.422535
Money Tree		26		56		0.464286
Snake Plant		34		73		0.465753
Orchid			37		75		0.493333
Alocasia Polly		27		54		0.500000
Pink Anthurium		37		74		0.500000
Birds Nest Fern		40		80		0.500000
Philodendron		32		63		0.507937
Fiddle Leaf Fig		30		59		0.508475
Spider Plant		30		59		0.508475
Ficus			35		68		0.514706
Angel Wings Begonia	32		62		0.516129
Jade Plant		24		46		0.521739
Peace Lily		35		67		0.522388
Monstera		26		49		0.530612
Pilea Peperomioides	32		60		0.533333
Devil's Ivy		24		45		0.533333
ZZ Plant		35		65		0.538462
Boston Fern		34		63		0.539683
Dragon Tree		34		62		0.548387
Bird of Paradise	33		60		0.550000
Majesty Palm		38		69		0.550725
Aloe Vera		36		65		0.553846
Rubber Plant		32		56		0.571429
Cactus			32		55		0.581818
Calathea Makoyana	32		53		0.603774
Bamboo			42		69		0.608696
Arrow Head		39		64		0.609375
String of pearls	44		65		0.676923
==============  =================  ================  =================

```
**Why might certain products be converting at higher/lower rates than others?**
- Better photographs available online
- Better value
- Easiest or cheapest to ship

**Part 2: Macro Created**
-

Create a macro to simplify part of a model(s).
- created event_type_macro
- used in int_products_agg

**Part 3: Post Hook**
-

Add a post hook to your project to apply grants to the role “reporting”. 
- Added post hook and on-run-end to project.yml file and confirmed they ran in Snowflake

**Part 4: dbt Packages**
-

Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project
- Installed `codegen`
- Ran `dbt run-operation generate_model_yaml --args '{"model_names": ["fact_conversions"]}'` to double-check my work in my yml file and fixed the error I found!

**Part 5: Improving our Projects**
-

Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.
<img width="389" alt="Image 2023-05-11 at 11 34 42 PM" src="https://github.com/amanda-ynab/course-dbt/assets/52301223/b823ce63-676b-42d4-a27c-0c84d6d5e1f6">
<img width="323" alt="Image 2023-05-11 at 11 38 03 PM" src="https://github.com/amanda-ynab/course-dbt/assets/52301223/6ffff04d-28b5-4c79-9b4c-d3c408369642">

**Part 6: Snapshot**
-

Which products had their inventory change from week 2 to week 3?
- Sold 12 bamboo, 14 monstera, 10 philodendron, 20 pothos, 10 string of pearls, 36 zz plants
