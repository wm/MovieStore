-- MySQL dump 10.13  Distrib 5.1.40, for apple-darwin9.5.0 (i386)
--
-- Host: localhost    Database: movie_store
-- ------------------------------------------------------
-- Server version	5.1.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `copies`
--

DROP TABLE IF EXISTS `copies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `copy_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `sale_price` float NOT NULL,
  `wholesale_price` float NOT NULL,
  `section_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `itemForeignKey` (`item_id`),
  KEY `sectionForeignKey` (`section_id`),
  CONSTRAINT `itemForeignKey` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `sectionForeignKey` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copies`
--

LOCK TABLES `copies` WRITE;
/*!40000 ALTER TABLE `copies` DISABLE KEYS */;
INSERT INTO `copies` VALUES (3,3,'DVD',9.99,4,2),(4,4,'DVD',9.99,4,4),(6,2,'DVD',9.99,4,1),(7,3,'BlueRay',9.99,4,2),(8,4,'DVD',9.99,4,4),(10,2,'DVD',9.99,4,1),(11,3,'BlueRay',9.99,4,2),(12,4,'DVD',9.99,4,4),(14,2,'BlueRay',9.99,4,1),(15,3,'BlueRay',9.99,4,2),(16,4,'DVD',9.99,4,4),(25,5,'DVD',9.99,4,4),(26,5,'DVD',9.99,4,4),(27,5,'DVD',9.99,4,4),(28,5,'DVD',9.99,4,4),(36,6,'DVD',9.99,4.99,5),(37,6,'DVD',9.99,4.99,5),(38,6,'DVD',9.99,4.99,0),(40,6,'DVD',9.99,4.99,5),(43,6,'DVD',9.99,4.99,6),(44,7,'BlueRay',9.99,4,1),(45,7,'BlueRay',9.99,4,1),(46,7,'BlueRay',9.99,4,1),(47,7,'BlueRay',9.99,4,1),(48,7,'DVD',9.99,4,1),(49,7,'DVD',9.99,4,1),(50,7,'DVD',9.99,4,1),(51,7,'DVD',9.99,4,1),(53,8,'DVD',9.99,4,1),(54,8,'DVD',9.99,4,1),(55,8,'DVD',9.99,4,1),(56,9,'DVD',9.99,4,1),(57,9,'DVD',9.99,4,1),(58,9,'DVD',9.99,4,1),(59,9,'DVD',9.99,4,1),(60,10,'DVD',9.99,4,1),(61,10,'DVD',9.99,4,1),(62,10,'DVD',9.99,4,1),(63,10,'DVD',9.99,4,1),(64,11,'DVD',9.99,4,1),(65,11,'DVD',9.99,4,1),(66,11,'DVD',9.99,4,1),(67,11,'DVD',9.99,4,1),(68,12,'DVD',9.99,4,1),(69,12,'DVD',9.99,4,1),(70,12,'DVD',9.99,4,1),(71,12,'DVD',9.99,4,1),(72,13,'DVD',9.99,4,1),(73,13,'DVD',9.99,4,1),(74,13,'DVD',9.99,4,1),(75,13,'DVD',9.99,4,1),(76,14,'DVD',9.99,4,1),(77,14,'DVD',9.99,4,1),(78,14,'DVD',9.99,4,1),(79,14,'DVD',9.99,4,1),(80,15,'VHS',9.99,4,1),(81,15,'VHS',9.99,4,1),(82,15,'VHS',9.99,4,1),(83,15,'VHS',9.99,4,1),(84,16,'VHS',9.99,4,1),(85,16,'VHS',9.99,4,1),(86,16,'VHS',9.99,4,1),(87,16,'VHS',9.99,4,1),(88,3,'BlueRay',9.99,4,9),(89,8,'DVD',9.99,4,1);
/*!40000 ALTER TABLE `copies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `street_1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street_2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Will','Mernagh','190 Summer','#405','Malden','02148','will@gmail.com','617-519-0352'),(2,'Orla','Mernagh','190 Summer','#405','Malden','02148','orla@gmail.com','617-519-0353'),(3,'Bridget','Connolly','10 Day','Unit 2','Medford','02148','bridget@gmail.com','617-519-0354'),(4,'EÌanna','Mernagh','90 Main','Apt 5','Medford','02148','eanna@gmail.com','617-519-0355'),(5,'Will','O\'Connor','190',NULL,'mal',NULL,NULL,NULL),(6,'Peter','Pan',NULL,NULL,'Cambridge','02138','pp@pan.com',NULL),(12,'Jim','Dwyer','yada',NULL,'yada',NULL,NULL,NULL),(13,'Joan','Dwyer','yada',NULL,'somerville',NULL,NULL,NULL),(14,'EÌrner','',NULL,NULL,NULL,NULL,NULL,NULL),(19,'Judy','Stafford','bla','22',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `position` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Jim','Dalton','letmein','associate'),(2,'Sarah','Dunn','letmein','associate'),(3,'Peter','Young','letmein','associate'),(4,'Paul','Daly','letmein','owner');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `year` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `genre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `item_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (2,'Where the Wild Things Are','2009','Family','Movie'),(3,'Couples Retreat','2009','Comedy','Movie'),(4,'Transformers','2007','Action','Movie'),(5,'Good Will Hunting','1998','Drama','movie'),(6,'Peter Pan','2009','Comedy','movie'),(7,'Movie A','2009','Documentary','movie'),(8,'Movie B','2009','Documentary','movie'),(9,'Movie C','2009','Documentary','movie'),(10,'Movie D','2009','Documentary','movie'),(11,'Movie E','2009','Documentary','movie'),(12,'Movie R','2009','Documentary','movie'),(13,'Another Movie','2009','Documentary','movie'),(14,'Yet Another Movie','2009','Documentary','movie'),(15,'Still Another Movie','2009','Documentary','movie'),(16,'Still Another Movie part II','2009','Documentary','movie');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `copy_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `transaction_type` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `transaction_ammount` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `copiesForeignKey` (`copy_id`),
  KEY `customersForeignKey` (`customer_id`),
  KEY `salesForeignKey` (`employee_id`),
  CONSTRAINT `copiesForeignKey` FOREIGN KEY (`copy_id`) REFERENCES `copies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customersForeignKey` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `salesForeignKey` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (31,53,2,'2009-12-10',1,'sale',9.99),(32,53,2,'2009-12-10',1,'return',9.99),(33,3,1,'2009-12-11',1,'sale',9.99);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,'New Releases','C01'),(2,'Comedy','C02'),(3,'Award Winners','C03'),(4,'Action','C04'),(5,'Random',''),(6,'ask.sd',''),(7,'Comedyz',''),(8,'Comedygg',''),(9,'TestIt','');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-12-16 23:59:18
