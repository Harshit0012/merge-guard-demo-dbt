{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- order_items: generated to mirror the DataHub catalog. See README.

with
  orders as (select * from {{ ref('orders') }}),
  products as (select * from {{ ref('products') }})

select
    order_id,  -- Foreign key to the orders table
    line_item_id,  -- Line item sequence number within the order
    product_id,  -- Foreign key to the products table
    unit_price,  -- Selling price per unit at time of order
    quantity,  -- Number of units ordered
    dispatch_date,  -- Date when item was dispatched from warehouse
    return_date,  -- Date when item was returned if applicable
    gift_wrap,  -- Flag or type of gift wrapping requested
    condition,  -- Condition of product (e.g., New, Refurbished)
    supplier_id,  -- ID of the supplier if dropshipped
    estimated_delivery  -- Estimated delivery date for this item
from orders
