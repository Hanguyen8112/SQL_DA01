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
