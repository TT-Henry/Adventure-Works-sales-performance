SELECT
COALESCE(consumer.order_date, retailer.order_date) AS 'date',
consumer.product_key, COALESCE(consumer.sales_territory_key, retailer.territory_id) AS region,
consumer.sales AS consumer_sales, retailer.sales_amount AS retailer_sales, 
consumer.sales - consumer.cost AS consumer_profit, retailer.sub_total AS retailer_profit
INTO sales_and_profit
FROM sales_consumers3 AS consumer
FULL OUTER JOIN sales_retailers3 AS retailer
		On consumer.order_date = retailer.order_date;