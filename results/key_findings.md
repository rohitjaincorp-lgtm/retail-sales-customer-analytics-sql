# Key Findings

These findings were calculated from the supplied CSV data after:

1. Removing the 2 duplicate transaction rows.
2. Converting transaction dates from `DD/MM/YY` text to SQL `DATE`.
3. Replacing transaction prices with the corresponding inventory price where discrepancies existed.
4. Treating missing customer locations as `Unknown` for the cleaned customer table.

## Data Quality

| Check | Finding |
|---|---:|
| Sales transaction rows | 5,002 |
| Duplicate rows | 2 |
| Missing customer locations | 13 |
| Price discrepancy rows | 20 |
| Price discrepancy product | ProductID 51 |
| Product 51 transaction price | 9,312.00 |
| Product 51 inventory price | 93.12 |

## Sales

After cleaning, the supplied transaction data represents approximately **₹1.21 million** in sales revenue and **12,329 units** sold.

Monthly sales:

| Month | Sales | MoM Growth |
|---|---:|---:|
| Jan 2023 | ₹104,289.18 | — |
| Feb 2023 | ₹96,690.99 | -7.29% |
| Mar 2023 | ₹103,271.49 | +6.81% |
| Apr 2023 | ₹101,561.09 | -1.66% |
| May 2023 | ₹102,998.84 | +1.42% |
| Jun 2023 | ₹102,210.28 | -0.77% |
| Jul 2023 | ₹90,981.75 | -10.99% |

**Observation:** July recorded the largest month-over-month decline in the supplied period.

## Product Categories

| Category | Units Sold | Sales |
|---|---:|---:|
| Home & Kitchen | 3,477 | ₹217,755.94 |
| Electronics | 3,037 | ₹177,548.48 |
| Clothing | 2,810 | ₹162,874.21 |
| Beauty & Health | 3,001 | ₹143,824.99 |

**Observation:** Home & Kitchen generated the highest sales among the four categories.

## Top Revenue Products

The highest-revenue products in the cleaned transaction data include:

| ProductID | Units Sold | Revenue |
|---:|---:|---:|
| 17 | 100 | ₹9,450.00 |
| 87 | 92 | ₹7,817.24 |
| 179 | 86 | ₹7,388.26 |
| 96 | 72 | ₹7,132.32 |
| 54 | 86 | ₹7,052.86 |

## Customer Segmentation

Using total quantity purchased:

| Segment | Customers |
|---|---:|
| Mid | 559 |
| Low | 423 |
| No Orders | 11 |
| High Value | 7 |

**Observation:** Most customers fall into the Mid and Low purchase-volume segments, while the High Value segment is relatively small.

## Repeat Purchasing

The customer-product analysis identified **70 customer/product combinations** where the same customer purchased the same product more than once.

## High-Frequency / High-Spend Customers

Customers meeting the case-study condition of:

- more than 10 transactions, and
- more than ₹1,000 total spend

form a relatively small high-engagement group. These customers can be considered candidates for loyalty or retention initiatives.

> These findings are descriptive results from the supplied case-study dataset and should not be interpreted as statistically representative of a real retail population.
