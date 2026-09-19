USE BikeStores

-- 5.1
SELECT p.product_id,
       p.product_name,
       p.brand_id,
       p.list_price
FROM production.products p
WHERE p.list_price > (SELECT AVG(p2.list_price)
                      FROM production.products p2
                      WHERE p2.brand_id = p.brand_id);


-- 5.2
SELECT o.order_id,
       o.customer_id,
       o.order_date,
       o.order_status
FROM sales.orders o
WHERE o.customer_id IN (SELECT c.customer_id
                        FROM sales.customers c
                        WHERE c.state IN ('NY', 'CA'));


-- 5.3
SELECT customer_id
FROM sales.customers
WHERE customer_id NOT IN (SELECT customer_id
                          FROM sales.orders
                          WHERE customer_id IS NOT NULL);

SELECT c.customer_id
FROM sales.customers c
WHERE NOT EXISTS (SELECT 1
                  FROM sales.orders o
                  WHERE o.customer_id = c.customer_id);


-- 5.4
SELECT AVG(item_count * 1.0) AS avg_items_per_order
FROM (SELECT order_id,
             COUNT(item_id) AS item_count
      FROM sales.order_items
      GROUP BY order_id) AS order_totals;


-- 5.5
SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM sales.customers c
WHERE EXISTS (SELECT 1
              FROM sales.orders o
              WHERE o.customer_id = c.customer_id);

SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM sales.customers c
WHERE c.customer_id IN (SELECT o.customer_id
                        FROM sales.orders o);


-- 5.6
SELECT c.customer_id,
       c.first_name,
       recent.order_id,
       recent.order_date
FROM sales.customers c
CROSS APPLY (SELECT TOP 3 o.order_id, o.order_date
             FROM sales.orders o
             WHERE o.customer_id = c.customer_id
             ORDER BY o.order_date DESC) AS recent
ORDER BY c.customer_id, recent.order_date DESC;
