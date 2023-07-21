USE classicmodels;
SHOW TABLES;

-- No 1
SELECT a.productCode, a.productName, c.orderDate
FROM products a, orderdetails b, orders c
WHERE a.productCode = b.productCode
AND b.orderNumber = c.orderNumber
AND YEAR(c.orderDate) = '2003' AND MONTH(c.orderDate) = '12'

-- No 2
SELECT employees.employeeNumber, employees.firstName, employees.email, employees.jobTitle
FROM employees
WHERE jobTitle = 'Sales Rep' AND employeeNumber NOT IN (
	SELECT salesRepEmployeeNumber FROM customers
	WHERE salesRepEmployeeNumber IS NOT NULL);

SELECT DISTINCT a.employeeNumber, a.firstName, a.email, a.jobTitle
FROM employees a, customers b
WHERE a.jobTitle = 'Sales Rep'
AND a.employeeNumber = b.salesRepEmployeeNumber

SELECT * FROM customers WHERE salesRepEmployeeNumber IS NOT NULL

-- No 3
SELECT a.`productCode`, a.`productName`, a.`productVendor`, b.`orderDate`
FROM products a, orders b, orderdetails d
WHERE YEAR(b.orderDate) BETWEEN '2002' AND '2003'
AND a.productLine IN ('classic cars', 'motorcycles')
AND a.productCode = d.ProductCode
AND d.orderNumber = b.orderNumber

-- No 4
SELECT productCode, productName, productVendor, orders.`orderDate` FROM products, orders
WHERE productCode NOT IN (SELECT productCode FROM orderdetails
WHERE orderNumber IN (SELECT orderNumber FROM orders
WHERE YEAR(OrderDate) = '2003' AND MONTH(OrderDate) BETWEEN '1' AND '6'));

-- No 5
SELECT customers.`customerNumber`, customers.`customerName`, customers.`phone`, customers.`city`
FROM customers
WHERE salesRepEmployeeNumber IN (SELECT employeeNumber FROM employees
WHERE officeCode IN (SELECT officeCode FROM offices
WHERE city IN ('Paris', 'London')));

SELECT c.`customerNumber`, c.`customerName`, c.`phone`, c.`city`
FROM customers c, employees e, offices o
WHERE c.`salesRepEmployeeNumber` = e.`employeeNumber`
AND e.`officeCode` = o.`officeCode`
AND o.city IN ('Paris', 'London')

-- No 6
SELECT customerName, orderNumber, orderDate, productCode, productName
FROM products, customers, orders
WHERE productCode IN (SELECT productCode FROM orderdetails
WHERE orderNumber IN (SELECT orderNumber FROM orders
WHERE customerNumber IN (SELECT  customerNumber FROM customers
WHERE customerName = 'Atelier graphique')))
AND customerName = 'Atelier graphique'
AND orderNumber IN (SELECT orderNumber FROM orders
WHERE customerNumber IN (SELECT customerNumber FROM customers
WHERE customerName = 'Atelier graphique')); 

SELECT c.customerName, o.orderNumber, o.orderDate, p.productCode, p.productName
FROM customers c, orders o, products p, orderDetails d
WHERE customerName = 'Atelier graphique'
AND c.customerNumber = o.customerNumber
AND o.orderNumber = d.orderNumber
AND d.productCode = p.productCode
