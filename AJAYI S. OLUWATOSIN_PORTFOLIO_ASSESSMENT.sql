---------------SQL PORTFOLIO ASSESMENT-------

-- Question 1 Update the list price of all products in the 'Bikes' category by 10%.
UPDATE p
SET p.ListPrice = p.ListPrice * 1.10
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes';

--Question 2: Find the top 5 products by sales amount
SELECT TOP 5 p.Name AS ProductName, SUM(sod.LineTotal) AS SalesAmount
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY SalesAmount DESC;

--Question 3: Retrieve a list of all employees along with their department names.

SELECT e.BusinessEntityID, e.JobTitle, d.Name AS DepartmentName
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID;

--Question 4: List all products with a stock level below 100.
SELECT ProductID, Name, SafetyStockLevel
FROM Production.Product
WHERE SafetyStockLevel < 100;

--Question 5: Find the total number of orders placed by each customer.
SELECT CustomerID, COUNT(SalesOrderID) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

--Question 6: Find the names of products that have been ordered more than 100 times.
SELECT p.Name
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.Name
HAVING COUNT(sod.SalesOrderID) > 100;

--Question 7: Calculate the average order quantity per product.
SELECT p.Name AS ProductName, AVG(sod.OrderQty) AS AverageOrderQty
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.Name;

--Question 8: List the products along with their current inventory levels.
SELECT p.Name AS ProductName, SUM(pi.Quantity) AS InventoryLevel
FROM Production.Product p
JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
GROUP BY p.Name;

--Question 9: Find the average number of days to manufacture products in each category.
SELECT pc.Name AS CategoryName, AVG(p.DaysToManufacture) AS AverageDaysToManufacture
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name;

--Question 10: List all sales orders placed on weekends.
SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
WHERE DATEPART(WEEKDAY, OrderDate) IN (1, 7);

--Question 11: Retrieve the product names and their standard costs where the standard cost is greater than 1000.
SELECT Name, StandardCost
FROM Production.Product
WHERE StandardCost > 1000;

--Question 12: Find the average sales amount per order for each salesperson.
SELECT s.BusinessEntityID, AVG(soh.TotalDue) AS AverageSalesAmount
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson s ON soh.SalesPersonID = s.BusinessEntityID
GROUP BY s.BusinessEntityID;

--Question 13: Find the employees who have the longest tenure.
SELECT TOP 5 BusinessEntityID, DATEDIFF(DAY, HireDate, GETDATE()) AS TenureDays
FROM HumanResources.Employee
ORDER BY TenureDays DESC;

--Question 14: List the top 10 customers by order count.
SELECT TOP 10 CustomerID, COUNT(SalesOrderID) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY OrderCount DESC;

--Question 15: Retrieve the names of products that have a list price above the average list price.
SELECT Name
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);




