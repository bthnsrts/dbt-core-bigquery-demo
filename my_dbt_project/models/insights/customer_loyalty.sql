/*
    this model combines customer and order data to create a 
    customer-store relationship table.
*/
{{ config(materialized='view') }}

with agg as (
  select
    store_name,
    customer_name,
    sum(order_total) as customer_store_total_order,
    sum(subtotal)    as customer_store_subtotal_order
  from {{ ref('customer_store_order_base') }}  -- replace with your actual source model
  group by 1, 2
)

select
  store_name,
  customer_name,
  customer_store_total_order,
  customer_store_subtotal_order,
  row_number() over (
    partition by store_name
    order by customer_store_total_order desc
  ) as total_ranking,
  row_number() over (
    partition by store_name
    order by customer_store_subtotal_order desc
  ) as subtotal_ranking
from agg
order by store_name, total_ranking