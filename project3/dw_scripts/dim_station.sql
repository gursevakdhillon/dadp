CREATE EXTERNAL TABLE dbo.dim_station
WITH
(
    LOCATION    = 'dim/dim_station/',   -- choose a NEW folder if rerun
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS 
SELECT 
SUBSTRING(station_id,2,LEN(station_id) -2) AS station_id,
(SUBSTRING(name,2,LEN(name)-2)) AS name,
latitude,
longitude
FROM dbo.stg_station
