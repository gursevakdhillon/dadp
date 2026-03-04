CREATE EXTERNAL TABLE dbo.fact_payment
WITH
(
    LOCATION    = 'fact/fact_payment/',  
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS 
SELECT TOP 100
SUBSTRING(trip_id,2,LEN(trip_id) -2) AS trip_id,
dd.date_id,
r.rider_id,
SUBSTRING(start_station_id,2, LEN(start_station_id)) AS start_station_id,
SUBSTRING(end_station_id,2,LEN(end_station_id)) AS end_station_id,
SUBSTRING(rideable_type,2,LEN(rideable_type)-2) AS rideable_type,
DATEDIFF(YEAR,birthday,start_at) AS rider_age,
start_at AS started_at,
ended_at AS ended_at,
DATEDIFF(MINUTE, start_at,ended_at) AS trip_duration
FROM dbo.stg_trip st
LEFT JOIN dim_datetime dd
ON st.start_at = dd.date_time
LEFT JOIN dbo.stg_rider r
ON st.rider_id  = r.rider_id
LEFT JOIN dim_station ds
ON  (st.start_station_id = ds.station_id AND st.end_station_id = ds.station_id )
