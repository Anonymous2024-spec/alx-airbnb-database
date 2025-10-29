# Database Seed Data - Task 3

## Overview
This directory contains SQL scripts to populate the Airbnb database with realistic sample data that simulates real-world usage patterns. The seed data includes users with different roles, diverse properties across various locations, bookings with different statuses, payments, reviews, and user messages.

---

## Files

- **`seed.sql`** - Complete MySQL DML script to populate all tables with sample data

---

## Sample Data Summary

### Data Volume

| Table | Record Count | Description |
|-------|--------------|-------------|
| User | 15 | 1 admin, 5 hosts, 9 guests |
| Property | 19 | Various properties across multiple US locations |
| Booking | 25 | Mix of confirmed (17), pending (5), and canceled (3) |
| Payment | 17 | Payments for all confirmed bookings |
| Review | 20 | Reviews with ratings 3-5 stars |
| Message | 34 | Pre-booking inquiries and post-stay messages |

---

## Data Characteristics

### Users (15 total)

**Admin (1):**
- Alice Admin - System administrator

**Hosts (5):**
- John Smith - 3 properties
- Maria Garcia - 4 properties  
- David Johnson - 3 properties
- Sarah Williams - 4 properties
- Michael Brown - 5 properties

**Guests (9):**
- Emma Davis, James Wilson, Olivia Martinez, William Anderson, Sophia Taylor, Liam Thomas, Ava Moore, Noah Jackson, Isabella White

**Realistic Features:**
- All users have unique email addresses
- Mix of users with and without phone numbers
- Password hashes simulate bcrypt encryption
- Registration dates span from January to August 2023

---

### Properties (19 total)

**Property Types:**
- Urban apartments and lofts
- Beachfront properties
- Mountain cabins and chalets
- Historic homes
- Luxury penthouses
- Family homes
- Studio apartments

**Locations:**
- New York, Austin, Miami, Key West, Aspen, Vail, San Francisco, Portland, Napa Valley, Lake Tahoe, Scottsdale, Chicago, Boston, Nashville, San Diego, Seattle, Denver, Charleston

**Price Range:**
- Minimum: $95/night (Downtown Studio Loft)
- Maximum: $450/night (Ski-In Ski-Out Chalet)
- Average: ~$220/night

**Realistic Features:**
- Detailed, unique descriptions for each property
- Varied amenities and characteristics
- Multiple properties per active host
- Creation dates from February to July 2023

---

### Bookings (25 total)

**Status Distribution:**
- **Confirmed:** 17 bookings (68%)
- **Pending:** 5 bookings (20%)
- **Canceled:** 3 bookings (12%)

**Date Range:**
- Bookings span from January 2024 to December 2024
- Stay durations: 3-7 nights typically
- Booking creation dates are realistically ahead of check-in dates

**Revenue Summary:**
- Total revenue from confirmed bookings: ~$28,000+
- Average booking value: ~$1,200

**Realistic Features:**
- No overlapping bookings for same property
- End dates always after start dates
- Total prices calculated based on nightly rates and duration
- Mix of short weekend trips and week-long vacations

---

### Payments (17 total)

**Payment Methods:**
- Credit Card: ~40%
- Stripe: ~35%
- PayPal: ~25%

**Characteristics:**
- Payment amounts match booking total prices
- Payment dates immediately follow booking creation
- Only confirmed bookings have associated payments
- Timestamps realistic (minutes after booking)

---

### Reviews (20 total)

**Rating Distribution:**
- 5 stars: 15 reviews (75%)
- 4 stars: 4 reviews (20%)
- 3 stars: 1 review (5%)
- Average rating: 4.7/5

**Review Characteristics:**
- Detailed, realistic comments (50-150 words)
- Mix of highly positive, positive, and constructive feedback
- Reviews posted 1-2 days after checkout
- Multiple reviews for popular properties
- Authentic guest experiences mentioned (amenities, location, host responsiveness)

**Content Themes:**
- Location and views
- Cleanliness and maintenance
- Host communication
- Amenities and facilities
- Overall experience

---

### Messages (34 total)

**Message Types:**
- Pre-booking inquiries (24 messages, 70%)
- Post-stay thank you messages (10 messages, 30%)

**Communication Patterns:**
- 3-message threads (inquiry → response → confirmation)
- Realistic questions about:
  - Property amenities
  - Parking availability
  - Child/family friendliness
  - Fishing equipment
  - Beach access
  - Hiking trails
  - Kitchen supplies
  
**Characteristics:**
- Natural, conversational tone
- Quick response times from hosts (1-2 hours typically)
- Professional and friendly communication
- Timestamps progress logically through conversations

---

## How to Use

### Prerequisites
- MySQL database server running
- `airbnb_db` database created (from Task 2 schema.sql)
- Appropriate database privileges

### Installation Steps

1. **Ensure schema is created first:**
   ```bash
   mysql -u root -p < database-script-0x01/schema.sql
   ```

2. **Run the seed script:**
   ```bash
   mysql -u root -p airbnb_db < database-script-0x02/seed.sql
   ```

   Or from within MySQL:
   ```sql
   USE airbnb_db;
   SOURCE /path/to/seed.sql;
   ```

3. **Verify data insertion:**
   The script includes verification queries at the end that will display:
   - Record counts for all tables
   - Booking statistics by status
   - Top 10 most expensive properties
   - Average ratings by property

---

## Verification Queries

After running the seed script, you can verify the data with these queries:

### Check User Distribution
```sql
SELECT role, COUNT(*) as user_count
FROM User
GROUP BY role;
```

### View Properties by Host
```sql
SELECT 
    CONCAT(u.first_name, ' ', u.last_name) AS host_name,
    COUNT(p.property_id) AS property_count,
    AVG(p.pricepernight) AS avg_price
FROM User u
JOIN Property p ON u.user_id = p.host_id
WHERE u.role = 'host'
GROUP BY u.user_id, host_name
ORDER BY property_count DESC;
```

### Booking Revenue Analysis
```sql
SELECT 
    status,
    COUNT(*) AS booking_count,
    SUM(total_price) AS total_revenue,
    AVG(total_price) AS avg_booking_value
FROM Booking
GROUP BY status;
```

### Top Rated Properties
```sql
SELECT 
    p.name,
    p.location,
    COUNT(r.review_id) AS review_count,
    AVG(r.rating) AS average_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location
HAVING review_count > 0
ORDER BY average_rating DESC, review_count DESC
LIMIT 5;
```

### Payment Method Distribution
```sql
SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_method
ORDER BY total_amount DESC;
```

### Message Activity by User
```sql
SELECT 
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(DISTINCT m1.message_id) AS messages_sent,
    COUNT(DISTINCT m2.message_id) AS messages_received
FROM User u
LEFT JOIN Message m1 ON u.user_id = m1.sender_id
LEFT JOIN Message m2 ON u.user_id = m2.recipient_id
GROUP BY u.user_id, user_name
HAVING messages_sent > 0 OR messages_received > 0
ORDER BY (messages_sent + messages_received) DESC;
```

---

## Sample Data Features

### Realistic Business Scenarios

1. **Multi-Property Hosts:**
   - Hosts manage multiple properties across different locations
   - Simulates successful hosts growing their business

2. **Seasonal Bookings:**
   - Bookings spread throughout the year
   - Mix of advance bookings and last-minute reservations

3. **Various Property Segments:**
   - Budget-friendly studios ($95-$130/night)
   - Mid-range homes and apartments ($140-$250/night)
   - Luxury properties ($280-$450/night)

4. **Authentic User Behavior:**
   - Guests asking relevant questions before booking
   - Hosts providing helpful, detailed responses
   - Post-stay communication and appreciation

5. **Review Authenticity:**
   - Mix of ratings (not all perfect 5 stars)
   - Detailed feedback mentioning specific features
   - Constructive criticism where appropriate

6. **Payment Diversity:**
   - Multiple payment methods representing real payment preferences
   - All confirmed bookings have corresponding payments

---

## Data Relationships

The seed data maintains proper referential integrity:

- ✅ All properties belong to valid hosts (users with 'host' role)
- ✅ All bookings reference valid properties and users
- ✅ All payments link to valid bookings
- ✅ All reviews reference valid properties and users
- ✅ All messages have valid sender and recipient users
- ✅ No orphaned records or broken foreign key relationships

---

## Customization

You can easily modify the seed data:

1. **Add More Users:**
   - Copy user INSERT pattern
   - Generate new UUIDs
   - Update email addresses (must be unique)

2. **Add More Properties:**
   - Ensure host_id references existing host
   - Generate new UUID for property_id
   - Update property details

3. **Add More Bookings:**
   - Check for date conflicts with existing bookings
   - Ensure property_id and user_id are valid
   - Calculate total_price based on dates and property price

4. **Add More Reviews:**
   - Ensure user has a completed booking for the property
   - Rating must be 1-5
   - Create unique, relevant comments

---

## Testing Scenarios

This seed data supports testing various application features:

### User Management
- Admin user can manage system
- Hosts can manage multiple properties
- Guests can book and review properties

### Property Listings
- Search by location
- Filter by price range
- View property details and amenities

### Booking System
- Create new bookings
- Check availability
- Update booking status
- Calculate pricing

### Payment Processing
- Process payments for bookings
- Support multiple payment methods
- Track payment history

### Review System
- Leave property reviews
- View average ratings
- Read detailed feedback

### Messaging
- Host-guest communication
- Inquiry handling
- Post-stay follow-up

---

## Database Statistics

After seeding, your database will contain:

- **15 users** across 3 roles
- **19 properties** in 18 different locations
- **25 bookings** with realistic date ranges
- **17 payments** totaling $26,100+
- **20 reviews** with average 4.7★ rating
- **34 messages** showing realistic communication patterns

**Total Records:** 130 across 6 tables

---

## Maintenance

### Reset Database
To clear all data and reseed:
```sql
-- Clear all tables (order matters due to foreign keys)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Message;
TRUNCATE TABLE Review;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Booking;
TRUNCATE TABLE Property;
TRUNCATE TABLE User;
SET FOREIGN_KEY_CHECKS = 1;

-- Re-run seed script
SOURCE /path/to/seed.sql;
```

### Add More Sample Data
Simply append additional INSERT statements to seed.sql following the existing patterns.

---

## Notes

- All UUIDs follow the format: `XXXXXXXX-XXXX-4XXX-YXXX-XXXXXXXXXXXX`
- Password hashes simulate bcrypt format: `$2a$12$...`
- Timestamps follow realistic timelines (bookings created before check-in dates)
- Foreign key checks are disabled/enabled to ensure smooth insertion
- Verification queries run automatically after seeding

---

## Next Steps

After seeding the database:
1. ✅ Verify all tables have data
2. ✅ Check relationships and constraints
3. ✅ Test queries and joins
4. ➡️ Begin building application features
5. ➡️ Implement search and filter functionality
6. ➡️ Create booking and payment flows

---

## Support

For questions about the seed data:
- Review relationships in ERD diagram (Task 0)
- Check schema definitions (Task 2)
- Refer to normalization documentation (Task 1)
- Examine the SQL comments in seed.sql for data context

---

**Happy coding!** 🚀