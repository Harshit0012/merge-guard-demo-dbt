{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- orders: generated to mirror the DataHub catalog. See README.

with
  customers as (select * from {{ ref('customers') }})

select
    order_id,  -- Unique identifier for the order
    order_date,  -- Date and time when the order was placed including timezone
    order_mode,  -- Method of order placement (e.g., online, phone, direct)
    customer_id,  -- Foreign key to the customers table
    order_status,  -- Current status of the order (e.g., 1=Pending, 2=Processing, 3=Shipped)
    order_total,  -- Total monetary value of the order
    sales_rep_id,  -- ID of the sales representative handling the order
    promotion_id,  -- Foreign key to promotions table if applicable
    warehouse_id,  -- Foreign key to warehouses table for fulfillment location
    delivery_type,  -- Shipping method (e.g., Standard, Express, Overnight)
    cost_of_delivery,  -- Shipping and handling cost
    wait_till_complete_yn,  -- Flag indicating whether to ship complete order or partial (Y/N)
    billing_address_id,  -- Reference to the billing address
    delivery_address_id,  -- Reference to the shipping address
    payment_method_code  -- Code indicating payment method used
from customers
