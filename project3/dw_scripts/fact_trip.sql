CREATE EXTERNAL TABLE dbo.fact_trip
WITH
(
    LOCATION    = 'fact/fact_trip/',  
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS 
SELECT 
payment_id,
fr.rider_id AS rider_id,
dd.date_id     AS date_id,
amount
FROM dbo.stg_payments sp
JOIN dim_rider fr 
ON sp.rider_id = fr.rider_id
JOIN dim_date dd
ON sp.date = dd.date

