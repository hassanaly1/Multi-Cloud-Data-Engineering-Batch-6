USE BikeStores;
GO


-- Task 1
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name                 AS customer_name,
    s.store_name,
    st.first_name + ' ' + st.last_name               AS staff_name,
    p.product_name,
    cat.category_name,
    b.brand_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    oi.quantity * oi.list_price * (1 - oi.discount)  AS net_line_revenue
FROM sales.orders o
    INNER JOIN sales.order_items oi       ON o.order_id     = oi.order_id
    INNER JOIN sales.customers c          ON o.customer_id  = c.customer_id
    INNER JOIN sales.stores s             ON o.store_id     = s.store_id
    INNER JOIN sales.staffs st            ON o.staff_id     = st.staff_id
    INNER JOIN production.products p      ON oi.product_id  = p.product_id
    INNER JOIN production.categories cat  ON p.category_id  = cat.category_id
    INNER JOIN production.brands b        ON p.brand_id     = b.brand_id
WHERE o.order_status = 4
ORDER BY
    o.order_date DESC,
    o.order_id   DESC,
    oi.item_id;
GO


-- Task 2
SELECT
    s.store_name,
    COUNT(DISTINCT o.order_id)                                AS number_of_orders,
    SUM(oi.quantity)                                          AS total_units_sold,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount))      AS total_net_revenue,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount))
        / COUNT(DISTINCT o.order_id)                          AS average_order_value
FROM sales.stores s
    INNER JOIN sales.orders o        ON s.store_id = o.store_id
    INNER JOIN sales.order_items oi  ON o.order_id = oi.order_id
WHERE o.order_status = 4
GROUP BY
    s.store_id,
    s.store_name
ORDER BY total_net_revenue DESC;
GO


-- Task 3
WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.first_name + ' ' + c.last_name                          AS customer_name,
        COUNT(DISTINCT o.order_id)                                AS completed_order_count,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount))      AS total_spending
    FROM sales.customers c
        INNER JOIN sales.orders o        ON c.customer_id = o.customer_id
        INNER JOIN sales.order_items oi  ON o.order_id    = oi.order_id
    WHERE o.order_status = 4
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    customer_id,
    customer_name,
    completed_order_count,
    total_spending
FROM customer_totals
WHERE total_spending > (SELECT AVG(total_spending) FROM customer_totals)
ORDER BY total_spending DESC;
GO


-- Task 4
SELECT
    p.product_name,
    s.store_name,
    st.quantity  AS current_quantity,
    cat.category_name,
    b.brand_name
FROM production.stocks st
    INNER JOIN production.products p      ON st.product_id  = p.product_id
    INNER JOIN sales.stores s             ON st.store_id    = s.store_id
    INNER JOIN production.categories cat  ON p.category_id  = cat.category_id
    INNER JOIN production.brands b        ON p.brand_id     = b.brand_id
WHERE st.quantity < 5
ORDER BY
    st.quantity ASC,
    p.product_name;
GO


-- Task 5
WITH product_revenue AS (
    SELECT
        cat.category_id,
        cat.category_name,
        p.product_name,
        SUM(oi.quantity)                                          AS total_units_sold,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount))      AS total_net_revenue
    FROM sales.orders o
        INNER JOIN sales.order_items oi       ON o.order_id     = oi.order_id
        INNER JOIN production.products p      ON oi.product_id  = p.product_id
        INNER JOIN production.categories cat  ON p.category_id  = cat.category_id
    WHERE o.order_status = 4
    GROUP BY
        cat.category_id,
        cat.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_name,
        total_units_sold,
        total_net_revenue,
        DENSE_RANK() OVER (
            PARTITION BY category_id
            ORDER BY total_net_revenue DESC
        ) AS position_in_category
    FROM product_revenue
)
SELECT
    category_name,
    product_name,
    total_units_sold,
    total_net_revenue,
    position_in_category
FROM ranked_products
WHERE position_in_category <= 3
ORDER BY
    category_name,
    position_in_category,
    product_name;
GO


-- Task 6
WITH monthly_revenue AS (
    SELECT
        YEAR(o.order_date)                                        AS sales_year,
        MONTH(o.order_date)                                       AS sales_month,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount))      AS total_net_revenue
    FROM sales.orders o
        INNER JOIN sales.order_items oi  ON o.order_id = oi.order_id
    WHERE o.order_status = 4
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)
SELECT
    sales_year,
    sales_month,
    total_net_revenue,
    LAG(total_net_revenue) OVER (ORDER BY sales_year, sales_month)
        AS previous_month_revenue,
    total_net_revenue - LAG(total_net_revenue) OVER (ORDER BY sales_year, sales_month)
        AS revenue_change
FROM monthly_revenue
ORDER BY
    sales_year,
    sales_month;
GO


-- Task 7
CREATE OR ALTER VIEW sales.vw_customer_sales_summary
AS
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name                                          AS customer_name,
    COUNT(DISTINCT o.order_id)                                                AS total_completed_orders,
    ISNULL(SUM(oi.quantity), 0)                                               AS total_units_purchased,
    ISNULL(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 0)           AS total_net_revenue,
    MAX(o.order_date)                                                         AS most_recent_completed_order_date
FROM sales.customers c
    LEFT JOIN sales.orders o        ON c.customer_id = o.customer_id
                                   AND o.order_status = 4
    LEFT JOIN sales.order_items oi  ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;
GO

SELECT *
FROM sales.vw_customer_sales_summary
ORDER BY total_net_revenue DESC;
GO


-- Task 8
BEGIN TRANSACTION;

UPDATE sales.customers
SET phone = '(999) 555-0101'
WHERE customer_id = 1;

SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE customer_id = 1;

ROLLBACK TRANSACTION;

SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE customer_id = 1;

GO


-- Task 9
CREATE OR ALTER PROCEDURE sales.usp_store_sales_report
    @store_id    INT,
    @start_date  DATE,
    @end_date    DATE
AS
BEGIN
    SET NOCOUNT ON;

    IF @start_date > @end_date
    BEGIN
        THROW 50001, 'Invalid date range: @start_date cannot be later than @end_date.', 1;
    END;

    SELECT
        p.product_name,
        SUM(oi.quantity)                                          AS total_units_sold,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount))      AS total_net_revenue
    FROM sales.orders o
        INNER JOIN sales.order_items oi   ON o.order_id    = oi.order_id
        INNER JOIN production.products p  ON oi.product_id = p.product_id
    WHERE o.store_id     = @store_id
      AND o.order_status = 4
      AND o.order_date  >= @start_date
      AND o.order_date  <= @end_date
    GROUP BY
        p.product_id,
        p.product_name
    ORDER BY total_net_revenue DESC;
END;
GO

EXEC sales.usp_store_sales_report
    @store_id   = 1,
    @start_date = '2017-01-01',
    @end_date   = '2017-12-31';

EXEC sales.usp_store_sales_report
    @store_id   = 1,
    @start_date = '2017-12-31',
    @end_date   = '2017-01-01';
GO


-- Task 10
SELECT
    b.brand_name,
    SUM(oi.quantity * oi.list_price)                          AS gross_sales,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount))      AS net_sales,
    SUM(oi.quantity * oi.list_price * oi.discount)            AS discount_amount,
    SUM(oi.quantity * oi.list_price * oi.discount) * 100.0
        / SUM(oi.quantity * oi.list_price)                    AS discount_percentage
FROM sales.orders o
    INNER JOIN sales.order_items oi   ON o.order_id    = oi.order_id
    INNER JOIN production.products p  ON oi.product_id = p.product_id
    INNER JOIN production.brands b    ON p.brand_id    = b.brand_id
WHERE o.order_status = 4
GROUP BY
    b.brand_id,
    b.brand_name
ORDER BY discount_amount DESC;
GO
