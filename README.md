# Fashion Retail Sales Analysis

A retail sales analysis project built to understand product performance, revenue trends, customer value, payment-method performance, and customer satisfaction.

The project combines MySQL for analysis and Google Sheets for the final dashboard.

## Project Overview

The dataset contains 3,400 simulated fashion retail transactions covering October 2022 to October 2023.

The main questions I wanted to answer were:

- Which products generate the most revenue?
- How does revenue change over time?
- Which payment method contributes more revenue?
- Who are the highest-value customers?
- Does customer satisfaction vary across products?
- Which price bands contribute most to revenue?

## Key Metrics

| Metric | Value |
|---|---:|
| Total Revenue | ₹430,952 |
| Transactions | 3,400 |
| Customers | 166 |
| Period | Oct 2022 – Oct 2023 |

## Tools Used

- **MySQL** — data analysis and SQL querying
- **Google Sheets** — pivot tables, dashboard and visualizations
- **Git/GitHub** — project version control and documentation

## SQL Analysis

The analysis includes:

- Aggregations with `SUM()`, `COUNT()`, `AVG()`, `MIN()` and `MAX()`
- `GROUP BY` and `HAVING`
- Common Table Expressions (CTEs)
- Window functions such as `SUM() OVER()` and `RANK()`
- Customer revenue segmentation using `CASE`
- Revenue-share calculations
- Monthly and quarterly trend analysis
- Data-quality checks

The main SQL queries are available in:

`sql/analysis_queries.sql`

## Dashboard

The final dashboard was built in Google Sheets and includes:

- KPI cards for revenue, transactions and customers
- Revenue by item
- Monthly revenue trend
- Revenue by payment method
- Top 10 customers by revenue
- Key business insights

### Dashboard Preview

_Add the dashboard screenshot here._

## Key Insights

Some of the main findings from the analysis:

1. **Tunic** generated the highest revenue among the listed products at ₹17,275.
2. **Credit Card** transactions generated more revenue than Cash transactions.
3. Revenue reached some of its strongest levels around **April–May 2023**.
4. Revenue declined sharply toward **October 2023**.
5. The analysis identifies a group of high-value customers that contribute significantly to total revenue.

These findings are based on the simulated dataset and should not be treated as real-world business performance.

## Project Structure

```text
fashion-retail-sales-analysis/
│
├── README.md
│
├── data/
│   └── Fashion_Retail_Sales_Clean.xlsx
│
├── sql/
│   └── analysis_queries.sql
│
├── dashboard/
│   └── dashboard_screenshot.png
│
└── insights/
    └── business_insights.md
```

## How to Reproduce the Analysis

### 1. Load the dataset into MySQL

Create a database and import the cleaned dataset into a table named:

```sql
fashion_sales_staging
```

### 2. Run the SQL queries

Open:

```text
sql/analysis_queries.sql
```

Run the queries in MySQL Workbench.

### 3. Build the dashboard

The resulting analysis can be used to recreate the pivot tables and charts in Google Sheets.

## What I Learned

This project helped me practice turning raw transactional data into business-focused analysis rather than only writing individual SQL queries.

The main focus was on:

- Writing SQL for practical business questions
- Using CTEs and window functions for more advanced analysis
- Translating query results into useful visualizations
- Presenting findings in a simple dashboard
- Communicating analytical results in business terms

## Author

**Akshaansh Singh**

Computer Science graduate interested in Data Analytics, Data Engineering and automation.
