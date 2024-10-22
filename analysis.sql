select * from onlineretail;
-- Question1: What is the distribution of order values across all customers in the dataset?
SELECT CustomerID, 
       ROUND(SUM(Quantity * UnitPrice),2) AS TotalOrderValue,
       CASE
           WHEN SUM(Quantity * UnitPrice) < 100 THEN 'Low Spender'
           WHEN SUM(Quantity * UnitPrice) BETWEEN 100 AND 500 THEN 'Medium Spender'
           ELSE 'High Spender'
       END AS SpendingCategory
FROM OnlineRetail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalOrderValue DESC;

-- question2 : How many unique products has each customer purchased?
SELECT CustomerID, 
       COUNT(DISTINCT StockCode) AS UniqueProducts
FROM OnlineRetail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY UniqueProducts desc;

-- 3 :number of unique products
select count(DISTINCT stockcode) from onlineretail as numberOfProducts;

-- 4: numbers of customers
select count(DISTINCT customerid) from onlineretail as numberOfCustomers;

-- 5: Which customers have only made a single purchase from the company?
SELECT CustomerID
FROM OnlineRetail as oneTimeCustomer
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
HAVING COUNT(InvoiceNo) = 1;

-- 6: Which products are most commonly purchased together by customers in the dataset?
SELECT 
    a.StockCode AS Product1, 
    b.StockCode AS Product2, 
    COUNT(*) AS PurchaseCount
FROM OnlineRetail a
JOIN OnlineRetail b 
    ON a.InvoiceNo = b.InvoiceNo 
    AND a.StockCode < b.StockCode  -- To avoid duplicates (e.g., (A, B) and (B, A))
WHERE a.StockCode IS NOT NULL 
    AND b.StockCode IS NOT NULL
GROUP BY Product1, Product2
ORDER BY PurchaseCount DESC
LIMIT 10; 

-- 7:How many unique products has each customer purchased?

SELECT TRIM(CustomerID) AS CustomerID, 
       COUNT(DISTINCT StockCode) AS UniqueProducts
FROM OnlineRetail
WHERE TRIM(CustomerID) IS NOT NULL AND TRIM(CustomerID) <> ''
GROUP BY TRIM(CustomerID)
ORDER BY UniqueProducts DESC;



-- 8 : What is the total revenue generated from all transactions?
select sum(quantity*unitprice) as Totalrevenue
from onlineretail
where quantity>0 and unitprice>0;

-- 9: count of country
select count(DISTINCT country) from onlineretail;

-- 10: Which customers have generated the highest revenue?
SELECT TRIM(CustomerID) AS CustomerID, 
       SUM(Quantity * UnitPrice) AS TotalRevenue
FROM OnlineRetail
WHERE TRIM(CustomerID) IS NOT NULL 
  AND TRIM(CustomerID) <> '' 
  AND Quantity > 0 
  AND UnitPrice > 0
GROUP BY TRIM(CustomerID)
ORDER BY TotalRevenue DESC limit 10;

select * from onlineretail;
-- 11: Which products are most popular in each country?
SELECT Country, StockCode, TotalQuantity
FROM (
    SELECT Country,
           StockCode,
           SUM(Quantity) AS TotalQuantity
    FROM OnlineRetail
    WHERE Quantity > 0
    GROUP BY Country, StockCode
) AS ProductTotals
WHERE (Country, TotalQuantity) IN (
    SELECT Country, MAX(TotalQuantity)
    FROM (
        SELECT Country,
               StockCode,
               SUM(Quantity) AS TotalQuantity
        FROM OnlineRetail
        WHERE Quantity > 0
        GROUP BY Country, StockCode
    ) AS CountryTotals
    GROUP BY Country
);

--  12:How many customers made repeat purchases?
SELECT COUNT(DISTINCT CustomerID) AS RepeatCustomers
FROM (
    SELECT CustomerID
    FROM OnlineRetail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT InvoiceNo) > 1
) AS RepeatPurchases;

-- 13:Which products have been sold the most in terms of quantity?
SELECT StockCode, 
       SUM(Quantity) AS TotalQuantity
FROM OnlineRetail
WHERE Quantity > 0
GROUP BY StockCode
ORDER BY TotalQuantity DESC
limit 5;

















