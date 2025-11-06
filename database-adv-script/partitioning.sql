-- ============================================================
-- Task: Partitioning Large Tables
-- Repository: alx-airbnb-database
-- Directory: database-adv-script
-- File: partitioning.sql
-- ============================================================

-- 🧠 Objective:
-- Optimize query performance on the large `bookings` table
-- by partitioning it based on the `start_date` column.

-- ------------------------------------------------------------
-- 1️⃣ Drop existing table (for demo purposes only)
-- ------------------------------------------------------------
DROP TABLE IF EXISTS bookings_partitioned;

-- ------------------------------------------------------------
-- 2️⃣ Create Partitioned Table by RANGE (using start_date)
-- ------------------------------------------------------------
-- Each partition represents one quarter of the year.
-- Adjust ranges according to dataset volume.

CREATE TABLE bookings_partitioned (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20),
    total_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (start_date);

-- ------------------------------------------------------------
-- 3️⃣ Define Partitions
-- ------------------------------------------------------------
CREATE TABLE bookings_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE bookings_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE bookings_q3 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

CREATE TABLE bookings_q4 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- ------------------------------------------------------------
-- 4️⃣ Index Creation on Partitions
-- ------------------------------------------------------------
CREATE INDEX idx_bookings_q1_start_date ON bookings_q1(start_date);
CREATE INDEX idx_bookings_q2_start_date ON bookings_q2(start_date);
CREATE INDEX idx_bookings_q3_start_date ON bookings_q3(start_date);
CREATE INDEX idx_bookings_q4_start_date ON bookings_q4(start_date);

-- ------------------------------------------------------------
-- 5️⃣ Performance Test Query (Before vs After)
-- ------------------------------------------------------------
-- Before: On unpartitioned 'bookings' table
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

-- After: On partitioned 'bookings_partitioned' table
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

-- ------------------------------------------------------------
-- 🧾 Notes:
--  - PostgreSQL automatically prunes partitions based on date range.
--  - Queries targeting specific date ranges only scan relevant partitions.
--  - Greatly reduces I/O and improves query speed.
