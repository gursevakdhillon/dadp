
-- Serverless SQL pool CETAS: create dim_date in Parquet

-- IMPORTANT: CETAS won't overwrite. Use a new folder if rerunning.
DROP EXTERNAL TABLE dbo.dim_date;  -- drop metadata only (files remain)

CREATE EXTERNAL TABLE dbo.dim_date
WITH
(
    LOCATION    = 'dim/dim_date_parquet/',   -- choose a NEW folder if rerun
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS
WITH bounds AS
(
    SELECT
        CAST(MIN(start_at) AS date) AS min_dt,
        CAST(MAX(ended_at) AS date) AS max_dt
    FROM dbo.stg_trip
),
-- Build a tally table 0..99999 using only VALUES + CROSS JOIN
d0 AS (SELECT v.n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)),
d1 AS (SELECT 10*a.n + b.n AS n FROM d0 a CROSS JOIN d0 b),                  -- 0..99
d2 AS (SELECT 100*a.n + b.n AS n FROM d1 a CROSS JOIN d1 b),                 -- 0..9999
d3 AS (SELECT 10000*a.n + b.n AS n FROM d2 a CROSS JOIN d1 b),               -- 0..99999
dates AS
(
    SELECT DATEADD(day, t.n, b.min_dt) AS d
    FROM bounds b
    JOIN d3 t
      ON t.n <= DATEDIFF(day, b.min_dt, b.max_dt)
)
SELECT
    CONVERT(int, CONVERT(char(8), d, 112))                                          AS date_id,
    CAST(d AS date)                                                                 AS [date],
    DATEPART(day, d)                                                                AS [day],
    DATENAME(weekday, d)                                                            AS day_name,
    DATEPART(weekday, d)                                                            AS day_of_week,     -- depends on DATEFIRST
    DAY(d)                                                                          AS day_of_month,
    DATEDIFF(day, DATEADD(quarter, DATEDIFF(quarter, 0, d), 0), d) + 1             AS day_of_quarter,
    DATEPART(ISO_WEEK, d)                                                           AS [week],
    DATEPART(month, d)                                                              AS [month],
    DATEPART(QUARTER, d)                                                     AS [quarter],
    DATEPART(year, d)                                                               AS [year]
FROM dates;
