--Ex1: https://leetcode.com/problems/immediate-food-delivery-ii/?envType=study-plan-v2&envId=top-sql-50
with cte as (Select
Customer_id,
delivery_id,
case  
    when order_date = customer_pref_delivery_date then 'immediate'
    else 'scheduled'
End as order_type,
case  
    when order_date = customer_pref_delivery_date then 1
    else 0
End as count_immediate,
rank() over(partition by customer_id order by order_date) as first_order
from delivery)

select 
round(sum(count_immediate)/count(order_type)*100.0,2) as immediate_percentage 
from cte 
where first_order=1

--Ex2: https://leetcode.com/problems/game-play-analysis-iv/?envType=study-plan-v2&envId=top-sql-50
with cte as (Select
 player_id,
 event_date,
 datediff(lead(event_date) over(partition by player_id order by event_date),event_date) as next_login,
 rank() over(partition by player_id order by event_date) as ranking
from Activity)

select
round(Count(distinct(player_id))/(select count(distinct(player_id)) from cte),2) as fraction
from cte
where next_login=1
and ranking = 1

---Ex2 (2)
SELECT
  ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM
  Activity
WHERE
  (player_id, DATE_SUB(event_date, INTERVAL 1 DAY))
  IN (
    SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id
  )

---Ex3:

with cte as (select
id,
case 
 when id = (select max(id) from Seat) and mod(id,2)=1 then id
 when mod(id,2)=0 then id-1
 else id+1
end as swap
from seat)

select 
c.swap as id,
a.student
from cte as c
join seat as a
on c.id = a.id
order by c.swap

---Ex4
with cte as (Select
 visited_on,
 sum(amount) as daily_amount,
 sum(sum(amount)) over(rows between 6 Preceding and Current Row ) as total_amount,
 rank() over(order by visited_on) as ranking
from Customer group by visited_on)

select
visited_on,
total_amount as amount,
round(total_amount/7,2) as average_amount
from cte
where ranking>=7
