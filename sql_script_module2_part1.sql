-- Module 2 : Adding sales reports

-- Create a virtual table to summarize data

-- Task 1
-- create a virtual table called OrdersView 
-- that focuses on OrderID, Quantity and Cost columns 
-- within the Orders table for all orders with a quantity greater than 2

CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, BillAmount
FROM Orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;

-- Task 2
-- get information from four tables on all customers with orders that cost more than $15

SELECT c.CustomerID, CONCAT(GuestFirstName, ' ', GuestLastName) AS FullName, o.OrderID, BillAmount, ItemName, Category
FROM bookings AS b
RIGHT JOIN customers AS c ON b.CustomerID = c.CustomerID
INNER JOIN orders AS o ON b.BookingID = o.BookingID
INNER JOIN menuitems AS m ON m.ItemID = o.ItemID
WHERE BillAmount > 15
ORDER BY BillAmount;

-- Task 3
--  find all menu items for which more than 2 orders have been placed

SELECT ItemName
FROM MenuItems
WHERE ItemID = ANY (
	SELECT o.ItemID
	FROM orders o
	INNER JOIN menuitems m
	ON o.ItemID = m.ItemID
	GROUP BY ItemID
	HAVING SUM(Quantity) > 2
	)
;


-- Create optimized queries to manage and analyze data

-- Task 1
-- create a procedure that displays the maximum ordered quantity in the Orders table

DELIMITER //
CREATE PROCEDURE GetMaxQuantity ()
BEGIN
    SELECT MAX(Quantity) AS 'Max Quantity in Order'
	FROM orders;
END //
DELIMITER ;

CALL GetMaxQuantity();

-- Task 2
-- create a prepared statement called GetOrderDetail

PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, BillAmount FROM Orders WHERE OrderID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 3
-- create a stored procedure called CancelOrder
-- to delete an order record based on the user input of the order id.

DELIMITER //
CREATE PROCEDURE CancelOrder (IN oid INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = oid;
    SELECT CONCAT('Order', oid , 'is cancelled') AS Confirmation;
END //
DELIMITER ;

CALL CancelOrder(5);

SELECT OrderID, BillAmount FROM Orders WHERE OrderID BETWEEN 4 AND 6;