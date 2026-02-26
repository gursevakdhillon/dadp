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
date,
amount,
rider_id
FROM dbo.stg_payments 
