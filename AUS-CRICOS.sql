-- Create Database and Activate
CREATE DATABASE CRICOS;
USE CRICOS;

-- Backup Database
BACKUP DATABASE CRICOS TO DISK = 'C:\Users\Admin\Desktop\Data Portfolio\CIRCOS\CRICOS_backup.bak';

-- Query 1: Estimated_Total_Course_Cost <= 10000
SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE
WHERE Estimated_Total_Course_Cost <= 10000;

-- Query 2: Estimated_Total_Course_Cost > 100000
SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE
WHERE Estimated_Total_Course_Cost > 100000;

-- Find the Total number of Institutions
SELECT COUNT(DISTINCT Institution_Name) AS TotalInstitutions
FROM CRICOS_CODE;

-- Find Total Number of Bachelor's Degree, Masters, PhD
SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE
WHERE Course_level LIKE '%bachelor%';

SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE
WHERE Course_level LIKE '%master%';

SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE
WHERE Course_level LIKE '%doctor%';

-- Course Level Frequency
SELECT Course_Level, COUNT(*) AS Course_Level_Count
FROM CRICOS_CODE
GROUP BY Course_Level;

-- Institution with Highest Offerings
SELECT TOP 1 WITH TIES Institution_Name, COUNT(*) AS Offerings_Count
FROM CRICOS_CODE
GROUP BY Institution_Name
ORDER BY Offerings_Count DESC;

-- Institution with the fewest Offerings
SELECT TOP 1 WITH TIES Institution_Name, COUNT(*) AS Offerings_Count
FROM CRICOS_CODE
GROUP BY Institution_Name
ORDER BY Offerings_Count;

-- Total Course Cost Analysis
SELECT 
    MAX(Estimated_Total_Course_Cost) AS MaxTotalCost,
    MIN(Estimated_Total_Course_Cost) AS MinTotalCost,
    AVG(Estimated_Total_Course_Cost) AS AvgTotalCost,
    COUNT(Estimated_Total_Course_Cost) AS TotalCourses,
    SUM(Estimated_Total_Course_Cost) AS TotalCostSum,
    STDEV(Estimated_Total_Course_Cost) AS TotalCostStdDev,
    MAX(Estimated_Total_Course_Cost) - MIN(Estimated_Total_Course_Cost) AS Total_Cost_Range
FROM CRICOS_CODE;

-- Mode of Estimated_Total_Course_Cost
SELECT TOP 1 WITH TIES Estimated_Total_Course_Cost AS Mode, COUNT(*) AS Frequency
FROM CRICOS_CODE
GROUP BY Estimated_Total_Course_Cost
ORDER BY Frequency DESC;

-- Median of Estimated_Total_Course_Cost
SELECT AVG(Estimated_Total_Course_Cost) AS Median
FROM (
    SELECT Estimated_Total_Course_Cost,
    ROW_NUMBER() OVER (ORDER BY Estimated_Total_Course_Cost) AS RowAsc,
    ROW_NUMBER() OVER (ORDER BY Estimated_Total_Course_Cost DESC) AS RowDesc
    FROM CRICOS_CODE
) AS MedianQuery
WHERE RowAsc = RowDesc OR RowAsc + 1 = RowDesc OR RowAsc = RowDesc + 1;

-- Percentage of Work Component
SELECT 
    Work_Component_Total_Hours,
    COUNT(*) AS Frequency,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM CRICOS_CODE)) AS Percentage
FROM CRICOS_CODE
GROUP BY Work_Component_Total_Hours
ORDER BY Work_Component_Total_Hours DESC;

-- Duration Week Analysis
SELECT 
    MAX(Duration_Weeks) AS MaxDurationWeeks,
    MIN(Duration_Weeks) AS MinDurationWeeks,
    AVG(Duration_Weeks) AS AvgDurationWeeks,
    COUNT(Duration_Weeks) AS TotalCourses,
    SUM(Duration_Weeks) AS TotalDurationWeeks,
    STDEV(Duration_Weeks) AS DurationWeeksStdDev,
    MAX(Duration_Weeks) - MIN(Duration_Weeks) AS DurationWeeksRange
FROM CRICOS_CODE;


-- Define the CTE
WITH CTE_CourseCost AS (
    SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
        Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
    FROM CRICOS_CODE
    WHERE Estimated_Total_Course_Cost <= 10000
)

-- Query the CTE and retrieve the results
SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE;



-- Creating View to store data for later visualizations

CREATE VIEW CourseCostView AS
SELECT Institution_Name, CRICOS_Course_Code, Course_Name, Field_of_Education_1_Detailed_Field, Course_Level,
    Work_Component, Work_Component_Total_Hours, Duration_Weeks, Estimated_Total_Course_Cost
FROM CRICOS_CODE;

