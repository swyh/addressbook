-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: addressbook
-- ------------------------------------------------------
-- Server version	5.6.35

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
-- Table structure for table `allgroup`
--

DROP TABLE IF EXISTS `allgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allgroup` (
  `group_idx` int(11) NOT NULL AUTO_INCREMENT,
  `mygroup` varchar(10) NOT NULL,
  PRIMARY KEY (`group_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allgroup`
--

LOCK TABLES `allgroup` WRITE;
/*!40000 ALTER TABLE `allgroup` DISABLE KEYS */;
INSERT INTO `allgroup` VALUES (10,'내연락처'),(11,'고등학교'),(12,'중학교'),(13,'군인들'),(16,'기타'),(17,'초등학교');
/*!40000 ALTER TABLE `allgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `group_idx` int(11) NOT NULL DEFAULT '1',
  `name` varchar(10) NOT NULL,
  `image` tinytext,
  `phone` varchar(11) NOT NULL,
  `email` varchar(25) DEFAULT NULL,
  `affiliation` varchar(10) DEFAULT NULL,
  `department` varchar(10) DEFAULT NULL,
  `duty` varchar(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `homepage` varchar(50) DEFAULT NULL,
  `SNS` varchar(20) DEFAULT NULL,
  `ID` varchar(12) DEFAULT NULL,
  `memo` varchar(50) DEFAULT NULL,
  `trash` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idx`),
  KEY `group_idx` (`group_idx`),
  CONSTRAINT `people_ibfk_1` FOREIGN KEY (`group_idx`) REFERENCES `allgroup` (`group_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (19,10,'양장피','default.gif','01022223333','','naver','','','0001-01-01','','','','','잘생김',0),(20,10,'송리','default.gif','01099998888','songLee@naver.com','3반','컴퓨터','학생','1995-12-01','경기도 안양','','sktm','sktm34','노력파',1),(21,10,'모루토','default.gif','01094943232','korean@naver.com','3반','컴퓨터','학생','0001-01-01','','','','','',0),(22,10,'김텐텐','default.gif','01011114444','1010@daum.net','3반','컴퓨터','학생','0001-01-01','','','','','',0),(23,13,'꿀꾸리','default.gif','01022224444','','농장','','','0001-01-01','','','','','',0),(24,11,'제우스','default.gif','01084883333','','','','','0000-01-01','','','','','',0),(25,12,'아폴론','default.gif','01022225555','','','','','0000-01-01','','','','','',0),(26,10,'김덕순','default.gif','01022223333','','','','','0000-01-01','','','','','',0),(27,10,'더파이팅','default.gif','11124424444','','','','','0001-01-01','','','','','',0),(28,12,'고장','default.gif','01099987774','','','','','0000-01-01','','','','','',0),(29,10,'김마','default.gif','01099997777','','','','','0000-01-01','','','','','',0),(30,10,'덕만이','default.gif','01022225555','','','','','1990-12-12','','','','','',0),(31,10,'백수','default.gif','01044443333','','','','','0001-01-01','','','','','',0),(32,10,'김영분','default.gif','11155553333','','','','','0001-01-01','','','','','',0),(34,16,'아니오치킨','default.gif','01055556666','','','','','0001-01-01','','','','','',1),(35,10,'피자헛','default.gif','01036664555','','','','','0000-01-01','','','','','',0),(37,11,'김인성','default.gif','01033334444','','','','','0000-01-01','','','','','',1);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-18 14:42:27
