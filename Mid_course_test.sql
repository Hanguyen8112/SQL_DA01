--Ex1: 
Select 
DISTINCT replacement_cost from film
order by replacement_cost asc
---Ex2: 
Select
Case 
when replacement_cost>= 9.99 and replacement_cost < 20 then 'low'
when replacement_cost>= 20 and replacement_cost < 25 then 'medium'
Else 'high'
end as Cost_category,
count(Film_id) as count_film
from film
group by Cost_category
---Ex3
Select  
f.film_id,
f.length,
d.name
from film as f 
left join film_category as c
on f.film_id = c.film_id
left join category as d
on c.category_id = d.category_id
where name = 'Drama' or name ='Sports' 
order by length desc
---Ex4
Select  
d.name,
Count(f.film_id) as countid
from film as f 
left join film_category as c
on f.film_id = c.film_id
left join category as d
on c.category_id = d.category_id
group by d.name
Order by countid desc
---E5
Select  
a.first_name ||' '|| a.last_name as full_name,
count (f.film_id) as count_film
from film as f 
left join film_actor as fa
on f.film_id = fa.film_id
left join actor as a
on fa.actor_id = a.actor_id
group by full_name
order by count_film desc
--ex6
select 
Count (a.address_id) as address_count
from address as a
left join customer as c
on a.address_id = c.address_id
where c.customer_id is null
---Ex7
select
ci.city,
sum(p.amount) as rev
from payment as p
	left join customer as c
	on p.customer_id = c.customer_id
	left join address as a
	on c.address_id = a.address_id
	left join city as ci
	on a.city_id = ci.city_id
group by ci.city
order by rev desc
---Exx8
select
(ci.city|| ', ' || co.country) as address,
sum(p.amount) as rev
from payment as p
	left join customer as c
	on p.customer_id = c.customer_id
	left join address as a
	on c.address_id = a.address_id
	left join city as ci
	on a.city_id = ci.city_id
	left join country as co
	on ci.country_id = co.country_id
group by (ci.city|| ', ' || co.country)
order by rev desc
