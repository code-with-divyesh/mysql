# 🎬 Netflix Data Analysis Project (MySQL)

## 📌 Project Overview

This project performs end-to-end SQL-based data analysis on the Netflix dataset using MySQL.  
The objective is to extract meaningful business insights using advanced SQL techniques such as aggregations, window functions, subqueries, string manipulation, and date transformations.

This project demonstrates real-world SQL problem-solving skills and data handling techniques suitable for Data Analyst and SQL Developer roles.

---

## 🛠️ Tech Stack

- MySQL
- SQL (CTE, Window Functions, GROUP BY, Subqueries)
- CSV Data Import
- Data Cleaning & Transformation
- String Manipulation Functions
- Date Functions

---

## 📂 Dataset Description

The dataset contains information about Netflix Movies and TV Shows:

| Column Name  | Description                    |
| ------------ | ------------------------------ |
| show_id      | Unique ID of content           |
| type         | Movie or TV Show               |
| title        | Title of content               |
| director     | Director name                  |
| cast         | Cast members (comma separated) |
| country      | Production country             |
| date_added   | Date added to Netflix          |
| release_year | Year of release                |
| rating       | Content rating                 |
| duration     | Duration (minutes or seasons)  |
| listed_in    | Genre                          |
| description  | Short description              |

---

## ⚙️ Database Setup

```sql
CREATE DATABASE netflix_db;
USE netflix_db;
```

### Steps Performed:

- Created structured table `netflix_data`
- Imported CSV using `LOAD DATA LOCAL INFILE`
- Converted `date_added` into proper DATE format using `STR_TO_DATE`
- Handled NULL and empty values
- Performed transformation for multi-value columns (country, cast, genre)

---

## 📊 Business Problems Solved

1. Count number of Movies vs TV Shows
2. Find most common rating for each content type
3. List movies released in a specific year
4. Identify top 5 countries with highest content
5. Find the longest movie
6. Find content added in last 5 years
7. Retrieve content by specific director
8. List TV Shows with more than 5 seasons
9. Count content items per genre
10. Year-wise content release analysis for India
11. Identify documentary movies
12. Find content without a director
13. Count Salman Khan movies in last 10 years
14. Identify top 10 actors in Indian movies
15. Categorize content based on keywords (Kill / Violence)

---

## 🔍 Key SQL Concepts Used

- GROUP BY & ORDER BY
- Aggregate Functions (COUNT, AVG)
- Window Functions (RANK)
- CASE WHEN statements
- CTE (Common Table Expressions)
- Subqueries
- String Functions (SUBSTRING_INDEX, TRIM)
- Date Functions (CURDATE, INTERVAL)
- Data Cleaning Techniques

---

## 🧠 Key Learnings

- Handling comma-separated multi-value columns
- Writing scalable aggregation queries
- Using window functions for ranking analysis
- Cleaning and transforming raw CSV datasets
- Applying business logic using SQL
- Converting raw data into actionable insights

---

## 🚀 Project Highlights

✔ End-to-end SQL workflow  
✔ Real-world dataset  
✔ Data cleaning + transformation  
✔ Analytical business queries  
✔ Interview-ready project  
✔ Resume & portfolio suitable

---

## 👨‍💻 Author

Divyesh Gandhi
