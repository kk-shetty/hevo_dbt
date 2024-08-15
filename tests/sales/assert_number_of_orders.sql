WITH customer_order_count AS (
    SELECT
        SUM(number_of_orders) AS total_customer_orders
    FROM
        {{ ref('customers') }}
),
orders_count AS (
    SELECT
        count(id) AS total_orders
    FROM
        {{ source('public', 'orders') }}
    WHERE
        (
            status != 'returned'
            AND status != 'return_pending'
        )
)
SELECT
    'Mismatch detected' AS error_message
FROM
    customer_order_count,
    orders_count
WHERE
    customer_order_count.total_customer_orders != orders_count.total_orders
