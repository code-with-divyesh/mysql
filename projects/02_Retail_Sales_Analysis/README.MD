# 📊 Retail Sales Analysis (MySQL Project)

## 📌 Project Overview

This project analyzes retail sales data using MySQL.  
The objective is to perform data exploration, aggregation, and business insights extraction using SQL queries.

The dataset contains transactional-level retail sales information including customer details, product category, time of purchase, and revenue metrics.

---

## 🛠 Tools Used

- MySQL
- MySQL Workbench
- CSV Data Import
- SQL (Aggregations, Window Functions, CASE Statements)

---

## 🗂 Database Schema

### Table: `retail_sales`

| Column Name     | Data Type |
| --------------- | --------- |
| transactions_id | INT (PK)  |
| sale_date       | DATE      |
| sale_time       | TIME      |
| customer_id     | INT       |
| gender          | VARCHAR   |
| age             | INT       |
| category        | VARCHAR   |
| quantity        | INT       |
| price_per_unit  | FLOAT     |
| cogs            | FLOAT     |
| total_sale      | FLOAT     |

---

## 📥 Data Import Process

- Enabled `local_infile`
- Imported CSV using `LOAD DATA LOCAL INFILE`
- Converted date format using `STR_TO_DATE()`

---

## 📊 Business Problems Solved

1. Retrieve sales for a specific date
2. Filter category-based high quantity transactions
3. Total sales by category
4. Average age for Beauty category customers
5. Transactions above ₹1000
6. Gender-wise transactions per category
7. Best selling month in each year (Window Function)
8. Top 5 customers by revenue
9. Unique customers per category
10. Shift-wise order distribution (Morning/Afternoon/Evening)

---

## 📈 Key SQL Concepts Used

- GROUP BY
- ORDER BY
- DISTINCT
- Aggregate Functions (SUM, AVG, COUNT)
- CASE Statements
- Window Functions (RANK)
- Date Functions (YEAR, MONTH, HOUR)
- Subqueries

---

## 🚀 Key Insights

- Identified top revenue-generating months
- Analyzed category-wise sales performance
- Found highest spending customers
- Shift-based order distribution pattern
- Customer demographic insights

---

## 📌 Learning Outcome

- Hands-on SQL data analysis
- Window function implementation
- Data cleaning during CSV import
- Writing business-driven SQL queries

---

## 👨‍💻 Author

Divyesh Gandhi

Retail Sales Analysis Project using MySQL
