CREATE EXTERNAL TABLE [dbo].[stg_payments] (
	[payment_id] bigint,
	[date] datetime2(0),
	[amount] float,
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'public.payment.txt',
	DATA_SOURCE = [divvy-file-system_divvydl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO

SELECT TOP 100 * FROM [dbo].[stg_payments]
GO
