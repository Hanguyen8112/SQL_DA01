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

--ex4 Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 

-- Ex5 Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
-- Ex6 Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN
Lưu ý: với lệnh DELETE ko nên chạy trước khi bài được review











