-- ============================================================
-- 03 PRODUCT ANALYSIS
-- Uses: sales_transaction_final + product_inventory
-- ============================================================

-- ------------------------------------------------------------
-- 1. TOP 10 PRODUCTS BY REVENUE
-- ------------------------------------------------------------
SELECT
    ProductID,
    ROUND(SUM(Price * QuantityPurchased), 2) AS TotalRevenue
FROM sales_transaction_final
GROUP BY ProductID
ORDER BY TotalRevenue DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 2. 10 LOWEST-SELLING PRODUCTS BY UNIT VOLUME
-- Only products with at least one unit sold are included.
-- ------------------------------------------------------------
SELECT
    ProductID,
    SUM(QuantityPurchased) AS TotalUnitsSold
FROM sales_transaction_final
GROUP BY ProductID
HAVING TotalUnitsSold >= 1
ORDER BY TotalUnitsSold ASC
LIMIT 10;


-- ------------------------------------------------------------
-- 3. PRODUCT CATEGORY PERFORMANCE
-- ------------------------------------------------------------
SELECT
    pi.Category,
    SUM(st.QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(st.Price * st.QuantityPurchased), 2) AS TotalSales
FROM sales_transaction_final st
JOIN product_inventory pi
    ON st.ProductID = pi.ProductID
GROUP BY pi.Category
ORDER BY TotalSales DESC;
