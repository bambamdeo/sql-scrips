DECLARE @setIdentity VARCHAR(MAX)

DECLARE @flag VARCHAR(10)='ON'


SET @setIdentity=''


SELECT 
	@setIdentity +='SET IDENTITY_INSERT ['+s.name+'].['+o.name+'] '+@flag+CHAR(13)
FROM sys.objects o
INNER JOIN sys.schemas s ON s.schema_id=o.schema_id
	WHERE o.[type]='U'
	AND EXISTS(SELECT 1 FROM sys.columns WHERE object_id=o.object_id AND is_identity=1)

PRINT @setIdentity

--EXEC @setIdentity
