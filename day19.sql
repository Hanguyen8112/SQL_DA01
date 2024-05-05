select * from sales_dataset_rfm_prj
---ex1: Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
select * from sales_dataset_rfm_prj
Alter table sales_dataset_rfm_prj
alter quantityordered type numeric
USING (quantityordered::numeric);

Alter table sales_dataset_rfm_prj
alter priceeach type numeric
USING (priceeach::numeric);

Alter table sales_dataset_rfm_prj
alter sales type numeric
USING (sales::numeric);

Alter table sales_dataset_rfm_prj
alter orderlinenumber type integer
USING (orderlinenumber::integer);

Alter table sales_dataset_rfm_prj
alter orderdate type timestamp
USING (orderdate::timestamp);


--Ex2: Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
Select *
From sales_dataset_rfm_prj
Where (ORDERNUMBER is null or ORDERNUMBER = '')

  Select *
From sales_dataset_rfm_prj
Where QUANTITYORDERED is null

  Select *
From sales_dataset_rfm_prj
Where PRICEEACH is null

  Select *
From sales_dataset_rfm_prj
Where ORDERLINENUMBER is null

  Select *
From sales_dataset_rfm_prj
Where SALES is null

  Select *
From sales_dataset_rfm_prj
Where ORDERDATE is null

---ex3 Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. Gợi ý: ( ADD column sau đó UPDATE)
ALTER TABLE public.sales_dataset_rfm_prj
ADD CONTACTLASTNAME varchar(255);

ALTER TABLE public.sales_dataset_rfm_prj
ADD CONTACTFIRSTNAME varchar(255);

UPDATE sales_dataset_rfm_prj
SET CONTACTFIRSTNAME = 
(select 
SUBSTRING(contactfullname,1,position('-' in contactfullname)-1))

UPDATE sales_dataset_rfm_prj
SET CONTACTLASTNAME = 
(select 
SUBSTRING(contactfullname,position('-' in contactfullname)+1,length(contactfullname)-position('-' in contactfullname)))

UPDATE sales_dataset_rfm_prj
SET CONTACTLASTNAME = 
(Select upper(left(CONTACTLASTNAME,1))||right(CONTACTLASTNAME,length(CONTACTLASTNAME)-1))


UPDATE sales_dataset_rfm_prj
SET CONTACTFIRSTNAME = 
(Select upper(left(CONTACTFIRSTNAME,1))||right(CONTACTFIRSTNAME,length(CONTACTFIRSTNAME)-1))
--ex4 Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
ALTER TABLE public.sales_dataset_rfm_prj
ADD QTR_ID Integer;

ALTER TABLE public.sales_dataset_rfm_prj
ADD MONTH_ID Integer;

ALTER TABLE public.sales_dataset_rfm_prj
ADD YEAR_ID Integer;

UPDATE sales_dataset_rfm_prj
SET MONTH_ID = 
(select extract(month from ORDERDATE))


UPDATE sales_dataset_rfm_prj
SET YEAR_ID = 
(select extract(year from ORDERDATE))


UPDATE sales_dataset_rfm_prj
SET QTR_ID = 
(select extract(QUARTER from ORDERDATE))
-- Ex5 Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
  --Boxplot
with 
    cte as (Select 
  percentile_cont(0.25) within group (order by QUANTITYORDERED) as Q1,
  percentile_cont(0.75) within group (order by QUANTITYORDERED) as Q3,
  (percentile_cont(0.75) within group (order by QUANTITYORDERED) -percentile_cont(0.25) within group (order by QUANTITYORDERED)) as IQR
  from public.sales_dataset_rfm_prj),
    Min_max as
  (select 
  Q1-1.5*IQR as min_vl,
  Q3+1.5*IQR as max_vl
  from cte),
    Outlier as
  (select * from sales_dataset_rfm_prj
  where QUANTITYORDERED < (select min_vl from Min_max)
  or QUANTITYORDERED > (select max_vl from Min_max))
Update public.sales_dataset_rfm_prj
  Set QUANTITYORDERED = (select avg(QUANTITYORDERED) from public.sales_dataset_rfm_prj)
  where QUANTITYORDERED in (select QUANTITYORDERED from Outlier)
  
 --Zscore
    with zscore as (Select 
  ordernumber,
  QUANTITYORDERED,
  (select avg(QUANTITYORDERED) from public.sales_dataset_rfm_prj)  as av,
  (select stddev(QUANTITYORDERED) from public.sales_dataset_rfm_prj) as stddev
  from public.sales_dataset_rfm_prj),

   Outlier as (select ordernumber,
  QUANTITYORDERED,
  (QUANTITYORDERED-av)/stddev as zscore
  from zscore
  where abs((QUANTITYORDERED-av)/stddev)>3)

Update public.sales_dataset_rfm_prj
Set QUANTITYORDERED = (select avg(QUANTITYORDERED) from public.sales_dataset_rfm_prj)
where QUANTITYORDERED in (select QUANTITYORDERED from Outlier)
  
-- Ex6 Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN
SELECT * INTO SALES_DATASET_RFM_PRJ_CLEAN
FROM sales_dataset_rfm_prj










