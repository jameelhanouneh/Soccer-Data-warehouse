# ⚽ Soccer Data Warehouse & Analytics Project

## 📌 Overview

This project demonstrates the design and implementation of a modern data warehouse solution for soccer data using a multi-layer architecture approach (Bronze, Silver, Gold).

The goal was to transform raw CSV files into structured, analytics-ready datasets that support reporting and performance analysis.

The project follows industry best practices in:

- Data ingestion
- Data cleaning and transformation
- Data modeling
- Data mart creation

---

## 🎯 Objectives

- Build a structured data warehouse from raw soccer datasets
- Apply ETL processes using SQL Server
- Implement Medallion Architecture (Bronze → Silver → Gold)
- Create analytical views for business intelligence and reporting

---

## 📂 Dataset

The dataset consists of **10 CSV files** containing soccer-related data such as:

- Teams
- Players
- Coaches
- Matches
- Scores
- Standings
- Stadiums
- Leagues
- Seasons
- Referees

---

## 🏗️ Data Architecture

The project follows a layered architecture approach to ensure scalability and maintainability.

<img width="991" height="561" alt="Data Architecture" src="https://github.com/user-attachments/assets/6863d5af-b0f2-44c6-b53f-f51dda88eda8" />


---

## 🔄 Data Pipeline

The ETL pipeline was implemented in three stages:

### 🥉 Bronze Layer — Raw Data

- Created database tables matching the CSV structure
- Loaded raw data without transformation
- Preserved original data integrity

### 🥈 Silver Layer — Cleaned Data

- Handled missing values
- Standardized formats
- Fixed inconsistent records
- Applied business rules and transformations

### 🥇 Gold Layer — Data Marts

- Built analytical views
- Joined related entities
- Optimized for reporting and analysis

<img width="927" height="602" alt="DataFlow" src="https://github.com/user-attachments/assets/c72cda2c-ab77-40ec-8223-acc18097247c" />


<img width="2318" height="769" alt="Data integration" src="https://github.com/user-attachments/assets/d181d5b2-5027-4644-9548-89bbe8fa99e6" />


---

## 📊 Data Modeling (Gold Layer)

Four analytical views were created to support business intelligence:

### 🔹 Teams Dimension View

Includes:

- Teams
- Coaches
- Stadiums
- Leagues

### 🔹 Standings Fact View

Includes:

- Standings
- Seasons
- Leagues

### 🔹 Matches Fact View

Includes:

- Matches
- Scores
- Seasons

### 🔹 Players Dimension View

Includes:

- Players information

<img width="862" height="776" alt="DataMarts " src="https://github.com/user-attachments/assets/361f5005-7b90-4880-940e-a5f276b04866" />


---

## 🛠️ Technologies Used

- Microsoft SQL Server
- T-SQL
- Data Warehousing Concepts
- ETL Processes
- Dimensional Modeling


---

## 🚀 Key Skills Demonstrated

- Data Warehouse Design
- ETL Development
- Data Cleaning & Transformation
- SQL Optimization
- Dimensional Modeling
- Analytical Data Preparation

---

## 🔮 Future Improvements

- Add Power BI dashboards
- Implement incremental data loading
- Automate ETL pipeline
- Add stored procedures for orchestration

---

## 👤 Author

Jameel Hanouneh  
Data Analyst | Data Engineer Enthusiast


