----Ex1
SELECT 
Sum(CASE
  when device_type='laptop' then 1
  else 0
  End) as laptop_views,
Sum(CASE
  when device_type='tablet' then 1
  when device_type='phone' then 1
  else 0
  End) as mobile_views
 FROM viewership
---Ex2
Select 
X,
Y,
Z,
Case
when (X+Y)>Z and (X+Z)>Y and (Y+Z)>X then 'Yes'
Else 'No'
End as triangle
from Triangle
---Ex3
SELECT 
Round(Sum(CASE
 When call_category = 'n/a' then 1
 When call_category is null then 1
 else 0
end)/Count(policy_holder_id	)*100,1)||'%'
FROM callers;
---Ex4
Select name
from Customer
where 
 Case 
   when referee_id = 2 then 1
   else 0
End = 0
---Ex5
select 
survived,
sum(case 
    when pclass = 1 then 1 
    Else 0
    end) first_class,
sum(case 
    when pclass = 2 then 1 
    Else 0
    end) second_class,
sum(case 
    when pclass = 3 then 1 
    Else 0    
    end) third_class
from titanic
group by survived
