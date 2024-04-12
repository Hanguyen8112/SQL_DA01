---EX1
Select 
COUNTRY.Continent,
(CEILING(avg(CITY.Population))-1)
From Country
Inner join City
On CITY.CountryCode = COUNTRY.Code
Group by COUNTRY.Continent
Order by CEILING(avg(CITY.Population)) asc;
---Ex2
SELECT 
 Round(CAST(sum(
            case 
            when t.signup_action = 'Confirmed' then 1 
            else 0 end)*1.0 
          / count(distinct e.user_id) as numeric),2) as confirm_rate 
FROM emails as e
left join texts as t
on e.email_id = t.email_id

---Ex3
