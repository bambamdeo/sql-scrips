DECLARE @sql VARCHAR(MAX)=''
 SELECT @sql+= 'DROP PROCEDURE [' + SCHEMA_NAME(p.schema_id) + '].[' + p.NAME + '];'+CHAR(13)
FROM sys.procedures p WHERE p.name LIKE '%2%'

print @sql
--EXEC (@sql)


--OR



Declare @procName varchar(500) 
Declare cur Cursor For Select [name] From sys.objects where type = 'p' AND name LIKE '%xudsp%'
Open cur 
Fetch Next From cur Into @procName 
While @@fetch_status = 0 
Begin 
 --Exec('drop procedure [' + @procName+']') 
 print @procName
 Fetch Next From cur Into @procName 
End
Close cur 
Deallocate cur 


