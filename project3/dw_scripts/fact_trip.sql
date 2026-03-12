CREATE EXTERNAL TABLE dbo.fact_trip
WITH
(
    LOCATION    = 'fact/fact_trip/',  
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS 
SELECT
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
JOIN dim_datetime dd
ON CAST(st.start_at AS date) = dd.date
JOIN dbo.dim_rider r
ON st.rider_id  = r.rider_id
JOIN dim_station ds_start
ON  st.start_station_id = ds_start.station_id
JOIN dim_station ds_end
ON st.end_station_id = ds_end.station_id

