-- Start from empty tables with IDs reset to 1.
TRUNCATE payments, bookings, suppliers, customers RESTART IDENTITY;

-- 1,000 customers
INSERT INTO customers (email, name)
SELECT 'customer' || g || '@test.com', 'Customer ' || g
FROM generate_series(1, 1000) AS g;

-- 50 suppliers with travel-style names, e.g. "Harbour Cruises"
INSERT INTO suppliers (name)
SELECT
  (ARRAY['Harbour','Coastal','Outback','Reef','Alpine'])[1 + floor(random() * 5)::int]
  || ' ' ||
  (ARRAY['Cruises','Tours','Airlines','Hotels','Adventures'])[1 + floor(random() * 5)::int]
FROM generate_series(1, 50);

-- 100,000 bookings over the last year.
-- Only customers 1 to 900 get bookings, so 901 to 1000 have none.
INSERT INTO bookings (customer_id, supplier_id, status, total_cents, created_at)
SELECT
  1 + floor(random() * 900)::int,
  1 + floor(random() * 50)::int,
  (ARRAY['pending','confirmed','confirmed','confirmed','cancelled'])[1 + floor(random() * 5)::int],
  5000 + floor(random() * 495000)::int,       -- $50 to $5,000
  now() - random() * interval '365 days'
FROM generate_series(1, 100000);

-- One payment for every confirmed booking
INSERT INTO payments (booking_id, amount_cents, paid_at)
SELECT id, total_cents, created_at + interval '1 hour'
FROM bookings
WHERE status = 'confirmed';

-- Update the statistics the query planner uses
ANALYZE;