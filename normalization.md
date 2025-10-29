# Database Normalization Analysis

## Overview

This document explains the normalization process applied to the Airbnb database schema, ensuring it meets Third Normal Form (3NF) requirements. Normalization eliminates data redundancy, improves data integrity, and optimizes database performance.

---

## Normalization Forms Applied

### First Normal Form (1NF)

**Requirements:**

- Each table has a primary key
- All attributes contain atomic (indivisible) values
- No repeating groups or arrays

**Application:**

✅ **User Table**

- Primary key: `user_id` (UUID)
- All attributes are atomic (first_name, last_name, email, etc.)
- No multi-valued attributes
- `role` uses ENUM but stores a single value

✅ **Property Table**

- Primary key: `property_id` (UUID)
- All attributes are atomic
- Location stored as single VARCHAR (can be further normalized if needed for address components)

✅ **Booking Table**

- Primary key: `booking_id` (UUID)
- All attributes are atomic (dates, price, status)
- No repeating groups

✅ **Payment Table**

- Primary key: `payment_id` (UUID)
- All attributes are atomic
- Single payment method per transaction

✅ **Review Table**

- Primary key: `review_id` (UUID)
- Rating is a single integer value
- Comment is a single text field

✅ **Message Table**

- Primary key: `message_id` (UUID)
- All attributes are atomic
- Single message body per record

**Conclusion:** All tables satisfy 1NF requirements.

---

### Second Normal Form (2NF)

**Requirements:**

- Must be in 1NF
- All non-key attributes must be fully functionally dependent on the entire primary key
- No partial dependencies (relevant for composite keys)

**Application:**

✅ **User Table**

- Single-column primary key (`user_id`)
- All attributes (first_name, last_name, email, password_hash, phone_number, role, created_at) depend entirely on `user_id`
- No partial dependencies possible

✅ **Property Table**

- Single-column primary key (`property_id`)
- All attributes (host_id, name, description, location, pricepernight, created_at, updated_at) depend on `property_id`
- `host_id` is a foreign key reference, not a partial dependency

✅ **Booking Table**

- Single-column primary key (`booking_id`)
- All attributes depend on `booking_id`
- `property_id` and `user_id` are foreign keys representing relationships, not partial dependencies

✅ **Payment Table**

- Single-column primary key (`payment_id`)
- All attributes depend on `payment_id`
- `booking_id` is a foreign key, properly referenced

✅ **Review Table**

- Single-column primary key (`review_id`)
- All attributes depend on `review_id`
- `property_id` and `user_id` are foreign keys

✅ **Message Table**

- Single-column primary key (`message_id`)
- All attributes depend on `message_id`
- `sender_id` and `recipient_id` are foreign keys

**Conclusion:** All tables satisfy 2NF requirements. Since all tables use single-column primary keys (UUIDs), there are no composite keys and thus no risk of partial dependencies.

---

### Third Normal Form (3NF)

**Requirements:**

- Must be in 2NF
- No transitive dependencies (non-key attributes should not depend on other non-key attributes)
- All non-key attributes must depend directly on the primary key only

**Application:**

✅ **User Table**

- **Analysis:** All attributes (first_name, last_name, email, password_hash, phone_number, role, created_at) depend directly on `user_id`
- **No transitive dependencies:** No attribute depends on another non-key attribute
- **3NF Compliant:** ✓

✅ **Property Table**

- **Analysis:** All attributes depend directly on `property_id`
- **Foreign Key Check:** `host_id` references User table appropriately
- **No transitive dependencies:**
  - `name`, `description`, `location`, `pricepernight` all depend on `property_id` only
  - `host_id` is a relationship, not a transitive dependency
- **3NF Compliant:** ✓

✅ **Booking Table**

- **Analysis:** All attributes depend directly on `booking_id`
- **Potential Issue Checked:** `total_price` could theoretically be calculated from dates and property price
  - **Decision:** Storing `total_price` is acceptable for denormalization optimization (common in real-world applications for performance and historical data integrity)
  - **Justification:** Property prices may change over time; storing the total price at booking time preserves accurate historical records
- **No transitive dependencies:** `status`, `start_date`, `end_date` all depend on `booking_id`
- **3NF Compliant:** ✓ (with justified denormalization)

✅ **Payment Table**

- **Analysis:** All attributes depend directly on `payment_id`
- **Potential Issue Checked:** `amount` relates to booking but is stored here
  - **Justification:** Payment amount may differ from booking total (partial payments, refunds, fees) so it must be stored independently
- **No transitive dependencies:** Each attribute relates directly to the payment transaction
- **3NF Compliant:** ✓

✅ **Review Table**

- **Analysis:** All attributes depend directly on `review_id`
- **No transitive dependencies:** `rating` and `comment` both describe the review itself
- **Foreign Keys:** `property_id` and `user_id` establish relationships, not transitive dependencies
- **3NF Compliant:** ✓

✅ **Message Table**

- **Analysis:** All attributes depend directly on `message_id`
- **No transitive dependencies:** `message_body` and `sent_at` describe the message itself
- **Foreign Keys:** `sender_id` and `recipient_id` establish relationships
- **3NF Compliant:** ✓

---

## Normalization Summary

| Table    | 1NF | 2NF | 3NF | Notes                                        |
| -------- | --- | --- | --- | -------------------------------------------- |
| User     | ✓   | ✓   | ✓   | Fully normalized                             |
| Property | ✓   | ✓   | ✓   | Fully normalized                             |
| Booking  | ✓   | ✓   | ✓   | `total_price` stored for historical accuracy |
| Payment  | ✓   | ✓   | ✓   | Fully normalized                             |
| Review   | ✓   | ✓   | ✓   | Fully normalized                             |
| Message  | ✓   | ✓   | ✓   | Fully normalized                             |

---

## Design Decisions and Justifications

### 1. UUID Primary Keys

**Decision:** Use UUIDs instead of auto-incrementing integers
**Justification:**

- Globally unique identifiers (useful for distributed systems)
- Better security (non-sequential, harder to guess)
- Simplifies data merging and replication
- Prevents primary key conflicts in multi-database scenarios

### 2. Storing `total_price` in Booking

**Decision:** Store calculated value rather than computing it on-the-fly
**Justification:**

- **Historical Integrity:** Property prices may change; storing the total price preserves the original booking cost
- **Performance:** Avoids complex calculations for historical data
- **Business Logic:** Total price may include discounts, taxes, or fees not derivable from property price alone
- **Acceptable Denormalization:** Common practice in transactional systems

### 3. Storing `amount` in Payment

**Decision:** Store payment amount separately from booking total
**Justification:**

- Payments may be partial, split, or include refunds
- Processing fees may be included/excluded
- Multiple payments may exist for one booking (installments)
- Essential for accurate financial records

### 4. Separate Message Table

**Decision:** Create dedicated Message table rather than embedding in User
**Justification:**

- Users can have unlimited messages
- Prevents array/repeating group violations (1NF)
- Enables efficient querying and indexing
- Supports conversation history

### 5. ENUM Types for Status Fields

**Decision:** Use ENUM for `role`, `status`, and `payment_method`
**Justification:**

- Enforces data integrity at database level
- Reduces storage space
- Improves query performance
- Prevents invalid values

---

## Potential Future Enhancements

While the current schema is fully normalized to 3NF, here are potential considerations for future iterations:

1. **Location Normalization:**

   - Could create separate `Location` table with city, state, country, zip code
   - Would improve querying by geographic region
   - Trade-off: Adds complexity for simple location strings

2. **Amenities Table:**

   - Add `Amenity` and `Property_Amenity` tables for property features
   - Allows flexible amenity management
   - Currently not required by specification

3. **Conversation/Thread Table:**
   - Group messages into conversations
   - Improves message organization
   - Not required for current scope

---

## Conclusion

The Airbnb database schema successfully achieves **Third Normal Form (3NF)** with:

- ✅ All tables in 1NF (atomic values, no repeating groups)
- ✅ All tables in 2NF (no partial dependencies)
- ✅ All tables in 3NF (no transitive dependencies)
- ✅ Justified denormalization where it serves business requirements
- ✅ Proper use of foreign keys to maintain referential integrity
- ✅ Optimized for both data integrity and query performance

The design balances theoretical normalization principles with practical real-world database requirements, ensuring scalability, maintainability, and efficiency.
