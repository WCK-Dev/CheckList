-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: checklist
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `a_checked` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N',
  `a_regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `a_modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `a_modifydate` timestamp NULL DEFAULT NULL,
  `u_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `c_seq` int NOT NULL,
  PRIMARY KEY (`u_id`,`c_seq`),
  KEY `FK_cseq` (`c_seq`),
  CONSTRAINT `FK_cseq` FOREIGN KEY (`c_seq`) REFERENCES `checklist` (`c_seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_uid` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자 체크리스트 답변 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES ('N','2020-09-23 05:38:26',NULL,NULL,'wck',19),('N','2020-09-23 05:38:26',NULL,NULL,'wck',20),('N','2020-09-23 05:38:26',NULL,NULL,'wck',21),('Y','2020-09-23 05:38:26',NULL,NULL,'wck',22),('N','2020-09-23 05:38:26',NULL,NULL,'wck',23),('N','2020-09-23 05:38:26',NULL,NULL,'wck',24),('N','2020-09-23 05:38:26',NULL,NULL,'wck',25),('N','2020-09-23 05:38:26',NULL,NULL,'wck',26);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `b_seq` int NOT NULL AUTO_INCREMENT,
  `b_title` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `b_comment` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `b_regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `b_writer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `b_topYN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N',
  `b_modifier` varchar(100) DEFAULT NULL,
  `b_modifydate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`b_seq`),
  KEY `FK_b_writer` (`b_writer`),
  CONSTRAINT `FK_b_writer` FOREIGN KEY (`b_writer`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각 체크리스트 글 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (19,'##사업부 위생관리 체크리스트( 2020_09_23 )','특이사항 : \r\n\r\n1. 청소담당자는 매일 청소후 check리스트를 작성한다\r\n\r\n2. 점검자는 양호한 상태에만 체크박스에 체크를 기입한다.','2020-09-23 03:25:58','admin','Y',NULL,NULL),(31,'1','1','2020-09-23 09:20:54','admin','N','admin','2020-09-23 09:23:13'),(32,'3','3','2020-09-23 09:21:01','admin','N','admin','2020-09-23 09:23:17'),(33,'3','5','2020-09-23 09:21:08','admin','N','admin','2020-09-23 09:23:22'),(34,'6','6','2020-09-23 09:21:22','admin','N',NULL,NULL),(35,'7','7','2020-09-23 09:21:32','admin','N',NULL,NULL),(36,'8','8','2020-09-23 09:21:44','admin','N',NULL,NULL),(37,'9','9','2020-09-23 09:21:55','admin','N',NULL,NULL),(38,'10','10','2020-09-23 09:22:07','admin','N',NULL,NULL),(39,'11','11','2020-09-23 09:22:20','admin','N',NULL,NULL),(40,'12','12','2020-09-23 09:22:28','admin','Y','admin','2020-09-23 09:23:07');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklist` (
  `c_seq` int NOT NULL AUTO_INCREMENT,
  `c_name` varchar(100) NOT NULL,
  `b_seq` int NOT NULL,
  PRIMARY KEY (`c_seq`),
  KEY `FK_b_seq` (`b_seq`),
  CONSTRAINT `FK_b_seq` FOREIGN KEY (`b_seq`) REFERENCES `board` (`b_seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각 작성글별 체크리스트 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
INSERT INTO `checklist` VALUES (19,'좌변기 / 소변기 청결상태 체크',19),(20,'휴지걸이의 휴지 충분여부',19),(21,'세면대의 청결상태 여부',19),(22,'세면대에 세정제 비치 여부',19),(23,'바닥 청결상태 양호도',19),(24,'환풍기의 정상작동',19),(25,'용기의 파손부위 여부',19),(26,'변기 / 하수구 등의 막힘 여부',19),(67,'1',31),(68,'3',32),(69,'3',33),(70,'6',34),(71,'7',35),(72,'8',36),(73,'9',37),(74,'10',38),(75,'11',39),(76,'12',40);
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `l_seq` int NOT NULL AUTO_INCREMENT,
  `l_readdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `u_id` varchar(100) NOT NULL,
  `b_seq` int NOT NULL,
  PRIMARY KEY (`l_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자별 조회 / 답변 로그 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2020-09-23 06:06:08','wck',14),(2,'2020-09-23 03:02:03','wck',17),(3,'2020-09-23 03:02:36','user2',14),(4,'2020-09-23 01:07:23','user3',14),(5,'2020-09-23 01:07:20','user3',18),(6,'2020-09-23 01:09:09','user1',18),(7,'2020-09-23 09:12:04','wck',19);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showlist`
--

DROP TABLE IF EXISTS `showlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showlist` (
  `u_id` varchar(100) NOT NULL,
  `b_seq` int NOT NULL,
  PRIMARY KEY (`u_id`,`b_seq`),
  KEY `FK_show_bseq` (`b_seq`),
  CONSTRAINT `FK_show_bseq` FOREIGN KEY (`b_seq`) REFERENCES `board` (`b_seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_show_uid` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시글을 보여줄 사용자 리스트 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showlist`
--

LOCK TABLES `showlist` WRITE;
/*!40000 ALTER TABLE `showlist` DISABLE KEYS */;
INSERT INTO `showlist` VALUES ('user3',19),('user5',19),('wck',19),('wck',31),('wck',32),('wck',33),('wck',34),('wck',35),('wck',36),('wck',37),('wck',38),('wck',39),('wck',40);
/*!40000 ALTER TABLE `showlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `u_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `u_pwd` varchar(100) NOT NULL,
  `u_name` varchar(100) NOT NULL,
  `u_roll` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'user',
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','1234','관리자','admin'),('user1','1234','사용자1','user'),('user2','1234','사용자2','user'),('user3','1234','사용자3','user'),('user4','1234','사용자4','user'),('user5','1234','사용자5','user'),('wck','1234','우치경','user');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-23 18:31:28
