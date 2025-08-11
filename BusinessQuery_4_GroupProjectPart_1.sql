SELECT
    ub.Apartment_ID,
    ub.Building_ID,
    FORMAT(ub.MonthlyCost, 2) AS Current_Cost,
    FORMAT(
        (
            SELECT AVG(MonthlyCost)
            FROM UTILITY_BILLING
            WHERE Building_ID = ub.Building_ID
        ), 2
    ) AS Building_Avg_Cost
FROM UTILITY_BILLING ub
WHERE ub.MonthlyCost > (
    SELECT AVG(MonthlyCost)
    FROM UTILITY_BILLING
    WHERE Building_ID = ub.Building_ID
);
