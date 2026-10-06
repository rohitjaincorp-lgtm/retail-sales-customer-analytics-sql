-- ============================================================
-- 04 CUSTOMER ANALYSIS
-- Uses: sales_transaction_final + customer_profiles_clean
-- ============================================================

-- ------------------------------------------------------------
-- 1. CUSTOMER PURCHASE FREQUENCY
-- ------------------------------------------------------------
SELECT
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions
FROM sales_transaction_final
GROUP BY CustomerID
ORDER BY NumberOfTransactions DESC;


-- ------------------------------------------------------------
-- 2. CUSTOMER SEGMENTATION
-- 0      = No Orders
-- 1-10   = Low
-- 11-30  = Mid
-- >30    = High Value
-- ------------------------------------------------------------
DROP TABLE IF EXISTS customer_segment;

CREATE TABLE customer_segment AS
SELECT
    cp.CustomerID,
    COALESCE(SUM(st.QuantityPurchased), 0) AS TotalQuantityPurchased,
    CASE
        WHEN COALESCE(SUM(st.QuantityPurchased), 0) = 0
            THEN 'No Orders'
        WHEN COALESCE(SUM(st.QuantityPurchased), 0) BETWEEN 1 AND 10
            THEN 'Low'
        WHEN COALESCE(SUM(st.QuantityPurchased), 0) BETWEEN 11 AND 30
            THEN 'Mid'
        WHEN COALESCE(SUM(st.QuantityPurchased), 0) > 30
            THEN 'High Value'
    END AS CustomerSegment
FROM customer_profiles_clean cp
LEFT JOIN sales_transaction_final st
    ON cp.CustomerID = st.CustomerID
GROUP BY cp.CustomerID;

SELECT
    CustomerSegment,
    COUNT(*) AS CustomerCount
FROM customer_segment
GROUP BY CustomerSegment
ORDER BY CustomerCount DESC;


-- ------------------------------------------------------------
-- 3. REPEAT PURCHASES BY CUSTOMER AND PRODUCT
-- ------------------------------------------------------------
SELECT
    CustomerID,
    ProductID,
    COUNT(*) AS TimesPurchased
FROM sales_transaction_final
GROUP BY CustomerID, ProductID
HAVING COUNT(*) > 1
ORDER BY TimesPurchased DESC;


-- ------------------------------------------------------------
-- 4. OCCASIONAL CUSTOMERS
-- Customers with 2 or fewer transactions.
-- ------------------------------------------------------------
SELECT
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions,
    ROUND(SUM(Price * QuantityPurchased), 2) AS TotalSpent
FROM sales_transaction_final
GROUP BY CustomerID
HAVING COUNT(TransactionID) <= 2
ORDER BY NumberOfTransactions ASC, TotalSpent DESC;


-- ------------------------------------------------------------
-- 5. HIGH-FREQUENCY / HIGH-SPEND CUSTOMERS
-- ------------------------------------------------------------
SELECT
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions,
    ROUND(SUM(Price * QuantityPurchased), 2) AS TotalSpent
FROM sales_transaction_final
GROUP BY CustomerID
HAVING COUNT(TransactionID) > 10
   AND SUM(Price * QuantityPurchased) > 1000
ORDER BY TotalSpent DESC;


-- ------------------------------------------------------------
-- 6. LOYALTY INDICATORS
-- First purchase, last purchase, and elapsed days.
-- ------------------------------------------------------------
SELECT
    CustomerID,
    MIN(TransactionDate) AS FirstPurchase,
    MAX(TransactionDate) AS LastPurchase,
    DATEDIFF(
        MAX(TransactionDate),
        MIN(TransactionDate)
    ) AS DaysBetweenPurchases
FROM sales_transaction_final
GROUP BY CustomerID
HAVING DATEDIFF(
    MAX(TransactionDate),
    MIN(TransactionDate)
) > 0
ORDER BY DaysBetweenPurchases DESC;
