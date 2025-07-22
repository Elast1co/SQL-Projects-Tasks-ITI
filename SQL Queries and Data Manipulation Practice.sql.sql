-- 1 
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2002-07-28' AND '2014-07-29';

-- 2
SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110;

-- 3 
SELECT ProductID, Name
FROM Production.Product
WHERE Weight IS NULL;

-- 4 
SELECT Name
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');

-- 5.
SELECT *
FROM Production.Product
WHERE Name LIKE 'B%';

-- 6.A 
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

-- 6.B
SELECT *
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%' ;

-- 7. 
SELECT OrderDate , SUM(TotalDue) 
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2001-07-01' AND '2014-07-31'
GROUP BY OrderDate;

-- 8
SELECT DISTINCT HireDate
FROM HumanResources.Employee;

-- 9 
SELECT AVG(DISTINCT ListPrice) 
FROM Production.Product;

-- 10
SELECT 'The ' + Name + ' is only! [' + CAST(ListPrice AS VARCHAR) + '] price!' 
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;

-- 11 a
SELECT rowguid, Name, SalesPersonID, Demographics
INTO store_Archive
FROM Sales.Store;

-- 11 b
SELECT rowguid, Name, SalesPersonID, Demographics
INTO store_Archive_StructureOnly
FROM Sales.Store
WHERE 1 = 0;

-- 12
SELECT CONVERT(VARCHAR, GETDATE(), 101) 
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 103)
UNION
SELECT FORMAT(GETDATE(), 'dddd, MMMM dd, yyyy') 
UNION
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd'); 
