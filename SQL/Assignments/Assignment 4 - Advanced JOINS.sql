USE BikeStores

-- Task 41
SELECT s.staff_id,
       s.first_name + ' ' + s.last_name AS staff_name,
       m.first_name + ' ' + m.last_name AS manager_name
FROM sales.staffs s
LEFT JOIN sales.staffs m ON s.manager_id = m.staff_id;


-- Task 42
SELECT p1.product_name AS product_1,
       p2.product_name AS product_2,
       b.brand_name,
       p1.list_price
FROM production.products p1
INNER JOIN production.products p2 ON p1.brand_id = p2.brand_id
                                 AND p1.list_price = p2.list_price
                                 AND p1.product_id < p2.product_id
INNER JOIN production.brands b ON p1.brand_id = b.brand_id;


-- Task 45
SELECT b.brand_name,
       c.category_name
FROM production.brands b
CROSS JOIN production.categories c;


-- Task 46
SELECT b.brand_name,
       c.category_name
FROM production.brands b
CROSS JOIN production.categories c
LEFT JOIN production.products p ON p.brand_id = b.brand_id
                               AND p.category_id = c.category_id
WHERE p.product_id IS NULL;


-- Task 49
SELECT b.brand_name,
       p.product_name
FROM production.products p
RIGHT JOIN production.brands b ON p.brand_id = b.brand_id;


-- Task 50
SELECT s.store_name,
       o.order_id,
       o.order_date
FROM sales.orders o
RIGHT JOIN sales.stores s ON o.store_id = s.store_id;


-- Task 53
SELECT c.customer_id,
       c.first_name + ' ' + c.last_name AS customer_name,
       c.email
FROM sales.customers c
LEFT JOIN sales.orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Task 54
SELECT p.product_id,
       p.product_name
FROM production.products p
LEFT JOIN production.stocks st ON p.product_id = st.product_id
WHERE st.store_id IS NULL;


-- Task 56
SELECT p.product_id,
       p.product_name
FROM production.products p
LEFT JOIN sales.order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;


-- Task 59
SELECT c.category_id,
       c.category_name
FROM production.categories c
LEFT JOIN (SELECT DISTINCT category_id
           FROM production.products
           WHERE list_price > 2000) expensive ON c.category_id = expensive.category_id
WHERE expensive.category_id IS NULL;


-- Task 60
SELECT DISTINCT c.customer_id,
       c.first_name + ' ' + c.last_name AS customer_name
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
LEFT JOIN (SELECT DISTINCT o2.customer_id
           FROM sales.orders o2
           INNER JOIN sales.order_items oi ON o2.order_id = oi.order_id
           INNER JOIN production.products p ON oi.product_id = p.product_id
           INNER JOIN production.brands b ON p.brand_id = b.brand_id
           WHERE b.brand_name = 'Trek') trek_buyers ON c.customer_id = trek_buyers.customer_id
WHERE trek_buyers.customer_id IS NULL;
