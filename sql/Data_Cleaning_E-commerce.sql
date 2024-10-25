-- Data Cleaning
-- MY attempt to clean a popular dataset 'e_commerce' from kaggle
-- I'll be performing the following data cleaning steps:
-- 1. Remove Duplicates (if any).
-- 2. Standardize the Data.
-- 3. Null Values or Blank Values.
-- 4. Remove rows (if needed).

SELECT *
FROM e_commerce;

CREATE TABLE e_commerce_clone
LIKE e_commerce;

SELECT *
FROM e_commerce_clone;

INSERT e_commerce_clone
SELECT *
FROM e_commerce
;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY InvoiceNo, StockCode, `Description`, Quantity, InvoiceDate, UnitPrice, CustomerId, Country) AS row_num
FROM e_commerce_clone 
;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY InvoiceNo, StockCode, `Description`, Quantity, InvoiceDate, UnitPrice, CustomerId, Country
ORDER BY InvoiceNo) AS row_num
FROM e_commerce_clone 
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `e_commerce_clone2` (
  `InvoiceNo` int DEFAULT NULL,
  `StockCode` text,
  `Description` text,
  `Quantity` int DEFAULT NULL,
  `InvoiceDate` text,
  `UnitPrice` double DEFAULT NULL,
  `CustomerID` bigint DEFAULT NULL,
  `Country` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM e_commerce_clone2
;

INSERT INTO e_commerce_clone2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY InvoiceNo, StockCode, `Description`, Quantity, InvoiceDate, UnitPrice, CustomerId, Country
ORDER BY InvoiceNo) AS row_num
FROM e_commerce_clone;

SELECT *
FROM e_commerce_clone2
WHERE row_num > 1;

DELETE
FROM e_commerce_clone2
WHERE row_num > 1;

SELECT *
FROM e_commerce_clone2
WHERE row_num > 1;

SELECT `Description`, TRIM(`Description`)
FROM e_commerce_clone2;

UPDATE e_commerce_clone2
SET `Description` = TRIM(`Description`)
;

SELECT DISTINCT `Description` , TRIM(TRAILING '""' FROM `Description`), TRIM(TRAILING '..' FROM `Description`)
FROM e_commerce_clone2
;

UPDATE e_commerce_clone2
SET `Description` = TRIM(TRAILING '..' FROM TRIM(TRAILING '"' FROM TRIM(TRAILING '.' FROM TRIM(TRAILING ',' FROM `Description`))))
;

SELECT InvoiceDate,
STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')
FROM e_commerce_clone2
;

UPDATE e_commerce_clone2
SET InvoiceDate = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')
;

SELECT InvoiceDate
FROM e_commerce_clone2
;

ALTER TABLE e_commerce_clone2
MODIFY COLUMN InvoiceDate DATETIME;

SELECT InvoiceDate,
STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')
FROM e_commerce_clone2
;

SELECT *
FROM e_commerce_clone2
WHERE `Description` IS NULL
		OR InvoiceNo IS NULL
        OR StockCode IS NULL
		OR Quantity IS NULL 
        OR InvoiceDate IS NULL 
        OR UnitPrice IS NULL
        OR CustomerID IS NULL
        OR Country IS NULL
;

SELECT *
FROM e_commerce_clone2
WHERE `Description` = ''
		OR InvoiceNo = ''
        OR StockCode = ''
		OR Quantity = ''
        OR UnitPrice = ''
        OR CustomerID = ''
        OR Country = ''
;

ALTER TABLE e_commerce_clone2
DROP COLUMN row_num
;

SELECT *
FROM e_commerce_clone2;

SELECT InvoiceDate 
FROM e_commerce_clone2 
WHERE STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i') IS NULL;

SELECT InvoiceNo, StockCode, CustomerID, COUNT(*)
FROM e_commerce_clone2
GROUP BY InvoiceNo, StockCode, CustomerID
HAVING COUNT(*) > 1;

SELECT DISTINCT InvoiceDate
FROM e_commerce_clone2;

UPDATE e_commerce_clone2
SET `Description` = LOWER(TRIM(`Description`)),
    `UnitPrice` = ROUND(`UnitPrice`, 2);

SELECT `Description`, UnitPrice
FROM e_commerce_clone2;



















