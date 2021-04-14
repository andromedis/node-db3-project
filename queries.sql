-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
SELECT p.ProductName AS "Product", 
    c.CategoryName AS "Category"
FROM Product p
JOIN Category c
    ON p.CategoryId = c.Id;

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
SELECT o.Id AS "Order ID", 
    s.CompanyName AS "Shipping Company"
FROM [Order] o 
JOIN Shipper s
    ON o.ShipVia = s.Id
WHERE o.OrderDate < "2012-08-08%";

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
SELECT p.ProductName AS "Product",
    o.Quantity AS "Quantity" 
FROM OrderDetail o 
JOIN Product p
    ON o.ProductId = p.Id
WHERE o.OrderId = 10251
ORDER BY "Product";

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
SELECT o.Id AS "Order ID",
    c.CompanyName AS "Customer Company",
    e.LastName AS "Employee Last Name"
FROM [Order] o 
JOIN Customer c
    ON o.CustomerId = c.Id
JOIN Employee e
    ON o.EmployeeId = e.Id;
