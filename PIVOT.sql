USE tempdb;
GO
CREATE TABLE dbo.Products
(
  ProductID INT PRIMARY KEY,
  Name      VARCHAR(200)   
);
INSERT dbo.Products VALUES
(1, N'foo'),(2, N'bar'),(3, N'kin');
CREATE TABLE dbo.OrderDetails
(
  OrderID INT,
  ProductID INT NOT NULL FOREIGN KEY REFERENCES dbo.Products(ProductID),
  Quantity INT
);
INSERT dbo.OrderDetails VALUES
(1, 1, 1),(1, 2, 2),(2, 1, 1),(3, 3, 1);

--hard-coded PIVOT query:

SELECT p.[foo], p.[bar], p.[kin]
FROM(
  SELECT p.Name, o.Quantity
   FROM dbo.Products AS p
   INNER JOIN dbo.OrderDetails AS o ON p.ProductID = o.ProductID
) AS j
PIVOT
(
  SUM(Quantity) FOR Name IN ([foo],[bar],[kin])
) AS p;

--dynamic SQL.We can simply build the output / pivot column list at runtime, and append it to the rest of the query:

DECLARE @columns NVARCHAR(MAX), @sql NVARCHAR(MAX);
SET @columns = N'';
SELECT @columns += N', p.' + QUOTENAME(Name)
  FROM (SELECT p.Name FROM dbo.Products AS p
  INNER JOIN dbo.OrderDetails AS o ON p.ProductID = o.ProductID
  GROUP BY p.Name) AS x;
SET @sql = N'
SELECT ' + STUFF(@columns, 1, 2, '') + '
FROM
(
  SELECT p.Name, o.Quantity
   FROM dbo.Products AS p
   INNER JOIN dbo.OrderDetails AS o
   ON p.ProductID = o.ProductID
) AS j
PIVOT
(
  SUM(Quantity) FOR Name IN ('
  + STUFF(REPLACE(@columns, ', p.[', ',['), 1, 1, '')
  + ')
) AS p;';
PRINT @sql;
EXEC sp_executesql @sql;
