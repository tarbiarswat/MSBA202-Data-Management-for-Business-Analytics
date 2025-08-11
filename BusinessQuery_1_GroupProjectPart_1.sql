SELECT
    ub.Apartment_ID,
    ub.Building_ID,
    FORMAT(ub.MonthlyCost, 2) AS Current_UtilityCost,
    (
        SELECT FORMAT(AVG(MonthlyCost), 2)
        FROM UTILITY_BILLING
        WHERE UtilityType = ub.UtilityType
    ) AS Type_Avg,
    (
        SELECT GROUP_CONCAT(Description SEPARATOR ' | ')
        FROM RESIDENT_FEEDBACK
        WHERE Apartment_ID = ub.Apartment_ID
          AND Building_ID = ub.Building_ID
          AND Status = 'Open'
    ) AS Open_Issues
FROM UTILITY_BILLING ub
WHERE ub.MonthlyCost > (
    SELECT AVG(MonthlyCost)
    FROM UTILITY_BILLING
    WHERE UtilityType = ub.UtilityType
)
AND EXISTS (
    SELECT 1
    FROM RESIDENT_FEEDBACK
    WHERE Apartment_ID = ub.Apartment_ID
      AND Building_ID = ub.Building_ID
      AND Status = 'Open'
)
ORDER BY ub.MonthlyCost DESC;
