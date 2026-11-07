-- All travellers on booking 42, lead traveller first.
-- SELECT t.id, t.full_name, bt.is_lead
-- FROM booking_travellers bt
-- JOIN travellers t ON t.id = bt.traveller_id
-- WHERE bt.booking_id = 42
-- ORDER BY bt.is_lead DESC;

-- Every trip for traveller 7: booking id, supplier name, status, date, newest first.
-- SELECT b.id AS booking, s.name AS supplier, b.status, b.created_at AS date
-- FROM booking_travellers bt
-- JOIN bookings b ON b.id = bt.booking_id
-- JOIN suppliers s ON s.id = b.supplier_id
-- WHERE bt.traveller_id = 7
-- ORDER BY date DESC;

-- The 5 travellers on the most bookings.
-- SELECT t.id, t.full_name, COUNT(*) AS bookings
-- FROM booking_travellers bt
-- JOIN travellers t ON t.id = bt.traveller_id
-- GROUP BY t.id
-- ORDER BY bookings DESC
-- LIMIT 5;

-- How many bookings have 1, 2 and 3 travellers?
-- split into 2: 1. How many travellers each booking have? 2. Of those results how many bookings have 1...?
-- SELECT travellers, COUNT(*) AS bookings
-- FROM (SELECT booking_id, COUNT(traveller_id) AS travellers
-- FROM booking_travellers
-- GROUP BY booking_id) AS sizes
-- GROUP BY travellers
-- ORDER BY travellers;

-- Break the rules: add an existing traveller to the same booking again, then add a traveller who doesn't exist.
-- INSERT INTO booking_travellers (booking_id, traveller_id) VALUES (2, 741);