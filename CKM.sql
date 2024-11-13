-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: cloud_kitchen
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cust_address`
--

DROP TABLE IF EXISTS `cust_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cust_address` (
  `Customer_ID` int NOT NULL,
  `Address_Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`Customer_ID`,`Address_Name`),
  CONSTRAINT `cust_address_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer_details` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cust_address`
--

LOCK TABLES `cust_address` WRITE;
/*!40000 ALTER TABLE `cust_address` DISABLE KEYS */;
INSERT INTO `cust_address` VALUES (1,'home','nerul'),(1,'work','andheri'),(2,'home','malad'),(2,'work','bandra'),(3,'home','kharghar'),(3,'work','dadar'),(4,'home','csn'),(4,'work','churchgate'),(5,'home','borivali'),(5,'work','goregaon'),(6,'home','malad'),(6,'work','worli'),(7,'home','solapur'),(7,'work','andheri'),(8,'home','csn'),(8,'work','churchgate'),(9,'home','solapur'),(9,'work','andheri'),(10,'home','worli'),(10,'work','ghatkopar');
/*!40000 ALTER TABLE `cust_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_details`
--

DROP TABLE IF EXISTS `customer_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_details` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Mobile_NO` bigint NOT NULL,
  `Email_ID` varchar(100) NOT NULL,
  `Acc_Type` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Username_UNIQUE` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_details`
--

LOCK TABLES `customer_details` WRITE;
/*!40000 ALTER TABLE `customer_details` DISABLE KEYS */;
INSERT INTO `customer_details` VALUES (1,'Advait','advait@123',9004226767,'advait@gmail.com',1),(2,'Sahil','sahil@123',1023456789,'sahil@gmail.com',0),(3,'Kshitij','kshitij@123',1122334455,'kshitij@hotmail.com',1),(4,'Tejas','tejas@123',1245789630,'tejas@gmail.com',1),(5,'Harsh','harsh@123',2589630147,'harsh@gmail.com',0),(6,'Daksh','daksh@123',7539148620,'daksh@gmail.com',0),(7,'Vedant K','vedant@123',9876543210,'ram@yahoo.com',1),(8,'Sameer','sameer@123',9876543211,'sameer@gmail.com',0),(9,'Sarthak','sarthak@123',9123456789,'sarthak@gmail.com',0),(10,'Anil','anil@123',9004226767,'anil@yahoo.com',1),(11,'Kunal','kunal@123',9874152630,'kunal@gmail.com',1),(12,'ajinkya','ajinkya@123',9856321470,'ajinkya@hotmail.com',0);
/*!40000 ALTER TABLE `customer_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_in_customers` BEFORE UPDATE ON `customer_details` FOR EACH ROW BEGIN
  DECLARE msg VARCHAR(255);

  IF NEW.Password NOT REGEXP '[A-Z]' THEN
    SET msg = 'Password must contain at least one letter.';
  ELSEIF NEW.Password NOT REGEXP '[0-9]' THEN
    SET msg = 'Password must contain at least one digit.';
  ELSEIF NEW.Password NOT REGEXP '[!@#\$%]' THEN
    SET msg = 'Password must contain at least one special character.';
  END IF;

  IF msg IS NOT NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_in_customers` AFTER DELETE ON `customer_details` FOR EACH ROW BEGIN
  IF OLD.Acc_Type = 1 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion is not allowed for customers with Acc_Type 1.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `Ingredient_ID` int NOT NULL AUTO_INCREMENT,
  `Ingredient_Name` varchar(100) NOT NULL,
  `Quantity` int NOT NULL,
  `Ingredient_Cost` int NOT NULL,
  PRIMARY KEY (`Ingredient_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,'Milk',10,5),(2,'Sugar',10,2),(3,'Tea',10,2),(4,'Coffee',10,2),(5,'Sambar',10,15),(6,'Chutney',10,15),(7,'Masala_Dosa',10,20),(8,'Batter',10,20),(9,'flour',10,30),(10,'Black Tea Leaves',10,20),(11,'Coffee Beans',10,100),(12,'Milk',10,50),(13,'Sugar',10,20),(14,'Cardamom',10,30),(15,'Cinnamon',10,25),(16,'Cloves',10,30),(17,'Ginger',10,20),(18,'Urad Dal',10,50),(19,'Rice Flour',10,30),(20,'Potatoes',10,30),(21,'Onions',10,20),(22,'Tomatoes',10,20),(23,'Green Chillies',10,10),(24,'Coriander Leaves',10,10),(25,'Paneer',10,200),(26,'Chicken',10,300),(27,'Ghee',10,150),(28,'Maida Flour',10,30),(29,'Milk Powder',10,100);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `Item_ID` int NOT NULL AUTO_INCREMENT,
  `Item_Name` varchar(100) NOT NULL,
  `Item_Type` varchar(100) NOT NULL,
  `Description` varchar(225) NOT NULL,
  `Item_Price` int NOT NULL,
  PRIMARY KEY (`Item_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Tea','beverage','A popular beverage made by steeping tea leaves in hot water.',15),(2,'Black tea','beverage','A type of tea known for its strong, dark color and bold flavor.',20),(3,'Coffee','beverage','A beverage made from roasted coffee beans.',20),(4,'Black Coffee','beverage','Coffee that is served without any additives like milk or sugar.',25),(5,'Plain Dosa','breakfast','A thin, crispy Indian pancake made from fermented batter.',70),(6,'Masala Dosa','breakfast','A type of dosa filled with a spiced potato and onion mixture.',100),(7,'Latte','Beverage','Espresso with steamed milk',150),(8,'Cappuccino','Beverage','Espresso with steamed milk and foam',180),(9,'Chai Latte','Beverage','Spiced tea latte',200),(10,'Herbal Tea','Beverage','Caffeine-free herbal infusion',120),(11,'Idli','Food','Soft, steamed rice cakes',80),(12,'Vada','Food','Deep-fried lentil donuts',60),(13,'Poori','Food','Deep-fried puffed bread',60),(14,'Uttapam','Food','Savory pancake with toppings',120),(15,'Samosa','Food','Deep-fried pastry with spiced filling',60),(16,'Biryani','Food','Flavorful rice dish with meat or vegetables',300),(17,'Pav Bhaji','Food','Spicy vegetable curry with bread rolls',150),(18,'Paneer Butter Masala','Food','Creamy curry with cottage cheese',250),(19,'Chicken Tikka Masala','Food','Grilled chicken in a creamy tomato sauce',300),(20,'Gulab Jamun','Dessert','Sweet, fried dough balls in syrup',120),(21,'Rasmalai','Dessert','Soft cheese dumplings in sweetened milk',150),(22,'Jalebi','Dessert','Deep-fried, sweet spirals',120),(23,'Kheer','Dessert','Rice pudding',100),(24,'Ice Cream','Dessert','Frozen dessert',100);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_ingredients`
--

DROP TABLE IF EXISTS `menu_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_ingredients` (
  `Item_ID` int NOT NULL,
  `Ingredient_ID` int NOT NULL,
  `Ingredient` varchar(255) NOT NULL,
  PRIMARY KEY (`Item_ID`,`Ingredient_ID`),
  KEY `Ingredient_ID` (`Ingredient_ID`),
  CONSTRAINT `item_fk` FOREIGN KEY (`Item_ID`) REFERENCES `menu` (`Item_ID`),
  CONSTRAINT `menu_ingredients_ibfk_1` FOREIGN KEY (`Ingredient_ID`) REFERENCES `inventory` (`Ingredient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_ingredients`
--

LOCK TABLES `menu_ingredients` WRITE;
/*!40000 ALTER TABLE `menu_ingredients` DISABLE KEYS */;
INSERT INTO `menu_ingredients` VALUES (1,1,'Milk'),(1,2,'Sugar'),(1,3,'Tea'),(2,2,'Sugar'),(2,3,'Tea'),(3,1,'Milk'),(3,2,'Sugar'),(3,4,'Coffee'),(4,2,'Sugar'),(4,4,'Coffee'),(5,5,'Sambar'),(5,7,'Masala_Dosa'),(5,8,'Batter'),(6,5,'Sambar'),(6,6,'Chutney'),(6,7,'Masala_Dosa'),(6,8,'Batter'),(7,11,'Coffee Beans'),(7,12,'Milk'),(7,13,'Sugar'),(8,11,'Coffee Beans'),(8,12,'Milk'),(8,13,'Sugar'),(9,10,'Black Tea Leaves'),(9,12,'Milk'),(9,13,'Sugar'),(9,14,'Cardamom'),(9,15,'Cinnamon'),(9,16,'Cloves'),(9,17,'Ginger'),(10,10,'Black Tea Leaves'),(10,14,'Cardamom'),(10,15,'Cinnamon'),(10,16,'Cloves'),(10,17,'Ginger'),(11,18,'Urad Dal'),(11,19,'Rice Flour'),(12,13,'Sugar'),(12,18,'Urad Dal'),(12,19,'Rice Flour'),(12,23,'Green Chillies'),(12,24,'Coriander Leaves'),(13,19,'Rice Flour'),(13,27,'Ghee'),(14,18,'Urad Dal'),(14,19,'Rice Flour'),(14,20,'Potatoes'),(14,21,'Onions'),(14,23,'Green Chillies'),(14,24,'Coriander Leaves'),(15,20,'Potatoes'),(15,21,'Onions'),(15,23,'Green Chillies'),(16,19,'Rice'),(16,21,'Onions'),(16,26,'Chicken'),(17,20,'Potatoes'),(17,21,'Onions'),(17,22,'Tomatoes'),(17,23,'Green Chillies'),(17,24,'Coriander Leaves'),(17,27,'Ghee'),(17,28,'Maida Flour'),(18,12,'Milk'),(18,13,'Sugar'),(18,17,'Ginger'),(18,21,'Onions'),(18,22,'Tomatoes'),(18,23,'Green Chillies'),(18,25,'Paneer'),(18,27,'Ghee'),(19,12,'Milk'),(19,13,'Sugar'),(19,17,'Ginger'),(19,21,'Onions'),(19,22,'Tomatoes'),(19,23,'Green Chillies'),(19,26,'Chicken'),(19,27,'Ghee'),(20,13,'Sugar'),(20,27,'Ghee'),(20,28,'Maida Flour'),(20,29,'Milk Powder'),(21,12,'Milk'),(21,13,'Sugar'),(21,14,'Cardamom'),(21,25,'Paneer'),(22,13,'Sugar'),(22,28,'Maida Flour'),(23,12,'Milk'),(23,13,'Sugar'),(23,14,'Cardamom'),(23,19,'Rice'),(24,12,'Milk'),(24,13,'Sugar'),(24,29,'Milk Powder');
/*!40000 ALTER TABLE `menu_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_items`
--

DROP TABLE IF EXISTS `ordered_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_items` (
  `Order_ID` int NOT NULL,
  `Item_ID` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`Order_ID`,`Item_ID`),
  CONSTRAINT `ordered_items_chk_1` CHECK ((`Quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_items`
--

LOCK TABLES `ordered_items` WRITE;
/*!40000 ALTER TABLE `ordered_items` DISABLE KEYS */;
INSERT INTO `ordered_items` VALUES (1,1,1),(1,3,1),(2,2,1),(2,5,1),(3,3,5),(4,1,1),(4,3,1),(4,4,1),(5,1,1),(5,4,1),(5,5,1),(6,5,1),(6,6,1),(7,3,1),(7,5,1),(8,1,1),(8,2,1),(8,4,1),(9,1,1),(9,3,1),(9,5,1),(10,2,1),(10,3,1),(11,10,1),(11,15,1),(12,15,1),(13,15,1),(14,15,1),(15,2,1),(16,2,1),(17,2,2),(17,15,2),(18,2,1);
/*!40000 ALTER TABLE `ordered_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Customer_ID` int NOT NULL,
  `Total_Ammount` int NOT NULL,
  `Address` varchar(45) NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer_details` (`Customer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,100,'home'),(2,3,200,'work'),(3,5,500,'home'),(4,2,250,'home'),(5,4,300,'work'),(6,6,350,'work'),(7,7,90,'work'),(8,1,60,'work'),(9,7,105,'home'),(10,7,40,'home'),(11,7,180,'work'),(12,7,120,'homw'),(13,7,120,'home'),(14,7,240,'home'),(15,7,40,'home'),(16,7,20,'home'),(17,7,160,'home'),(18,7,60,'home');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_in_orders` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
  IF NEW.customer_id NOT IN (SELECT customer_id FROM customer_details) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Customer ID!!';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-06 23:45:23
