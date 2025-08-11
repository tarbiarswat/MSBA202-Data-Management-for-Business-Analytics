SELECT
    ub.Building_ID,
    ub.Apartment_ID,
    ub.UtilityType,
    FORMAT(ub.MonthlyCost, 2) AS Due_Amount,
    ub.DueDate,
    CASE
        WHEN DATEDIFF(CURDATE(), ub.DueDate) > 30 THEN 'Delinquent'
        WHEN DATEDIFF(CURDATE(), ub.DueDate) > 15 THEN 'Overdue'
        ELSE 'Current'
    END AS Payment_Status,
    (
        SELECT COUNT(*)
        FROM RESIDENT_FEEDBACK
        WHERE Apartment_ID = ub.Apartment_ID
          AND Building_ID = ub.Building_ID
          AND Category = 'Facility'
    ) AS Facility_Complaints
FROM UTILITY_BILLING ub
ORDER BY Payment_Status, DueDate DESC;
