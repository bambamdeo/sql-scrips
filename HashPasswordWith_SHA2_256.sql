SELECT CONVERT(VARCHAR(MAX), HASHBYTES('SHA2_256', 'password'), 2)
SELECT CONVERT(VARCHAR(MAX), HASHBYTES('SHA1', 'password'), 2)
SELECT CONVERT(VARCHAR(MAX), HASHBYTES('md5', 'password'), 2)
