/* Show the occupancy rate (occupied/total apartments) for each building. */
SELECT b.Building_ID, 
       COUNT(a.Apartment_ID) AS Total_Apartments,
       SUM(CASE WHEN a.Rental_status = 'Occupied' THEN 1 ELSE 0 END) AS Occupied,
       ROUND((SUM(CASE WHEN a.Rental_status = 'Occupied' THEN 1 ELSE 0 END) / COUNT(a.Apartment_ID)) * 100, 2) AS Occupancy_Rate
FROM BUILDING b
INNER JOIN APARTMENT a ON b.Building_ID = a.Building_ID
GROUP BY b.Building_ID;

/*  List managers earning above average salary with their building addresses. */
SELECT m.MFull_Name AS Manager_Name, m.Salary, CONCAT(b.Street, ', ', b.City, ', ', b.State, ' ', b.ZipCode) AS Building_Address
FROM MANAGER m
LEFT JOIN BUILDING b ON m.Building_ID = b.Building_ID
WHERE m.Salary > (SELECT AVG(Salary) FROM MANAGER);

/* Find leases with durations longer than 1 year. */
SELECT Lease_ID, 
       DATEDIFF(End_Date, Start_Date) AS Days,
       (DATEDIFF(End_Date, Start_Date) / 365) AS Years
FROM LEASE
HAVING Years > 1;

/* Count maintenance requests by status per building. */
SELECT b.Building_ID, 
       mr.Status, 
       COUNT(mr.Request_ID) AS Total_Requests
FROM BUILDING b
INNER JOIN MAINTENANCE_REQUEST mr ON b.Building_ID = mr.Building_ID
GROUP BY b.Building_ID, mr.Status;

/* Show unresolved feedback with apartment details. */
SELECT rf.FeedbackID, rf.Description, a.Building_ID, a.Apartment_ID
FROM RESIDENT_FEEDBACK rf
LEFT JOIN APARTMENT a ON rf.Building_ID = a.Building_ID AND rf.Apartment_ID = a.Apartment_ID
WHERE rf.Status = 'Open';

/* Calculate total utility costs per building. */
SELECT b.Building_ID, 
       SUM(ub.MonthlyCost) AS Total_Utility_Cost
FROM BUILDING b
INNER JOIN UTILITY_BILLING ub ON b.Building_ID = ub.Building_ID
GROUP BY b.Building_ID;

/* List corporate clients who didn't refer anyone. */
SELECT Client_ID AS CCID, Client_Name AS CCName
FROM CORPCLIENT
WHERE Client_ID NOT IN (SELECT Refer_Client_ID FROM CORPCLIENT WHERE Refer_Client_ID IS NOT NULL);

/* Count inspections per inspector. */
SELECT i.InspectorName AS Inspector_Name, COUNT(ins.Inspector_ID) AS Total_Inspections
FROM INSPECTOR i
LEFT JOIN INSPECTS ins ON i.Inspector_ID = ins.Inspector_ID
GROUP BY i.InspectorName;

/*  Show staff with more than one cleaning assignment. */
SELECT s.Staff_Name AS Staff_Name, COUNT(ca.Apartment_ID) AS Total_Assignments
FROM STAFF s
INNER JOIN CLEANS ca ON s.Staff_ID = ca.Staff_ID
GROUP BY s.Staff_Name
HAVING Total_Assignments > 1;

/* Create a trigger to mark apartments as occupied when leased. */
DELIMITER //
CREATE TRIGGER UpdateApartmentStatus
AFTER INSERT ON LEASE
FOR EACH ROW
BEGIN
    UPDATE APARTMENT
    SET Rental_status = 'Occupied'
    WHERE Building_ID = NEW.Building_ID AND Apartment_ID = NEW.Apartment_ID;
END;
//
DELIMITER ;

/* Find corporate clients referred by others in a chain (3+ levels). */
WITH RECURSIVE ReferralChain AS (
    SELECT Client_ID AS CCID, Client_Name AS CCName, Refer_Client_ID AS Referrer_CCID, 1 AS Depth
    FROM CORPCLIENT
    WHERE Refer_Client_ID IS NOT NULL
    UNION ALL
    SELECT rc.CCID, rc.CCName, c.Refer_Client_ID, rc.Depth + 1
    FROM ReferralChain rc
    JOIN CORPCLIENT c ON rc.Referrer_CCID = c.Client_ID
)
SELECT * FROM ReferralChain WHERE Depth >= 3;

/* Find staff working in multiple buildings. */
SELECT s.Staff_Name AS Staff_Name, 
       COUNT(DISTINCT ca.Building_ID) AS Buildings_Covered
FROM STAFF s
JOIN CLEANS ca ON s.Staff_ID = ca.Staff_ID
GROUP BY s.Staff_Name
HAVING Buildings_Covered > 1;

/* Create log table */
CREATE TABLE MAINTENANCE_LOG (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Request_ID INT,
    CompletionDate TIMESTAMP,
    FOREIGN KEY (Request_ID) REFERENCES MAINTENANCE_REQUEST(Request_ID)
);

/*  Automatically log completed maintenance requests */
DELIMITER //
CREATE TRIGGER LogCompletedMaintenance
AFTER UPDATE ON MAINTENANCE_REQUEST
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Completed' AND OLD.Status != 'Completed' THEN
        INSERT INTO MAINTENANCE_LOG (Request_ID, CompletionDate)
        VALUES (NEW.Request_ID, NOW());
    END IF;
END;
//
DELIMITER ;
