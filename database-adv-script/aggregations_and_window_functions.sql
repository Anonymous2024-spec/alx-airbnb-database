-- Task: Apply Aggregations and Window Functions
-- Repository: alx-airbnb-database
-- Directory: database-adv-script
-- File: aggregations_and_window_functions.sql
-- -------------------------------------------------------------

-- 1️⃣ Find the total number of bookings made by each user
-- Using COUNT() and GROUP BY

SELECT 
    user_id,
    COUNT(*) AS total_bookings
FROM 
    bookings
GROUP BY 
    user_id
ORDER BY 
    total_bookings DESC;


-- 2️⃣ Rank properties based on total number of bookings
-- Using a window function (RANK())

SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS property_rank
FROM 
    bookings
GROUP BY 
    property_id
ORDER BY 
    property_rank;
