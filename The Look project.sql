--Ex1
with cte as (Select 
Extract(month from created_at) as month,
Extract(year from created_at) as year,
created_at,
user_id,
order_id
from bigquery-public-data.thelook_ecommerce.order_items
Where status = 'Complete' and
      created_at< CAST('2022-05-01 00:00:00 UTC' AS TIMESTAMP) and created_at> CAST('2019-12-31 23:59:59 UTC' AS TIMESTAMP)
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
      created_at< CAST('2022-05-01 00:00:00 UTC' AS TIMESTAMP) and created_at> CAST('2019-12-31 23:59:59 UTC' AS TIMESTAMP)
order by created_at)
Select
 FORMAT_TIMESTAMP('%m-%Y', TIMESTAMP(created_at)) as month_year,
 Count(distinct(user_id)) as total_user,
 Sum(sale_price)/Count(distinct(order_id)) as Avg_order
From cte
group by month_year,year, month
order by year, month

---Ex3
WITH MinAgesByGender AS (
    SELECT 
        gender,
        MIN(age) AS min_age
    FROM 
        `bigquery-public-data.thelook_ecommerce.users`
    GROUP BY 
        gender
),
MaxAgesByGender AS (
    SELECT 
        gender,
        MAX(age) AS max_age
    FROM 
        `bigquery-public-data.thelook_ecommerce.users`
    GROUP BY 
        gender
)
, result as (SELECT 
   u.first_name,
    u.last_name,
    u.gender,
    u.age,
    CASE 
        WHEN u.age = m.min_age THEN 'youngest'
        WHEN u.age = x.max_age THEN 'oldest'
    END AS tag
FROM 
    `bigquery-public-data.thelook_ecommerce.users` u
LEFT JOIN 
    MinAgesByGender m
ON 
    u.gender = m.gender
LEFT JOIN 
    MaxAgesByGender x
ON 
    u.gender = x.gender
WHERE
    u.age = m.min_age OR u.age = x.max_age)
select
gender,
tag,
count(gender) as no_customers
from result
group by gender,tag

--Ex4
with cte as 
      (select
            EXTRACT(YEAR FROM oi.created_at) AS year,
            EXTRACT(MONTH FROM oi.created_at) AS month,
            FORMAT_TIMESTAMP('%Y-%m', oi.created_at) AS month_year,
            oi.Product_id,
            p.name,
            SUM(oi.sale_price - p.cost) AS profit
      From bigquery-public-data.thelook_ecommerce.order_items as oi 
      join bigquery-public-data.thelook_ecommerce.products as p
      on oi.product_id = p.id
      group by  EXTRACT(YEAR FROM oi.created_at),EXTRACT(MONTH FROM oi.created_at),FORMAT_TIMESTAMP('%Y-%m', oi.created_at),oi.Product_id,p.name),

      rank_profit as
      (Select 
            month_year,
            Product_id,
            name,
            profit,
            dense_rank() Over(partition by month_year order by profit desc) as ranking
      from cte)

Select 
      month_year,
      Product_id,
      name,
      profit,
      ranking
from rank_profit
where ranking <= 5
order by month_year

---Ex5
