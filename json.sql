--ISJSON() – verifies that the input text has valid JSON data
--JSON_VALUE() – extracts scalar value from the JSON text.
--JSON_QUERY() – extracts an object or array from the JSON text.
--JSON_VALUE - function returns a scalar value whereas JSON_QUERY returns an object or an array from the JSON data.
--OPENJSON - function can be used to convert JSON text into table rows and columns or to import JSON object into SQL tables.
--JSON_MODIFY - to update the value of a property in JSON string

DECLARE @json nvarchar(max) 
  SET @json =N'
{
  "Person": [
    {
      "Name": {
        "FirstName": "Catherine",
        "LastName": "Abel"
      },
      "Address": {
        "State": "VA",
        "Zip": "24153"
      }
    }
  ]
}'

PRINT @json

IF (ISJSON(@json) = 1)
       PRINT 'It is a Valid JSON' --Valid JSON
ELSE
       PRINT 'It is an Invalid JSON string' 
--******************** JSON_QUERY ****************************
--Lax mode – Returns NULL if the path does not exist.
--Strict mode – Returns an error if path does not exist.

SELECT JSON_QUERY(@json, '$.Person');
-- Extract object/array value from a JSON text 
SELECT JSON_QUERY(@json, '$.Person[0].Address');

-- Returns NULL if the path does not exist
SELECT JSON_QUERY(@json, '$.Person[0].Age');

-- lax option is by default and returns NULL if there is a problem
SELECT JSON_QUERY(@json, 'lax $.Person[0].Age');

-- strict option raises an error if there is a problem
SELECT JSON_QUERY(@json, 'strict $.Person[0].Age');

--******************** JSON_VALUE ****************************
-- Extract scalar value from a JSON text 
SELECT JSON_VALUE(@json, '$.Person[0].LastName');
SELECT JSON_VALUE(@json, '$.Person[1].AccountNumber');

-- Returns NULL if the path does not exist
SELECT JSON_VALUE(@json, '$.Person[1].Age');

-- lax option is by default and returns NULL if there is a problem
SELECT JSON_VALUE(@json, 'lax $.Person[1].Age');

-- strict option raises an error if there is a problem
SELECT JSON_VALUE(@json, 'strict $.Person[1].Age');

--******************** JSON_MODIFY ****************************

PRINT JSON_MODIFY (@json, '$.Person[0].Address.Zip' , '35043');

PRINT @json
