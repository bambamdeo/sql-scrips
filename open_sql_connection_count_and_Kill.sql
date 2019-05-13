SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame
    
    
--Open Connections on a database
SELECT S.spid, login_time, last_batch, status, hostname, program_name, cmd,
(
      select text from sys.dm_exec_sql_text(S.sql_handle)
) as last_sql
FROM sys.sysprocesses S
where dbid > 0
and DB_NAME(dbid) = 'hipaadb-qa'
order by last_batch asc    


--kill all open connections on a database
DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('hipaadb-qa')
print @kill
--EXEC(@kill);
