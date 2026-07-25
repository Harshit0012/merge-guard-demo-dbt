{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- addresses: generated to mirror the DataHub catalog. See README.

select
    address_id,  -- Unique identifier for the address
    customer_id,  -- Foreign key to the customers table
    date_created,  -- Date when address was added to the system
    address_line1,  -- First line of address
    address_line2,  -- Second line of address
    town_city,  -- Town or city of the address
    country_id,  -- Reference to country table
    zipcode,  -- Postal code of address
    region_id  -- Reference to region table
from {{ source('raw', 'addresses') }}
