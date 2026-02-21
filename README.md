#🚀 End-to-End Data Warehouse, Analytics & BI Project

## 📌 Overview

This project demonstrates an end-to-end data solution covering the complete analytics pipeline:

Raw Data → Data Warehouse → Analytics → Power BI Dashboard

The project transforms raw CSV soccer datasets into structured, analytics-ready data using SQL Server, followed by analytical reporting and interactive visualization using Power BI.

It follows modern data engineering and business intelligence best practices including:

- Data ingestion and ETL pipelines
- Medallion Architecture (Bronze → Silver → Gold)
- Dimensional data modeling
- Analytical SQL reporting
- Interactive BI dashboards

The goal is to simulate a real-world data workflow from data engineering to business intelligence delivery.

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
- Power BI
- Data Warehousing Concepts
- ETL Processes
- Dimensional Modeling
- Data Visualization


---

## 🚀 Key Skills Demonstrated

- End-to-End Data Pipeline Development
- Data Warehouse Architecture (Bronze, Silver, Gold)
- ETL Development & Data Transformation
- Dimensional Modeling
- Analytical SQL & KPI Development
- Data Visualization with Power BI
- Drill-Through & Interactive Reporting
- Business Insights Generation

---

## 📊 Power BI Dashboard

The final stage of the project focuses on business intelligence and visualization using Power BI.

The dashboard connects to the Gold Layer of the data warehouse to provide interactive insights into league and team performance.

### Key Features

- KPI overview (Goals, Wins, Draws, Teams)
- League performance comparison
- Team rankings and statistics
- Drill-through functionality for detailed league analysis
- Interactive filters and slicers

### Dashboard Overview

![Leagues Dashboard](powerbi/images/Page 1.PNG)

This page provides a high-level summary of performance across leagues.

### Drill-Through Analysis

![League Drillthrough](powerbi/images/Page 2.PNG)

Users can drill into a selected league to analyze team-level metrics such as points, wins, goals, and rankings.

---

## 👤 Author

Jameel Hanouneh  
Data Analyst | Data Engineer Enthusiast


