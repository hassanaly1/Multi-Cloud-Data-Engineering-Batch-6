USE BikeStores

-- Q1
SELECT o.order_id,
       c.first_name + ' ' + c.last_name AS customer_name,
       s.store_name,
       st.first_name + ' ' + st.last_name AS staff_name
FROM sales.orders o
INNER JOIN sales.customers c ON o.customer_id = c.customer_id
INNER JOIN sales.stores s    ON o.store_id = s.store_id
INNER JOIN sales.staffs st   ON o.staff_id = st.staff_id;


-- Q2
SELECT p.product_name,
       b.brand_name,
       c.category_name
FROM production.products p
LEFT JOIN production.brands b     ON p.brand_id = b.brand_id
LEFT JOIN production.categories c ON p.category_id = c.category_id;


-- Q3
SELECT c.first_name + ' ' + c.last_name AS customer_name,
       c.city,
       c.email
FROM sales.customers c
LEFT JOIN sales.orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Q4
SELECT s.store_name,
       SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.stores s
INNER JOIN sales.orders o       ON s.store_id = o.store_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;


-- Q5
SELECT b.brand_name,
       COUNT(p.product_id) AS number_of_products,
       AVG(p.list_price)   AS average_price,
       MAX(p.list_price)   AS highest_price
FROM production.brands b
INNER JOIN production.products p ON b.brand_id = p.brand_id
GROUP BY b.brand_name
HAVING COUNT(p.product_id) > 5;


-- Q6
SELECT MONTH(o.order_date) AS order_month,
       COUNT(DISTINCT o.order_id) AS number_of_orders,
       SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.orders o
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = 2017
GROUP BY MONTH(o.order_date)
ORDER BY MONTH(o.order_date);


-- Q7
SELECT p.product_name,
       p.category_id,
       p.list_price
FROM production.products p
WHERE p.list_price > (
    SELECT AVG(p2.list_price)
    FROM production.products p2
    WHERE p2.category_id = p.category_id
);


-- Q8
SELECT c.first_name + ' ' + c.last_name AS customer_name,
       COUNT(o.order_id) AS number_of_orders
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count * 1.0)
    FROM (
        SELECT COUNT(order_id) AS order_count
        FROM sales.orders
        GROUP BY customer_id
    ) AS counts
);


-- Q9
WITH customer_spend AS (
    SELECT c.customer_id,
           c.first_name + ' ' + c.last_name AS customer_name,
           SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spend
    FROM sales.customers c
    INNER JOIN sales.orders o       ON c.customer_id = o.customer_id
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
customer_label AS (
    SELECT cs.customer_name,
           cs.total_spend,
           (SELECT COUNT(*)
            FROM customer_spend x
            WHERE x.total_spend > cs.total_spend) + 1 AS spend_rank,
           CASE
               WHEN cs.total_spend > (SELECT AVG(total_spend) FROM customer_spend)
                   THEN 'High'
               ELSE 'Regular'
           END AS spend_label
    FROM customer_spend cs
)
SELECT TOP 10 customer_name, total_spend, spend_rank, spend_label
FROM customer_label
ORDER BY spend_rank;


-- Q10
WITH product_sales AS (
    SELECT p.product_id,
           p.product_name,
           p.category_id,
           SUM(oi.quantity) AS total_quantity_sold
    FROM production.products p
    INNER JOIN sales.order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name, p.category_id
),
category_max AS (
    SELECT category_id,
           MAX(total_quantity_sold) AS max_quantity
    FROM product_sales
    GROUP BY category_id
)
SELECT c.category_name,
       ps.product_name,
       ps.total_quantity_sold,
       ISNULL(SUM(st.quantity), 0) AS total_stock
FROM product_sales ps
INNER JOIN category_max cm ON ps.category_id = cm.category_id
                          AND ps.total_quantity_sold = cm.max_quantity
INNER JOIN production.categories c ON ps.category_id = c.category_id
LEFT JOIN production.stocks st     ON ps.product_id = st.product_id
GROUP BY c.category_name, ps.product_name, ps.total_quantity_sold;