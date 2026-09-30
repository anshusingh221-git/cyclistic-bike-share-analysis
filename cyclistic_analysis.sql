-- ====================================================================
-- GOOGLE DATA ANALYTICS CAPSTONE PROJECT: CYCLISTIC BIKE-SHARE
-- Author: Anshu Kumari
-- Purpose: Merge 12 months of historical data, clean it, and analyze 
--          trends between casual riders and annual members.
-- ====================================================================

-- STEP 1: MERGING 12 MONTHS OF HISTORICAL DATA
-- Combining monthly datasets into one consolidated master table
CREATE TABLE total_trips_data AS
SELECT * FROM `cyclistic_data.jan_2026`
UNION ALL
SELECT * FROM `cyclistic_data.feb_2026`
UNION ALL
SELECT * FROM `cyclistic_data.mar_2026`
UNION ALL
SELECT * FROM `cyclistic_data.apr_2026`
UNION ALL
SELECT * FROM `cyclistic_data.may_2026`
UNION ALL
SELECT * FROM `cyclistic_data.jun_2026`
UNION ALL
SELECT * FROM `cyclistic_data.jul_2026`
UNION ALL
SELECT * FROM `cyclistic_data.aug_2026`
UNION ALL
SELECT * FROM `cyclistic_data.sep_2026`
UNION ALL
SELECT * FROM `cyclistic_data.oct_2026`
UNION ALL
SELECT * FROM `cyclistic_data.nov_2026`
UNION ALL
SELECT * FROM `cyclistic_data.dec_2026`;


-- STEP 2: DATA CLEANING & TRANSFORMATION
-- Removing rows where essential tracking data is missing (Null values)
DELETE FROM total_trips_data
WHERE start_station_name IS NULL 
   OR end_station_name IS NULL 
   OR ride_id IS NULL;

-- Removing technical errors where trip end time is before or equal to start time
DELETE FROM total_trips_data
WHERE ended_at <= started_at;


-- STEP 3: DESCRIPTIVE ANALYSIS
-- Finding the average ride duration (length of ride) for each user type
SELECT member_casual, 
       AVG(ended_at - started_at) AS avg_ride_duration
FROM total_trips_data
GROUP BY member_casual;

-- Counting the total number of rides taken by each user type on different days of the week
-- Note: Day 1 = Sunday, Day 7 = Saturday
SELECT member_casual,
       EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
       COUNT(ride_id) AS total_rides
FROM total_trips_data
GROUP BY member_casual, day_of_week
ORDER BY total_rides DESC;
