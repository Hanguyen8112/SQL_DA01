--Ex1
SELECT
COUNT(company_id) as duplicate_companies
from 
(SELECT company_id
from job_listings
GROUP BY Company_id
having COUNT(Company_id)>1
and count(description)>1) as a
---Ex2
--Chọn category, sản phẩm, tổng tiêu trong năm 2022
SELECT 
a.category, 
a.product, 
SUM(a.spend) 
FROM product_spend as a
where EXTRACT('YEAR' FROM a.transaction_date ) = 2022
and a.product in --- điều kiện sản phẩm nằm trong top 2 sản phẩm có tổng tiêu cao nhất của category đó
(select b.product
from product_spend as b 
where EXTRACT('YEAR' FROM b.transaction_date ) = 2022
and b.category = a.category
Group by  B.product
order by sum(b.spend) DESC
limit 2) -- subquery lọc 2 sản phẩm
Group by a.category,a.product ORDER BY a.category, a.product DESC

  --- Ex3 : không thấy dữ liệu
SELECT COUNT(policy_holder_id)
FROM (
  SELECT
    policy_holder_id,
    COUNT(case_id) AS count_call
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS Call;
---Ex4
SELECT
p.page_id
FROM pages as p left JOIN page_likes as pl
on p.page_id	= pl.page_id
GROUP BY p.page_id
having count(pl.user_id)=0

---Ex5
SELECT
EXTRACT(month from event_date) as month,
Count(DISTINCT (user_id))
from user_actions
where EXTRACT(month from event_date)= 7
and User_id in
---list active tháng 6
(select 
User_id 
from user_actions
where EXTRACT(month from event_date)=6)
GROUP BY month

---Ex6
select 
DATE_FORMAT(trans_date,'%Y-%m') as month,
country,
Count(id ) as trans_count,
sum(case when state = 'approved' then 1
            else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum((case when state = 'approved' then 1
            else 0 end)*amount ) as approved_total_amount
from Transactions
group by month,country;

---Ex7
Select 
a.product_id,
a.year as first_year ,
a.quantity,
a.price
from Sales as a
inner join (Select 
                product_id,
                min(Year) as minyear
                from Sales
                group by product_id) as b
on a.product_id=b.product_id
and a.year= b.minyear
---Ex8
Select 
    customer_id
from Customer
    group by customer_id
    having Count(distinct(product_key)) = (Select 
                                            count(product_key) 
                                            from Product)

---Ex9
Select a.employee_id
from Employees a
left join Employees b
on a.manager_id = b.employee_id
where a.manager_id is not null
and b.name is null
and a.employee_id in (Select employee_id from Employees
where salary < 30000)
order by a.employee_id

---Ex10 - bài này bị trùng link??
Select 
COUNT(company_id)
from
(SELECT 
 company_id,
 Count(description)
FROM job_listings
Group by company_id
having Count(description) >1) as duplicate

---Ex11
with 
  user_rate as (select
  a.user_id,
  Count(a.movie_id),
  b.name as results
  from
  MovieRating a
  Left join Users b
  on a.user_id=b.user_id
  group by a.user_id, b.name
  Order by Count(a.movie_id) desc, b.name
  limit 1),

  Movie_rate as (Select 
  c.movie_id,
  avg (c.rating),
  d.title as results
  from MovieRating c
  left join Movies d
  on c.movie_id = d.movie_id
  where c.created_at > '2020-01-31' and c.created_at < '2020-03-01'
  group by movie_id
  order by avg (c.rating) desc , d.title
  limit 1)

Select results from user_rate
Union all
Select results from Movie_rate

--- Ex12

with allid as
(select requester_id id from RequestAccepted
union all
select accepter_id id from RequestAccepted)

select 
id, 
count(id) num  
from allid group 
by id order by count(id) desc 
limit 1
