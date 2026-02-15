/*===============================================================================
  Script Name:   gold_layer_views.sql
  Layer:         Gold Layer (Business & Analytics Layer)
  Project:       Layered Data Warehouse Architecture

  Description:
      This script creates the Gold layer views of the data warehouse.
      The Gold layer represents the business-ready data model designed
      for reporting, dashboards, and analytical consumption.

      Data in this layer is sourced from the Silver layer (cleaned and
      standardized data) and transformed into meaningful business entities.

      The views combine multiple Silver tables using joins to provide
      enriched, analytics-friendly datasets.

  Architecture Context:
      Bronze Layer  → Raw ingestion (source data)
      Silver Layer  → Cleaned & standardized data
      Gold Layer    → Business-level analytical model (this script)

  Objects Created:
      - gold.teams       → Team business entity with coach, stadium, and league info
      - gold.standings   → Team standings per season with league context
      - gold.matches     → Match results with scores and season information
      - gold.players     → Player dimension with team relationship

  Design Approach:
      - Views are used instead of physical tables to ensure:
            • Real-time consistency with Silver layer
            • Reduced data duplication
            • Simplified maintenance
      - LEFT JOINs are applied to preserve business entities even when
        related records are missing.

  Dependencies:
      This script requires the following Silver tables to exist:
          silver.teams
          silver.coaches
          silver.stadiums
          silver.leagues
          silver.standings
          silver.seasons
          silver.matches
          silver.scores
          silver.players

  Usage:
      These views are intended for:
          • Business Intelligence tools (Power BI, Tableau, etc.)
          • Reporting queries
          • Analytical workloads
          • Data exploration

  Author:        Jameel Hanouneh
===============================================================================*/

--==================================================
-- GOLD VIEW: TEAMS (Dimension View)
--==================================================
IF OBJECT_ID('gold.teams', 'V') IS NOT NULL
DROP VIEW gold.teams;

GO

CREATE VIEW gold.teams AS
SELECT 
	t.team_id,
	t.name AS team_name,
	l.name AS league_name,
	t.founded_year,
	c.name AS coach_name,
	c.nationality AS coach_nationality,
	s.name AS stadium_name,
	s.location,
	s.capacity
FROM silver.teams t
LEFT JOIN silver.coaches c
ON t.coach_id = c.coache_id
LEFT JOIN silver.stadiums s
ON t.stadium_id = s.stadium_id
LEFT JOIN silver.leagues l
ON t.league_id = l.league_id

GO

--================================Creating dimantion table==============================

--==================================================
-- GOLD VIEW: STANDINGS (Fact View)
--==================================================
IF OBJECT_ID('gold.standings', 'V') IS NOT NULL
DROP VIEW gold.standings;

GO

CREATE VIEW gold.standings AS
SELECT 
	s.team_id,
	s.position,
	s.played_games,
	s.won,
	s.draw,
	s.lost,
	s.goals_for,
	s.goals_against,
	s.goal_difference AS goals_difference,
	s.form,
	ss.year,
	l.name AS league_name
FROM silver.standings s
LEFT JOIN silver.leagues l
ON s.league_id = l.league_id
LEFT JOIN silver.seasons ss
ON s.season_id = ss.season_id
GO

--==================================================
-- GOLD VIEW: MATCHES (Fact View)
--==================================================
IF OBJECT_ID('gold.matches', 'V') IS NOT NULL
DROP VIEW gold.matches;

GO
CREATE VIEW gold.matches AS
SELECT 
	m.matchday,
	m.home_team_id,
	m.away_team_id,
	sc.full_time_home,
	sc.full_time_away,
	sc.half_time_home,
	sc.half_time_away,
	winner,
	l.name AS league_name,
	s.year,
	m.utc_date
FROM silver.matches m
LEFT JOIN silver.seasons s
ON m.season_id = s.season_id
LEFT JOIN silver.scores sc
ON m.match_id = sc.match_id
LEFT JOIN silver.leagues l
ON m.league_id = l.league_id
GO

--==================================================
-- GOLD VIEW: PLAYERS (Dimension View)
--==================================================
IF OBJECT_ID('gold.players', 'V') IS NOT NULL
DROP VIEW gold.players;
GO
CREATE VIEW gold.players AS
SELECT 
	team_id,
	name AS player_name,
	position,
	date_of_birth,
	nationality AS player_nationality
FROM silver.players
GO
