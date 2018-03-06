SELECT  [TABLE_NAME] ,  [INFORMATION_SCHEMA].COLUMNS.COLUMN_NAME
FROM    INFORMATION_SCHEMA.COLUMNS
WHERE   INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME LIKE '%NAME%' ;

OR

Select object_name(object_id) as TableName,* from  SYS.columns where name LIKE '%MyName%'

OR

SELECT * 
FROM  INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = 'YOUR_DATABASE'
AND   COLUMN_NAME LIKE '%YOUR_COLUMN%'

OR

SELECT t.name AS table_name, SCHEMA_NAME(schema_id) AS schema_name,
 c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%EmployeeID%'
ORDER BY schema_name, table_name;

OR SELECT t.name AS Table, c.name AS Column,
ty.name AS Type, c.max_length AS Length
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
INNER JOIN sys.types ty ON c.system_type_id = ty.system_type_id
WHERE c.name LIKE '%column%'
ORDER BY t.name, c.name
