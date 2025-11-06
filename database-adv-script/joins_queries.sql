-- =====================================================
-- Task 0: Write Complex Queries with Joins
-- =====================================================
-- Objective: Master SQL joins by writing complex queries using different types of joins
-- Author: ALX Airbnb Database Project
-- Database: MySQL
-- =====================================================

-- -----------------------------------------------------
-- Query 1: INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
-- -----------------------------------------------------
-- Description: This query combines the Booking and User tables to show 
-- all bookings along with complete user information. INNER JOIN returns 
-- only the records where there is a match in both tables.
-- -----------------------------------------------------

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.created_at DESC;


-- -----------------------------------------------------
-- Query 2: LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
-- -----------------------------------------------------
-- Description: This query retrieves all properties from the Property table
-- and their associated reviews from the Review table. LEFT JOIN ensures 
-- that even properties without reviews are included in the result set
-- (with NULL values for review fields).
-- -----------------------------------------------------

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created_at,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
ORDER BY 
    p.property_id, r.created_at DESC;


-- -----------------------------------------------------
-- Query 3: FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking 
-- or a booking is not linked to a user
-- -----------------------------------------------------
-- Description: MySQL does not support FULL OUTER JOIN directly, so we 
-- simulate it using a UNION of LEFT JOIN and RIGHT JOIN. This query 
-- returns all users (even those without bookings) and all bookings 
-- (even those not linked to any user).
-- -----------------------------------------------------

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status
FROM 
    User u
RIGHT JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    user_id, booking_id;


-- =====================================================
-- Additional Notes:
-- =====================================================
-- 1. INNER JOIN: Returns only matching records from both tables
--    Use case: When you need data that exists in both tables
--
-- 2. LEFT JOIN: Returns all records from the left table and matching 
--    records from the right table. NULL for non-matching right records.
--    Use case: When you need all records from the primary table
--
-- 3. FULL OUTER JOIN (simulated): Returns all records from both tables,
--    with NULLs where there's no match.
--    Use case: When you need complete data from both tables
--
-- 4. Performance Tips:
--    - Ensure foreign key columns (user_id, property_id) are indexed
--    - Use EXPLAIN to analyze query performance
--    - Add WHERE clauses to filter results when needed
-- =====================================================