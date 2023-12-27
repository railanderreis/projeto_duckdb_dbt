-- Create a CTE to extract date and time components
WITH datetime_cte AS (  
  SELECT DISTINCT
    InvoiceDate AS datetime_id,
  FROM {{ source('retail','raw_invoices') }}
  WHERE InvoiceDate IS NOT NULL
)
SELECT
  datetime_id,
  EXTRACT(YEAR FROM datetime_id) AS year,
  EXTRACT(MONTH FROM datetime_id) AS month,
  EXTRACT(DAY FROM datetime_id) AS day,
  EXTRACT(HOUR FROM datetime_id) AS hour,
  EXTRACT(MINUTE FROM datetime_id) AS minute,
  EXTRACT(DAYOFWEEK FROM datetime_id) AS weekda
FROM datetime_cte