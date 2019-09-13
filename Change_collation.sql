--check collation
SELECT name, collation_name FROM sys.databases WHERE name = 'myDatabase';

SELECT COLUMN_NAME, COLLATION_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'myTable'


-- make sure no one else is using database
ALTER DATABASE myDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE

-- change collation to Modern_Spanish_CI_AI_WS
ALTER DATABASE myDatabase COLLATE Modern_Spanish_CI_AI_WS;

-- allow users back into the database
ALTER DATABASE myDatabase SET MULTI_USER


--Change table collation
ALTER TABLE myTable ALTER COLUMN myCollumn nvarchar(200) COLLATE Modern_Spanish_CI_AI_WS
