-- Time: 9:49:45 PM
WITH cusomer_order_summary AS (
	SELECT
		o.user_id,
		min(o.order_date) AS first_order,
		max(o.order_date) AS most_recent_order,
		count(DISTINCT o.id) AS number_of_orders,
		sum(p.amount) AS customer_lifetime_value
	FROM
		{{ source('public', 'orders') }} o
	LEFT JOIN {{ source('public', 'payments') }} p ON
		p.order_id = o.id
	WHERE   -- Applying below conditions to not include payments made against orders that are rturned or placed for return
		(
			o.status != 'returned'
				AND o.status != 'return_pending'
		)
	GROUP BY
		o.user_id
),
FINAL AS (
	SELECT
		c.id AS customer_id,
		c.first_name,
		c.last_name,
		cos.first_order,
		cos.most_recent_order,
		cos.number_of_orders,
		cos.customer_lifetime_value
	FROM
		{{ source('public', 'customers') }} c
	LEFT JOIN cusomer_order_summary cos ON
		cos.user_id = c.id
)
SELECT
	*
FROM
	FINAL