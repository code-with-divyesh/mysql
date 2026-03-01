# ☕ Coffee Sales Analytics SQL Project

## 📌 Project Overview

This project is an end-to-end SQL-based Business Analytics system built using MySQL.

The goal of this project is to analyze coffee sales data and generate meaningful business insights such as revenue trends, customer behavior, product performance, churn risk, and market potential.

---

## 🗂 Database Schema

The database consists of four relational tables:

### 1️⃣ city

Stores city-level demographic and rent information.

| Column         | Description               |
| -------------- | ------------------------- |
| city_id        | Primary Key               |
| city_name      | Name of the city          |
| population     | Total population          |
| estimated_rent | Estimated rental cost     |
| city_rank      | Rank based on market size |

---

### 2️⃣ products

Stores coffee product information.

| Column       | Description     |
| ------------ | --------------- |
| product_id   | Primary Key     |
| product_name | Name of product |
| price        | Product price   |

---

### 3️⃣ customers

Stores customer details and their city mapping.

| Column        | Description        |
| ------------- | ------------------ |
| customer_id   | Primary Key        |
| customer_name | Customer name      |
| city_id       | Foreign Key → city |

---

### 4️⃣ sales

Transaction-level sales data.

| Column      | Description              |
| ----------- | ------------------------ |
| sale_id     | Primary Key              |
| sale_date   | Transaction date         |
| product_id  | Foreign Key → products   |
| customer_id | Foreign Key → customers  |
| total       | Total transaction amount |
| rating      | Product rating           |

---

# 📊 Business Problems Solved

## ✅ 1. Coffee Consumer Estimation

Estimated coffee-consuming population assuming 25% penetration.

---

## ✅ 2. Quarterly Revenue Analysis

Calculated total revenue for Q4 2023.

---

## ✅ 3. Product Sales Performance

Identified most sold products by volume.

---

## ✅ 4. Average Customer Spending by City

Calculated average revenue generated per customer in each city.

---

## ✅ 5. Market Penetration Analysis

Compared:

- Current customer base
- Estimated coffee consumers (25% of population)

---

## ✅ 6. Top 3 Products by City

Used `ROW_NUMBER()` window function to rank top-selling products per city.

---

## ✅ 7. Monthly Sales Growth Rate

Calculated Month-over-Month (MoM) growth using `LAG()` window function.

Growth Formula Used:
(Current Month Sales - Previous Month Sales)
-------------------------------------------- × 100
Previous Month Sales

---

## ✅ 8. Market Potential Analysis

Identified Top 3 cities based on:

- Total sales
- Rent
- Total customers
- Estimated coffee consumers

---

## ✅ 9. Customer Lifetime Value (CLV)

Calculated total revenue generated per customer.

---

## ✅ 10. Revenue Contribution %

Calculated percentage contribution of each city to overall revenue.

---

## ✅ 11. Monthly Best Selling Product

Identified highest revenue-generating product each month using window functions.

---

## ✅ 12. Churn Risk Customers

Defined churn based on recency:

Customers who haven't purchased in the last 60 days were flagged as churn risk.

Advanced segmentation:

- Low Risk
- Medium Risk
- High Risk

---

# 🧠 SQL Concepts Used

- INNER JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- Subqueries
- Aggregate Functions (SUM, AVG, COUNT)
- Window Functions:
  - ROW_NUMBER()
  - LAG()
- Ranking Logic
- Growth Rate Calculation
- Revenue Segmentation
- Customer Behavioral Analysis

---

# 🚀 Key Business Insights Generated

- Identified high-revenue cities
- Found most profitable products
- Detected repeat customers
- Calculated customer lifetime value
- Measured sales growth trends
- Estimated market potential by city
- Flagged churn-risk customers

---

# 💡 Skills Demonstrated

- SQL Query Optimization
- Analytical Thinking
- Business KPI Development
- Data Aggregation & Segmentation
- Window Function Mastery
- Real-world Business Problem Solving

---

# 🎯 Future Improvements

- Add indexes for performance optimization
- Build Power BI / Tableau dashboard
- Implement RFM Segmentation
- Add predictive churn modeling
- Automate reporting

---

📌 Author: Divyesh Gandhi
📌 Tool Used: MySQL  
📌 Domain: Retail / Coffee Sales Analytics
