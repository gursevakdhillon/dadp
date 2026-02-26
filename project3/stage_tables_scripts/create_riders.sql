CREATE EXTERNAL TABLE [dbo].[stg_rider] (
	[rider_id] bigint,
	[first] nvarchar(400),
	[last] nvarchar(400),
	[address] nvarchar(400),
	[birthday] datetime2(0),
	[account_start_date] datetime2(0),
	[account_end_date] datetime2(0),
	[is_member] bit
	)
	WITH (
	LOCATION = 'public.rider.txt',
	DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO

SELECT TOP 100 * FROM [dbo].[stg_rider]
GO
