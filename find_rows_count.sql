;WITH TableRows AS
(
   SELECT 
      SUM(row_count) AS [RowCount], 
      OBJECT_NAME(OBJECT_ID) AS TableName
   FROM 
      sys.dm_db_partition_stats
   WHERE 
      index_id = 0 OR index_id = 1
   GROUP BY 
      OBJECT_ID
)
SELECT *
FROM TableRows
WHERE [RowCount] = 0

---OR

SELECT  OBJECT_NAME(OBJECT_ID) AS TableName,row_count FROM       sys.dm_db_partition_stats
WHERE  OBJECT_NAME(OBJECT_ID)  NOT LIKE 'sys%' AND   OBJECT_NAME(OBJECT_ID)  NOT LIKE 'queue_messages_%'
AND   OBJECT_NAME(OBJECT_ID)  NOT LIKE 'file%' AND(    index_id = 0 OR index_id = 1)
AND row_count=0
