-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: checklist
-- ------------------------------------------------------
-- Server version	8.0.18

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
  `a_modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `u_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `c_seq` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `b_seq` int(11) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각 체크리스트 글 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (14,'새 체크리스트 작성','해당 유저들은 오늘안에 체크리스트 작성 부탁합니다.','2020-09-21 08:53:06','admin','Y',NULL,NULL),(17,'상단 비노출 체크리스트','체크항목에 모두 답변해주세요','2020-09-21 13:56:32','admin','N',NULL,NULL);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklist` (
  `c_seq` int(11) NOT NULL AUTO_INCREMENT,
  `c_name` varchar(100) NOT NULL,
  `b_seq` int(11) NOT NULL,
  PRIMARY KEY (`c_seq`),
  KEY `FK_b_seq` (`b_seq`),
  CONSTRAINT `FK_b_seq` FOREIGN KEY (`b_seq`) REFERENCES `board` (`b_seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각 작성글별 체크리스트 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
INSERT INTO `checklist` VALUES (11,'체크리스트1',14),(12,'체크리스트2',14),(13,'체크리스트3',14),(14,'체크항목 3',17),(15,'체크항목 4',17);
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `l_seq` int(11) NOT NULL AUTO_INCREMENT,
  `l_readdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `u_id` varchar(100) NOT NULL,
  `b_seq` int(11) NOT NULL,
  PRIMARY KEY (`l_seq`),
  KEY `FK_u_id` (`u_id`),
  KEY `FK_log_bseq` (`b_seq`),
  CONSTRAINT `FK_log_bseq` FOREIGN KEY (`b_seq`) REFERENCES `board` (`b_seq`),
  CONSTRAINT `FK_u_id` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자별 조회 / 답변 로그 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
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
  `b_seq` int(11) NOT NULL,
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
INSERT INTO `showlist` VALUES ('user2',14),('user3',14),('user5',14),('wck',14),('user3',17),('user4',17),('wck',17);
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

-- Dump completed on 2020-09-21 22:57:37
