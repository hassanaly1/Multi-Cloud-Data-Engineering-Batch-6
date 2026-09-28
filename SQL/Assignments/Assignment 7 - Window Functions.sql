USE BikeStores

-- 7.1
SELECT product_id,
       product_name,
       category_id,
       list_price,
       ROW_NUMBER() OVER (ORDER BY list_price DESC) AS overall_row_number,
       ROW_NUMBER() OVER (PARTITION BY category_id
                          ORDER BY list_price DESC) AS category_row_number
FROM production.products;


-- 7.2
SELECT product_name,
       category_id,
       list_price,
       RANK() OVER (PARTITION BY category_id
                    ORDER BY list_price DESC) AS price_rank,
       DENSE_RANK() OVER (PARTITION BY category_id
                          ORDER BY list_price DESC) AS price_dense_rank
FROM production.products;

WITH ranked_products AS (
    SELECT product_name,
           category_id,
           list_price,
           RANK() OVER (PARTITION BY category_id
                        ORDER BY list_price DESC) AS price_rank,
           DENSE_RANK() OVER (PARTITION BY category_id
                              ORDER BY list_price DESC) AS price_dense_rank
    FROM production.products
)
SELECT product_name,
       category_id,
       list_price,
       price_rank,
       price_dense_rank
FROM ranked_products
WHERE price_rank <> price_dense_rank
ORDER BY category_id, price_rank;


-- 7.3
WITH monthly_revenue AS (
    SELECT o.store_id,
           DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS revenue_month,
           SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS revenue
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY o.store_id,
             DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1)
)
SELECT store_id,
       revenue_month,
       revenue AS current_month_revenue,
       LAG(revenue) OVER (PARTITION BY store_id
                          ORDER BY revenue_month) AS previous_month_revenue,
       revenue - LAG(revenue) OVER (PARTITION BY store_id
                                    ORDER BY revenue_month) AS revenue_change
FROM monthly_revenue
ORDER BY store_id, revenue_month;


-- 7.4
SELECT product_name,
       list_price,
       NTILE(5) OVER (ORDER BY list_price) AS price_band
FROM production.products;


-- 7.5
WITH order_revenue AS (
    SELECT o.order_id,
           o.order_date,
           SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS revenue
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.order_date
)
SELECT order_id,
       order_date,
       revenue,
       SUM(revenue) OVER (ORDER BY order_date, order_id
                          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM order_revenue
ORDER BY order_date, order_id;
