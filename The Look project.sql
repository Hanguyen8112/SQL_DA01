--Ex1
with cte as (Select 
Extract(month from created_at) as month,
Extract(year from created_at) as year,
created_at,
user_id,
order_id
from bigquery-public-data.thelook_ecommerce.order_items
Where status = 'Complete' and
      created_at< CAST('2022-05-01 00:00:00 UTC' AS TIMESTAMP) and created_at> CAST('2018-12-31 23:59:59 UTC' AS TIMESTAMP)
order by created_at)
Select
 FORMAT_TIMESTAMP('%m-%Y', TIMESTAMP(created_at)) as month_year,
 Count(distinct(user_id)) as total_user,
 Count(order_id) as total_order
From cte
group by month_year,year, month
order by year, month

--Ex2: tổng số lượng khách tăng nhưng giá trị TB/1 đơn ko tăng
with cte as (Select 
Extract(month from created_at) as month,
Extract(year from created_at) as year,
created_at,
user_id,
order_id,
sale_price
from bigquery-public-data.thelook_ecommerce.order_items
Where status = 'Complete' and
      created_at< CAST('2022-05-01 00:00:00 UTC' AS TIMESTAMP) and created_at> CAST('2018-12-31 23:59:59 UTC' AS TIMESTAMP)
order by created_at)
Select
 FORMAT_TIMESTAMP('%m-%Y', TIMESTAMP(created_at)) as month_year,
 Count(distinct(user_id)) as total_user,
 Sum(sale_price)/Count(distinct(order_id)) as Avg_order
From cte
group by month_year,year, month
order by year, month

---Ex3

