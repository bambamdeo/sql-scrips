--size of all tables in database

SELECT 
    t.NAME AS TableName,
    s.Name AS SchemaName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB,
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB,
    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UnusedSpaceMB
FROM sys.tables t
INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE t.NAME NOT LIKE 'dt%' AND t.is_ms_shipped = 0 AND i.OBJECT_ID > 255 
GROUP BY t.Name, s.Name, p.Rows
ORDER BY t.Name


-------------or---------------
exec sp_MSForEachTable 'exec sp_spaceused [?]'

--***************************************************************************************************
--find stored procedures containing word 'Foo'


SELECT ROUTINE_NAME, ROUTINE_DEFINITION 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE '%Foo%' AND ROUTINE_TYPE='PROCEDURE'
    
SELECT OBJECT_NAME(id) 
FROM SYSCOMMENTS 
WHERE [text] LIKE '%Foo%' AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
GROUP BY OBJECT_NAME(id)
    
SELECT OBJECT_NAME(object_id) 
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1 AND definition LIKE '%Foo%'


SELECT schema_name(o.schema_id) as Scehma, o.Name, o.type 
FROM sys.sql_modules m
INNER JOIN sys.objects o ON o.object_id = m.object_id
WHERE m.definition like '%Foo%'




