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
---
