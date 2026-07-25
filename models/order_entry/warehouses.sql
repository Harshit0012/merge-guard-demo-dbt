{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- warehouses: generated to mirror the DataHub catalog. See README.

select
    warehouse_id,  -- Unique identifier for the warehouse
    warehouse_name,  -- Name of the warehouse location
    location_id,  -- Reference to the physical location
    wh_geo_location  -- Geographic coordinates of the warehouse
from {{ source('raw', 'warehouses') }}
