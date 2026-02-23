# 🍕 PizzaHut Sales Data Analysis (SQL Project)

## 📌 Project Overview

This project focuses on analyzing PizzaHut sales data using SQL to generate actionable business insights.

The goal of this analysis is to:

- Measure total revenue and order volume
- Identify top-performing pizzas and categories
- Analyze customer ordering patterns by time
- Evaluate revenue contribution by category
- Track cumulative revenue growth over time

This project demonstrates strong SQL fundamentals along with advanced analytical techniques.

---

## 🗄️ Database Schema

The database consists of four relational tables:

### 1️⃣ Orders Table

Stores order-level details.

| Column Name | Description                           |
| ----------- | ------------------------------------- |
| order_id    | Unique order identifier (Primary Key) |
| order_date  | Date of order                         |
| order_time  | Time of order                         |

---

### 2️⃣ Order Details Table

Stores item-level details for each order.

| Column Name      | Description                           |
| ---------------- | ------------------------------------- |
| order_details_id | Unique identifier (Primary Key)       |
| order_id         | References Orders table (Foreign Key) |
| pizza_id         | References Pizzas table (Foreign Key) |
| quantity         | Number of pizzas ordered              |

---

### 3️⃣ Pizzas Table

Contains pricing and size information.

### 4️⃣ Pizza Types Table

Contains pizza names and categories (Classic, Veggie, Supreme, etc.).

---

## 📊 Business Problems Solved

### 🔹 1. Sales & Revenue Analysis

- Total number of orders placed
- Total revenue generated
- Average pizzas ordered per day
- Cumulative revenue over time

### 🔹 2. Product Performance Analysis

- Highest priced pizza
- Most commonly ordered pizza size
- Top 5 most ordered pizza types
- Top 3 pizza types by revenue
- Top 3 revenue-generating pizzas within each category

### 🔹 3. Category Performance

- Category-wise total quantity sold
- Percentage revenue contribution by category

### 🔹 4. Time-Based Analysis

- Hourly order distribution
- Daily sales aggregation
- Revenue trend analysis

---

## 🧠 SQL Concepts Demonstrated

This project includes:

- ✔ INNER JOIN
- ✔ GROUP BY & ORDER BY
- ✔ Aggregate Functions (SUM, COUNT, AVG)
- ✔ Subqueries
- ✔ Foreign Keys & Relational Design
- ✔ Window Functions
  - `RANK()`
  - `SUM() OVER()`
- ✔ Revenue Modeling (quantity × price)
- ✔ Percentage Contribution Calculation
- ✔ Cumulative Running Total

---

## 📈 Key Insights Generated

- Identified highest revenue-generating pizza types
- Determined most popular pizza size
- Measured revenue share of each category
- Analyzed peak ordering hours
- Tracked cumulative business growth over time

---

## 🛠️ Tools & Technologies

- MySQL
- SQL Window Functions
- Relational Database Design
- Data Aggregation Techniques

---

## 💡 Why This Project Matters

This project simulates real-world business analysis performed by Data Analysts in the food & retail industry.

It demonstrates:

- Business-oriented thinking
- Strong SQL query writing skills
- Ability to extract insights from structured data
- Knowledge of advanced SQL functions

---

## 🚀 Project Level

✔ Intermediate SQL Project  
✔ Portfolio Ready  
✔ Interview Ready  
✔ Business Insight Focused

---

## 👤 Author

Divyesh Gandhi

Aspiring Data Analyst

| Data Analytics | SQL |
