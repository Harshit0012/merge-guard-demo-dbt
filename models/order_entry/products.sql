{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- products: generated to mirror the DataHub catalog. See README.

select
    product_id,  -- Unique identifier for the product
    product_name,  -- Name of the product
    product_description,  -- Brief description of the product
    category_id,  -- Foreign key to the product_categories table
    weight_class,  -- Weight class for shipping calculations
    warranty_period,  -- Standard warranty period for the product
    supplier_id,  -- ID of the supplier for this product
    product_status,  -- Current status (e.g., Available, Discontinued, Planned)
    list_price,  -- Standard list price for the product
    min_price,  -- Minimum selling price for the product
    catalog_url,  -- URL to the product in the online catalog
    date_added  -- Date when product was added to the catalog
from {{ source('raw', 'products') }}
