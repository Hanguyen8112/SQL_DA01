--Ex1
SELECT
COUNT(company_id) as duplicate_companies
from 
(SELECT company_id
from job_listings
GROUP BY Company_id
having COUNT(Company_id)>1
and count(description)>1) as a
---Ex2
--Chọn category, sản phẩm, tổng tiêu trong năm 2022
SELECT 
a.category, 
a.product, 
SUM(a.spend) 
FROM product_spend as a
where EXTRACT('YEAR' FROM a.transaction_date ) = 2022
and a.product in --- điều kiện sản phẩm nằm trong top 2 sản phẩm có tổng tiêu cao nhất của category đó
(select b.product
from product_spend as b 
where EXTRACT('YEAR' FROM b.transaction_date ) = 2022
and b.category = a.category
Group by  B.product
order by sum(b.spend) DESC
limit 2) -- subquery lọc 2 sản phẩm
Group by a.category,a.product ORDER BY a.category, a.product DESC
---
