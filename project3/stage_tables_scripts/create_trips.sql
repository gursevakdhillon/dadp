CREATE EXTERNAL TABLE [dbo].[stg_trip] (
	[trip_id] nvarchar(400),
	[rideable_type] nvarchar(400),
	[start_at] datetime2(0),
	[ended_at] datetime2(0),
	[start_station_id] nvarchar(400),
	[end_station_id] nvarchar(400),
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'public.trip.txt',
	DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM [dbo].[stg_trip]
GO
