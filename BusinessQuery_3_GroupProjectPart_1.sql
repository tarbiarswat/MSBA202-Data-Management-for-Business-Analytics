SELECT
    rf.Apartment_ID,
    rf.Building_ID,
    rf.Description AS Open_Issue,
    FORMAT(ub.MonthlyCost, 2) AS Utility_Cost
FROM RESIDENT_FEEDBACK rf
JOIN UTILITY_BILLING ub
    ON rf.Apartment_ID = ub.Apartment_ID
    AND rf.Building_ID = ub.Building_ID
WHERE rf.Status = 'Open'
    AND ub.MonthlyCost > (
        SELECT AVG(MonthlyCost)
        FROM UTILITY_BILLING
    );
