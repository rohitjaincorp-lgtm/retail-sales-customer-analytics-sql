-- ============================================================
-- 02 SALES ANALYSIS
-- Uses: sales_transaction_final
-- ============================================================

-- ------------------------------------------------------------
-- 1. TOTAL SALES SUMMARY BY PRODUCT
-- ------------------------------------------------------------
SELECT
    ProductID,
    SUM(QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(Price * QuantityPurchased), 2) AS TotalSales
FROM sales_transaction_final
GROUP BY ProductID
ORDER BY TotalSales DESC;


-- ------------------------------------------------------------
-- 2. DAILY SALES TREND
-- ------------------------------------------------------------
SELECT
    TransactionDate,
    COUNT(TransactionID) AS TransactionCount,
    SUM(QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(Price * QuantityPurchased), 2) AS TotalSales
FROM sales_transaction_final
GROUP BY TransactionDate
ORDER BY TransactionDate DESC;


-- ------------------------------------------------------------
-- 3. MONTHLY SALES AND MONTH-OVER-MONTH GROWTH
-- ------------------------------------------------------------
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(TransactionDate, '%Y-%m') AS SalesMonth,
        ROUND(SUM(Price * QuantityPurchased), 2) AS TotalSales
    FROM sales_transaction_final
    GROUP BY DATE_FORMAT(TransactionDate, '%Y-%m')
),
sales_with_previous_month AS (
    SELECT
        SalesMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SalesMonth) AS PreviousMonthSales
    FROM monthly_sales
)
SELECT
    SalesMonth,
    TotalSales,
    PreviousMonthSales,
    ROUND(
        (TotalSales - PreviousMonthSales)
        / NULLIF(PreviousMonthSales, 0) * 100,
        2
    ) AS MoM_Growth_Percentage
FROM sales_with_previous_month
ORDER BY SalesMonth;
