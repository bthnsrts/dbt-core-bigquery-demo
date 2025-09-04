/*
    This model joins order items with product and supply data to create 
    a consolidated view of ordered products and their supply information.
    Each row represents an individual item ordered.
*/

{{ config(materialized='table') }}

select
    t1.id,
    t1.order_id,
    t1.sku,
    t2.name as product_name,
    t2.type as product_type,
    t2.price as product_price,
    t3.id as supply_id,    
    t3.cost as supply_cost,    
    (t2.price - t3.cost) as margin,
    (t2.price - t3.cost) / nullif(t3.cost, 0) * 100 as margin_percentage
from 
    {{ ref('raw_items') }} as t1
left join 
    {{ ref('raw_products') }} as t2
    on t1.sku = t2.sku
left join 
    {{ ref('raw_supplies') }} as t3
    on t2.sku = t3.sku
