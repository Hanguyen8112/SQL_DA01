with cte as (
select
  EXTRACT(YEAR FROM o.created_at) AS year,
  EXTRACT(MONTH FROM o.created_at) AS month1,
  FORMAT_TIMESTAMP('%Y-%m', o.created_at) AS month,
  p.category as Product_category,
  sum(oi.sale_price) as TPV,
  count(distinct(o.order_id)) as TPO,
  sum(p.cost) as total_cost,
  sum(oi.sale_price) -  sum(p.cost) as Total_profit,
  Round(Cast((sum(oi.sale_price) -  sum(p.cost))/sum(oi.sale_price)*100 as numeric),2) as Profit_to_cost_ratio
from bigquery-public-data.thelook_ecommerce.order_items oi
left join bigquery-public-data.thelook_ecommerce.orders o
on oi.order_id=o.order_id
left join bigquery-public-data.thelook_ecommerce.products p
on oi.product_id = p.id
where oi.status = 'Complete'
Group by EXTRACT(YEAR FROM o.created_at), EXTRACT(MONTH FROM o.created_at), FORMAT_TIMESTAMP('%Y-%m', o.created_at), p.category)

SELECT
  month,
  Product_category,
  TPV,
  round(cast((TPV - Lag(TPV) over(PARTITION BY Product_category order by year, month))/Lag(TPV) over(PARTITION BY Product_category order by year, month)*100 as numeric),2) as Revenue_growth,
  TPO,
  round(cast((TPO - Lag(TPO) over(PARTITION BY Product_category order by year, month))/Lag(TPO) over(PARTITION BY Product_category order by year, month)*100 as numeric),2) as Order_growth,
  total_cost,
  Total_profit,
  Profit_to_cost_ratio
From cte
