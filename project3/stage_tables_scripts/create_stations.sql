CREATE EXTERNAL TABLE [dbo].[station] (
	[station_id] nvarchar(400),
	[name] nvarchar(400),
	[latitude] float,
	[longitude] float
	)
	WITH (
	LOCATION = 'public.station.txt',
	DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM [dbo].[station]
GO
