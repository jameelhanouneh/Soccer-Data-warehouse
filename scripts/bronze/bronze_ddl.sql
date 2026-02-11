/*===============================================================================
  Script:        bronze_ddl.sql
  Project:       Soccer Data Warehouse
  Layer:         Bronze (Raw Data Layer)

  Description:
      This script creates all Bronze layer tables used for storing raw ingested
      soccer data. The Bronze layer represents the landing zone of the data
      warehouse, where source data is stored in its original structure with
      minimal or no transformation.

  ⚠️ WARNING:
      This script DROPS existing Bronze tables before recreating them.
      Running this script will permanently delete all data currently stored
      in the listed tables.

      Make sure:
      • You have backups if the data is needed
      • The script is not executed in a production environment unintentionally

  Tables Created:
      • coaches
      • leagues
      • matches
      • players
      • referees
      • scores
      • seasons
      • stadiums
      • standings
      • teams

  Notes:
      • Data types reflect raw source structure (CSV files)
      • Data cleansing and transformations will be handled in the Silver layer
      • No constraints or relationships are enforced at this stage

  Author:        Jameel Hanouneh.
  Tools Used:    Microsoft SQL Server (T-SQL)
===============================================================================*/

--================= Create table coaches ====================
IF OBJECT_ID('bronze.coaches', 'U') IS NOT NULL
DROP TABLE bronze.coaches
CREATE TABLE bronze.coaches(coache_id INT,
							name NVARCHAR(50),
							team_id INT,
							nationality NVARCHAR(50))

--================= Create table leagues ====================
IF OBJECT_ID('bronze.leagues', 'U') IS NOT NULL
DROP TABLE bronze.leagues
CREATE TABLE bronze.leagues(league_id INT,
							name NVARCHAR(50),
							country NVARCHAR(50),
							country_id INT,
							icon_url NVARCHAR(255),
							cl_spot INT,
							uel_spot INT,
							relegation_spot INT)


--================= Create table matches ====================
IF OBJECT_ID('bronze.matches', 'U') IS NOT NULL
DROP TABLE bronze.matches
CREATE TABLE bronze.matches(match_id INT,
							season_id INT,
							league_id INT,
							matchday INT,
							home_team_id INT,
							away_team_id INT,
							winner NVARCHAR(50),
							utc_date DATE

)
	

--================= Create table players ====================
IF OBJECT_ID('bronze.players', 'U') IS NOT NULL
DROP TABLE bronze.players
CREATE TABLE bronze.players(player_id INT,
							team_id INT,
							name NVARCHAR(50),
							position NVARCHAR(50),
							date_of_birth DATE,
							nationality NVARCHAR(50)
)
	
--================= Create table referees ====================
IF OBJECT_ID('bronze.referees', 'U') IS NOT NULL
DROP TABLE bronze.referees
CREATE TABLE bronze.referees(referee_id INT,
							name NVARCHAR(50),
							nationality NVARCHAR(50)
)

--================= Create table scores ====================
IF OBJECT_ID('bronze.scores', 'U') IS NOT NULL
DROP TABLE bronze.scores
CREATE TABLE bronze.scores(score_id INT,
							match_id INT,
							full_time_home INT,
							full_time_away INT,
							half_time_home INT,
							half_time_away INT
)

--================= Create table seasons ====================
IF OBJECT_ID('bronze.seasons', 'U') IS NOT NULL
DROP TABLE bronze.seasons
CREATE TABLE bronze.seasons(season_id INT,
							league_id INT,
							year NVARCHAR(50)
)

--================= Create table stadiums ====================
IF OBJECT_ID('bronze.stadiums', 'U') IS NOT NULL
DROP TABLE bronze.stadiums
CREATE TABLE bronze.stadiums(stadium_id INT,
							name NVARCHAR(255),
							location NVARCHAR(255),
							capacity VARCHAR(20) NULL
)
	
--================= Create table standings ====================
IF OBJECT_ID('bronze.standings', 'U') IS NOT NULL
DROP TABLE bronze.standings
CREATE TABLE bronze.standings(
								standing_id INT,
								season_id INT,
								league_id INT,
								position INT,
								team_id INT,
								played_games INT,
								won INT,
								draw INT,
								lost INT,
								points INT,
								goals_for INT,
								goals_against INT,
								goal_difference INT,
								form NVARCHAR(50)

)

--================= Create table teams ====================
IF OBJECT_ID('bronze.teams', 'U') IS NOT NULL
DROP TABLE bronze.teams
CREATE TABLE bronze.teams(team_id INT,
						  name NVARCHAR(50),
						  founded_year NVARCHAR(50),
						  stadium_id INT,
						  league_id INT,
						  coach_id INT,
						  cresturl NVARCHAR(100)
)
	
