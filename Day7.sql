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

