----P1
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
---- P2
/* 
- Tìm ngày mua hàng đầu tiên 
- Tìm index=tháng (ngày mua hàng - ngày đầu tiên) + 1
- Count số lượng khách hàng hoặc tổng doanh thu tại mỗi cohort_Date và index tương ứng
- Pivot table
*/

with month_diff as 
/*tìm index*/
(SELECT
  o.user_id,
  o.order_id,
  o.created_at,
  f.first_order_date,
  f.first_month,
  (extract(month from  o.created_at)-extract(month from  f.first_order_date))+(extract(year from  o.created_at)-extract(year from  f.first_order_date))*12+1 as index_month
from bigquery-public-data.thelook_ecommerce.orders o
left join
/*tìm ngày mua đầu tiên*/
(SELECT
    user_id,
		MIN(created_at) AS first_order_date,
		FORMAT_TIMESTAMP('%Y-%m', MIN(created_at)) AS first_month
  FROM
      bigquery-public-data.thelook_ecommerce.orders
  Group by user_id) f
on o.user_id = f.user_id),

Cohort_index as 
(select
first_month,
index_month,
Count(distinct(user_id)) as No_customers
from month_diff
group by first_month, index_month
order by first_month)

SELECT
first_month,
sum(Case when index_month = 1 then No_customers else 0 end) as M1,
sum(Case when index_month = 2 then No_customers else 0 end) as M2,
sum(Case when index_month = 3 then No_customers else 0 end) as M3,
sum(Case when index_month = 4 then No_customers else 0 end) as M4
From Cohort_index
group by first_month
order by first_month

