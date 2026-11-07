-- CTE: suppliers whose confirmed revenue is above the average supplier's confirmed revenue. Hint: one CTE for revenue per supplier, then compare each to (SELECT AVG(revenue) FROM that_cte).

-- WITH supplier_revenue AS (
--     SELECT b.supplier_id, SUM(b.total_cents) AS revenue
--     FROM bookings b
--     WHERE status = 'confirmed'
--     GROUP BY b.supplier_id
-- )
-- SELECT s.id, s.name, sr.revenue / 100.0 AS revenue_dollars
-- FROM supplier_revenue sr
-- JOIN suppliers s ON s.id = sr.supplier_id
-- WHERE sr.revenue > (
--     SELECT AVG(revenue) FROM supplier_revenue
-- )
-- ORDER BY sr.revenue DESC;

-- ROW_NUMBER: each customer's most recent booking (show the first 20 customers).
-- WITH ranked AS (
--     SELECT id, customer_id, created_at, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY created_at) AS rn
--     FROM bookings
-- )
-- SELECT r.customer_id, c.name, r.id AS booking_id, r.created_at
-- FROM ranked r
-- JOIN customers c ON c.id = r.customer_id
-- WHERE rn = 1
-- ORDER BY customer_id
-- LIMIT 20;

-- Top N per group: the 3 highest-value bookings for each supplier.
-- WITH ranked AS 
-- (SELECT id, supplier_id, total_cents, 
--     ROW_NUMBER() OVER (PARTITION BY supplier_id ORDER BY total_cents DESC) AS rn 
-- FROM bookings)
-- SELECT s.id, s.name, r.id AS booking_id, r.total_cents/100.00 AS total_dollars, r.rn
-- FROM ranked r
-- JOIN suppliers s ON s.id = r.supplier_id
-- WHERE r.rn <= 3
-- ORDER BY s.name, r.supplier_id, r.rn;

-- Bonus: running total. Confirmed revenue per month, with a running total.

