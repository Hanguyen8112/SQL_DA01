--1. Task: Tạo danh sách tất cả chi phí thay thế (replacement costs )  khác nhau của các film.
--Question: Chi phí thay thế thấp nhất là bao nhiêu?

Select 
DISTINCT replacement_cost from film
order by replacement_cost asc
