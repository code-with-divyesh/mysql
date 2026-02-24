# 🛒 Zepto Sales & Inventory Analysis (MySQL Project)

## 📌 Project Overview

This project focuses on **end-to-end sales and inventory analysis** using MySQL.  
The dataset contains product-level information including pricing, discounts, stock availability, and weight.

The goal of this project is to perform:

- Data exploration
- Data cleaning
- Business analysis
- Revenue modeling
- Performance optimization

This project simulates a real-world e-commerce inventory analytics scenario.

---

## 🗂 Database Structure

### 📦 Database Name:

Zepto_db

### 🏷 Table: products

| Column Name            | Data Type     | Description                                   |
| ---------------------- | ------------- | --------------------------------------------- |
| sku_id                 | INT (PK)      | Unique product ID                             |
| category               | VARCHAR(100)  | Product category                              |
| name                   | VARCHAR(100)  | Product name                                  |
| mrp                    | DECIMAL(10,2) | Maximum Retail Price                          |
| discountPercent        | INT           | Discount percentage                           |
| availableQuantity      | INT           | Current stock quantity                        |
| discountedSellingPrice | DECIMAL(10,2) | Final selling price                           |
| weightInGms            | INT           | Product weight in grams                       |
| outOfStock             | TINYINT       | Stock status (0 = In Stock, 1 = Out of Stock) |
| quantity               | INT           | Default purchase quantity                     |

---

## 📥 Data Import

- CSV file imported using `LOAD DATA LOCAL INFILE`
- UTF-8 encoding applied
- Header row ignored during import

---

## 🔎 Data Exploration Performed

- Total record count
- NULL value detection
- Category distribution
- Stock availability distribution

---

## 🧹 Data Cleaning

- Removed invalid rows (MRP = 0)
- Converted pricing from paisa to rupees
- Verified pricing consistency

---

## 📊 Business Analysis Queries

### ✔ Top Discounted Products

Identified products offering highest discounts.

### ✔ Category-wise Potential Revenue

Calculated revenue using:

discountedSellingPrice × availableQuantity

### ✔ Profit Margin %

((MRP - Selling Price) / MRP) × 100

### ✔ Price per Gram Analysis

Used to compare product value across categories.

### ✔ Revenue Contribution %

Determined each category’s contribution to total revenue.

---

## ⚡ Performance Optimization

Created indexes on:

- category
- outOfStock

Improved filtering and aggregation speed.

---

## 👁 View Created

### category_revenue

Virtual table for category-wise revenue reporting.

---

## ⚙ Stored Procedure

### LowStock()

Returns products where:

availableQuantity < 5

Used for inventory monitoring.

---

## 🧠 Skills Demonstrated

- Database design
- Data import handling
- Data cleaning
- SQL aggregations (SUM, COUNT, GROUP BY)
- Revenue modeling
- Profit analysis
- Indexing
- View creation
- Stored procedures
- Business insight generation

---

## 🎯 Key Business Insights Generated

- High-discount products identified
- Most profitable categories detected
- Revenue-driving segments analyzed
- Stock risk products identified
- Pricing efficiency evaluated

---

## 🚀 Tools Used

- MySQL
- CSV Dataset
- SQL (DDL, DML, Aggregations, Views, Procedures)

---

## 📌 Future Improvements

- Add sales transaction table
- Implement foreign key relationships
- Build dashboard in Power BI / Tableau
- Automate reporting with scheduled procedures

---

## 🏁 Conclusion

This project demonstrates practical SQL skills applied to a real-world e-commerce dataset.  
It showcases the ability to transform raw inventory data into meaningful business insights.
