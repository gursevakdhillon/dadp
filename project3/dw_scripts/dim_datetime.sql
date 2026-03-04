-- Drop metadata only (files remain in storage)
IF OBJECT_ID('dbo.dim_datetime', 'U') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_datetime;

CREATE EXTERNAL TABLE dbo.dim_datetime
WITH
(
    LOCATION    = 'dim/dim_datetime_parquet/run_20260304_3/', -- use NEW folder per run
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS
WITH raw_dt AS
(
    -- Collect all timestamps that exist in the fact table
    SELECT CAST(start_at AS datetime2(0)) AS dt FROM dbo.stg_trip
    UNION ALL
    SELECT CAST(ended_at AS datetime2(0))  AS dt FROM dbo.stg_trip WHERE ended_at IS NOT NULL
),
dedup AS
(
    SELECT DISTINCT dt
    FROM raw_dt
    WHERE dt IS NOT NULL
)
SELECT
    -- Surrogate key: yyyyMMddHHmmss (as bigint)
    CONVERT(bigint, FORMAT(dt, 'yyyyMMddHHmmss')) AS datetime_id,

    -- Helpful join keys
    CONVERT(int, FORMAT(dt, 'yyyyMMdd'))          AS date_id,
    CONVERT(int, FORMAT(dt, 'HHmmss'))            AS time_id,
    -- Natural datetime
    dt                                            AS date_time,
    -- Common attributes
    CAST(dt AS date)                              AS [date],
    DATEPART(year, dt)                            AS [year],
    DATEPART(quarter, dt)                         AS [quarter],
    DATEPART(month, dt)                           AS [month],
    DATEPART(day, dt)                             AS [day],
    DATEPART(hour, dt)                            AS [hour],
    DATEPART(minute, dt)                          AS [minute],
    DATEPART(second, dt)                          AS [second],
    DATENAME(weekday, dt)                         AS day_name,
    DATEPART(weekday, dt)                         AS day_of_week, -- depends on DATEFIRST
    DATEPART(ISO_WEEK, dt)                        AS iso_week
FROM dedup;
