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

---Ex4
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
