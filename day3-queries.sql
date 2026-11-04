-- INNER JOIN: the 10 most recent bookings, with booking id, customer name, supplier name, status and created_at
-- SELECT b.id, c.name AS customer, s.name AS supplier, b.status, b.created_at
-- FROM bookings b
-- JOIN customers c ON c.id = b.customer_id
-- JOIN suppliers s ON s.id = b.supplier_id
-- ORDER BY b.created_at DESC
-- LIMIT 10;

-- LEFT JOIN: every customer with no bookings. Expect about 100 (901 to 1000).
-- SELECT c.id, c.name
-- FROM customers c
-- LEFT JOIN bookings b ON b.customer_id = c.id
-- WHERE b.id IS NULL
-- ORDER BY c.id;

-- GROUP BY: bookings by status. Expect roughly 20% / 60% / 20%.
-- SELECT status, COUNT(*) AS bookings
-- FROM bookings
-- GROUP BY status
-- ORDER BY bookings DESC;

-- JOIN + GROUP BY: top 5 suppliers by confirmed revenue, in dollars.
-- SELECT s.id, s.name, COUNT(b.total_cents)/100.0 AS revenue
-- FROM bookings b
-- JOIN suppliers s ON s.id = b.supplier_id
-- WHERE b.status = 'confirmed'
-- GROUP BY s.id
-- ORDER BY revenue DESC
-- LIMIT 5;

-- HAVING: customers with more than 120 bookings, with name and count, highest first. Expect roughly 150 to 200 rows.
-- SELECT c.id, c.name, COUNT(*) AS bookings
-- FROM bookings b
-- JOIN customers c ON c.id = b.customer_id
-- GROUP BY c.id
-- HAVING COUNT(*) > 120
-- ORDER BY bookings DESC;

-- SELECT s.id, s.name, COUNT(*) AS bookings, ROUND(AVG(b.total_cents)/100.0,2) AS booking_value
-- FROM bookings b
-- JOIN suppliers s ON s.id = b.supplier_id
-- WHERE b.status = 'confirmed'
-- GROUP BY s.id
-- HAVING AVG(b.total_cents) > 255000
-- ORDER BY booking_value DESC;

SELECT c.id, c.name, COUNT(b.id) AS bookings
FROM customers c
LEFT JOIN bookings b ON b.customer_id = c.id
GROUP BY c.id
HAVING COUNT(b.id) < 95
ORDER BY bookings ASC;
