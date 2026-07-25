{{
  config(
    materialized='table',
    schema='order_entry'
  )
}}

-- customers: generated to mirror the DataHub catalog. See README.

with
  addresses as (select * from {{ ref('addresses') }})

select
    customer_id,  -- Unique identifier for the customer
    cust_first_name,  -- Customer first name
    cust_last_name,  -- Customer last name
    nls_language,  -- Preferred language code
    nls_territory,  -- Geographical territory for localization settings
    credit_limit,  -- Maximum credit amount for the customer
    cust_email,  -- Customer email address
    account_mgr_id,  -- ID of the account manager assigned to the customer
    customer_since,  -- Date when customer was first registered
    customer_class as cust_segment,  -- Classification of the customer (e.g., Platinum, Gold, Silver)
    suggestions,  -- Customer product suggestions or preferences
    dob,  -- Customer date of birth
    mailshot,  -- Flag indicating if customer has opted for marketing emails (Y/N)
    partner_mailshot,  -- Flag indicating if customer has opted for partner marketing (Y/N)
    phone_number,  -- Customer contact phone number
    address_line1,  -- First line of customer primary address
    address_line2,  -- Second line of customer primary address
    address_line3,  -- Third line of customer primary address
    town_city,  -- Town or city of customer primary address
    country_id,  -- Reference to country table for primary address
    zipcode,  -- Postal code of customer primary address
    region_id  -- Reference to region table for primary address
from addresses
