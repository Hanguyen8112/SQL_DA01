Select 
Extract(month from created_at) as month,
Extract(year from created_at) as year,
Count(distinct(user_id)) as total_user,
Count(order_id) as total_order
from bigquery-public-data.thelook_ecommerce.orders
Where delivered_at is not null and '2019-31-08 11:59:59 UTC'<created_at and '2022-01-05 00:00:00 UTC'>created_at
Group by Extract(month from created_at),Extract(year from created_at)
order by Year, Month
