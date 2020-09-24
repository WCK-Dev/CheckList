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
INSERT INTO `answer` VALUES ('N','2020-09-24 02:04:09','user1','2020-09-24 02:40:31','user1',77),('Y','2020-09-24 02:04:09','user1','2020-09-24 02:40:31','user1',79),('N','2020-09-24 02:40:38',NULL,NULL,'user1',82),('N','2020-09-24 02:40:38',NULL,NULL,'user1',83),('Y','2020-09-24 02:40:38',NULL,NULL,'user1',84),('N','2020-09-24 02:40:38',NULL,NULL,'user1',85),('Y','2020-09-24 02:40:38',NULL,NULL,'user1',86),('N','2020-09-24 02:40:38',NULL,NULL,'user1',118),('Y','2020-09-24 02:04:09','user1','2020-09-24 02:40:32','user1',119),('N','2020-09-24 02:04:09','user1','2020-09-24 02:40:32','user1',120),('N','2020-09-24 02:59:23',NULL,NULL,'user2',77),('N','2020-09-24 02:59:23',NULL,NULL,'user2',79),('Y','2020-09-24 02:59:23',NULL,NULL,'user2',119),('N','2020-09-24 02:59:23',NULL,NULL,'user2',120),('N','2020-09-24 02:59:20',NULL,NULL,'user2',129),('Y','2020-09-24 02:59:20',NULL,NULL,'user2',130),('Y','2020-09-24 02:59:20',NULL,NULL,'user2',131),('N','2020-09-24 02:59:20',NULL,NULL,'user2',132),('N','2020-09-24 02:59:20',NULL,NULL,'user2',133),('N','2020-09-24 02:59:31',NULL,NULL,'user4',100),('Y','2020-09-24 02:59:31',NULL,NULL,'user4',101),('N','2020-09-24 02:59:47',NULL,NULL,'user5',77),('N','2020-09-24 02:59:47',NULL,NULL,'user5',79),('Y','2020-09-24 02:59:47',NULL,NULL,'user5',119),('N','2020-09-24 02:59:47',NULL,NULL,'user5',120),('N','2020-09-23 05:38:26',NULL,NULL,'wck',19),('N','2020-09-23 05:38:26',NULL,NULL,'wck',20),('N','2020-09-23 05:38:26',NULL,NULL,'wck',21),('Y','2020-09-23 05:38:26',NULL,NULL,'wck',22),('N','2020-09-23 05:38:26',NULL,NULL,'wck',23),('N','2020-09-23 05:38:26',NULL,NULL,'wck',24),('N','2020-09-23 05:38:26',NULL,NULL,'wck',25),('N','2020-09-23 05:38:26',NULL,NULL,'wck',26),('Y','2020-09-24 02:00:39','wck','2020-09-24 02:03:35','wck',77),('Y','2020-09-24 02:00:39','wck','2020-09-24 02:03:36','wck',79),('N','2020-09-24 02:40:59',NULL,NULL,'wck',82),('Y','2020-09-24 02:40:59',NULL,NULL,'wck',83),('N','2020-09-24 02:40:59',NULL,NULL,'wck',84),('Y','2020-09-24 02:40:59',NULL,NULL,'wck',85),('N','2020-09-24 02:40:59',NULL,NULL,'wck',86),('N','2020-09-24 02:58:57',NULL,NULL,'wck',92),('N','2020-09-24 02:58:57',NULL,NULL,'wck',93),('Y','2020-09-24 02:58:57',NULL,NULL,'wck',94),('N','2020-09-24 02:58:57',NULL,NULL,'wck',95),('Y','2020-09-24 02:33:10',NULL,NULL,'wck',102),('Y','2020-09-24 02:33:10',NULL,NULL,'wck',103),('N','2020-09-24 02:33:10',NULL,NULL,'wck',104),('N','2020-09-24 02:40:59',NULL,NULL,'wck',118),('N','2020-09-24 02:03:04','wck','2020-09-24 02:03:36','wck',119),('Y','2020-09-24 02:03:04','wck','2020-09-24 02:03:36','wck',120),('Y','2020-09-24 02:45:34','wck','2020-09-24 02:46:09','wck',134),('Y','2020-09-24 02:45:34','wck','2020-09-24 02:46:09','wck',135),('Y','2020-09-24 02:45:34','wck','2020-09-24 02:46:09','wck',136),('N','2020-09-24 02:45:34','wck','2020-09-24 02:46:09','wck',137),('Y','2020-09-24 02:45:34','wck','2020-09-24 02:46:09','wck',140),('Y','2020-09-24 02:45:34','wck','2020-09-24 02:46:09','wck',141),('Y','2020-09-24 02:46:09',NULL,NULL,'wck',142);
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각 체크리스트 글 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (19,'##사업부 위생관리 체크리스트( 2020_09_23 )','특이사항 : \r\n\r\n1. 청소담당자는 매일 청소후 check리스트를 작성한다\r\n\r\n2. 점검자는 양호한 상태에만 체크박스에 체크를 기입한다.','2020-09-23 03:25:58','admin','Y',NULL,NULL),(41,'안전사고 예방 체크리스트(체크리스트 항목 수정)','행사 관련 안전사고 예방 및 발생시 대처방안을 위한 체크리스트입니다.\r\n\r\n필히 확인하신 후 답변 부탁드립니다.','2020-09-24 00:41:03','adm','Y','adm','2020-09-24 02:04:00'),(43,'창업시 평가사항 체크리스트(수정)','창업 계획시에 고려해야 할 사전 준비 여건 체크리스트입니다.\r\n\r\n창업을 계획하고 있거나 고민하시는 분들은 사전에 체크를 통해 점검해보시기 바랍니다.\r\n\r\n\r\n(adm계정이 수정합니다)','2020-09-24 01:15:42','admin','N','adm','2020-09-24 01:40:45'),(44,'집중력 자체진단 체크리스트','집중력 자체진단 체크리스트입니다.','2020-09-24 01:18:24','admin','N',NULL,NULL),(45,'위험성 평가 체크리스트','건설현장 위험성 평가 체크리스트입니다.','2020-09-24 01:20:05','admin','N',NULL,NULL),(46,'건물 노후화 체크리스트','건물 노후화 체크리스트입니다.\r\n\r\n해당 항목에 대해 양호한 상태일때만 체크해주시면 됩니다.','2020-09-24 01:22:23','admin','N',NULL,NULL),(47,'사내 직원 업무전 체크리스트','사내 직원 업무전 체크리스트입니다.\r\n\r\n매일 출근시 업무시작전에 체크하여 답변해주시기 바랍니다.','2020-09-24 01:24:13','admin','N',NULL,NULL),(48,'업무 수행시 방해요인 제거 체크리스트','방해요인 체크리스트입니다\r\n\r\n꼭 확인하고 정상적인 업무수행에 임해주시기 바랍니다.','2020-09-24 01:37:29','admin','N',NULL,NULL),(49,'테스트 체크리스트','테스트 체크리스트입니다.\r\n\r\n정상적인 작동이 되는지 확인해보세요','2020-09-24 01:38:04','admin','N',NULL,NULL),(50,'관리자 계정 테스트','1234','2020-09-24 01:38:30','adm','N',NULL,NULL),(55,'오늘의 집 하자보수 체크리스트','오늘의 집에서 작성한\r\n\r\n체크리스트 목록을 등록합니다.','2020-09-24 02:44:13','admin','N',NULL,NULL),(56,'생필품 구매 체크리스트','생필품 구매 체크리스트입니다.\r\n\r\n구매시에 참고해보세요','2020-09-24 02:45:16','admin','N','admin','2020-09-24 02:45:57');
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
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각 작성글별 체크리스트 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
INSERT INTO `checklist` VALUES (19,'좌변기 / 소변기 청결상태 체크',19),(20,'휴지걸이의 휴지 충분여부',19),(21,'세면대의 청결상태 여부',19),(22,'세면대에 세정제 비치 여부',19),(23,'바닥 청결상태 양호도',19),(24,'환풍기의 정상작동',19),(25,'용기의 파손부위 여부',19),(26,'변기 / 하수구 등의 막힘 여부',19),(77,'사전 안전교육',41),(79,'안전관리 요원 편성',41),(82,'창업분야 시장 이해도',43),(83,'충분한 사전조사와 포지셔닝 계획',43),(84,'사업진행중 어려움 발생시 대비책',43),(85,'안정적인 자금관리와 지속적인 기술개발',43),(86,'변동되는 시장 상황에 대한 대처능력',43),(87,'특정 업무수행시 오랜시간 집중할 수 있다',44),(88,'생각을 다방면으로 충분히 한 후 계획을 실행한다',44),(89,'최근 1년간 안전사고 발생 이력이 있다',45),(90,'엘리베이터 입구부 자재 낙하위험이 있다',45),(91,'차폐판 설치 작업중 추락위험이 있다',45),(92,'출입문 설치 및 작동상태 양호도',46),(93,'전실 바닥 마감상태 양호도',46),(94,'천정 및 구석부분 파손상태 양호도',46),(95,'벽체 및 건물 내 외부 도배마감 양호도',46),(96,'당일 업무 계획 확인',47),(97,'전일 업무보고 작성 확인',47),(98,'투입 프로젝트 확인',47),(99,'업무환경 주변정리',47),(100,'불필요한 소음의 발생여부',48),(101,'휴대폰이나 전자기기의 매너모드 확인',48),(102,'테스트 체크리스트입니다',49),(103,'확인해주세요',49),(104,'체크해보세요',49),(105,'두번쨰',50),(106,'관리',50),(107,'계정',50),(118,'adm체크리스트',43),(119,'개인 안전보호용품 착용',41),(120,'주변 위험물품 제거',41),(129,'노후된 수도와 난방배관',55),(130,'베란다 혹은 벽의 균열',55),(131,'벽면사이 석회질이 생긴 새시',55),(132,'손상이 심한 벽면과 문틀',55),(133,'벽지 들뜸과 곰팡이 자국이 있는 벽 단열',55),(134,'계량컵',56),(135,'칫솔',56),(136,'변기커버',56),(137,'조미료',56),(140,' 호일',56),(141,'빨래망',56),(142,'싱크대 거름망',56);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자별 조회 / 답변 로그 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2020-09-23 06:06:08','wck',14),(2,'2020-09-23 03:02:03','wck',17),(3,'2020-09-23 03:02:36','user2',14),(4,'2020-09-23 01:07:23','user3',14),(5,'2020-09-23 01:07:20','user3',18),(6,'2020-09-23 01:09:09','user1',18),(7,'2020-09-24 02:58:46','wck',19),(8,'2020-09-24 02:39:43','wck',41),(9,'2020-09-24 01:10:46','wck',32),(10,'2020-09-24 01:10:48','wck',31),(11,'2020-09-24 01:58:57','wck',53),(12,'2020-09-24 02:00:00','user1',52),(13,'2020-09-24 01:59:31','user2',52),(14,'2020-09-24 02:59:11','user1',41),(15,'2020-09-24 02:39:25','wck',51),(16,'2020-09-24 02:39:27','wck',50),(17,'2020-09-24 02:39:28','wck',48),(18,'2020-09-24 02:40:57','wck',43),(19,'2020-09-24 02:39:33','wck',44),(20,'2020-09-24 02:58:51','wck',45),(21,'2020-09-24 02:58:54','wck',46),(22,'2020-09-24 02:26:30','wck',47),(23,'2020-09-24 02:39:29','wck',49),(24,'2020-09-24 02:59:10','user1',43),(25,'2020-09-24 02:47:36','wck',56),(26,'2020-09-24 02:59:17','user2',55),(27,'2020-09-24 02:59:21','user2',41),(28,'2020-09-24 02:59:29','user4',48),(29,'2020-09-24 02:59:44','user5',41);
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
INSERT INTO `showlist` VALUES ('user3',19),('user5',19),('wck',19),('user1',41),('user2',41),('user3',41),('user5',41),('wck',41),('user1',43),('user3',43),('user4',43),('wck',43),('user3',44),('wck',44),('wck',45),('wck',46),('wck',47),('user4',48),('wck',48),('user3',49),('wck',49),('wck',50),('user2',55),('wck',55),('user3',56),('wck',56);
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
INSERT INTO `user` VALUES ('adm','1234','관리자계정2','admin'),('admin','1234','관리자','admin'),('user1','1234','사용자1','user'),('user2','1234','사용자2','user'),('user3','1234','사용자3','user'),('user4','1234','사용자4','user'),('user5','1234','사용자5','user'),('wck','1234','우치경','user');
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

-- Dump completed on 2020-09-24 13:30:01
