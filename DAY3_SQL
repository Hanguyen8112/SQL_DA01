-----Ex1
Select Name from City
where CountryCode = 'USA'
and Population >120000;

--- Ex2
Select * from CITY
where COUNTRYCODE = 'JPN';

---Ex3
Select CITY, STATE from STATION
where LAT_N >0 and LONG_W >0;

---EX4
SELECT DISTINCT(CITY) FROM STATION 
WHERE 
CITY LIKE 'A%' 
OR CITY LIKE 'E%' 
OR CITY LIKE 'I%' 
OR CITY LIKE 'O%' 
OR CITY LIKE 'U%'
AND
LAT_N >0 and LONG_W >0;

---EX5
SELECT DISTINCT(CITY) FROM STATION 
WHERE 
CITY LIKE '%a' 
OR CITY LIKE '%e' 
OR CITY LIKE '%i' 
OR CITY LIKE '%o' 
OR CITY LIKE '%u'
AND
LAT_N >0 and LONG_W >0;

---EX6
SELECT DISTINCT(CITY) FROM STATION 
WHERE 
CITY NOT LIKE 'A%' 
AND CITY NOT LIKE 'E%' 
AND CITY NOT LIKE 'I%' 
AND CITY NOT LIKE 'O%' 
AND CITY NOT LIKE 'U%'
AND
LAT_N >0 and LONG_W >0;

---Ex7
SELECT NAME FROM EMPLOYEE 
ORDER BY NAME ASC;

--- EX8
SELECT NAME FROM EMPLOYEE
WHERE 
SALARY >2000
AND MONTHS <10
ORDER BY EMPLOYEE_ID ASC;

---EX9
Select product_id from Products
where 
low_fats = 'Y'
and recyclable = 'Y';

---EX10
Select name from customer
where referee_id <> 2 or referee_id is null;

---EX11
select  name, population, area from World
where 
area >= 3000000
OR population >= 25000000;

---EX12
SELECT DISTINCT(author_id) as id from Views 
where viewer_id = author_id
Order by author_id asc
---EX13
SELECT part,assembly_step FROM parts_assembly
where finish_date is NULL
  
---EX14
select * from lyft_drivers
where yearly_salary <=30000
or yearly_salary >=70000;

---15
select advertising_channel from uber_advertising
where year =2019
and money_spent >=100000;
