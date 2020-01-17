SELECT 
	CASE FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')
		WHEN 1 THEN 'Full-Text installed.' 
		ELSE 'Full-Text is NOT installed.' 
	END
;
SELECT  FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')
SELECT is_fulltext_enabled,DB_ID(), DB_NAME()
FROM sys.databases
WHERE database_id = DB_ID()
 
select *
FROM sys.fulltext_catalogs

ALTER FULLTEXT CATALOG VenueSearch AS DEFAULT;

CREATE FULLTEXT INDEX ON Venue(
[Name]
      ,[Address]
      ,[City]
      ,[ZipCode]
      ,[Country]
      ,[State]
      
) 
KEY INDEX PK_Venue 
WITH STOPLIST = SYSTEM;
