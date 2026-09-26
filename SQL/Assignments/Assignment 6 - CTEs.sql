USE BikeStores

-- 6.1
WITH store_counts AS (
    SELECT store_id,
           COUNT(*) AS order_count
    FROM sales.orders
    GROUP BY store_id
)
SELECT AVG(order_count) AS avg_orders
FROM store_counts;


-- 6.2
WITH cte_high_value_products AS (
    SELECT product_id,
           product_name,
           category_id,
           list_price
    FROM production.products
    WHERE list_price > 2000
)
SELECT hv.product_id,
       hv.product_name,
       c.category_name,
       hv.list_price
FROM cte_high_value_products hv
INNER JOIN production.categories c ON hv.category_id = c.category_id
WHERE c.category_name = 'Mountain Bikes';


-- 6.3
WITH order_counts AS (
    SELECT customer_id,
           COUNT(order_id) AS order_count
    FROM sales.orders
    GROUP BY customer_id
),
revenue_totals AS (
    SELECT o.customer_id,
           SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)
SELECT oc.customer_id,
       oc.order_count,
       rt.total_revenue
FROM order_counts oc
INNER JOIN revenue_totals rt ON oc.customer_id = rt.customer_id;


-- 6.4
WITH numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT n,
       n * n AS square
FROM numbers;


-- 6.5
WITH org_chart AS (
    SELECT staff_id,
           first_name,
           last_name,
           manager_id,
           CAST(NULL AS VARCHAR(50)) AS manager_first_name,
           0 AS level
    FROM sales.staffs
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.staff_id,
           s.first_name,
           s.last_name,
           s.manager_id,
           oc.first_name AS manager_first_name,
           oc.level + 1 AS level
    FROM sales.staffs s
    INNER JOIN org_chart oc ON s.manager_id = oc.staff_id
)
SELECT staff_id,
       first_name,
       last_name,
       manager_first_name,
       level
FROM org_chart
ORDER BY level, staff_id;
