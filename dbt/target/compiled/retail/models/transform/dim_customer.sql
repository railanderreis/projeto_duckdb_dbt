-- Create the dimension table
WITH customer_cte AS (
	SELECT DISTINCT
	    md5(cast(coalesce(cast(CustomerID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Country as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customer_id,
	    Country AS country
	FROM "retail"."main"."raw_invoices"
	WHERE CustomerID IS NOT NULL
)
SELECT
    t.*,
	cm.iso
FROM customer_cte t
LEFT JOIN "retail"."main"."country" cm ON t.country = cm.nicename