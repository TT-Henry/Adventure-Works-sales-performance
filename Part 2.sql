----- CHECK DUPILCATES WITH PRIMARY KEY -----
SELECT Sale_ID, COUNT(*) AS duplicate_count
FROM bike_market_sales
GROUP BY Sale_ID
HAVING COUNT(*) > 1;

----- CHECK DUPILCATES WITH OTHER FEILDS -----
WITH cte_market AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY [Date], Customer_ID, Bike_Model, Price, Quantity, 
Store_Location, Salesperson_ID, Payment_Method, Customer_Age, Customer_Gender ORDER BY [Date] DESC) AS row_num
FROM bike_market_sales)
SELECT * 
FROM cte_market
WHERE row_num > 1;

----- EXTRACT DATA -----
SELECT Sale_ID, [Date], Bike_Model AS Category, Price, Quantity, Store_Location, Payment_Method, Customer_Age AS Age, Customer_Gender AS Gender
INTO bike_market_sales2
FROM bike_market_sales;

----- STANDARDLIZE DATA FORMAT -----
ALTER TABLE bike_market_sales2
ALTER COLUMN Price DECIMAL(10,2);

----- LABEL DATA -----
WITH cte_label AS(
SELECT *,
CASE
	WHEN Store_Location ='New York' OR  Store_Location = 'Philadelphia' THEN 'Northeast'
	WHEN Store_Location = 'Chicago' OR Store_Location = 'Houston' OR Store_Location = 'San Antonio' THEN 'Central'
	WHEN Store_Location = 'Phoenix' OR Store_Location = 'Los Angeles' THEN 'Southwest'
END AS Region
FROM bike_market_sales2)
SELECT *
INTO bike_market_sales3
FROM cte_label;




SELECT * FROM bike_market_sales3
