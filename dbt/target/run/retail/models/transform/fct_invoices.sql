
  
    
    

    create  table
      "retail"."main"."fct_invoices__dbt_tmp"
  
    as (
      -- Create the fact table by joining the relevant keys from dimension table
WITH fct_invoices_cte AS (
    SELECT
        InvoiceNo AS invoice_id,
        InvoiceDate AS datetime_id,
        md5(cast(coalesce(cast(StockCode as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Description as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(UnitPrice as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
        md5(cast(coalesce(cast(CustomerID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Country as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customer_id,
        Quantity AS quantity,
        Quantity * UnitPrice AS total
    FROM "retail"."main"."raw_invoices"
    WHERE Quantity > 0
)
SELECT
    invoice_id,
    dt.datetime_id,
    dp.product_id,
    dc.customer_id,
    quantity,
    total
FROM fct_invoices_cte fi
INNER JOIN "retail"."main"."dim_datetime" dt ON fi.datetime_id = dt.datetime_id
INNER JOIN "retail"."main"."dim_product" dp ON fi.product_id = dp.product_id
INNER JOIN "retail"."main"."dim_customer" dc ON fi.customer_id = dc.customer_id
    );
  
  