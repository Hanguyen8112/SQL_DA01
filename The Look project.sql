--Ex1
with cte as (Select 
Extract(month from created_at) as month,
Extract(year from created_at) as year,
created_at,
user_id,
order_id
from bigquery-public-data.thelook_ecommerce.orders
Where delivered_at is not null and 
      created_at< CAST('2022-05-01 00:00:00 UTC' AS TIMESTAMP) and created_at> CAST('2018-12-31 23:59:59 UTC' AS TIMESTAMP)
order by created_at)
Select
 FORMAT_TIMESTAMP('%m-%Y', TIMESTAMP(created_at)) as month_year,
 Count(distinct(user_id)) as total_user,
 Count(order_id) as total_order
From cte
group by month_year,year, month
order by year, month
