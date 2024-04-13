---EX1
Select 
COUNTRY.Continent,
(CEILING(avg(CITY.Population))-1)
From Country
Inner join City
On CITY.CountryCode = COUNTRY.Code
Group by COUNTRY.Continent
Order by CEILING(avg(CITY.Population)) asc;
---Ex2
SELECT 
 Round(CAST(sum(
            case 
            when t.signup_action = 'Confirmed' then 1 
            else 0 end)*1.0 
          / count(distinct e.user_id) as numeric),2) as confirm_rate 
FROM emails as e
left join texts as t
on e.email_id = t.email_id

---Ex3
SELECT 
t2.age_bucket,
round(sum(Case when activity_type	= 'open' then time_spent else 0 end)*100.0
     /(sum(Case when activity_type	= 'open' then time_spent else 0 end)
       +sum(Case when activity_type	= 'send' then time_spent else 0 end)),2)
as open_perc,
round(sum(Case when activity_type	= 'send' then time_spent else 0 end)*100.0
     /(sum(Case when activity_type	= 'open' then time_spent else 0 end)
       +sum(Case when activity_type	= 'send' then time_spent else 0 end)),2)
as send_perc
FROM activities as t1
JOIN age_breakdown as t2
On t1.user_id = t2.user_id
group by t2.age_bucket
---Ex4
SELECT 
t1.customer_id
FROM customer_contracts as t1
Join products as t2
on t1.product_id	= t2.product_id
GROUP BY t1.customer_id
HAVING COUNT(DISTINCT t2.product_category) = (
SELECT count(distinct product_category)
FROM products )
---Ex5
Select
m.employee_id,
m.name,
Count(em.employee_id) as reports_count,
round(avg(em.age),0) as average_age
from Employees as em
left join Employees as m
on m.employee_id = em.reports_to
where m.employee_id is not null
group by m.employee_id
order by m.employee_id
 
---Ex6
Select
p.product_name,
sum(o.unit) as unit
from Products as p
join Orders as o
on p.product_id=o.product_id
where o.order_date < '2020-03-01' and o.order_date > '2020-01-31'
group by p.product_name
Having sum(o.unit)>= 100

---Ex7
SELECT
p.page_id

FROM pages as p left JOIN page_likes as pl
on p.page_id	= pl.page_id
GROUP BY p.page_id
having count(pl.user_id)=0
