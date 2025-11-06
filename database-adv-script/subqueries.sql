-- =====================================================
-- Task 1: Practice Subqueries
-- =====================================================
-- Objective: Write both correlated and non-correlated subqueries
-- Author: ALX Airbnb Database Project
-- Database: MySQL
-- =====================================================

-- -----------------------------------------------------
-- Query 1: Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0
-- -----------------------------------------------------
-- Description: This is a non-correlated subquery because the inner query
-- (subquery) can be executed independently of the outer query. 
-- The subquery calculates the average rating for each property and 
-- filters properties with avg rating > 4.0, then the outer query 
-- retrieves the full property details.
-- -----------------------------------------------------

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.host_id
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.name;


-- -----------------------------------------------------
-- Alternative approach: Using JOIN (more efficient for large datasets)
-- -----------------------------------------------------
-- This approach achieves the same result but may perform better
-- on large datasets as it avoids the IN clause
-- -----------------------------------------------------

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.host_id,
    AVG(r.rating) AS average_rating
FROM 
    Property p
INNER JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name, p.description, p.location, p.pricepernight, p.host_id
HAVING 
    AVG(r.rating) > 4.0
ORDER BY 
    average_rating DESC;


-- -----------------------------------------------------
-- Query 2: Correlated Subquery
-- Find users who have made more than 3 bookings
-- -----------------------------------------------------
-- Description: This is a correlated subquery because the inner query
-- references a column (u.user_id) from the outer query. The subquery 
-- is executed once for each row in the outer query, counting the 
-- bookings for that specific user.
-- -----------------------------------------------------

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    u.first_name, u.last_name;


-- -----------------------------------------------------
-- Enhanced version: Include booking count in results
-- -----------------------------------------------------
-- This version also shows how many bookings each user has made
-- -----------------------------------------------------

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) AS total_bookings
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    total_bookings DESC;


-- -----------------------------------------------------
-- Alternative approach: Using JOIN (more efficient)
-- -----------------------------------------------------
-- This approach uses JOIN and GROUP BY instead of a correlated subquery
-- Generally performs better on large datasets
-- -----------------------------------------------------

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
INNER JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email, u.role
HAVING 
    COUNT(b.booking_id) > 3
ORDER BY 
    total_bookings DESC;


-- =====================================================
-- Additional Notes:
-- =====================================================
-- 1. Non-Correlated Subquery:
--    - Inner query executes once
--    - Results are used by outer query
--    - Generally faster than correlated subqueries
--    - Example: IN, EXISTS with independent subqueries
--
-- 2. Correlated Subquery:
--    - Inner query executes for each row of outer query
--    - References columns from outer query
--    - Can be less efficient on large datasets
--    - Useful when you need row-by-row evaluation
--
-- 3. Performance Tips:
--    - Use EXPLAIN to analyze query execution plan
--    - Consider JOIN alternatives for better performance
--    - Index columns used in WHERE and JOIN conditions
--    - For correlated subqueries, ensure subquery filters are indexed
--
-- 4. When to use each:
--    - Non-correlated: When subquery result is independent
--    - Correlated: When you need to compare each row against a condition
--
-- 5. Best Practices:
--    - Test both subquery and JOIN approaches
--    - Measure performance on your actual dataset
--    - Use appropriate indexes on foreign keys
--    - Consider query complexity vs. maintainability
-- =====================================================