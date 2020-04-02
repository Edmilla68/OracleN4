SELECT execquery.last_execution_time AS "Date Time", execsql.text AS "Script"


select * FROM sys.dm_exec_query_stats ;

AS execquery
CROSS APPLY sys.dm_exec_sql_text(execquery.sql_handle) AS execsql
ORDER BY execquery.last_execution_time DESC;

SELECT * FROM v$sql
where TO_DATE(first_load_time, 'YYYY-MM-DD HH24:MI:SS')  BETWEEN
TO_DATE('2020-03-13 16:25:00', 'YYYY-MM-DD HH24:MI:SS') AND 
TO_DATE('2020-03-13 16:30:00', 'YYYY-MM-DD HH24:MI:SS') ;
