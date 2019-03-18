SELECT TOP (25) p.NAME AS [SP Name]
	,qs.total_elapsed_time / qs.execution_count AS [avg_elapsed_time]
	,qs.total_elapsed_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_elapsed_time_seconds]
	,qs.total_elapsed_time
	,qs.total_elapsed_time / cast(1000000 AS FLOAT) AS [total_elapsed_time_seconds]
	,qs.execution_count
	--,ISNULL(qs.execution_count / DATEDIFF(Minute, qs.cached_time, GETDATE()), 0) AS [Calls/Minute]
	,qs.total_worker_time / qs.execution_count AS [AvgWorkerTime]
	,qs.total_worker_time AS [TotalWorkerTime]
	,qs.cached_time
	,qs.min_elapsed_time
	,qs.max_elapsed_time
	,qs.last_elapsed_time
	,qs.min_elapsed_time / cast(1000000 AS FLOAT) AS min_elapsed_time_seconds
	,qs.max_elapsed_time / cast(1000000 AS FLOAT) AS max_elapsed_time_seconds
	,qs.last_elapsed_time / cast(1000000 AS FLOAT) AS last_elapsed_time_seconds
	,qs.plan_handle
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK) ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY avg_elapsed_time DESC
--ORDER BY qs.execution_count DESC
OPTION (RECOMPILE);


/*

select * from  sys.dm_exec_query_plan (0x05000900784D9104105771230100000001000000000000000000000000000000000000000000000000000000)

*/

