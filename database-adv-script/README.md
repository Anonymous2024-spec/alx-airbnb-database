# Task 0: Write Complex Queries with Joins

## Objective

Master SQL joins by writing complex queries using different types of joins.

## Overview

This task focuses on implementing three fundamental SQL JOIN operations to retrieve and combine data from multiple tables in the Airbnb database. Understanding joins is crucial for working with relational databases and extracting meaningful insights from interconnected data.

## Files

- **joins_queries.sql**: Contains all three JOIN queries with detailed comments

## Database Schema Reference

### Tables Used

1. **User**: Contains user information (guests, hosts, admins)
2. **Booking**: Contains reservation records
3. **Property**: Contains property listings
4. **Review**: Contains user reviews for properties

### Key Relationships

- `Booking.user_id` → `User.user_id` (Foreign Key)
- `Booking.property_id` → `Property.property_id` (Foreign Key)
- `Review.property_id` → `Property.property_id` (Foreign Key)

## Queries Implemented

### 1. INNER JOIN Query

**Purpose**: Retrieve all bookings and the respective users who made those bookings.

**How it works**:

- Combines `Booking` and `User` tables
- Returns only records where there's a match in both tables (booking has a valid user)
- Excludes orphaned bookings (if any exist)

**Returns**:

- Booking details (ID, dates, price, status)
- User details (name, email, phone, role)

**Use Case**: Display booking history with user information for reports or dashboards.

---

### 2. LEFT JOIN Query

**Purpose**: Retrieve all properties and their reviews, including properties that have no reviews.

**How it works**:

- Takes all records from `Property` table (left table)
- Matches with `Review` table (right table)
- Includes properties without reviews (review fields show NULL)

**Returns**:

- All properties with their details
- Associated reviews (if they exist)
- Properties with no reviews will have NULL in review fields

**Use Case**: Display all properties in a listing, showing review data when available. Useful for identifying properties that need more reviews.

---

### 3. FULL OUTER JOIN Query

**Purpose**: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

**How it works**:

- MySQL doesn't support FULL OUTER JOIN natively
- Simulated using UNION of LEFT JOIN and RIGHT JOIN
- Returns complete dataset from both tables with NULLs for non-matching records

**Returns**:

- All users (including those without bookings)
- All bookings (including orphaned bookings if any)
- NULL values where no match exists

**Use Case**: Data integrity checks, finding users without bookings, or identifying orphaned records.

## Running the Queries

### Prerequisites

1. MySQL database server installed
2. Airbnb database created with User, Booking, Property, and Review tables
3. Sample data inserted into tables

### Execute Queries

```bash
# Connect to MySQL
mysql -u your_username -p

# Select database
USE airbnb;

# Run all queries from file
SOURCE database-adv-script/joins_queries.sql;
```

### Or run individual queries:

```sql
-- Query 1: INNER JOIN
SELECT b.booking_id, b.start_date, u.first_name, u.email
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id;

-- Query 2: LEFT JOIN
SELECT p.property_id, p.name, r.rating, r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;

-- Query 3: FULL OUTER JOIN (simulated)
SELECT u.user_id, u.first_name, b.booking_id, b.status
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
UNION
SELECT u.user_id, u.first_name, b.booking_id, b.status
FROM User u
RIGHT JOIN Booking b ON u.user_id = b.user_id;
```

## Understanding the Results

### INNER JOIN Output

```
+-------------+------------+------------+-------------+------------------+
| booking_id  | start_date | first_name | last_name   | email            |
+-------------+------------+------------+-------------+------------------+
| uuid-001    | 2024-12-01 | John       | Doe         | john@email.com   |
| uuid-002    | 2024-12-15 | Jane       | Smith       | jane@email.com   |
+-------------+------------+------------+-------------+------------------+
```

Only bookings with valid users are shown.

### LEFT JOIN Output

```
+-------------+------------------+------------+--------+-----------+
| property_id | property_name    | review_id  | rating | comment   |
+-------------+------------------+------------+--------+-----------+
| uuid-101    | Beach Villa      | uuid-501   | 5      | Amazing!  |
| uuid-102    | City Apartment   | NULL       | NULL   | NULL      |
+-------------+------------------+------------+--------+-----------+
```

All properties shown; "City Apartment" has no reviews (NULLs).

### FULL OUTER JOIN Output

```
+---------+------------+-------------+--------+
| user_id | first_name | booking_id  | status |
+---------+------------+-------------+--------+
| uuid-01 | John       | uuid-001    | conf.  |
| uuid-02 | Jane       | NULL        | NULL   |
| NULL    | NULL       | uuid-999    | pend.  |
+---------+------------+-------------+--------+
```

Shows all users (Jane has no bookings) and all bookings (uuid-999 is orphaned).

## Performance Considerations

### Optimization Tips

1. **Index Foreign Keys**: Ensure `user_id`, `property_id` are indexed

   ```sql
   CREATE INDEX idx_booking_user_id ON Booking(user_id);
   CREATE INDEX idx_review_property_id ON Review(property_id);
   ```

2. **Use EXPLAIN**: Analyze query execution plan

   ```sql
   EXPLAIN SELECT b.*, u.*
   FROM Booking b
   INNER JOIN User u ON b.user_id = u.user_id;
   ```

3. **Add WHERE Clauses**: Filter data to reduce result set

   ```sql
   WHERE b.status = 'confirmed'
   WHERE b.start_date >= '2024-01-01'
   ```

4. **Limit Results**: Use pagination for large datasets
   ```sql
   LIMIT 100 OFFSET 0
   ```

## Common Issues and Solutions

### Issue 1: Duplicate Rows in FULL OUTER JOIN

**Problem**: UNION may not eliminate duplicates if data exists in both joins.
**Solution**: Use `UNION` (which removes duplicates) instead of `UNION ALL`.

### Issue 2: NULL Values Confusion

**Problem**: Hard to distinguish between "no match" NULL and actual NULL data.
**Solution**: Use COALESCE or IFNULL to provide default values:

```sql
SELECT
    p.name,
    COALESCE(r.rating, 0) AS rating,
    COALESCE(r.comment, 'No review yet') AS comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;
```

### Issue 3: Slow Performance on Large Tables

**Problem**: JOIN operations take too long.
**Solution**:

- Add indexes on join columns
- Use LIMIT to paginate results
- Consider adding WHERE clauses to filter early

## Testing the Queries

### Test 1: Verify INNER JOIN Returns Only Matches

```sql
-- Should return same count
SELECT COUNT(*) FROM Booking WHERE user_id IN (SELECT user_id FROM User);
SELECT COUNT(*) FROM Booking b INNER JOIN User u ON b.user_id = u.user_id;
```

### Test 2: Verify LEFT JOIN Includes All Left Table Rows

```sql
-- Should return same count as total properties
SELECT COUNT(*) FROM Property;
SELECT COUNT(DISTINCT p.property_id) FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;
```

### Test 3: Verify FULL OUTER JOIN Includes All Rows

```sql
-- Should be >= to both individual table counts
SELECT COUNT(*) FROM User;
SELECT COUNT(*) FROM Booking;
-- FULL OUTER JOIN count should be >= max(User count, Booking count)
```

## Learning Outcomes

After completing this task, you will understand:

- ✅ The differences between INNER, LEFT, and FULL OUTER JOINs
- ✅ When to use each type of JOIN
- ✅ How to combine data from multiple related tables
- ✅ How to handle NULL values in JOIN results
- ✅ MySQL's approach to simulating FULL OUTER JOIN
- ✅ Performance implications of different JOIN types

## Next Steps

Once you've completed this task:

1. Test queries with your sample data
2. Verify results match expectations
3. Use EXPLAIN to check performance
4. Move on to Task 1: Practice Subqueries

## Resources

- [MySQL JOIN Documentation](https://dev.mysql.com/doc/refman/8.0/en/join.html)
- [SQL JOIN Visual Explanation](https://www.w3schools.com/sql/sql_join.asp)
- [Understanding LEFT JOIN vs INNER JOIN](https://stackoverflow.com/questions/38549/what-is-the-difference-between-inner-join-and-outer-join)

## Repository Information

- **Repository**: `alx-airbnb-database`
- **Directory**: `database-adv-script`
- **Files**: `joins_queries.sql`, `README.md`

---

**Status**: ✅ Ready for submission and manual review

# 🧮 Aggregations and Window Functions

## 🎯 Objective

This script demonstrates the use of **SQL aggregation** and **window functions** to analyze Airbnb booking data.  
It focuses on counting user activity and ranking properties based on popularity.

---

## 🧩 1. Aggregation Query – Total Bookings per User

**Purpose:** Determine how many bookings each user has made.  
**SQL Concept:** `COUNT()` with `GROUP BY`.

```sql
SELECT
    user_id,
    COUNT(*) AS total_bookings
FROM
    bookings
GROUP BY
    user_id
ORDER BY
    total_bookings DESC;
```
