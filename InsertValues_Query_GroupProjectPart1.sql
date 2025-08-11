
SET FOREIGN_KEY_CHECKS = 0;

/* Insert Managers with temporary Building_IDs */
INSERT INTO MANAGER (Manager_ID, MFull_Name, Salary, M_Contact, MEmail, Building_ID) VALUES
(103, 'Saanvi Desai', 68000, '555-0103', 'sdesai@gmail.com', 3),
(104, 'Arjun Kumar', 72000, '555-0203', 'akumar@gmail.com', 4),
(105, 'Ishaan Rao', 70000, '555-0301', 'irao@gmail.com', 5),
(106, 'Meera Nair', 75000, '555-0401', 'mnair@gmail.com', 6),
(107, 'Reyansh Singh', 69000, '555-0501', 'rsingh@gmail.com', 7),
(108, 'Aarohi Patel', 71000, '555-0601', 'apatel@gmail.com', 8),
(109, 'Krishna Verma', 73000, '555-0701', 'kverma@gmail.com', 9),
(110, 'Navya Reddy', 72000, '555-0801', 'nreddy@gmail.com', 10),
(111, 'Sai Prakash', 74000, '555-0901', 'sprakash@gmail.com', 11),
(112, 'Diya Sharma', 76000, '555-1001', 'dsharma@gmail.com', 12);

/* Insert Buildings with actual Manager_IDs */
INSERT INTO BUILDING (Building_ID, Street, City, State, ZipCode, Manager_ID) VALUES
(3, '789 Pine Rd', 'Greenwich', 'CT', 06830, 103),
(4, '101 Birch Blvd', 'Fairfield', 'CT', 06824, 104),
(5, '202 Cedar Ln', 'Stamford', 'CT', 06901, 105),
(6, '303 Elm St', 'Norwalk', 'CT', 06851, 106),
(7, '404 Maple Dr', 'Danbury', 'CT', 06810, 107),
(8, '505 Oak Ct', 'Bridgeport', 'CT', 06604, 108),
(9, '606 Pine Ave', 'New Haven', 'CT', 06510, 109),
(10, '707 Birch Rd', 'Hartford', 'CT', 06103, 110),
(11, '808 Cedar Blvd', 'Waterbury', 'CT', 06702, 111),
(12, '909 Elm Ave', 'New London', 'CT', 06320, 112);

/* Update Managers to reference the correct Building_IDs */
UPDATE MANAGER SET Building_ID = 3 WHERE Manager_ID = 103;
UPDATE MANAGER SET Building_ID = 4 WHERE Manager_ID = 104;
UPDATE MANAGER SET Building_ID = 5 WHERE Manager_ID = 105;
UPDATE MANAGER SET Building_ID = 6 WHERE Manager_ID = 106;
UPDATE MANAGER SET Building_ID = 7 WHERE Manager_ID = 107;
UPDATE MANAGER SET Building_ID = 8 WHERE Manager_ID = 108;
UPDATE MANAGER SET Building_ID = 9 WHERE Manager_ID = 109;
UPDATE MANAGER SET Building_ID = 10 WHERE Manager_ID = 110;
UPDATE MANAGER SET Building_ID = 11 WHERE Manager_ID = 111;
UPDATE MANAGER SET Building_ID = 12 WHERE Manager_ID = 112;

/* Insert Manager Phone Numbers */
INSERT INTO MANAGER_PHONE (Mphone, Manager_ID) VALUES
('555-0103', 103),
('555-0104', 104),
('555-0301', 105),
('555-0401', 106),
('555-0501', 107),
('555-0601', 108),
('555-0701', 109),
('555-0801', 110),
('555-0901', 111),
('555-1001', 112);

/* Insert Corporate Clients with referrals */
INSERT INTO CORPCLIENT (Client_ID, Client_Name, CEmail, Refer_Client_ID) VALUES
(504, 'Innovative Solutions Ltd', 'innovate@gmail.com', NULL),
(505, 'Eco Friendly Enterprises', 'eco@gmail.com', 504),
(506, 'Smart Tech Corp', 'smart@gmail.com', 505),
(507, 'Global Logistics Inc', 'log@gmail.com', 506),
(508, 'Creative Designs Studio', 'desi@gmail.com', 507),
(509, 'Health Plus Clinic', 'health@gmail.com', 508),
(510, 'EduTech Solutions', 'edutech@gmail.com', 509),
(511, 'Green Energy Co', 'green@gmail.com', 510),
(512, 'Fast Delivery Services', 'del@gmail.com', 511),
(513, 'Bright Future School', 'sc@gmail.com', 512);

/* Insert Corporate Client Phone Numbers */
INSERT INTO CORPCLIENT_PHONE (CPhone, Client_ID) VALUES
('555-1101', 504),
('555-1102', 504),
('555-2001', 505),
('555-2002', 505),
('555-3001', 506),
('555-3002', 506),
('555-4001', 507),
('555-4002', 507),
('555-5001', 508),
('555-5002', 508);

/* Insert Apartments */
INSERT INTO APARTMENT (Apartment_ID, Building_ID, No_of_Bedrooms, Rental_status, Client_ID) VALUES
(203, 3, 2, 'Vacant', NULL),
(204, 3, 3, 'Occupied', 504),
(205, 4, 1, 'Vacant', NULL),
(206, 4, 2, 'Occupied', 505),
(207, 5, 2, 'Vacant', NULL),
(208, 5, 3, 'Occupied', 506),
(209, 6, 1, 'Vacant', NULL),
(210, 6, 2, 'Occupied', 507),
(211, 7, 2, 'Vacant', NULL),
(212, 7, 3, 'Occupied', 508);

/* Insert Leases */
INSERT INTO LEASE (Lease_ID, Apartment_ID, Building_ID, Start_Date, End_Date, monthly_rent, security_deposit, Client_ID) VALUES
(1003, 203, 3, '2023-05-01', '2024-04-30', 2200.00, 3300.00, 504),
(1004, 204, 3, '2023-06-15', '2024-06-14', 2400.00, 3600.00, 505),
-- Continue Lease Inserts
(1005, 205, 4, '2023-07-01', '2024-06-30', 1900.00, 2850.00, 506),
(1006, 206, 4, '2023-08-01', '2024-07-31', 2100.00, 3150.00, 507),
(1007, 207, 5, '2023-09-01', '2024-08-31', 1700.00, 2550.00, 508),
(1008, 208, 5, '2023-10-01', '2024-09-30', 1800.00, 2700.00, 509),
(1009, 209, 6, '2023-11-01', '2024-10-31', 1600.00, 2400.00, 510),
(1010, 210, 6, '2023-12-01', '2024-11-30', 2000.00, 3000.00, 511),
(1011, 211, 7, '2024-01-01', '2024-12-31', 2300.00, 3450.00, 512),
(1012, 212, 7, '2024-02-01', '2025-01-31', 2500.00, 3750.00, 513);

/* Insert Staff Members */
INSERT INTO STAFF (Staff_ID, Staff_Name, SEmail) VALUES
(203, 'Ravi Mehta', 'rmehta@gmail.com'),
(204, 'Priya Sharma', 'psharma@gmail.com'),
(205, 'Kunal Joshi', 'kjoshi@gmail.com'),
(206, 'Nikita Rao', 'nrao@gmail.com'),
(207, 'Amit Kapoor', 'akapoor@gmail.com'),
(208, 'Sneha Iyer', 'siyer@gmail.com'),
(209, 'Rahul Das', 'rdas@gmail.com'),
(210, 'Pooja Sen', 'psen@gmail.com'),
(211, 'Manoj Varma', 'mvarma@gmail.com'),
(212, 'Tanya Roy', 'troy@gmail.com');

/* Insert Staff Phone Numbers */
INSERT INTO STAFF_PHONE (SPhone, Staff_ID) VALUES
('555-0602', 203),
('555-0603', 204),
('555-0604', 205),
('555-0605', 206),
('555-0606', 207),
('555-0607', 208),
('555-0608', 209),
('555-0609', 210),
('555-0610', 211),
('555-0611', 212);

/* Insert Inspectors */
INSERT INTO INSPECTOR (Inspector_ID, InspectorName, IEmail) VALUES
(303, 'Ritika Das', 'rdas@exam.com'),
(304, 'Kabir Malhotra', 'kmalh@exam.com'),
(305, 'Leena Bhatt', 'lbhatt@exam.com'),
(306, 'Aditya Singh', 'asingh@exam.com'),
(307, 'Tanvi Saxena', 'tsax@exam.com'),
(308, 'Mohit Jain', 'mjain@gmail.com'),
(309, 'Nidhi Kapoor', 'nkapoor@gmail.com'),
(310, 'Ajay Deshmukh', 'adesh@gmail.com'),
(311, 'Simran Kohli', 'skohli@gmail.com'),
(312, 'Dev Arora', 'darora@gmail.com');

/* Insert Inspector Phone Numbers */
INSERT INTO INSPECTOR_PHONE (IPhone, Inspector_ID) VALUES
('555-0702', 303),
('555-0703', 304),
('555-0704', 305),
('555-0705', 306),
('555-0706', 307),
('555-0707', 308),
('555-0708', 309),
('555-0709', 310),
('555-0710', 311),
('555-0711', 312);

/* Insert Inspections */
INSERT INTO INSPECTS (Inspector_ID, Building_ID, Insp_date, next_insp) VALUES
(303, 3, '2023-05-15', '2024-05-15'),
(304, 4, '2023-06-01', '2024-06-01'),
(305, 5, '2023-06-20', '2024-06-20'),
(306, 6, '2023-07-10', '2024-07-10'),
(307, 7, '2023-08-01', '2024-08-01'),
(308, 8, '2023-09-01', '2024-09-01'),
(309, 9, '2023-10-01', '2024-10-01'),
(310, 10, '2023-11-01', '2024-11-01'),
(311, 11, '2023-12-01', '2024-12-01'),
(312, 12, '2024-01-01', '2025-01-01');

/* Insert Cleaning Assignments */
INSERT INTO CLEANS (Staff_ID, Apartment_ID, Building_ID) VALUES
(203, 203, 3),
(204, 204, 3),
(205, 205, 4),
(206, 206, 4),
(207, 207, 5),
(208, 208, 5),
(209, 209, 6),
(210, 210, 6),
(211, 211, 7),
(212, 212, 7);

/* Insert Maintenance Requests */
INSERT INTO MAINTENANCE_REQUEST (Request_ID, Building_ID, Apartment_ID, Request_Date, Completion_date, Status, Assigned_Staff) VALUES
(403, 3, 203, '2023-05-20', '2023-05-22', 'Completed', 203),
(404, 3, 204, '2023-06-05', NULL, 'Pending', 204),
(405, 4, 205, '2023-06-15', '2023-06-17', 'Completed', 205),
(406, 4, 206, '2023-07-10', NULL, 'Pending', 206),
(407, 5, 207, '2023-08-01', NULL, 'Pending', 207),
(408, 5, 208, '2023-08-15', '2023-08-16', 'Completed', 208),
(409, 6, 209, '2023-09-01', NULL, 'Pending', 209),
(410, 6, 210, '2023-10-01', '2023-10-02', 'Completed', 210),
(411, 7, 211, '2023-11-01', NULL, 'Pending', 211),
(412, 7, 212, '2023-12-01', NULL, 'Pending', 212);

/* Insert Resident Feedback */
INSERT INTO RESIDENT_FEEDBACK (Building_ID, Apartment_ID, FeedbackDate, Category, Description, Status) VALUES
(3, 203, '2023-06-10', 'Facility', 'Gym equipment needs maintenance.', 'Open'),
(3, 204, '2023-06-12', 'Noise', 'Parties late at night.', 'Open'),
(4, 205, '2023-07-01', 'Maintenance', 'Air conditioning not working.', 'Resolved'),
(4, 206, '2023-07-10', 'Noise', 'Construction noise in the morning.', 'Open'),
(5, 207, '2023-08-01', 'Facility', 'Pool water is not clean.', 'Resolved'),
(5, 208, '2023-08-05', 'Noise', 'Elevator noise.', 'Open'),
(6, 209, '2023-09-01', 'Maintenance', 'Plumbing issue in bathroom.', 'Resolved'),
(6, 210, '2023-09-10', 'Facility', 'Lights in hallway flickering.', 'Resolved'),
(7, 211, '2023-10-01', 'Noise', 'Neighbors playing loud music.', 'Open'),
(7, 212, '2023-10-05', 'Maintenance', 'Broken window in living room.', 'Resolved');

/* Insert Utility Bills */
INSERT INTO UTILITY_BILLING (Building_ID, Apartment_ID, UtilityType, MonthlyCost, DueDate) VALUES
(3, 203, 'Electricity', 160.00, '2023-06-01'),
(3, 204, 'Water', 80.00, '2023-06-01'),
(4, 205, 'Gas', 100.00, '2023-07-01'),
(4, 206, 'Electricity', 170.00, '2023-07-01'),
(5, 207, 'Water', 85.00, '2023-08-01'),
(5, 208, 'Gas', 95.00, '2023-08-01'),
(6, 209, 'Electricity', 150.00, '2023-09-01'),
(6, 210, 'Water', 90.00, '2023-09-01'),
(7, 211, 'Gas', 110.00, '2023-10-01'),
(7, 212, 'Electricity', 175.00, '2023-10-01');

/* Re-enable foreign key checks */
SET FOREIGN_KEY_CHECKS = 1;

 
 
 
 
 
 
 
 
 
 
 
 
