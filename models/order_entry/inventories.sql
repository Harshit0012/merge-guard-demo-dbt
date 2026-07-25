{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- inventories: generated to mirror the DataHub catalog. See README.

with
  products as (select * from {{ ref('products') }}),
  warehouses as (select * from {{ ref('warehouses') }})

select
    product_id,  -- Foreign key to the products table
    warehouse_id,  -- Foreign key to the warehouses table
    quantity_on_hand,  -- Current inventory count for this product in this warehouse
    restock_level,  -- Threshold at which restocking is initiated
    max_stock_level,  -- Maximum storage capacity for this product
    reorder_quantity  -- Standard reorder quantity when restocking
from products
