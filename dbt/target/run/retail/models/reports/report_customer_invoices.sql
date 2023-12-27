
  
    
    

    create  table
      "retail"."main"."report_customer_invoices__dbt_tmp"
  
    as (
      -- report_customer_invoices.sql
SELECT
  c.country,
  c.iso,
  COUNT(fi.invoice_id) AS total_invoices,
  SUM(fi.total) AS total_revenue
FROM "retail"."main"."fct_invoices" fi
JOIN "retail"."main"."dim_customer" c ON fi.customer_id = c.customer_id
GROUP BY c.country, c.iso
ORDER BY total_revenue DESC
LIMIT 10
    );
  
  