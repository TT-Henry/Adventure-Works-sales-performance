----- CHECK DUPILCATES WITH PRIMARY KEY -----
-- products table --
SELECT ProductKey, COUNT(*) AS duplicate_count
FROM products
GROUP BY ProductKey
HAVING COUNT(*) > 1;

-- regions table --
SELECT SalesTerritoryKey, COUNT(*) AS duplicate_count
FROM regions
GROUP BY SalesTerritoryKey
HAVING COUNT(*) > 1;

-- employee_info table --
SELECT EmployeeKey, COUNT(*) AS duplicate_count
FROM employee_info
GROUP BY EmployeeKey
HAVING COUNT(*) > 1;

----- CHECK DUPILCATES WITH OTHER FEILDS -----
-- products table --
WITH cte_products AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY [Product], Standard_Cost, Color,
Subcategory, Category, Background_Color_Format, Font_Color_Format ORDER BY ProductKey ASC) AS row_num
FROM products)
SELECT * 
FROM cte_products
WHERE row_num > 1;

-- regions table --
WITH cte_regions AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY Region, Country, [Group] ORDER BY SalesTerritoryKey ASC) AS row_num
FROM regions)
SELECT * 
FROM cte_regions
WHERE row_num > 1;

-- employee_info table --
WITH cte_employee AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY EmployeeID, Salesperson, Title, UPN ORDER BY EmployeeKey ASC) AS row_num
FROM employee_info)
SELECT * 
FROM cte_employee
WHERE row_num > 1;

-- sales_consumers table --
WITH cte_consumers AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY OrderDate, ProductKey, ResellerKey, EmployeeKey, 
SalesTerritoryKey, Unit_Price, Quantity, Sales, Cost ORDER BY OrderDate DESC) AS row_num
FROM sales_consumers)
SELECT * 
FROM cte_consumers
WHERE row_num > 1;

-- sales_retailers table --
WITH cte_retailers AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY RevisionNumber, OrderDate, DueDate, Shipping_Date, [Status], OnlineOrderFlag,  
SalesOrderNumber, PurchaseOrderNumber, AccountNumber, CustomerID, SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID,
ShipMethodID, CreditCardID, CreditCardApprovalCode, CurrencyRateID, SubTotal, TaxAmt, Freight, Sales_Amount, Comment, rowguid, Modifieddate  
ORDER BY SalesOrderID DESC) AS row_num
FROM sales_retailers)
SELECT * 
FROM cte_retailers
WHERE row_num > 1;

----- REMOVE DUPLICATES -----
-- products table --
WITH cte_products AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY [Product], Standard_Cost, Color,
Subcategory, Category, Background_Color_Format, Font_Color_Format ORDER BY ProductKey ASC) AS row_num
FROM products)
SELECT *
INTO products_dup
FROM cte_products;

DELETE FROM products_dup
WHERE row_num > 1;

ALTER TABLE products_dup
DROP COLUMN row_num;

-- sale_consumers table --
WITH cte_consumers AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY OrderDate, ProductKey, ResellerKey, EmployeeKey, 
SalesTerritoryKey, Unit_Price, Quantity, Sales, Cost ORDER BY OrderDate DESC) AS row_num
FROM sales_consumers)
SELECT *
INTO sales_consumers_dup
FROM cte_consumers;

DELETE FROM sales_consumers_dup
WHERE row_num > 1;

ALTER TABLE sales_consumers_dup
DROP COLUMN row_num;
