SELECT
    ub.Apartment_ID,
    ub.Building_ID,
    FORMAT(SUM(ub.MonthlyCost), 2) AS Total_Utilities,
    (
        SELECT COUNT(*)
        FROM RESIDENT_FEEDBACK
        WHERE Apartment_ID = ub.Apartment_ID
          AND Building_ID = ub.Building_ID
          AND Status = 'Open'
    ) AS Open_Feedback_Count
FROM UTILITY_BILLING ub
GROUP BY ub.Apartment_ID, ub.Building_ID
HAVING Open_Feedback_Count > 0;