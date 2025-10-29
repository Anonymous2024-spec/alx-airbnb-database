# Database Schema (DDL) - Task 2

## Overview
This directory contains the SQL Data Definition Language (DDL) scripts for creating the Airbnb database schema in MySQL. The schema includes all tables, constraints, foreign keys, and indexes necessary for a fully functional Airbnb-like application.

---

## Files

- **`schema.sql`** - Complete MySQL DDL script to create the database and all tables

---

## Database Information

**Database Name:** `airbnb_db`

**Database Engine:** InnoDB (supports transactions and foreign keys)

**Character Set:** utf8mb4 (supports full Unicode including emojis)

**Collation:** utf8mb4_unicode_ci (case-insensitive Unicode collation)

---

## Tables Created

### 1. User
Stores information about all platform users (guests, hosts, and administrators).

**Columns:**
- `user_id` - CHAR(36) - Primary Key (UUID format)
- `first_name` - VARCHAR(100) - User's first name
- `last_name` - VARCHAR(100) - User's last name
- `email` - VARCHAR(255) - Unique email address
- `password_hash` - VARCHAR(255) - Hashed password
- `phone_number` - VARCHAR(20) - Optional contact number
- `role` - ENUM('guest', 'host', 'admin') - User role
- `created_at` - TIMESTAMP - Account creation time

**Indexes:**
- Primary key on `user_id`
- Index on `email` for fast login queries

---

### 2. Property
Stores property listings created by hosts.

**Columns:**
- `property_id` - CHAR(36) - Primary Key (UUID format)
- `host_id` - CHAR(36) - Foreign Key to User
- `name` - VARCHAR(255) - Property name/title
- `description` - TEXT - Detailed description
- `location` - VARCHAR(255) - Property location
- `pricepernight` - DECIMAL(10,2) - Nightly price
- `created_at` - TIMESTAMP - Listing creation time
- `updated_at` - TIMESTAMP - Last update time

**Foreign Keys:**
- `host_id` → User(user_id) with CASCADE delete

**Indexes:**
- Primary key on `property_id`
- Index on `host_id` for host property lookups
- Index on `property_id` for property searches

---

### 3. Booking
Stores reservation/booking information.

**Columns:**
- `booking_id` - CHAR(36) - Primary Key (UUID format)
- `property_id` - CHAR(36) - Foreign Key to Property
- `user_id` - CHAR(36) - Foreign Key to User
- `start_date` - DATE - Check-in date
- `end_date` - DATE - Check-out date
- `total_price` - DECIMAL(10,2) - Total booking cost
- `status` - ENUM('pending', 'confirmed', 'canceled') - Booking status
- `created_at` - TIMESTAMP - Booking creation time

**Foreign Keys:**
- `property_id` → Property(property_id) with CASCADE delete
- `user_id` → User(user_id) with CASCADE delete

**Constraints:**
- CHECK: `end_date > start_date`

**Indexes:**
- Primary key on `booking_id`
- Index on `property_id` for availability checks
- Index on `user_id` for user booking history
- Index on `booking_id` for payment lookups

---

### 4. Payment
Stores payment transaction records.

**Columns:**
- `payment_id` - CHAR(36) - Primary Key (UUID format)
- `booking_id` - CHAR(36) - Foreign Key to Booking
- `amount` - DECIMAL(10,2) - Payment amount
- `payment_date` - TIMESTAMP - Payment timestamp
- `payment_method` - ENUM('credit_card', 'paypal', 'stripe') - Payment method

**Foreign Keys:**
- `booking_id` → Booking(booking_id) with CASCADE delete

**Indexes:**
- Primary key on `payment_id`
- Index on `booking_id` for booking-payment lookups

---

### 5. Review
Stores user reviews and ratings for properties.

**Columns:**
- `review_id` - CHAR(36) - Primary Key (UUID format)
- `property_id` - CHAR(36) - Foreign Key to Property
- `user_id` - CHAR(36) - Foreign Key to User
- `rating` - INTEGER - Rating (1-5 stars)
- `comment` - TEXT - Review text
- `created_at` - TIMESTAMP - Review creation time

**Foreign Keys:**
- `property_id` → Property(property_id) with CASCADE delete
- `user_id` → User(user_id) with CASCADE delete

**Constraints:**
- CHECK: `rating >= 1 AND rating <= 5`

**Indexes:**
- Primary key on `review_id`
- Index on `property_id` for property reviews
- Index on `user_id` for user review history

---

### 6. Message
Stores messages exchanged between users.

**Columns:**
- `message_id` - CHAR(36) - Primary Key (UUID format)
- `sender_id` - CHAR(36) - Foreign Key to User (sender)
- `recipient_id` - CHAR(36) - Foreign Key to User (recipient)
- `message_body` - TEXT - Message content
- `sent_at` - TIMESTAMP - Message timestamp

**Foreign Keys:**
- `sender_id` → User(user_id) with CASCADE delete
- `recipient_id` → User(user_id) with CASCADE delete

**Indexes:**
- Primary key on `message_id`
- Index on `sender_id` for sent messages
- Index on `recipient_id` for received messages

---

## How to Use

### Prerequisites
- MySQL 5.7+ or MySQL 8.0+ installed
- MySQL client or MySQL Workbench
- Appropriate database privileges

### Installation Steps

1. **Connect to MySQL:**
   ```bash
   mysql -u root -p
   ```

2. **Execute the schema script:**
   ```bash
   mysql -u root -p < schema.sql
   ```

   Or from within MySQL:
   ```sql
   SOURCE /path/to/schema.sql;
   ```

3. **Verify database creation:**
   ```sql
   USE airbnb_db;
   SHOW TABLES;
   ```

4. **Check table structure:**
   ```sql
   DESCRIBE User;
   DESCRIBE Property;
   -- etc.
   ```

---

## Key Design Features

### 1. **UUID Primary Keys**
- Format: CHAR(36) to store standard UUID format (e.g., '550e8400-e29b-41d4-a716-446655440000')
- Benefits: Globally unique, better for distributed systems, non-sequential (more secure)

### 2. **Referential Integrity**
- All foreign keys use `ON DELETE CASCADE`
- Ensures data consistency when parent records are deleted
- Example: Deleting a user automatically deletes their bookings, reviews, and messages

### 3. **Performance Optimization**
- Strategic indexes on frequently queried columns
- Primary keys automatically indexed
- Foreign keys indexed for JOIN operations
- Email indexed for authentication queries

### 4. **Data Validation**
- ENUM types for constrained values (role, status, payment_method)
- CHECK constraints for data integrity (rating range, date logic)
- NOT NULL constraints on required fields
- UNIQUE constraint on email

### 5. **InnoDB Engine**
- ACID compliance for transactions
- Row-level locking for concurrency
- Foreign key support
- Crash recovery capabilities

### 6. **UTF8MB4 Encoding**
- Full Unicode support (including emojis)
- International character support
- Modern web application standard

---

## Testing the Schema

After creating the schema, you can test it with basic queries:

```sql
-- Test User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, role)
VALUES (UUID(), 'John', 'Doe', 'john@example.com', 'hashed_password', 'guest');

-- Verify insertion
SELECT * FROM User;

-- Test foreign key constraint
-- This should work (assuming the user_id exists)
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES (UUID(), (SELECT user_id FROM User LIMIT 1), 'Beach House', 'Beautiful view', 'Miami', 150.00);

-- Test ENUM constraint
-- This should fail (invalid role)
INSERT INTO User (user_id, first_name, last_name, email, password_hash, role)
VALUES (UUID(), 'Jane', 'Smith', 'jane@example.com', 'hashed_password', 'invalid_role');
```

---

## Maintenance Commands

### View all indexes:
```sql
SHOW INDEX FROM User;
SHOW INDEX FROM Property;
-- etc.
```

### View foreign key constraints:
```sql
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'airbnb_db' AND REFERENCED_TABLE_NAME IS NOT NULL;
```

### Drop database (if needed):
```sql
DROP DATABASE IF EXISTS airbnb_db;
```

---

## Notes

- The script includes `DROP DATABASE IF EXISTS` at the beginning for clean reinstallation
- All timestamps use `CURRENT_TIMESTAMP` for automatic time tracking
- The `updated_at` field in Property table auto-updates on record modification
- Foreign key relationships maintain data integrity across tables
- Indexes are carefully chosen to balance query performance and storage

---

## Next Steps

After creating the schema:
1. ✅ Verify all tables are created correctly
2. ✅ Test constraints and foreign keys
3. ➡️ Proceed to Task 3: Seed the database with sample data
4. ➡️ Run queries to test functionality

---

## Troubleshooting

**Issue: Foreign key constraint fails**
- Ensure parent record exists before inserting child record
- Verify UUID format is correct (36 characters)

**Issue: ENUM value error**
- Check spelling and case of ENUM values
- Refer to table definition for valid values

**Issue: Date constraint violation**
- Ensure `end_date` is after `start_date` in Booking table

**Issue: Duplicate entry for email**
- Email must be unique across all users
- Check existing records before insertion

---

## Contact & Support

For issues or questions about this schema:
- Review the `normalization.md` file for design decisions
- Check MySQL documentation for specific syntax questions
- Refer to the ERD diagram for visual representation of relationships