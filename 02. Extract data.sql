-- Extract Sales_consumers table --
SELECT SalesOrderNumber AS sales_order_number, Orderdate AS order_date, ProductKey AS product_key, ResellerKey AS reseller_key, 
EmployeeKey AS employee_key, SalesTerritoryKey AS sales_territory_key, Quantity AS quantity, Unit_Price AS unit_price, Sales AS sales, Cost AS cost 
INTO sales_consumers2
FROM sales_consumers_dup;

-- Extract Sales_retailers table --
SELECT SalesOrderID AS sales_order_id, Orderdate AS order_date, CustomerID AS customer_id,
TerritoryID AS territory_id, Subtotal AS sub_total, TaxAmt AS tax_amt,Freight AS freight, Sales_Amount AS sales_amount
INTO sales_retailers2
FROM sales_retailers;

-- Extract Employee_info table --
SELECT EmployeeKey AS employee_key, EmployeeID AS employee_id, Salesperson AS full_name, Title AS title, UPN
INTO employee_info2
FROM employee_info;

-- Extract Regions table --
SELECT SalesTerritoryKey AS territory_key, Region AS region, Country AS country, [Group] AS area
INTO regions2
FROM regions;

-- Extract Products table --
SELECT ProductKey AS product_key, [Product] AS product_name, Category AS category,
Subcategory AS subcategory, Color AS color, Standard_Cost AS price
INTO products2
FROM products_dup;