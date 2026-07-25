{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- promotions: generated to mirror the DataHub catalog. See README.

select
    promotion_id,  -- Unique identifier for the promotion
    promotion_name,  -- Name of the marketing promotion
    promotion_start_date,  -- Starting date of the promotion
    promotion_end_date,  -- Ending date of the promotion
    promotion_description,  -- Detailed description of the promotion
    promotion_cost  -- Budgeted cost of running the promotion
from {{ source('raw', 'promotions') }}
