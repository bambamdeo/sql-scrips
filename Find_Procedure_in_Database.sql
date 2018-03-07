--find stored procedures containing word 'Foo'

SELECT ROUTINE_NAME, ROUTINE_DEFINITION 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE '%Foo%' 
--AND ROUTINE_TYPE='PROCEDURE'
    
--OR

SELECT OBJECT_NAME(object_id), OBJECT_DEFINITION(object_id)
FROM sys.procedures
WHERE OBJECT_DEFINITION(object_id) LIKE '%SearchString%'

--OR

SELECT OBJECT_NAME(id) FROM SYSCOMMENTS 
WHERE [text] LIKE '%Foo%' AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
GROUP BY OBJECT_NAME(id)

--OR

SELECT OBJECT_NAME(object_id) FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1 AND definition LIKE '%Foo%'

--OR

SELECT schema_name(o.schema_id) as Scehma, o.Name, o.type 
FROM sys.sql_modules m
INNER JOIN sys.objects o ON o.object_id = m.object_id
WHERE m.definition like '%Foo%'

