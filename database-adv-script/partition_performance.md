# 🧩 Partitioning Large Tables – Performance Report

## 🎯 Objective
This report evaluates the impact of **table partitioning** on the `bookings` table, which stores millions of rows.  
Partitioning aims to improve query performance by reducing the number of scanned rows when filtering by `start_date`.

---

## 🧱 1. Implementation
The table was partitioned by **RANGE** on the `start_date` column:

| Partition | Date Range |
|------------|-------------|
| `bookings_q1` | 2025-01-01 → 2025-03-31 |
| `bookings_q2` | 2025-04-01 → 2025-06-30 |
| `bookings_q3` | 2025-07-01 → 2025-09-30 |
| `bookings_q4` | 2025-10-01 → 2025-12-31 |

Each partition includes an index on `start_date` for faster lookups.

---

## 🧮 2. Test Query
The following query was used before and after partitioning:

```sql
SELECT * FROM bookings
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';
