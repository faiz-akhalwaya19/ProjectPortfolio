# ProjectPortfolio
# 📊 SQL Data Cleaning & Exploratory Data Analysis Portfolio
## 🧠 Overview

This repository contains two end-to-end SQL projects focused on **data cleaning and exploratory data analysis (EDA)** using real-world datasets:

1. 🚗 **Car Sales Data Analysis**
2. 📉 **Layoffs Data Analysis**

Each project demonstrates the full data workflow:

* Data cleaning and preprocessing
* Handling duplicates and inconsistencies
* Exploratory data analysis using SQL
* Generating business insights

---

## 🛠️ Tools & Skills Used

* **MySQL**
* SQL (Joins, CTEs, Window Functions)
* Data Cleaning & Transformation
* Exploratory Data Analysis (EDA)
* Analytical Thinking

---

# 🚗 PROJECT 1: Car Sales Data Cleaning & Analysis

## 📊 Objective

To clean and analyse car sales data in order to understand trends in **pricing, mileage, fuel types, and manufacturer performance**.

---

## 🧹 Data Cleaning Process

### 🔹 1. Removing Duplicates

* Created a secondary table (`car_data`) from the raw dataset 
* Used a **CTE with `ROW_NUMBER()`** to identify duplicates:

```sql
ROW_NUMBER() OVER (
PARTITION BY Manufacturer, Model, `Engine size`, `Fuel type`,
             `Year of Manufacture`, Mileage, Price
)
```

* Removed duplicates using a **CTE + subquery workaround** (MySQL limitation)

---

### 🔹 2. Standardising Data

* Trimmed whitespace from manufacturer names
* Checked for invalid values such as:

  * Negative mileage
  * Invalid prices
  * Unrealistic years

---

### 🔹 3. Data Validation

* Identified missing values in key columns
* Ensured consistency across dataset fields

---

## 📊 Exploratory Data Analysis

### 🔍 Key Questions

* Which manufacturers dominate the market?
* How does mileage affect price?
* What is the distribution of car prices?
* Are newer cars significantly more expensive?

---

### 📈 Example Queries

#### 🔹 Price Distribution

```sql
SELECT *
FROM car_data
ORDER BY Price;
```

#### 🔹 Duplicate Check

```sql
SELECT 
    Manufacturer, Model, `Year of Manufacture`, Mileage, Price,
    COUNT(*) AS duplicate_count
FROM car_data
GROUP BY Manufacturer, Model, `Engine size`, `Fuel type`,
         `Year of Manufacture`, Mileage, Price
HAVING COUNT(*) > 1;
```

---

## 🔍 Key Insights

* Car price is strongly influenced by mileage and year
* Certain manufacturers dominate higher price ranges
* Data cleaning significantly improves analysis accuracy

---

# 📉 PROJECT 2: Layoffs Data Cleaning & Analysis

## 📊 Objective

To clean and analyse global layoffs data to uncover trends in **company layoffs, industries, and geographic impact**.

---

## 🧹 Data Cleaning Process

### 🔹 1. Removing Duplicates

* Created staging tables (`layoffs_staging`, `layoffs_staging2`) 
* Used **`ROW_NUMBER()` with CTE** to identify duplicates
* Removed duplicate rows where `row_num > 1`

---

### 🔹 2. Standardising Data

* Trimmed company names
* Standardised industry labels (e.g., “Crypto%” → “Crypto”)
* Cleaned country names (removed trailing punctuation)
* Converted date format using `STR_TO_DATE()`
* Changed column type to `DATE`

---

### 🔹 3. Handling Missing Values

* Replaced blank values with `NULL`
* Used **self-joins** to populate missing industry values
* Removed rows with insufficient data

---

### 🔹 4. Data Reduction

* Dropped helper column (`row_num`)
* Removed invalid records

---

## 📊 Exploratory Data Analysis

### 🔍 Key Questions

* Which companies had the highest layoffs?
* Which industries were most affected?
* Which countries experienced the most layoffs?
* How did layoffs change over time?

---

### 📈 Example Queries

#### 🔹 Total Layoffs by Company

```sql
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
```

#### 🔹 Layoffs by Industry

```sql
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
```

#### 🔹 Rolling Monthly Layoffs (Advanced)

```sql
SUM(total_off) OVER (ORDER BY month)
```

#### 🔹 Top Companies Per Year (Ranking)

```sql
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC)
```

---

## 🔍 Key Insights

* A small number of companies account for the majority of layoffs
* The tech industry is heavily impacted
* Layoffs trends show clear peaks during certain periods
* Geographic concentration exists in layoffs data

---

# 📁 Repository Structure

```
/sql-data-projects
│── Car Sales Data Cleaning.sql
│── Car Sales EDA.sql
│── Layoffs Data Cleaning.sql
│── Layoffs EDA.sql
│── README.md
```

---

# 🚀 Skills Demonstrated

* Data Cleaning & Preprocessing
* SQL Window Functions (`ROW_NUMBER`, `DENSE_RANK`)
* Common Table Expressions (CTEs)
* Data Transformation
* Data Validation
* Business Insight Generation

---

# 📌 Conclusion

These projects demonstrate the ability to:

* Work with raw, unstructured datasets
* Apply structured data cleaning techniques
* Use SQL to generate meaningful insights
* Solve real-world data problems

They reflect practical skills required for roles in:

* **Data Analytics**
* **Data Science**
* **Business Intelligence**
