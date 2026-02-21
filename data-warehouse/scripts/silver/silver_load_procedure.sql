/*===============================================================================
  Description:
      This stored procedure loads and transforms data from the Bronze layer
      (raw ingestion layer) into the Silver layer (cleaned and standardized layer).

      The Silver layer performs:
      - Data cleaning (TRIM, NULL handling, COALESCE)
      - Data standardization
      - Type conversions
      - Business rule corrections
      - Basic data quality fixes

      Each table in the Silver schema is:
      1. Truncated
      2. Reloaded with transformed data from Bronze

  ⚠ WARNING:
      This procedure uses TRUNCATE TABLE on all Silver tables.
      Running this procedure will permanently delete existing Silver data
      before reloading it.

      Ensure:
      - Bronze layer is fully loaded
      - No downstream process is currently consuming Silver data
      - This is not executed unintentionally in production
  Features:
      - Execution time tracking per table
      - Total load duration tracking
      - TRY/CATCH error handling
      - Basic data quality corrections

  Author:        Jameel Hanouneh
===============================================================================*/
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @total_start_time DATETIME, @total_end_time DATETIME
	BEGIN TRY
		SET @total_start_time = GETDATE()
		PRINT'--------------------------------';
		PRINT'>>Loading Silver Layer';
		PRINT'--------------------------------';

		--INSERTING CLEAN DATA INTO coaches Table:
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.coaches';
		TRUNCATE TABLE silver.coaches
		PRINT'>>Inserting Data into table silver.coaches';
		INSERT INTO silver.coaches(
			coache_id,
			name,
			team_id,
			nationality
		)
		SELECT 
			coache_id,
			name AS coache_name,
			team_id,
			COALESCE(nationality, 'N/A') AS nationality
		FROM bronze.coaches
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===============================Table:silver.leagues================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.leagues';
		TRUNCATE TABLE silver.leagues
		PRINT'>>Inserting Data into table silver.leagues';
		--Inserting clean data into leagues Table:
		INSERT INTO silver.leagues(
			league_id,
			name,
			country,
			country_id,
			cl_spot,
			uel_spot,
			relegation_spot
		)
		SELECT
			league_id,
			TRIM(name) AS league_name,
			TRIM(country) AS country,
			country_id,
			cl_spot,
			uel_spot,
			relegation_spot
		FROM bronze.leagues
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.matches================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.matches';
		TRUNCATE TABLE silver.matches
		PRINT'>>Inserting Data into table silver.matches';
		--Inserting clean data into matches Table:
		INSERT INTO silver.matches(
			match_id,
			season_id,
			league_id,
			matchday,
			home_team_id,
			away_team_id,
			winner,
			utc_date
		)
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
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.players================================

		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.players';
		TRUNCATE TABLE silver.players
		PRINT'>>Inserting Data into table silver.players';
		--Inserting clean data into players Table:
		INSERT INTO silver.players(
			player_id,
			team_id,
			name,
			position,
			date_of_birth,
			nationality
		)
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
			END  AS birth_date,
			nationality
		FROM bronze.players
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.referees================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.referees';
		TRUNCATE TABLE silver.referees
		PRINT'>>Inserting Data into table silver.referees';
		--Inserting clean data into referees Table:
		INSERT INTO silver.referees(
			referee_id,
			name,
			nationality
				)
		SELECT
			referee_id,
			TRIM(name) AS referee_name,
			CASE WHEN nationality = 'null' THEN 'N/A'
				 ELSE nationality
			END AS nationality
		FROM bronze.referees
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.scores================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.scores';
		TRUNCATE TABLE silver.scores
		PRINT'>>Inserting Data into table silver.scores';
		--Inserting clean data into scores Table:
		INSERT INTO silver.scores(
			score_id,
			match_id,
			full_time_home,
			full_time_away,
			half_time_home,
			half_time_away
		)
		SELECT
			score_id,
			match_id,
			full_time_home,
			full_time_away,
			half_time_home,
			half_time_away
		FROM bronze.scores
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.seasons================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.seasons';
		TRUNCATE TABLE silver.seasons
		PRINT'>>Inserting Data into table silver.seasons';
		--Inserting clean data into scores Table:
		INSERT INTO silver.seasons(
			season_id,
			league_id,
			year
		)
		SELECT
			season_id,
			league_id,
			year
		FROM bronze.seasons
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.stadiums================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.stadiums';
		TRUNCATE TABLE silver.stadiums
		PRINT'>>Inserting Data into table silver.stadiums';
		--Inserting clean data into stadiums Table:
		INSERT INTO silver.stadiums(
			stadium_id,
			name,
			location,
			capacity)
		SELECT
			stadium_id,
			TRIM(name) stadium_name,
			location,
			COALESCE(capacity, 'N/A') AS capacity
		FROM bronze.stadiums
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.standings================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.standings';
		TRUNCATE TABLE silver.standings
		PRINT'>>Inserting Data into table silver.standings';
		--Inserting clean data into standings Table:
		INSERT INTO silver.standings(
			standing_id,
			season_id,
			league_id,
			position,
			team_id,
			played_games,
			won,
			draw,
			lost,
			points,
			goals_for,
			goals_against,
			goal_difference,
			form
		)
		SELECT
			standing_id,
			season_id,
			league_id,
			position,
			team_id,
			played_games,
			won,
			draw,
			lost,
			points,
			goals_for,
			goals_against,
			goal_difference,
			form
		FROM bronze.standings
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		--===================================Table silver.teams================================
		SET @start_time = GETDATE()
		PRINT'>>Truncating table silver.teams';
		TRUNCATE TABLE silver.teams
		PRINT'>>Inserting Data into table silver.teams';
		--Inserting clean data into teams Table:
		INSERT INTO silver.teams(
			team_id,
			name,
			founded_year,
			stadium_id,
			league_id,
			coach_id
		)
		SELECT
			team_id,
			TRIM(name) team_name,
			COALESCE(DATEFROMPARTS(CAST(CAST(founded_year AS FLOAT) AS INT),1,1), '9999') AS founded_date,
			stadium_id,
			league_id,
			coach_id
		FROM bronze.teams
		SET @end_time = GETDATE()
		PRINT'-----------------------------';
		PRINT'>>Duration time: '+CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR)+' Seconds';
		PRINT'-----------------------------';

		SET @total_end_time = GETDATE();
		PRINT'>>Loading Silver layer is completed';
		PRINT '>> Total Load Duration: '+CAST(DATEDIFF(SECOND,@total_start_time, @total_end_time)AS NVARCHAR)+ ' Second';
		PRINT '---------------------';
	END TRY
	BEGIN CATCH
		PRINT'============================================='
		PRINT'ERROR occured during loading Silver layer';
		PRINT'Error Message'+ERROR_MESSAGE();
		PRINT'Error Number'+CAST(ERROR_NUMBER()AS NVARCHAR);
		PRINT'Error State'+CAST(ERROR_STATE()AS NVARCHAR);
		PRINT'=============================================';
	END CATCH
END


