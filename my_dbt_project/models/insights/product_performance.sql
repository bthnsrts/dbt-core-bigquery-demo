/*
    This model aggregates product performance metrics across orders,
    showing counts, revenue, costs and margins per product.
*/

{{ config(materialized='view') }}

select
  sku,
  product_name,
  count(distinct order_id) as order_count,
  sum(product_price) as total_selling_price,
  sum(supply_cost) as total_supply_cost,
  sum(margin) as total_net_revenue
from 
  {{ ref('order_product_supply_base') }}
group by 
  1, 2
order by 
  3 desc