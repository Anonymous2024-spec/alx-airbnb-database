-- ============================================================
-- Task: Optimize Complex Queries
-- Repository: alx-airbnb-database
-- Directory: database-adv-script
-- File: perfomance.sql
-- ============================================================

-- 🧠 Objective:
-- Retrieve all bookings along with corresponding user, property,
-- and payment details, then refactor for performance improvement.

-- ------------------------------------------------------------
-- 1️⃣ Initial Query (Unoptimized)
-- ------------------------------------------------------------
-- This query retrieves all data through multiple joins,
-- but it fetches all columns (*) and lacks filtering or indexing.

SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;

-- Problem:
--  - Uses SELECT * (unnecessary columns)
--  - Joins fetch redundant data
--  - Lacks WHERE or LIMIT filters
--  - No explicit index utilization

-- ------------------------------------------------------------
-- 2️⃣ Optimized Query (Refactored)
-- ------------------------------------------------------------
-- Improvements:
--  - Selects only required fields
--  - Uses indexed join keys
--  - Avoids redundant joins
--  - Uses aliasing and LIMIT for testing
--  - Employs proper JOIN order to reduce dataset size early

EXPLAIN
SELECT 
    b.id AS booking_id,
    b.booking_date,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.username,
    u.email,
    p.id AS property_id,
    p.title AS property_title,
    p.location,
    pay.amount AS payment_amount,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE b.status = 'confirmed'
ORDER BY b.booking_date DESC
LIMIT 50;

-- ------------------------------------------------------------
-- 3️⃣ Indexes Supporting Optimization
-- ------------------------------------------------------------
-- These indexes help improve the query’s performance by enabling
-- faster joins and lookups.

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_properties_id ON properties(id);
CREATE INDEX idx_users_id ON users(id);

-- ------------------------------------------------------------
-- 4️⃣ Additional Test Queries (Optional)
-- ------------------------------------------------------------
-- Compare before/after execution times:
-- EXPLAIN ANALYZE SELECT ... (original)
-- EXPLAIN ANALYZE SELECT ... (optimized)
