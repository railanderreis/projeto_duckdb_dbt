-- dim_product.sql
-- StockCode isn't unique, a product with the same id can have different and prices
-- Create the dimension table
SELECT DISTINCT
    md5(cast(coalesce(cast(StockCode as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Description as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(UnitPrice as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
		StockCode AS stock_code,
    Description AS description,
    UnitPrice AS price
FROM "retail"."main"."raw_invoices"
WHERE StockCode IS NOT NULL
AND UnitPrice > 0