{{
  config(
    materialized='table',
    schema='analytics'
  )
}}

-- order_details: generated to mirror the DataHub catalog. See README.

with
  orders as (select * from {{ ref('orders') }}),
  order_items as (select * from {{ ref('order_items') }}),
  customers as (select * from {{ ref('customers') }}),
  products as (select * from {{ ref('products') }}),
  promotions as (select * from {{ ref('promotions') }}),
  inventories as (select * from {{ ref('inventories') }})

select
    order_id,  -- Unique identifier for the order
    order_date,  -- Date and time when the order was placed including timezone
    order_mode,  -- Method of order placement (e.g., online, phone, instore)
    order_status,  -- Current status of the order (e.g., 1=Pending, 2=Processing, 3=Shipped)
    order_total,  -- Total monetary value of the order
    cost_of_delivery,  -- Shipping and handling cost
    delivery_type,  -- Shipping method (e.g., Standard, Curbside, Overnight)
    wait_till_complete_yn,  -- Flag indicating whether to ship complete order or partial (Y/N)
    payment_method_code,  -- Code indicating payment method used
    customer_id,  -- Unique identifier for the customer
    cust_first_name,  -- Customer first name
    cust_last_name,  -- Customer last name
    cust_email,  -- Customer email address
    phone_number,  -- Customer contact phone number
    customer_class,  -- Classification of the customer (e.g., Retail, Enterprise, Online)
    billing_address_line1,  -- First line of customer billing address
    billing_address_line2,  -- Second line of customer billing address
    billing_town_city,  -- Town or city of customer billing address
    billing_country,  -- Country name for the billing address
    billing_zipcode,  -- Postal code of customer billing address
    billing_region,  -- Region/state/province name for the billing address
    shipping_address_line1,  -- First line of customer shipping address
    shipping_address_line2,  -- Second line of customer shipping address
    shipping_town_city,  -- Town or city of customer shipping address
    shipping_country,  -- Country name for the shipping address
    shipping_zipcode,  -- Postal code of customer shipping address
    shipping_region,  -- Region/state/province name for the shipping address
    warehouse_id,  -- Identifier of the warehouse fulfilling the order
    warehouse_name,  -- Name of the warehouse location
    promotion_id,  -- Identifier of the promotion applied to the order
    promotion_name,  -- Name of the marketing promotion
    promotion_description,  -- Detailed description of the promotion
    line_item_id,  -- Line item sequence number within the order
    product_id,  -- Identifier of the product ordered
    product_name,  -- Name of the product
    product_description,  -- Brief description of the product
    category_id,  -- Identifier of the product category
    category_name,  -- Name of the product category
    unit_price,  -- Selling price per unit at time of order
    quantity,  -- Number of units ordered
    line_total,  -- Total price for the line item (unit_price * quantity)
    dispatch_date,  -- Date when item was dispatched from warehouse
    return_date,  -- Date when item was returned if applicable
    gift_wrap,  -- Flag or type of gift wrapping requested
    condition,  -- Condition of product (e.g., New, Refurbished)
    estimated_delivery,  -- Estimated delivery date for this item
    list_price,  -- Standard list price for the product
    product_status,  -- Current status of the product (e.g., Active, Inactive, Backordered)
    quantity_on_hand,  -- Current inventory count for this product in the fulfilling warehouse
    stock_status,  -- Status of current inventory levels (Low Stock, In Stock, Overstocked)
    discount_amount,  -- Amount of discount applied (list_price - unit_price)
    discount_percent,  -- Percentage discount applied ((list_price - unit_price) / list_price * 100)
    delivery_status,  -- Current status of delivery (Not Shipped, In Transit, Delivered)
    return_status,  -- Status indicating if item was returned (Returned, Not Returned)
    updated_at  -- Timestamp indicating when this record was last refreshed
from orders
