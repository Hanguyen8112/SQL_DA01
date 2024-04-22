--Ex1
with yearly_spend as (SELECT 
Extract(Year from transaction_date) as year,
Product_id,
Sum(spend) as curr_year_spend
FROM user_transactions
Group by Extract(Year from transaction_date),Product_id)

select 
year,
product_id,
curr_year_spend,
lag(curr_year_spend) over(PARTITION BY Product_id order by year) as prev_year_spend,
Round(Cast(curr_year_spend/lag(curr_year_spend) over(PARTITION BY Product_id)*100-100 as numeric),2) as yoy_rate
from yearly_spend

---Ex2
SELECT
card_name,
issued_amount
from
(SELECT
*,
Rank() over(PARTITION BY card_name order by issue_year,issue_month) 
FROM monthly_cards_issued) as ranking
where rank = 1
ORDER BY issued_amount DESC

---Ex3
SELECT 
user_id,
spend,
transaction_date
FROM 
(Select 
*,
Rank() over(PARTITION BY user_id ORDER BY transaction_date) as rank
from transactions) as ranking
where rank = 3
--Ex4: https://datalemur.com/questions/histogram-users-purchases
SELECT
transaction_date,
user_id,
purchase_count
from
(SELECT 
 transaction_date,
 user_id,
 Count(user_id) as purchase_count,
 Rank() OVER(PARTITION BY user_id ORDER BY transaction_date desc) as ranking
FROM user_transactions
GROUP BY transaction_date,user_id) as latest
where ranking =1
ORDER BY transaction_date
  
---Ex5: https://datalemur.com/questions/histogram-users-purchases
with rolling_avg as (SELECT 
*,
rank() OVER(PARTITION BY user_id ORDER BY tweet_date) as rank,
lag(tweet_count) OVER(PARTITION BY user_id) as day1,
lag(tweet_count,2) OVER(PARTITION BY user_id) as day2
FROM tweets)

SELECT
user_id,
tweet_date,
round((case 
  when day1 is null then tweet_count
  when day2 is null then (tweet_count+day1)/2.0
  else (tweet_count+day2+day1)/3.0
end),2) as rolling_avg_3d
from rolling_avg

---Ex6:https://datalemur.com/questions/repeated-payments
with Minutes as
(SELECT 
*,
Rank() over(PARTITION BY merchant_id,credit_card_id,amount ORDER BY transaction_timestamp) as ranking,
EXTRACT(EPOCH FROM(transaction_timestamp-Lag(transaction_timestamp) over(PARTITION BY merchant_id,credit_card_id,amount ORDER BY transaction_timestamp)))/60 as diff
FROM transactions)

SELECT
Count(transaction_timestamp) as payment_count
from Minutes
where
Ranking >1 and diff >=10

--Ex7: https://datalemur.com/questions/sql-highest-grossing
with total_spending as (SELECT 
category,
product,
sum(spend) as total_spend,
RANK() OVER(PARTITION BY category ORDER BY sum(spend) desc) as ranking
FROM product_spend
where EXTRACT(year from transaction_date) = 2022
GROUP BY category,product)
SELECT
category,
product,
total_spend
from total_spending
WHERE ranking <=2
ORDER BY Category,total_spend DESC

--Ex8
with cte as 
(SELECT 
a.artist_name,
dense_rank() OVER(ORDER BY Count(s.song_id) desc) as artist_rank
FROM 
songs as s
left join artists as a  
on s.artist_id=a.artist_id
left join global_song_rank as g  
on g.song_id = s.song_id
where g.rank <11
GROUP BY a.artist_name)

Select 
artist_name,
artist_rank
from cte
where artist_rank<6


