CREATE EXTERNAL TABLE dbo.fact_payment
WITH
(
    LOCATION    = 'fact/fact_payment/',  
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS 
SELECT
SUBSTRING(trip_id,2,LEN(trip_id) -2) AS trip_id,
SUBSTRING(rideable_type,2,LEN(rideable_type)-2) AS rideable_type,
start_at AS started_at,
ended_at AS ended_at,
DATEDIFF(MINUTE, start_at,ended_at) AS trip_duration,
SUBSTRING(start_station_id,2, LEN(start_station_id)) AS start_station_id,
SUBSTRING(end_station_id,2,LEN(end_station_id)) AS end_station_id,
r.rider_id,
DATEDIFF(YEAR,birthday,start_at) AS rider_age
FROM dbo.stg_trip t
LEFT JOIN dbo.stg_rider r
ON t.rider_id  = r.rider_id
