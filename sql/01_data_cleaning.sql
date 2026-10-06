-- ============================================================
-- 01 DATA CLEANING
-- Retail Sales & Customer Analytics
-- MySQL
-- ============================================================

-- IMPORTANT:
-- Keep the original imported tables unchanged.
-- The portfolio version creates cleaned tables for analysis.

-- ------------------------------------------------------------
-- 1. CHECK DUPLICATE TRANSACTIONS
-- ------------------------------------------------------------
SELECT
    TransactionID,
    COUNT(*) AS DuplicateCount
FROM sales_transaction
GROUP BY TransactionID
HAVING COUNT(*) > 1;

-- ------------------------------------------------------------
-- 2. CREATE A DEDUPLICATED SALES TABLE
-- ------------------------------------------------------------
DROP TABLE IF EXISTS sales_transaction_clean;

CREATE TABLE sales_transaction_clean AS
SELECT DISTINCT
    TransactionID,
    CustomerID,
    ProductID,
    QuantityPurchased,
    STR_TO_DATE(TransactionDate, '%d/%m/%y') AS TransactionDate,
    Price
FROM sales_transaction;

-- Validate row count after deduplication
SELECT COUNT(*) AS CleanedRows
FROM sales_transaction_clean;

-- ------------------------------------------------------------
-- 3. CHECK MISSING CUSTOMER LOCATIONS
-- ------------------------------------------------------------
SELECT
    COUNT(*) AS MissingLocationCount
FROM customer_profiles
WHERE Location IS NULL;

-- Create a cleaned customer table without modifying the raw table.
DROP TABLE IF EXISTS customer_profiles_clean;

CREATE TABLE customer_profiles_clean AS
SELECT
    CustomerID,
    Age,
    Gender,
    COALESCE(Location, 'Unknown') AS Location,
    STR_TO_DATE(JoinDate, '%d/%m/%y') AS JoinDate
FROM customer_profiles;

-- ------------------------------------------------------------
-- 4. CHECK TRANSACTION VS INVENTORY PRICE DISCREPANCIES
-- ------------------------------------------------------------
SELECT
    st.TransactionID,
    st.ProductID,
    st.Price AS TransactionPrice,
    pi.Price AS InventoryPrice
FROM sales_transaction_clean st
JOIN product_inventory pi
    ON st.ProductID = pi.ProductID
WHERE st.Price <> pi.Price;

-- ------------------------------------------------------------
-- 5. CREATE CLEAN SALES TABLE USING INVENTORY PRICE
-- ------------------------------------------------------------
DROP TABLE IF EXISTS sales_transaction_final;

CREATE TABLE sales_transaction_final AS
SELECT
    st.TransactionID,
    st.CustomerID,
    st.ProductID,
    st.QuantityPurchased,
    st.TransactionDate,
    pi.Price AS Price
FROM sales_transaction_clean st
JOIN product_inventory pi
    ON st.ProductID = pi.ProductID;

-- Validate that no transaction/inventory price discrepancies remain
SELECT
    COUNT(*) AS RemainingPriceDiscrepancies
FROM sales_transaction_final st
JOIN product_inventory pi
    ON st.ProductID = pi.ProductID
WHERE st.Price <> pi.Price;

-- Final table used by all downstream analysis:
-- sales_transaction_final
