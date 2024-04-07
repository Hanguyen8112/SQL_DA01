--Ex1
Select 
Name 
From STUDENTS
where marks >75
order by right(name,3) asc, id  asc;
---Ex2
Select
user_id,
Concat(left(Upper(Name),1),Right(Lower(name),length(name)-1)) as name
From Users
Order by User_id
---Ex3
SELECT 
manufacturer,
'$'||ROUND(CAST((Sum(total_sales)/10^6) as numeric),0)||' '||'million' as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY Sum(total_sales) DESC, manufacturer
---Ex4
SELECT
Extract(Month from submit_date) as mth,
product_id,
round(avg(stars),2) as avg_stars
FROM reviews
GROUP BY Extract(Month from submit_date),product_id
ORDER BY mth, product_id
---Ex5
SELECT 
sender_id,
Count(message_id)
FROM messages
WHERE sent_date>'07/31/2022' and sent_date<'09/01/2022'
GROUP BY sender_id
ORDER BY Count(message_id) DESC
LIMIT 2;
--Ex6
Select
tweet_id
from Tweets
where length(content) >15
--Ex7
  Select 
 activity_date as day,
 Count(distinct(user_id)) as active_users 
from Activity
where activity_date >'2019-06-27' and  activity_date <'2019-07-28'
Group by day
--- Ex8
select 
Count(id)
from employees
where joining_date >'2021-12-31' and joining_date <'2022-08-01';
---Ex9
select 
POSITION ('a' in first_name)
from worker
Where first_name ='Amitah';
---Ex10
select 
title,
Substring(title,Length(winery)+2,4)
from winemag_p2
where country='Macedonia';


