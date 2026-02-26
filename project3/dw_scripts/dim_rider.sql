CREATE EXTERNAL TABLE dbo.dim_rider
WITH
(
    LOCATION    = 'dim/dim_rider/',   -- choose a NEW folder if rerun
    DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
    FILE_FORMAT = [SynapseParquetFormat]
)
AS 
SELECT 
rider_id,
(SUBSTRING(first,2,LEN(first)-2) + ' ' +  SUBSTRING(last,2,LEN(last)-2)) AS name,
(SUBSTRING(address,2,LEN(address) -2)) AS address, 
birthday,
DATEDIFF(YEAR, birthday, getdate()) AS age,
DATEDIFF(YEAR, birthday, account_start_date) AS age_when_joined,
is_member
FROM dbo.stg_rider
