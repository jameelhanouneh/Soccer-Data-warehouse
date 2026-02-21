/*===============================================================================
  Script:        silver_cleaning.sql
  Project:       Soccer Data Warehouse
  Layer:         Silver (Data Cleaning & Standardization)

  Description:
      This script performs data cleaning and transformation on raw data 
      loaded into the Bronze layer. The goal is to standardize, correct, 
      and enrich the data before moving it to the Gold analytical layer.

  Cleaning Operations Performed:
      • Trimming leading/trailing spaces from text columns
      • Handling NULL and missing values using COALESCE
      • Standardizing categorical values (e.g., player positions)
      • Correcting incorrect or corrupted dates
      • Converting text-based numeric values into proper date formats
      • Renaming columns for clarity and consistency

  Output:
      Cleaned and structured datasets ready for transformation into
      dimension and fact tables in the Gold layer.

  Author:        Jameel Hanouneh.
  Tools Used:    Microsoft SQL Server (T-SQL)
===============================================================================*/

--Cleaning coaches Table:
SELECT 
		coache_id,
		name,
		team_id,
		COALESCE(nationality, 'N/A') AS nationality
FROM bronze.coaches


--Cleaning leagues Table:
SELECT
	league_id,
	TRIM(name) AS name,
	TRIM(country) AS country,
	country_id,
	cl_spot,
	uel_spot,
	relegation_spot
FROM bronze.leagues

--Cleaning matches table:
SELECT 
		match_id,
		season_id,
		league_id,
		matchday,
		home_team_id,
		away_team_id,
		winner,
		utc_date
FROM bronze.matches

--Cleaning players table:
SELECT
		player_id,
		team_id,
		TRIM(name) AS player_name,
		CASE WHEN position = 'Offence'THEN 'Attacker'
			 ELSE position
		END AS postiton,

		CASE WHEN date_of_birth = '2027-06-30' THEN '2004-07-14'
			 WHEN date_of_birth = '2026-06-30' THEN '2005-01-04'
			 WHEN date_of_birth = '2023-06-30' THEN '1993-02-19'
			 ELSE date_of_birth
		END  AS birth_date
FROM bronze.players


-- Cleaning Table: referees
SELECT
	referee_id,
	TRIM(name) AS referee_name,
	CASE WHEN nationality = 'null' THEN 'N/A'
		 ELSE nationality
	END AS nationality
FROM bronze.referees

-- Cleaning Table:scores
SELECT
	*
FROM bronze.scores

-- Cleaning Table:seasons
SELECT
	*
FROM bronze.seasons

-- Cleaning Table:stadiums
SELECT
	stadium_id,
	TRIM(name) stadium_name,
	location,
	COALESCE(capacity, 'N/A') AS capacity
FROM bronze.stadiums
-- Cleaning Table:standings
SELECT
	*
FROM bronze.standings

--Cleaning Table: teams
SELECT
	team_id,
	TRIM(name) team_name,
	COALESCE(DATEFROMPARTS(CAST(CAST(founded_year AS FLOAT) AS INT),1,1), '9999') AS founded_date,
	stadium_id,
	league_id,
	coach_id
FROM bronze.teams


 

