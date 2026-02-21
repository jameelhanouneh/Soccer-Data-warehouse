/*===============================================================================
  Script:        bronze_load_procedure.sql
  Project:       Soccer Data Warehouse
  Layer:         Bronze (Raw Data Ingestion)

  Description:
      This stored procedure loads raw CSV data files into the Bronze layer
      tables using BULK INSERT. The Bronze layer stores data in its original
      format with minimal transformation, serving as the landing zone for
      all source files.

  ⚠️ WARNING:
      This procedure uses TRUNCATE TABLE on all Bronze tables before loading.
      Running this procedure will permanently delete any existing data in
      those tables. Make sure the source files are correct and complete
      before execution.

  Key Features:
      • Truncates Bronze tables before each load to ensure fresh ingestion
      • Uses BULK INSERT for efficient high-volume data loading
      • Supports CSV format with delimiters and UTF-8 encoding where needed
      • Tracks load duration for each table and the full process
      • Includes TRY...CATCH error handling for monitoring failures

  Data Sources:
      Local CSV files representing soccer datasets such as:
      coaches, leagues, matches, players, referees, scores,
      seasons, stadiums, standings, and teams

  Output:
      Fully reloaded Bronze layer tables ready for cleaning and transformation
      in the Silver layer.

  Author:        Jameel Hanouneh.
  Tools Used:    Microsoft SQL Server (T-SQL, BULK INSERT)
===============================================================================*/



CREATE PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @start_time     DATETIME,
                @end_time       DATETIME,
                @starting_time  DATETIME,
                @ending_time    DATETIME;

        SET @starting_time = GETDATE();

        -------------------------------------------------
        -- COACHES
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: coaches';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.coaches;

        BULK INSERT bronze.coaches
        FROM 'C:\Users\DELL\Desktop\soccer dataset\coaches.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- LEAGUES
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: leagues';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.leagues;

        BULK INSERT bronze.leagues
        FROM 'C:\Users\DELL\Desktop\soccer dataset\leagues.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- MATCHES
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: matches';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.matches;

        BULK INSERT bronze.matches
        FROM 'C:\Users\DELL\Desktop\soccer dataset\matches.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- PLAYERS
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: players';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.players;

        BULK INSERT bronze.players
        FROM 'C:\Users\DELL\Desktop\soccer dataset\players.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- REFEREES
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: referees';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.referees;

        BULK INSERT bronze.referees
        FROM 'C:\Users\DELL\Desktop\soccer dataset\referees.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- SCORES
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: scores';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.scores;

        BULK INSERT bronze.scores
        FROM 'C:\Users\DELL\Desktop\soccer dataset\scores.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- SEASONS
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: seasons';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.seasons;

        BULK INSERT bronze.seasons
        FROM 'C:\Users\DELL\Desktop\soccer dataset\seasons.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- STADIUMS (Special CSV Handling)
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: stadiums';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.stadiums;

        BULK INSERT bronze.stadiums
        FROM 'C:\Users\DELL\Desktop\soccer dataset\stadiums.csv'
        WITH (
            FIRSTROW = 2,
            FORMAT = 'CSV',
            FIELDQUOTE = '"',
            CODEPAGE = '65001',
            KEEPNULLS,
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- STANDINGS
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: standings';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.standings;

        BULK INSERT bronze.standings
        FROM 'C:\Users\DELL\Desktop\soccer dataset\standings.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- TEAMS
        -------------------------------------------------
        PRINT '---------------';
        PRINT 'TABLE: teams';
        PRINT '---------------';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.teams;

        BULK INSERT bronze.teams
        FROM 'C:\Users\DELL\Desktop\soccer dataset\teams.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -------------------------------------------------
        -- TOTAL DURATION
        -------------------------------------------------
        SET @ending_time = GETDATE();
        PRINT '=============================================';
        PRINT 'Total bronze load duration: ' 
              + CAST(DATEDIFF(SECOND, @starting_time, @ending_time) AS NVARCHAR) 
              + ' seconds';
        PRINT '=============================================';

    END TRY
    BEGIN CATCH
        PRINT '=============================================';
        PRINT 'ERROR occurred during bronze load';
        PRINT 'Message: ' + ERROR_MESSAGE();
        PRINT 'Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'State  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=============================================';
    END CATCH
END;
