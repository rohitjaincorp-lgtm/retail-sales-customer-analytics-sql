# Retail Sales & Customer Analytics — SQL

## Project Overview

This project analyzes retail sales transactions, customer profiles, and product inventory data to understand sales performance, product performance, customer purchasing behavior, customer segmentation, repeat purchases, and loyalty indicators.

The analysis follows a typical data-analytics workflow:

**Raw data → Data quality checks → Data cleaning → Exploratory analysis → Customer/product insights**

## Business Problem

The retail company has experienced stagnant growth and declining customer engagement. Management wants data-driven insights into:

- Product sales performance and revenue contribution
- Sales trends and month-over-month growth
- Customer purchasing frequency
- Customer segments based on purchase volume
- Repeat purchasing behavior
- High-frequency and occasional customers
- Customer loyalty indicators
- Data-quality issues affecting analysis

## Datasets

| Dataset | Records | Description |
|---|---:|---|
| `sales_transaction.csv` | 5,002 | Transaction ID, customer, product, quantity, date, and transaction price |
| `customer_profiles.csv` | 1,000 | Customer demographics, location, and join date |
| `product_inventory.csv` | 200 | Product name, category, stock level, and inventory price |

## Data Quality Findings

The raw datasets contain several issues that are addressed before analysis:

- `sales_transaction` contains **2 duplicate rows**.
- `customer_profiles` contains **13 missing Location values**.
- `sales_transaction` contains **20 price discrepancies**, all relating to ProductID 51, where the transaction price is 9,312.00 while the inventory price is 93.12.
- `TransactionDate` is stored as text in `DD/MM/YY` format and is converted to a proper SQL `DATE`.
- One customer record contains an unusually high age value (131). This is retained because the supplied case study does not define an age-validation rule.

## Analysis Areas

### 1. Data Cleaning
- Detect and remove duplicate transactions
- Convert transaction dates from text to `DATE`
- Identify and handle missing customer locations
- Identify price discrepancies between transaction and inventory tables

### 2. Sales Analysis
- Total units sold and revenue by product
- Daily sales trend
- Monthly sales
- Month-over-month sales growth

### 3. Product Analysis
- Top products by revenue
- Lowest-selling products
- Product-category performance

### 4. Customer Analysis
- Customer purchase frequency
- Customer segmentation
- Repeat purchases by customer and product
- Occasional customers
- High-frequency / high-spend customers
- First and last purchase dates
- Days between first and last purchase

## Customer Segmentation

Customers are segmented using total quantity purchased:

| Total Quantity Purchased | Segment |
|---:|---|
| 0 | No Orders |
| 1–10 | Low |
| 11–30 | Mid |
| >30 | High Value |

The segmentation uses a `LEFT JOIN` from customer profiles to transactions so customers with no transactions are not excluded.

## SQL Concepts Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`
- `GROUP BY`, `HAVING`
- Aggregate functions: `SUM()`, `COUNT()`, `MIN()`, `MAX()`
- `CASE`
- `INNER JOIN` and `LEFT JOIN`
- Date conversion and date functions
- Subqueries
- Common Table Expressions (`WITH`)
- Window functions such as `LAG()`
- Month-over-month growth calculations
- Data-quality validation
- Customer segmentation

## Repository Structure

```text
retail-sales-customer-analytics-sql/
│
├── README.md
│
├── data/
│   ├── sales_transaction.csv
│   ├── customer_profiles.csv
│   └── product_inventory.csv
│
├── sql/
│   ├── 01_data_cleaning.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_product_analysis.sql
│   └── 04_customer_analysis.sql
│
├── results/
│   └── key_findings.md
│
└── documentation/
    └── case_study_summary.md
```

## Key Findings

After applying the cleaning rules and using the corrected inventory price for ProductID 51:

- Total cleaned sales revenue is approximately **₹1.21M** across the supplied transaction data.
- **Home & Kitchen** is the highest-revenue product category.
- Product **17** is the highest-revenue product in the supplied data.
- July shows the largest month-over-month decline in the analyzed period.
- Most customers fall into the **Mid** or **Low** purchase-volume segments.
- A smaller group of customers exhibits high transaction frequency and spending.
- Repeat-purchase analysis identifies customers purchasing the same product more than once.

See `results/key_findings.md` for supporting figures.

## How to Use

1. Import the three CSV files into MySQL.
2. Use the table names:
   - `sales_transaction`
   - `customer_profiles`
   - `product_inventory`
3. Run `sql/01_data_cleaning.sql`.
4. Run the analysis scripts in order.
5. Review the SQL comments to understand the business question behind each query.

> The SQL in this repository is organized and refined for portfolio presentation. The original case-study submissions were used as the starting point, while date parsing, data-quality handling, and customer segmentation were made more robust for reproducibility.

## Resume Project

**Retail Sales & Customer Analytics | MySQL, SQL**

- Analyzed **5,000+ retail transactions, 1,000 customer profiles, and 200 products** to evaluate sales performance and customer purchasing behavior.
- Performed data cleaning and validation covering **duplicate transactions, missing values, date conversion, and transaction/inventory price discrepancies**.
- Developed SQL analyses for **sales trends, month-over-month growth, product performance, customer segmentation, repeat purchases, and loyalty indicators**.
- Applied **JOINs, aggregations, CASE statements, CTEs, subqueries, date functions, and window functions** to derive business insights.

## Author

**Rohit Jain**

GitHub: `https://github.com/rohitjaincorp-lgtm`
