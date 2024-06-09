-- Module 2 : Adding sales reports

-- Create a virtual table to summarize data

-- Task 1
-- populate the Bookings table of their database with some records of data

INSERT INTO Bookings (BookingID, BookingDate, BookingTime, TableNumber, CustomerID, EmployeeID) VALUES
(101, '2022-10-10', '18:00:00', 5, 1, 7),
(102, '2022-11-12', '18:30:00', 3, 4, 6),
(103, '2022-10-11', '19:30:00', 2, 9, 12),
(104, '2022-10-13', '19:30:00', 2, 6, 6);

SELECT * 
FROM Bookings
WHERE BookingID BETWEEN 101 AND 104;


-- Task 2
-- create a stored procedure called CheckBooking 
-- to check whether a table in the restaurant is already booked

DELIMITER //
CREATE PROCEDURE CheckBooking (IN BDate DATE, IN BTime TIME, IN TNumber INT)
BEGIN
    IF (EXISTS (SELECT 1 FROM Bookings WHERE BookingDate = BDate AND BookingTime = BTime AND TableNumber = TNumber)) THEN
        SELECT CONCAT('Table ', TNumber, ' is booked') AS Message;
    ELSE
        SELECT CONCAT('Table ', TNumber, ' is not booked') AS Message;
    END IF;
END //
DELIMITER ;

CALL CheckBooking('2022-11-12', '18:30:00', 3);


-- Task 3
-- verify a booking, and decline any reservations for tables 
-- that are already booked under another name

DELIMITER //
CREATE PROCEDURE AddValidBooking (IN BID INT, IN BDate DATE, IN BTime TIME, IN TNumber INT, IN CustID INT)
BEGIN
    DECLARE bookingExists INT DEFAULT 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO bookingExists FROM Bookings WHERE BookingDate = BDate AND BookingTime = BTime AND TableNumber = TNumber;
    IF bookingExists > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', TNumber, ' is already booked') AS Message;
    ELSE
        INSERT INTO Bookings (BookingID, BookingDate, BookingTime, TableNumber, CustomerID)
        VALUES (BID, BDate, BTime, TNumber, CustID);
        COMMIT;
        SELECT CONCAT('Booking successfully added for Table ', TNumber, ' at ', BTime, ' on ', BDate) AS Message;
    END IF;
END //
DELIMITER ;

CALL AddValidBooking(200, '2022-11-12', '18:30:00', 3, 5);
CALL AddValidBooking(201, '2022-11-20', '18:30:00', 1, 5);



-- Create SQL queries to add and update bookings

-- Task 1
-- create a new procedure called AddBooking to add a new table booking record

DELIMITER //
CREATE PROCEDURE AddBooking (IN BID INT, IN BDate DATE, IN BTime TIME, IN TNumber INT, IN CID INT)
BEGIN
    INSERT INTO Bookings (BookingID, BookingDate, BookingTime, TableNumber, CustomerID) 
    VALUES 
    (BID, BDate, BTime, TNumber, CID);
    SELECT 'New booking added' AS Confirmation;
END //
DELIMITER ;

CALL AddBooking(301, '2022-11-22', '20:00:00', 3, 5);
SELECT * FROM bookings WHERE BookingID = 301;


-- Task 2
-- create a new procedure called UpdateBooking to update existing bookings in the booking table

DELIMITER //
CREATE PROCEDURE UpdateBooking (IN BID INT, IN BDate DATE)
BEGIN
    UPDATE Bookings SET BookingDate = BDate WHERE BookingID = BID;
    SELECT 'Booking Updated' AS Confirmation;
END //
DELIMITER ;

CALL UpdateBooking(301, '2022-11-23');
SELECT * FROM bookings WHERE BookingID = 301;


-- Task 3
-- create a new procedure called CancelBooking to cancel or remove a booking

DELIMITER //
CREATE PROCEDURE CancelBooking (IN BID INT)
BEGIN
    DELETE FROM Bookings WHERE BookingID = BID;
    SELECT CONCAT('Booking ', BID, ' cancelled') AS Confirmation;
END //
DELIMITER ;

CALL CancelBooking(301);
SELECT * FROM bookings WHERE BookingID = 301;