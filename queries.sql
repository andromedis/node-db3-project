-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
SELECT 
    p.ProductName AS "Product", 
    c.CategoryName AS "Category"
FROM Product p
JOIN Category c
    ON p.CategoryId = c.Id;

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
SELECT 
    o.Id AS "Order ID", 
    s.CompanyName AS "Shipping Company"
FROM [Order] o 
JOIN Shipper s
    ON o.ShipVia = s.Id
WHERE o.OrderDate < "2012-08-08%";

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
SELECT 
    p.ProductName AS "Product",
    o.Quantity AS "Quantity" 
FROM OrderDetail o 
JOIN Product p
    ON o.ProductId = p.Id
WHERE o.OrderId = 10251
ORDER BY "Product";

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
SELECT 
    o.Id AS "Order ID",
    c.CompanyName AS "Customer Company",
    e.LastName AS "Employee Last Name"
FROM [Order] o 
JOIN Customer c
    ON o.CustomerId = c.Id
JOIN Employee e
    ON o.EmployeeId = e.Id;


-- STRETCH QUERIES

-- Find the number of shipments by each shipper.
    -- 54 by Speedy Express, 74 by United Package, 68 by Federal Shipping
SELECT 
    s.ShipperName AS "Shipping Company",
	count(o.OrderID) AS "Total Orders"
FROM Orders o
JOIN Shippers s
	ON o.ShipperID = s.ShipperID
GROUP BY s.ShipperID

-- Find the top 5 best performing employees measured in number of orders.
    -- Margaret Peacock, Janet Leverling, Nancy Davolio, Laura Callahan, Andrew Fuller
SELECT 
    e.FirstName || " " || e.LastName AS "Employee",
	count(o.OrderID) AS "Total Orders"
FROM Orders o
JOIN Employees e
	ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID
ORDER BY "Total Orders" DESC
LIMIT 5;

-- Find the top 5 best performing employees measured in revenue.
    -- Margaret Peacock, Nancy Davolio, Janet Leverling, Robert King, Laura Callahan
SELECT
	e.FirstName || " " || e.LastName AS "Employee Name", 
    ROUND(SUM(od.Quantity * p.Price), 2) AS "Total Revenue"
FROM Employees e
JOIN Orders o
	ON o.EmployeeID = e.EmployeeID
JOIN OrderDetails od
	ON o.OrderID = od.OrderID
JOIN Products p
	ON od.ProductID = p.ProductID
GROUP BY "Employee Name"
ORDER BY "Total Revenue" DESC
LIMIT 5;

-- Find the category that brings in the least revenue.
    -- Grains/Cereals w/revenue of 22327.75
SELECT 
    c.CategoryName, 
	ROUND(SUM(od.Quantity * p.Price), 2) AS "Category Revenue"
FROM Categories c
JOIN Products p
	ON c.CategoryID = p.CategoryID
JOIN OrderDetails od
	ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY "Category Revenue"
LIMIT 1;

-- Find the customer country with the most orders.
    -- USA with 29 orders
SELECT 
    c.Country, 
    COUNT(o.OrderID) AS "Total Orders"
FROM Orders o
JOIN Customers c
	ON o.CustomerID = c.CustomerID
GROUP BY c.Country
ORDER BY "Total Orders" DESC
LIMIT 1;

-- Find the shipper that moves the most cheese measured in units.

