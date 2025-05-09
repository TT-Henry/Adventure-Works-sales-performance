-- sale_retailers table --
SELECT *
INTO sales_retailers3
FROM sales_retailers2;

ALTER TABLE sales_retailers3
ALTER COLUMN order_date DATE;

ALTER TABLE sales_retailers3
ALTER COLUMN sub_total DECIMAL(10,2);

ALTER TABLE sales_retailers3
ALTER COLUMN tax_amt DECIMAL(10,2);

ALTER TABLE sales_retailers3
ALTER COLUMN freight DECIMAL(10,2);

ALTER TABLE sales_retailers3
ALTER COLUMN sales_amount DECIMAL(10,2);

-- sale_consumers table --
SELECT *
INTO sales_consumers3
FROM sales_consumers2;

ALTER TABLE sales_consumers3
ALTER COLUMN unit_price DECIMAL(10,2);

ALTER TABLE sales_consumers3
ALTER COLUMN sales DECIMAL(10,2);

ALTER TABLE sales_consumers3
ALTER COLUMN cost DECIMAL(10,2);

-- products table --
SELECT *
INTO products3
FROM products2;

ALTER TABLE products3
ALTER COLUMN price DECIMAL(10,2);