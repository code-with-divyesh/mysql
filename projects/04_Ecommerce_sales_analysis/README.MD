# 🛒 Ecommerce Sales Analysis (SQL Project)

## 📌 Project Overview

This project analyzes an Ecommerce sales dataset using SQL.  
The objective is to extract meaningful business insights such as sales performance, profitability, regional trends, product performance, and growth analysis.

The project demonstrates strong SQL fundamentals including:

- Aggregations
- GROUP BY & HAVING
- Window Functions
- Subqueries
- Ranking
- Date formatting & trend analysis

---

## 🗂️ Database Setup

### 1️⃣ Create Database

```sql
CREATE DATABASE Ecommerce_sales_db;
USE Ecommerce_sales_db;
```

### 2️⃣ Create Table

```sql
CREATE TABLE orders (
    order_date DATE,
    product_name VARCHAR(255),
    category VARCHAR(100),
    region VARCHAR(100),
    quantity INT,
    sales DECIMAL(10,2),
    profit DECIMAL(10,2)
);
```

---

## 📊 Analysis Performed

### 🔹 1. Overall Business Summary

- Total Sales
- Total Profit
- Total Quantity Sold
- Total Orders
- Average Order Value
- Average Profit

---

### 🔹 2. Category Performance

- Sales by Category
- Profit by Category
- Profit Margin %
- Category Ranking by Sales

---

### 🔹 3. Regional Analysis

- Sales by Region
- Regions with Negative Profit

---

### 🔹 4. Product-Level Analysis

- Top Products by Sales
- Top Products by Profit

---

### 🔹 5. Monthly Trend Analysis

- Monthly Sales
- Monthly Profit
- Month-over-Month (MoM) Growth

---

### 🔹 6. Advanced SQL Concepts Used

- `GROUP BY`
- `HAVING`
- `Subqueries`
- `Window Functions`
  - `RANK()`
  - `LAG()`
  - `SUM() OVER()`
- Running Total Calculation
- Profit Margin Calculation

---

## 📈 Sample Insights Generated

- Identified most profitable product categories
- Detected loss-making regions
- Ranked categories based on total sales
- Calculated month-over-month revenue growth
- Measured overall business profitability

---

## 🛠️ Tools Used

- MySQL
- SQL Window Functions
- Date Functions

---

## 🚀 Author

Divyesh Gandhi
SQL & Data Analytics Enthusiast
