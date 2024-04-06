---Ex1:
Select distinct
City from Station
where Mod(ID,2)=0;
---Ex2:
Select 
(Count(City)-Count(Distinct(City)))
 From Station;
----Ex3
Select
Ceiling(Avg(salary)-avg(replace(salary,0,'')))
From Employees;
---Ex4
SELECT
Round(CAST(Sum(Item_count*order_occurrences)/sum(order_occurrences)as numeric),1)
FROM items_per_order;
---ex5
SELECT
candidate_id
FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
---ex6
SELECT 
User_id,
(MAX(post_date) - Min(post_date)) as days_between
FROM posts
where post_date >= '01/01/2021' and post_date < '01/01/2022'
GROUP BY User_id
---EX7
SELECT
Card_name,
MAX(issued_amount)-Min(issued_amount) as difference

FROM monthly_cards_issued
GROUP BY Card_name
ORDER BY difference DESC
---Ex8
SELECT
manufacturer,
COUNT(drug) as drug_count,
abs(Sum(total_sales - cogs)) as total_loss
FROM pharmacy_sales
where total_sales <  cogs
GROUP BY manufacturer
ORDER BY Sum(total_sales - cogs) ASC
--- Ex9
Select
id,
Movie,
description,
rating
From Cinema
where not description = 'boring'
and Mod (id,2)=1
Order by rating desc
---Ex10
Select
Teacher_id,
Count(distinct(subject_id)) as cnt
from Teacher
group by Teacher_id
---Ex11
Select
user_id,
Count(follower_id) as followers_count
From Followers
group by user_id
---Ex12
Select
Class
From Courses
Group by class
Having Count(student) >5
