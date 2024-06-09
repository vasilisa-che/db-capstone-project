CREATE DATABASE  IF NOT EXISTS `littlelemondb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `littlelemondb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BookingID` int NOT NULL,
  `BookingDate` date NOT NULL,
  `BookingTime` time NOT NULL,
  `TableNumber` int NOT NULL,
  `CustomerID` int NOT NULL,
  `EmployeeID` int DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `fk_Bookings_Customers_idx` (`CustomerID`),
  KEY `fk_Bookings_Staff1_idx` (`EmployeeID`),
  CONSTRAINT `fk_Bookings_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`),
  CONSTRAINT `fk_Bookings_Staff1` FOREIGN KEY (`EmployeeID`) REFERENCES `staff` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'2024-05-10','18:00:00',1,10,7),(2,'2024-05-10','18:30:00',2,8,6),(3,'2024-05-10','19:30:00',3,9,12),(4,'2024-05-10','19:30:00',4,4,6),(5,'2024-05-11','18:00:00',1,5,7),(6,'2024-05-11','18:30:00',2,6,7),(7,'2024-05-11','19:00:00',4,7,12),(8,'2024-05-11','20:00:00',3,2,6),(9,'2024-05-11','20:30:00',2,3,7),(10,'2024-05-11','20:30:00',1,1,12);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` int NOT NULL,
  `GuestFirstName` varchar(255) NOT NULL,
  `GuestLastName` varchar(255) NOT NULL,
  `ContactNumber` varchar(45) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John','Doe','1234567890','john.doe@example.com'),(2,'Jane','Smith','2345678901','jane.smith@example.com'),(3,'Emily','Jones','3456789012','emily.jones@example.com'),(4,'Michael','Brown','4567890123','michael.brown@example.com'),(5,'Sarah','Johnson','5678901234','sarah.johnson@example.com'),(6,'James','Wilson','6789012345','james.wilson@example.com'),(7,'Olivia','Davis','7890123456','olivia.davis@example.com'),(8,'Liam','Martinez','8901234567','liam.martinez@example.com'),(9,'Emma','Hernandez','9012345678','emma.hernandez@example.com'),(10,'Alexander','Lopez','1234567890','alexander.lopez@example.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `ItemID` int NOT NULL,
  `ItemName` varchar(45) NOT NULL,
  `Category` varchar(45) DEFAULT NULL,
  `Cousine` varchar(45) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
INSERT INTO `menuitems` VALUES (1,'Greek Salad','Starter','Greek',8.50),(2,'Margherita Pizza','Course','Italian',12.00),(3,'Baklava','Dessert','Turkish',6.00),(4,'Bruschetta','Starter','Italian',5.50),(5,'Moussaka','Course','Greek',15.00),(6,'Caprese Salad','Starter','Italian',7.50),(7,'Shish Kebab','Course','Turkish',20.00),(8,'Tiramisu','Dessert','Italian',8.00),(9,'Spanakopita','Starter','Greek',9.50),(10,'Chicken Parmesan','Course','Italian',18.00),(11,'Chicken Souvlaki','Course','Greek',17.00),(12,'Margherita Flatbread','Starter','Italian',10.00),(13,'Gyro Wrap','Course','Greek',14.00),(14,'Tzatziki','Side','Greek',6.50),(15,'Cannoli','Dessert','Italian',7.00);
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL,
  `BookingID` int NOT NULL,
  `ItemID` int NOT NULL,
  `Quantity` int DEFAULT NULL,
  `BillAmount` decimal(10,2) DEFAULT NULL,
  `OrderDateTime` datetime DEFAULT NULL,
  `OrderStatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `fk_Orders_Bookings1_idx` (`BookingID`),
  KEY `fk_Orders_MenuItems1_idx` (`ItemID`),
  CONSTRAINT `fk_Orders_Bookings1` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`),
  CONSTRAINT `fk_Orders_MenuItems1` FOREIGN KEY (`ItemID`) REFERENCES `menuitems` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,2,17.00,'2024-05-10 18:15:00','Completed'),(2,1,2,1,12.00,'2024-05-10 18:20:00','Completed'),(3,1,3,3,18.00,'2024-05-10 18:30:00','Completed'),(4,2,4,2,11.00,'2024-05-10 18:40:00','Completed'),(5,2,5,1,15.00,'2024-05-10 18:50:00','Completed'),(6,3,6,2,15.00,'2024-05-10 19:45:00','Completed'),(7,3,7,1,20.00,'2024-05-10 19:50:00','Completed'),(8,4,8,1,8.00,'2024-05-10 19:45:00','Completed'),(9,4,9,2,19.00,'2024-05-10 20:50:00','Completed'),(10,5,10,1,18.00,'2024-05-11 18:15:00','Completed'),(11,6,11,1,17.00,'2024-05-11 18:40:00','Completed'),(12,6,14,2,13.00,'2024-05-11 18:45:00','Completed'),(13,7,12,1,10.00,'2024-05-11 19:10:00','Completed'),(14,7,13,2,28.00,'2024-05-11 19:55:00','Completed'),(15,8,15,3,21.00,'2024-05-11 20:15:00','Completed'),(16,9,14,2,13.00,'2024-05-11 20:50:00','Completed'),(17,10,11,2,34.00,'2024-05-11 20:55:00','Completed'),(18,10,15,1,7.00,'2024-05-11 21:10:00','Completed');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `EmployeeID` int NOT NULL,
  `EmployeeName` varchar(255) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `AnnualSalary` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Alice Green','General Manager',60000),(2,'Bob White','Assistant Manager',45000),(3,'Charlie Black','Chef',50000),(4,'David Blue','Cook',37000),(5,'Eva Red','Host',35000),(6,'Frank Yellow','Server',30000),(7,'Grace Purple','Server',34000),(8,'Henry Orange','Cook',35000),(12,'Thomas Gold','Server',32000);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-08 20:11:40
