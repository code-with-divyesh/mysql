-- =====================================================
-- NETFLIX DATA ANALYSIS PROJECT (MYSQL)
-- =====================================================

-- Step 1: Create Database
CREATE DATABASE netflix_db;

-- Use the database
USE netflix_db;

-- =====================================================
-- Step 2: Create Table Structure
-- =====================================================

CREATE TABLE netflix_data (
    show_id VARCHAR(20),        -- Unique ID of each show
    type VARCHAR(20),           -- Movie or TV Show
    title VARCHAR(255),         -- Title of content
    director VARCHAR(255),      -- Director name
    cast TEXT,                  -- Cast members (comma separated)
    country VARCHAR(255),       -- Country of production
    date_added VARCHAR(50),     -- Date added to Netflix
    release_year INT,           -- Year of release
    rating VARCHAR(10),         -- Content rating (PG, TV-MA etc.)
    duration VARCHAR(50),       -- Duration (minutes or seasons)
    listed_in VARCHAR(255),     -- Genre categories
    description TEXT            -- Content description
);

-- =====================================================
-- Step 3: Enable CSV Import
-- =====================================================

SET GLOBAL local_infile = 1;        -- Enable local file import
SHOW VARIABLES LIKE 'local_infile'; -- Verify setting

-- Drop table if already exists (for reloading data)
DROP TABLE IF EXISTS netflix_data;

-- =====================================================
-- Step 4: Load CSV Data
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/gandh/OneDrive/Documents/mysql/projects/07_Netflix_Analysis/netflix_data.csv'
INTO TABLE netflix_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@show_id, @type, @title, @director, @cast, @country,
 @date_added, @release_year, @rating, @duration,
 @listed_in, @description)
SET
 show_id = @show_id,
 type = @type,
 title = @title,
 director = @director,
 cast = @cast,
 country = @country,
 -- Convert date_added into proper DATE format
 date_added = CASE 
               WHEN @date_added = '' THEN NULL
               ELSE STR_TO_DATE(@date_added, '%M %d, %Y')
             END,
 release_year = @release_year,
 rating = @rating,
 duration = @duration,
 listed_in = @listed_in,
 description = @description;

-- Check total records loaded
SELECT COUNT(*) AS Total FROM netflix_data;


-- =====================================================
-- 1. Count Number of Movies vs TV Shows
-- =====================================================

SELECT type, COUNT(*) AS Total_no
FROM netflix_data
GROUP BY type;


-- =====================================================
-- 2. Find Most Common Rating for Each Type
-- Using Window Function (RANK)
-- =====================================================

WITH rating_count AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS total_count,
        RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
    FROM netflix_data
    GROUP BY type, rating
)
SELECT type, rating, total_count
FROM rating_count
WHERE rnk = 1;


-- =====================================================
-- 3. Movies Released in 2020
-- =====================================================

SELECT *
FROM netflix_data
WHERE release_year = 2020
AND type = "Movie";


-- =====================================================
-- 4. Top 5 Countries with Most Content
-- (Split comma separated country column)
-- =====================================================

SELECT country, COUNT(*) AS total_content
FROM (
    SELECT TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country
    FROM netflix_data
    WHERE country IS NOT NULL

    UNION ALL

    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country, ',', 2), ',', -1))
    FROM netflix_data
    WHERE country LIKE '%,%'

    UNION ALL

    SELECT TRIM(SUBSTRING_INDEX(country, ',', -1))
    FROM netflix_data
    WHERE country LIKE '%,%,%'
) AS split_countries
WHERE country <> ''
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;


-- =====================================================
-- 5. Identify Longest Movie
-- Extract numeric duration from text
-- =====================================================

SELECT 
    title,
    duration,
    CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS duration_minutes
FROM netflix_data
WHERE type = 'Movie'
ORDER BY duration_minutes DESC
LIMIT 1;


-- =====================================================
-- 6. Content Added in Last 5 Years
-- =====================================================

SELECT *
FROM netflix_data
WHERE date_added >= CURDATE() - INTERVAL 5 YEAR;


-- =====================================================
-- 7. All Content by Director 'Rajiv Chilaka'
-- =====================================================

SELECT *
FROM netflix_data
WHERE director LIKE '%Rajiv Chilaka%';


-- =====================================================
-- 8. TV Shows with More Than 5 Seasons
-- =====================================================

SELECT 
    title,
    duration,
    CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS seasons
FROM netflix_data
WHERE type = 'Tv Show'
AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;


-- =====================================================
-- 9. Count Content in Each Genre
-- =====================================================

SELECT genre, COUNT(*) AS total_count
FROM (
    SELECT TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre
    FROM netflix_data

    UNION ALL

    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', 2), ',', -1))
    FROM netflix_data
    WHERE listed_in LIKE '%,%'

    UNION ALL

    SELECT TRIM(SUBSTRING_INDEX(listed_in, ',', -1))
    FROM netflix_data
    WHERE listed_in LIKE '%,%,%'
) AS split_genres
WHERE genre <> ''
GROUP BY genre
ORDER BY total_count DESC;


-- =====================================================
-- 10. Year-wise Content Released in India
-- =====================================================

SELECT 
    release_year,
    COUNT(*) AS total_content
FROM netflix_data
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY release_year;


-- =====================================================
-- 11. List All Documentary Movies
-- =====================================================

SELECT *
FROM netflix_data
WHERE listed_in LIKE '%Documentaries';


-- =====================================================
-- 12. Content Without Director
-- =====================================================

SELECT *
FROM netflix_data
WHERE director IS NULL
OR TRIM(director) = '';


-- =====================================================
-- 13. Movies Featuring Salman Khan (Last 10 Years)
-- =====================================================

SELECT COUNT(*) AS total_movies
FROM netflix_data
WHERE type = 'Movie'
AND cast LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10;


-- =====================================================
-- 14. Top 10 Actors in Indian Movies
-- =====================================================

-- (Split comma-separated cast column)

SELECT actor, COUNT(*) AS total_appearances
FROM (
    SELECT TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor
    FROM netflix_data
    WHERE type = 'Movie'
    AND country LIKE '%India%'

    UNION ALL

    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', 2), ',', -1))
    FROM netflix_data
    WHERE type = 'Movie'
    AND country LIKE '%India%'
    AND cast LIKE '%,%'

    UNION ALL

    SELECT TRIM(SUBSTRING_INDEX(cast, ',', -1))
    FROM netflix_data
    WHERE type = 'Movie'
    AND country LIKE '%India%'
    AND cast LIKE '%,%,%'
) AS split_cast
WHERE actor <> ''
GROUP BY actor
ORDER BY total_appearances DESC
LIMIT 10;


-- =====================================================
-- 15. Categorize Content as Good or Bad
-- Based on keywords: Kill / Violence
-- =====================================================

SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN LOWER(description) LIKE '%kill%'
              OR LOWER(description) LIKE '%violence%'
            THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix_data
) AS categorized_content
GROUP BY category;