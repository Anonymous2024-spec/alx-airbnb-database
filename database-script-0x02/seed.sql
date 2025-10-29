-- =============================================
-- ALX Airbnb Database - Sample Data Seed Script
-- =============================================
-- Description: Populates the Airbnb database with realistic sample data
-- simulating real-world usage patterns
-- =============================================

USE airbnb_db;

-- Disable foreign key checks temporarily for easier insertion
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- Seed User Table
-- =============================================
-- Insert 15 users with mix of guests, hosts, and admins

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
('550e8400-e29b-41d4-a716-446655440000', 'Alice', 'Admin', 'alice.admin@airbnb.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567890', 'admin', '2023-01-15 10:00:00'),

-- Hosts (Users who list properties)
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Smith', 'john.smith@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567891', 'host', '2023-02-01 09:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Maria', 'Garcia', 'maria.garcia@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567892', 'host', '2023-02-10 14:20:00'),
('550e8400-e29b-41d4-a716-446655440003', 'David', 'Johnson', 'david.johnson@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567893', 'host', '2023-03-05 11:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Sarah', 'Williams', 'sarah.williams@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567894', 'host', '2023-03-20 16:45:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Michael', 'Brown', 'michael.brown@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567895', 'host', '2023-04-12 08:30:00'),

-- Guests (Users who book properties)
('550e8400-e29b-41d4-a716-446655440006', 'Emma', 'Davis', 'emma.davis@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567896', 'guest', '2023-05-01 12:00:00'),
('550e8400-e29b-41d4-a716-446655440007', 'James', 'Wilson', 'james.wilson@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567897', 'guest', '2023-05-15 10:30:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Olivia', 'Martinez', 'olivia.martinez@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567898', 'guest', '2023-06-01 09:15:00'),
('550e8400-e29b-41d4-a716-446655440009', 'William', 'Anderson', 'william.anderson@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567899', 'guest', '2023-06-10 14:20:00'),
('550e8400-e29b-41d4-a716-446655440010', 'Sophia', 'Taylor', 'sophia.taylor@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567800', 'guest', '2023-06-20 11:45:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Liam', 'Thomas', 'liam.thomas@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567801', 'guest', '2023-07-05 13:30:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Ava', 'Moore', 'ava.moore@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567802', 'guest', '2023-07-15 15:00:00'),
('550e8400-e29b-41d4-a716-446655440013', 'Noah', 'Jackson', 'noah.jackson@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', '+1234567803', 'guest', '2023-08-01 10:00:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Isabella', 'White', 'isabella.white@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCwW8K9Z3e', NULL, 'guest', '2023-08-10 09:30:00');

-- =============================================
-- Seed Property Table
-- =============================================
-- Insert 20 properties with various locations and prices

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
-- John Smith's properties
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Loft', 'Modern loft in the heart of downtown with stunning city views. Perfect for business travelers and couples.', 'New York, NY', 150.00, '2023-02-05 10:00:00', '2023-02-05 10:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Spacious Family Home', 'Beautiful 4-bedroom home with backyard and modern amenities. Great for families.', 'Austin, TX', 200.00, '2023-03-10 11:30:00', '2023-03-10 11:30:00'),

-- Maria Garcia's properties
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Beachfront Paradise', 'Luxury beachfront villa with private access to the beach. Wake up to ocean views every morning.', 'Miami, FL', 350.00, '2023-02-15 09:00:00', '2023-02-15 09:00:00'),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Tropical Getaway Bungalow', 'Charming bungalow surrounded by palm trees and tropical gardens.', 'Key West, FL', 180.00, '2023-03-01 14:20:00', '2023-03-01 14:20:00'),
('650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002', 'Art Deco Studio', 'Stylish studio apartment in historic Art Deco building with modern updates.', 'Miami Beach, FL', 120.00, '2023-04-05 16:15:00', '2023-04-05 16:15:00'),

-- David Johnson's properties
('650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Mountain View Cabin', 'Rustic cabin with breathtaking mountain views. Perfect for nature lovers and hikers.', 'Aspen, CO', 280.00, '2023-03-08 10:45:00', '2023-03-08 10:45:00'),
('650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', 'Ski-In Ski-Out Chalet', 'Luxury chalet with direct ski slope access. Cozy fireplace and hot tub included.', 'Vail, CO', 450.00, '2023-03-20 13:30:00', '2023-03-20 13:30:00'),

-- Sarah Williams' properties
('650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Historic Victorian Home', 'Beautifully restored Victorian home with original architectural details and modern comforts.', 'San Francisco, CA', 220.00, '2023-03-25 15:00:00', '2023-03-25 15:00:00'),
('650e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Urban Garden Apartment', 'Peaceful apartment with private garden oasis in the middle of the city.', 'Portland, OR', 140.00, '2023-04-10 11:20:00', '2023-04-10 11:20:00'),
('650e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440004', 'Wine Country Cottage', 'Charming cottage nestled in wine country. Includes wine tasting tours.', 'Napa Valley, CA', 195.00, '2023-04-20 09:45:00', '2023-04-20 09:45:00'),

-- Michael Brown's properties
('650e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005', 'Lakeside Retreat', 'Tranquil lakeside property with private dock and kayaks. Perfect for fishing enthusiasts.', 'Lake Tahoe, CA', 240.00, '2023-04-15 12:00:00', '2023-04-15 12:00:00'),
('650e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440005', 'Desert Oasis Villa', 'Modern villa with pool in stunning desert landscape. Amazing sunset views.', 'Scottsdale, AZ', 300.00, '2023-05-01 14:30:00', '2023-05-01 14:30:00'),
('650e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440005', 'City Penthouse Suite', 'Luxury penthouse with panoramic city views and rooftop terrace.', 'Chicago, IL', 380.00, '2023-05-10 10:15:00', '2023-05-10 10:15:00'),
('650e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440005', 'Charming Brownstone', 'Classic brownstone apartment in trendy neighborhood. Walk to restaurants and shops.', 'Boston, MA', 175.00, '2023-05-20 16:00:00', '2023-05-20 16:00:00'),

-- Additional diverse properties
('650e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440001', 'Country Farmhouse', 'Peaceful farmhouse on working farm. Experience rural life with modern amenities.', 'Nashville, TN', 130.00, '2023-06-01 09:00:00', '2023-06-01 09:00:00'),
('650e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440002', 'Beach Condo Paradise', 'Modern condo steps from the beach with pool and fitness center.', 'San Diego, CA', 210.00, '2023-06-10 13:45:00', '2023-06-10 13:45:00'),
('650e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440003', 'Forest Treehouse Retreat', 'Unique treehouse experience in old-growth forest. Eco-friendly and magical.', 'Seattle, WA', 165.00, '2023-06-15 11:30:00', '2023-06-15 11:30:00'),
('650e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440004', 'Downtown Studio Loft', 'Compact but stylish studio perfect for solo travelers. Great location.', 'Denver, CO', 95.00, '2023-06-20 15:20:00', '2023-06-20 15:20:00'),
('650e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440005', 'Riverside Luxury Home', 'Stunning modern home on riverfront with private boat dock and entertainment area.', 'Charleston, SC', 425.00, '2023-07-01 10:00:00', '2023-07-01 10:00:00');

-- =============================================
-- Seed Booking Table
-- =============================================
-- Insert 25 bookings with various statuses and dates

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '2024-01-15', '2024-01-20', 750.00, 'confirmed', '2023-12-10 14:30:00'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', '2024-02-10', '2024-02-17', 2450.00, 'confirmed', '2024-01-05 10:20:00'),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440008', '2024-03-01', '2024-03-05', 1120.00, 'confirmed', '2024-02-01 09:15:00'),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440009', '2024-03-15', '2024-03-20', 1100.00, 'confirmed', '2024-02-20 11:45:00'),
('750e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440010', '2024-04-05', '2024-04-12', 1680.00, 'confirmed', '2024-03-01 16:30:00'),
('750e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', '2024-04-20', '2024-04-27', 1400.00, 'confirmed', '2024-03-15 13:20:00'),
('750e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440012', '2024-05-10', '2024-05-15', 1900.00, 'confirmed', '2024-04-01 10:00:00'),
('750e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440013', '2024-05-20', '2024-05-25', 600.00, 'confirmed', '2024-04-10 15:45:00'),
('750e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440014', '2024-06-01', '2024-06-08', 1470.00, 'confirmed', '2024-05-01 09:30:00'),
('750e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440006', '2024-06-15', '2024-06-20', 2250.00, 'confirmed', '2024-05-10 12:15:00'),

-- Pending bookings (awaiting confirmation)
('750e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440007', '2024-07-10', '2024-07-15', 700.00, 'pending', '2024-06-20 14:00:00'),
('750e8400-e29b-41d4-a716-446655440012', '650e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440008', '2024-07-20', '2024-07-25', 1500.00, 'pending', '2024-06-25 10:30:00'),
('750e8400-e29b-41d4-a716-446655440013', '650e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440009', '2024-08-01', '2024-08-06', 650.00, 'pending', '2024-07-05 11:20:00'),
('750e8400-e29b-41d4-a716-446655440014', '650e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440010', '2024-08-10', '2024-08-14', 380.00, 'pending', '2024-07-15 16:45:00'),
('750e8400-e29b-41d4-a716-446655440015', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440011', '2024-08-20', '2024-08-25', 900.00, 'pending', '2024-07-20 09:00:00'),

-- Canceled bookings
('750e8400-e29b-41d4-a716-446655440016', '650e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440012', '2024-03-10', '2024-03-15', 975.00, 'canceled', '2024-02-05 13:30:00'),
('750e8400-e29b-41d4-a716-446655440017', '650e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440013', '2024-04-01', '2024-04-05', 700.00, 'canceled', '2024-03-10 10:15:00'),
('750e8400-e29b-41d4-a716-446655440018', '650e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440014', '2024-05-05', '2024-05-10', 825.00, 'canceled', '2024-04-15 14:20:00'),

-- More confirmed bookings for variety
('750e8400-e29b-41d4-a716-446655440019', '650e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440006', '2024-09-01', '2024-09-07', 2550.00, 'confirmed', '2024-07-25 11:00:00'),
('750e8400-e29b-41d4-a716-446655440020', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', '2024-09-15', '2024-09-18', 450.00, 'confirmed', '2024-08-01 15:30:00'),
('750e8400-e29b-41d4-a716-446655440021', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', '2024-10-01', '2024-10-08', 2450.00, 'confirmed', '2024-08-15 09:45:00'),
('750e8400-e29b-41d4-a716-446655440022', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440009', '2024-10-15', '2024-10-20', 1400.00, 'confirmed', '2024-09-01 12:20:00'),
('750e8400-e29b-41d4-a716-446655440023', '650e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440010', '2024-11-01', '2024-11-05', 960.00, 'confirmed', '2024-09-10 14:00:00'),
('750e8400-e29b-41d4-a716-446655440024', '650e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440011', '2024-11-20', '2024-11-24', 1520.00, 'confirmed', '2024-10-01 10:30:00'),
('750e8400-e29b-41d4-a716-446655440025', '650e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440012', '2024-12-15', '2024-12-22', 1470.00, 'confirmed', '2024-10-20 16:15:00');

-- =============================================
-- Seed Payment Table
-- =============================================
-- Insert payments for confirmed bookings only

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 750.00, '2023-12-10 14:35:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 2450.00, '2024-01-05 10:25:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', 1120.00, '2024-02-01 09:20:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004', 1100.00, '2024-02-20 11:50:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005', 1680.00, '2024-03-01 16:35:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440006', 1400.00, '2024-03-15 13:25:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440007', 1900.00, '2024-04-01 10:05:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440008', 600.00, '2024-04-10 15:50:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440009', 1470.00, '2024-05-01 09:35:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440010', 2250.00, '2024-05-10 12:20:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440019', '750e8400-e29b-41d4-a716-446655440019', 2550.00, '2024-07-25 11:05:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440020', '750e8400-e29b-41d4-a716-446655440020', 450.00, '2024-08-01 15:35:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440021', '750e8400-e29b-41d4-a716-446655440021', 2450.00, '2024-08-15 09:50:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440022', '750e8400-e29b-41d4-a716-446655440022', 1400.00, '2024-09-01 12:25:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440023', '750e8400-e29b-41d4-a716-446655440023', 960.00, '2024-09-10 14:05:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440024', '750e8400-e29b-41d4-a716-446655440024', 1520.00, '2024-10-01 10:35:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440025', '750e8400-e29b-41d4-a716-446655440025', 1470.00, '2024-10-20 16:20:00', 'credit_card');

-- =============================================
-- Seed Review Table
-- =============================================
-- Insert reviews for completed bookings

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for Downtown Loft
('950e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 5, 'Absolutely loved this place! The location was perfect, right in the heart of downtown. The loft was modern, clean, and had everything we needed. John was a great host and very responsive. Would definitely stay again!', '2024-01-21 10:30:00'),
('950e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 4, 'Great place overall. The views were stunning and the apartment was well-maintained. Only minor issue was some street noise at night, but nothing major. Would recommend!', '2024-09-19 14:20:00'),

-- Reviews for Beachfront Paradise
('950e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', 5, 'This place exceeded all expectations! Waking up to the ocean view every morning was magical. The villa was luxurious and had everything we needed. Maria was an excellent host. Best vacation ever!', '2024-02-18 09:15:00'),
('950e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 5, 'Absolutely stunning property! The private beach access was incredible. Perfect for our anniversary trip. Highly recommend!', '2024-10-09 16:45:00'),

-- Reviews for Mountain View Cabin
('950e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440008', 5, 'The mountain views were breathtaking! Perfect getaway for nature lovers. The cabin was cozy and well-equipped. We enjoyed hiking nearby trails. David provided great local recommendations.', '2024-03-06 11:20:00'),
('950e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440009', 4, 'Beautiful location and very peaceful. The cabin was rustic but comfortable. Would have given 5 stars if the WiFi was stronger, but that\'s a minor complaint for such a beautiful place.', '2024-10-21 13:30:00'),

-- Reviews for Historic Victorian Home
('950e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440009', 5, 'What a gem! This Victorian home is beautifully restored with so much character. Sarah was incredibly welcoming and helpful. The neighborhood was charming and walkable. Perfect stay!', '2024-03-21 15:00:00'),

-- Reviews for Lakeside Retreat
('950e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440010', 5, 'Incredible lakeside property! We spent our days kayaking and fishing. The sunsets were spectacular. Michael thought of everything - the place was spotless and well-stocked. Can\'t wait to return!', '2024-04-13 10:45:00'),
('950e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440023', 5, 'Perfect family vacation spot! The kids loved the kayaks and swimming. Very peaceful and relaxing. Highly recommend!', '2024-11-06 09:30:00'),

-- Reviews for Spacious Family Home
('950e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 4, 'Great house for our family reunion. Plenty of space for everyone. The backyard was perfect for the kids. Only suggestion would be more kitchen supplies, but John quickly provided what we needed. Good stay overall!', '2024-04-28 12:15:00'),

-- Reviews for City Penthouse Suite
('950e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440012', 5, 'Absolutely luxurious! The rooftop terrace was amazing for evening cocktails. The views of the city skyline were stunning. Michael was a great host. Worth every penny!', '2024-05-16 14:30:00'),
('950e8400-e29b-41d4-a716-446655440012', '650e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440024', 5, 'Incredible penthouse! Everything was top-notch. The location was perfect for exploring the city. Would definitely book again!', '2024-11-25 11:20:00'),

-- Reviews for Art Deco Studio
('950e8400-e29b-41d4-a716-446655440013', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440013', 4, 'Cute little studio with lots of character. The Art Deco details were charming. Location was great for exploring Miami Beach. A bit small but perfect for a solo traveler like me.', '2024-05-26 10:00:00'),

-- Reviews for Beach Condo Paradise
('950e8400-e29b-41d4-a716-446655440014', '650e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440014', 5, 'Perfect beach vacation! The condo was modern and clean. Being steps from the beach was amazing. The pool and fitness center were great amenities. Maria was very helpful with check-in.', '2024-06-09 13:45:00'),
('950e8400-e29b-41d4-a716-446655440015', '650e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440025', 4, 'Great location and nice amenities. The condo was comfortable and well-maintained. Only minor issue was parking, but everything else was perfect!', '2024-12-23 15:30:00'),

-- Reviews for Ski-In Ski-Out Chalet
('950e8400-e29b-41d4-a716-446655440016', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440006', 5, 'Dream ski vacation! The chalet was luxurious and the ski-in ski-out access was unbeatable. The hot tub after a day on the slopes was heaven. David was an excellent host. Already planning our return trip!', '2024-06-21 16:20:00'),

-- Reviews for Riverside Luxury Home
('950e8400-e29b-41d4-a716-446655440017', '650e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440006', 5, 'Stunning property! The riverfront location was so peaceful. The entertainment area was perfect for our group. Michael\'s attention to detail was impressive. One of the best stays we\'ve ever had!', '2024-09-08 11:00:00'),

-- Mixed rating reviews for variety
('950e8400-e29b-41d4-a716-446655440018', '650e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440007', 3, 'Nice apartment but not quite as described. The garden was smaller than expected and needed some maintenance. Location was good though. Sarah was responsive to our concerns.', '2024-07-16 09:30:00'),

('950e8400-e29b-41d4-a716-446655440019', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440011', 4, 'Lovely bungalow in a great location. Very relaxing atmosphere. The tropical gardens were beautiful. Lost one star because check-in process was a bit confusing, but Maria sorted it out quickly.', '2024-08-26 14:15:00'),

('950e8400-e29b-41d4-a716-446655440020', '650e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440008', 5, 'Amazing desert oasis! The pool was perfect for cooling off. Sunsets were incredible. The villa had everything we needed. Michael was a wonderful host!', '2024-07-26 10:45:00');

-- =============================================
-- Seed Message Table
-- =============================================
-- Insert messages between users (guests and hosts communication)

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Emma inquiring about Downtown Loft
('a50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Hi John! I\'m interested in booking your downtown loft for January 15-20. Is it available? Also, is there parking available?', '2023-12-08 10:15:00'),
('a50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hi Emma! Yes, the loft is available for those dates. We have one parking spot included with the rental. Would you like to proceed with the booking?', '2023-12-08 11:30:00'),
('a50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Perfect! Yes, I\'d like to book it. Looking forward to my stay!', '2023-12-08 12:00:00'),

-- James asking about Beachfront Paradise
('a50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Hello Maria! Your beachfront villa looks amazing! I\'m planning a week-long vacation in February. Can you tell me more about the beach access?', '2024-01-02 14:20:00'),
('a50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Hi James! Thank you! The villa has a private gate that leads directly to a secluded section of beach. It\'s absolutely beautiful and very peaceful. Beach chairs and umbrellas are provided!', '2024-01-02 15:45:00'),
('a50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'That sounds perfect! I\'ll book it right away. Thanks!', '2024-01-02 16:10:00'),

-- Olivia inquiring about Mountain Cabin
('a50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Hi David, I\'m interested in your mountain cabin for early March. Are there good hiking trails nearby?', '2024-01-28 09:30:00'),
('a50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Hi Olivia! Yes, there are several excellent trails within a 10-minute drive. I can provide you with a detailed trail map and recommendations based on difficulty level when you arrive!', '2024-01-28 11:15:00'),
('a50e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Excellent! I\'ll proceed with the booking. Really looking forward to this trip!', '2024-01-28 12:00:00'),

-- William asking about Victorian Home
('a50e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Hi Sarah! Love the look of your Victorian home. I\'m bringing my family for 5 nights in March. Is it kid-friendly?', '2024-02-18 13:45:00'),
('a50e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 'Hi William! Yes, the home is very kid-friendly. We have a fenced backyard and I can provide a high chair and pack-n-play if needed. The neighborhood is also very safe and quiet.', '2024-02-18 15:20:00'),
('a50e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Perfect! That would be great. I\'ll book it now. Thank you!', '2024-02-18 16:00:00'),

-- Sophia inquiring about Lakeside Retreat
('a50e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Hi Michael! Your lakeside retreat looks wonderful. Do you provide fishing equipment? My husband loves to fish!', '2024-02-28 10:00:00'),
('a50e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010', 'Hi Sophia! Yes, we have fishing rods and tackle available. The lake is well-stocked with bass and trout. Your husband will love it!', '2024-02-28 11:30:00'),
('a50e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Wonderful! Booking now. Can\'t wait!', '2024-02-28 12:15:00'),

-- Liam asking about Family Home
('a50e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'Hi John, I\'m organizing a family reunion. Will your home accommodate 8 people comfortably?', '2024-03-10 14:30:00'),
('a50e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440011', 'Hi Liam! Yes, the house sleeps 8 comfortably - 4 bedrooms with various bed configurations. The backyard is great for gatherings too. Perfect for a reunion!', '2024-03-10 16:00:00'),
('a50e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'Sounds perfect! Booking it now. Thanks!', '2024-03-10 16:30:00'),

-- Ava inquiring about Penthouse
('a50e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440005', 'Hi Michael! I\'m interested in your penthouse for May 10-15. Is the rooftop terrace private?', '2024-03-28 11:00:00'),
('a50e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', 'Hi Ava! Yes, the rooftop terrace is completely private - just for penthouse guests. It has comfortable seating and a great sound system. Perfect for entertaining!', '2024-03-28 13:15:00'),
('a50e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440005', 'Excellent! That\'s exactly what I was hoping for. Proceeding with booking!', '2024-03-28 14:00:00'),

-- Noah asking about Art Deco Studio
('a50e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440002', 'Hi Maria, I\'m a solo traveler looking for a place in Miami Beach for 5 nights in May. Is your studio walking distance to restaurants?', '2024-04-08 09:45:00'),
('a50e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440013', 'Hi Noah! Yes, you\'re right in the heart of Miami Beach. Dozens of restaurants, cafes, and shops within a 5-minute walk. Perfect for solo travelers!', '2024-04-08 11:20:00'),
('a50e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440002', 'Perfect! Booking it now. Thanks for the quick response!', '2024-04-08 12:00:00'),

-- Isabella inquiring about Beach Condo
('a50e8400-e29b-41d4-a716-446655440025', '550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440002', 'Hi Maria! Your beach condo looks great. Does it have a washer/dryer? We\'ll be staying for a week.', '2024-04-28 15:30:00'),
('a50e8400-e29b-41d4-a716-446655440026', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440014', 'Hi Isabella! Yes, there\'s a washer and dryer in the unit. Also, the building has additional laundry facilities if needed. You\'ll be all set!', '2024-04-28 16:45:00'),
('a50e8400-e29b-41d4-a716-446655440027', '550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440002', 'Great! Booking now. Can\'t wait for our beach vacation!', '2024-04-28 17:15:00'),

-- Emma asking about Ski Chalet
('a50e8400-e29b-41d4-a716-446655440028', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Hi David! I\'m planning a ski trip in June. Does the chalet really have ski-in ski-out access?', '2024-05-08 10:20:00'),
('a50e8400-e29b-41d4-a716-446655440029', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440006', 'Hi Emma! Yes, you can literally ski to and from the front door! There\'s also a ski storage room with boot warmers. It doesn\'t get more convenient than this!', '2024-05-08 12:00:00'),
('a50e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'That sounds amazing! Booking right away. This will be perfect!', '2024-05-08 13:00:00'),

-- Follow-up messages after stays
('a50e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hi Emma! I hope you enjoyed your stay. Thank you for leaving the place so tidy. You\'re welcome back anytime!', '2024-01-21 14:00:00'),
('a50e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Thank you John! We had a wonderful time. Your place was perfect. Will definitely book again when we\'re back in town!', '2024-01-21 16:30:00'),

('a50e8400-e29b-41d4-a716-446655440033', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Hi James! Thank you for being such a great guest. I hope you enjoyed the beach! Safe travels home.', '2024-02-18 10:00:00'),
('a50e8400-e29b-41d4-a716-446655440034', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Thanks Maria! It was an incredible week. Your villa is paradise. Already planning our next visit!', '2024-02-18 15:20:00');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- Verification Queries
-- =============================================

-- Count records in each table
SELECT 'Users' AS table_name, COUNT(*) AS record_count FROM User
UNION ALL
SELECT 'Properties', COUNT(*) FROM Property
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'Reviews', COUNT(*) FROM Review
UNION ALL
SELECT 'Messages', COUNT(*) FROM Message;

-- Show booking statistics by status
SELECT status, COUNT(*) AS booking_count, SUM(total_price) AS total_revenue
FROM Booking
GROUP BY status
ORDER BY booking_count DESC;

-- Show properties with their hosts
SELECT p.name AS property_name, CONCAT(u.first_name, ' ', u.last_name) AS host_name, p.location, p.pricepernight
FROM Property p
JOIN User u ON p.host_id = u.user_id
ORDER BY p.pricepernight DESC
LIMIT 10;

-- Show average rating by property
SELECT p.name AS property_name, 
       COUNT(r.review_id) AS review_count,
       AVG(r.rating) AS average_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING review_count > 0
ORDER BY average_rating DESC, review_count DESC;

-- =============================================
-- End of Seed Script
-- =============================================