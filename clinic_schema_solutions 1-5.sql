#1
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

#2
SELECT uid, SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

#3
WITH revenue AS (
    SELECT MONTH(datetime) m, SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY m
),
expense AS (
    SELECT MONTH(datetime) m, SUM(amount) AS expense
    FROM expenses
    GROUP BY m
)
SELECT 
    r.m,
    r.revenue,
    e.expense,
    (r.revenue - e.expense) AS profit,
    CASE 
        WHEN (r.revenue - e.expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
JOIN expense e ON r.m = e.m;

#4
WITH t AS (
    SELECT 
        c.city,
        cs.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.city, cs.cid
),
r AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) rnk
    FROM t
)
SELECT * FROM r WHERE rnk = 1;

#5
WITH t AS (
    SELECT 
        c.state,
        cs.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.state, cs.cid
),
r AS (
    SELECT *,
           RANK() OVER (PARTITION BY state ORDER BY profit ASC) rnk
    FROM t
)
SELECT * FROM r WHERE rnk = 2;
