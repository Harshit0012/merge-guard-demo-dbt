{{
  config(
    materialized='table',
    schema='analytics'
  )
}}

-- order_history: generated to mirror the DataHub catalog. See README.

with
  order_details as (select * from {{ ref('order_details') }})

select
    order_id,
    customer_id,
    order_status,
    order_total,
    as_of_date
from order_details
