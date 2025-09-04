/*
    This model combines customer and order data to create a 
    customer-store relationship table.
*/
{{ config(materialized='table') }}

select 
  t3.name as store_name,
  t1.store_id, 
  t2.name as customer_name,
  t1.subtotal,
  t3.tax_rate,
  t1.tax_paid,
  t1.order_total
from {{ ref('raw_orders') }} as orders
join {{ ref('raw_customers') }} as customers
  on orders.customer = customers.id
join {{ ref('raw_stores') }} as stores
  on orders.store_id = stores.id 
