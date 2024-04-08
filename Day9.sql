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
