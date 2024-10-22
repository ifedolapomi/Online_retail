
RENAME TABLE online_retail.`online retail1` TO online_retail.online_retail;
select * from online_retail;
-- unique customerid
select DISTINCT customerID from online_retail;
-- count of unique customerid
select count(distinct customerID) from online_retail;

-- duplicate online_retail table
create table onlineRetail like online_retail;
select * from onlineRetail;
-- inserting all the columns in online_retail to onlineRetail
insert onlineRetail select * from online_retail;

select * from onlineRetail;

-- data cleaning
-- step one: finding null value
select * from onlineRetail where invoiceNo is Null;
select * from onlineRetail where StockCode is Null;
select * from onlineRetail where Description is Null;
select * from onlineRetail where InvoiceDate is Null;
select * from onlineRetail where Unitprice is Null;
select * from onlineRetail where customerid is Null;
select * from onlineRetail where country is Null;

-- verify datatype(standalization)
describe onlineRetail;
-- select rows that are non integer
SELECT InvoiceNo
FROM onlineRetail
WHERE InvoiceNo NOT REGEXP '^[0-9]+$';

-- name the non integer
select invoiceNo as non_integer
from onlineRetail 
where InvoiceNo not REGEXP '^[0-9]+$';

select * from onlineRetail;
-- count of the non integer and performing CTE
WITH non_integer AS (
    SELECT InvoiceNo 
    FROM onlineRetail
    WHERE InvoiceNo NOT REGEXP '^[0-9]+$'
)
SELECT COUNT(*) AS non_integer_count FROM non_integer;

select * from onlineRetail;
select count(customerid) from onlineRetail;

-- delect the inconsistent from invoiceNo
SET SQL_SAFE_UPDATES = 0;
DELETE FROM onlineRetail WHERE invoiceNo NOT REGEXP '^[0-9]+$';

describe onlineRetail;
-- Count the number of rows
SELECT COUNT(*) AS total_rows
FROM onlineRetail;

select * from onlineRetail
where
 InvoiceNo is null
or StockCode is null
or Description is null 
or Quantity is null
or InvoiceDate is null 
or UnitPrice is null
or CustomerID is null
or Country is null;

select * from onlineRetail;
-- change datatype
alter table onlineRetail
modify invoiceNo int;
alter table onlineRetail
modify stockcode varchar(10);
alter table onlineRetail
modify description varchar(70);
alter table onlineRetail
modify quantity int;
alter table onlineRetail
modify unitprice FLOAT;
alter table onlineRetail
modify country varchar(20);

WITH non_int AS (
    SELECT customerId 
    FROM onlineRetail
    WHERE customerID NOT REGEXP '^[0-9]+$'
)
SELECT COUNT(*) AS non_integer_count FROM non_int;
alter table onlineRetail
modify customerId varchar(10);

-- identifying inconsistency in date
select invoicedate from onlineRetail
where str_to_date(invoicedate, '%m/%d/%Y %H:%i') is null;
SELECT invoiceDate
FROM onlineRetail
WHERE invoiceDate
 IS NULL OR invoiceDate = '' OR invoiceDate
 NOT REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$';
 
 UPDATE onlineRetail
SET invoiceDate = TRIM(invoiceDate);
UPDATE onlineRetail
SET invoiceDate = STR_TO_DATE(invoiceDate, '%m/%d/%Y %H:%i')
WHERE STR_TO_DATE(invoiceDate, '%m/%d/%Y %H:%i') IS NOT NULL;
ALTER TABLE onlineRetail
MODIFY invoiceDate DATE;

select invoicedate from onlineRetail;
SELECT DATE_FORMAT(invoiceDate, '%d/%m/%Y') AS InvoiceDateformat
FROM onlineRetail;

select * from onlineRetail;
-- trim the columns
update onlineRetail set description=trim(description);
update onlineRetail set country=trim(country),
customerId=trim(customerId)
;

-- removing outlier
DELETE FROM onlineRetail WHERE unitprice < 0;
DELETE FROM onlineRetail WHERE quantity < 0;

select distinct country from onlineRetail;

SET SQL_SAFE_UPDATES = 0;

UPDATE OnlineRetail
SET CustomerID = TRIM(CustomerID)
WHERE CustomerID IS NOT NULL;



