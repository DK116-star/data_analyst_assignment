#
SELECT user_id, room_no
FROM bookings b
WHERE booking_date = (
    SELECT MAX(booking_date)
    FROM bookings b2
    WHERE b.user_id = b2.user_id
);

#2
SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11 
  AND YEAR(b.booking_date) = 2021
GROUP BY bc.booking_id;

#3
SELECT 
    bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bill_date) = 10 
  AND YEAR(bill_date) = 2021
GROUP BY bill_id
HAVING bill_amount > 1000;

SET SQL_SAFE_UPDATES = 0;

UPDATE booking_commercials
SET item_quantity = 10
WHERE bill_id = 'bl-34qhd-r7h8';

SET SQL_SAFE_UPDATES = 1;

#4
WITH t AS (
    SELECT 
        MONTH(bill_date) AS month,
        item_id,
        SUM(item_quantity) AS qty
    FROM booking_commercials
    WHERE YEAR(bill_date) = 2021
    GROUP BY month, item_id
),
r AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY qty DESC) AS max_rank,
           RANK() OVER (PARTITION BY month ORDER BY qty ASC) AS min_rank
    FROM t
)
SELECT *
FROM r
WHERE max_rank = 1 OR min_rank = 1;
#5
WITH t AS (
    SELECT 
        MONTH(bill_date) AS month,
        bill_id,
        SUM(bc.item_quantity * i.item_rate) AS total_bill
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bill_date) = 2021
    GROUP BY month, bill_id
),
r AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_bill DESC) AS rnk
    FROM t
)
SELECT *
FROM r
WHERE rnk = 2;
