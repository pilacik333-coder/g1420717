-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: mysql-345e39ab-pilacik333-9acf.a.aivencloud.com    Database: Crownfield_Hospital
-- ------------------------------------------------------
-- Server version	8.4.8

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
-- Table structure for table `ap_tbl`
--

DROP TABLE IF EXISTS `ap_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ap_tbl` (
  `ap_id` int NOT NULL AUTO_INCREMENT,
  `dr_id` varchar(5) NOT NULL,
  `pat_id` varchar(10) NOT NULL,
  `clinic_id` varchar(5) NOT NULL,
  `ap_date` date NOT NULL,
  `ap_time` time NOT NULL,
  PRIMARY KEY (`ap_id`),
  KEY `fk_dr` (`dr_id`),
  KEY `fk_pat` (`pat_id`),
  KEY `fk_clinic` (`clinic_id`),
  CONSTRAINT `fk_clinic` FOREIGN KEY (`clinic_id`) REFERENCES `clinic_tbl` (`clinic_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_dr` FOREIGN KEY (`dr_id`) REFERENCES `dr_tbl` (`dr_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pat` FOREIGN KEY (`pat_id`) REFERENCES `pat_tbl` (`pat_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ap_tbl`
--

LOCK TABLES `ap_tbl` WRITE;
/*!40000 ALTER TABLE `ap_tbl` DISABLE KEYS */;
INSERT INTO `ap_tbl` (`ap_id`, `dr_id`, `pat_id`, `clinic_id`, `ap_date`, `ap_time`) 
VALUES (1,'Dr1','OP001','cl1','2026-10-05','09:00:00'),(2,'Dr2','OP002','cl1','2026-10-05','09:30:00'),(3,'Dr1','OP003','cl1','2026-10-06','11:00:00'),(4,'Dr3','OP004','cl3','2026-10-07','14:00:00'),(5,'Dr1','OP001','cl2','2026-11-16','10:15:00'),(7,'Dr3','OP005','cl2','2026-11-26','16:30:00'),(11,'Dr1','OP006','cl1','2026-12-30','16:30:00'),(12,'Dr2','OP009','cl2','2026-12-15','11:45:00'),(13,'dr7','OP007','cl4','2027-01-13','10:00:00'),(16,'dr5','OP006','cl5','2027-01-20','11:30:00'),(18,'Dr5','OP010','cl6','2027-01-25','12:00:00'),(19,'dr1','OP008','cl6','2026-12-12','11:30:00'),(20,'Dr9','OP012','cl11','2026-12-12','13:00:00'),(21,'Dr9','OP011','cl11','2026-12-12','13:30:00'),(22,'Dr1','OP011','cl1','2026-12-21','10:00:00');
/*!40000 ALTER TABLE `ap_tbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS check_appointment_date */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`cat`@`%`*/ /*!50003 TRIGGER `check_appointment_date` BEFORE INSERT ON `ap_tbl` FOR EACH ROW BEGIN
    IF NEW.ap_date < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment date cannot be in the past';
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
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS CheckDoctorAvailability */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `CheckDoctorAvailability` BEFORE INSERT ON `ap_tbl` FOR EACH ROW BEGIN
IF EXISTS (
	SELECT *
    FROM ap_tbl
    WHERE dr_id = NEW.dr_id
		AND ap_date = NEW.ap_date
        AND ap_time = NEW.ap_time
        ) THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Doctor already has an appointment' ;
		END IF;
        END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clinic_tbl`
--

DROP TABLE IF EXISTS `clinic_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_tbl` (
  `clinic_id` varchar(5) NOT NULL,
  `clinic_name` varchar(20) NOT NULL,
  PRIMARY KEY (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_tbl`
--

LOCK TABLES `clinic_tbl` WRITE;
/*!40000 ALTER TABLE `clinic_tbl` DISABLE KEYS */;
INSERT INTO `clinic_tbl` (`clinic_id`, `clinic_name`) VALUES ('cl1','City Road'),('cl10','Sheep Hole'),('cl11','Westgate Clinic'),('cl2','Bedford'),('cl3','Croydon'),('cl4','Corby'),('cl5','Peterborough'),('cl6','Tamworth'),('cl7','Telford'),('cl8','Birmingham'),('cl9','Bristol');
/*!40000 ALTER TABLE `clinic_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diag_tbl`
--

DROP TABLE IF EXISTS `diag_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diag_tbl` (
  `diag_id` int NOT NULL AUTO_INCREMENT,
  `ap_id` int NOT NULL,
  `diag` varchar(50) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`diag_id`),
  KEY `fk_ap` (`ap_id`),
  CONSTRAINT `fk_ap` FOREIGN KEY (`ap_id`) REFERENCES `ap_tbl` (`ap_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diag_tbl`
--

LOCK TABLES `diag_tbl` WRITE;
/*!40000 ALTER TABLE `diag_tbl` DISABLE KEYS */;
INSERT INTO `diag_tbl` (`diag_id`, `ap_id`, `diag`, `notes`) VALUES (1,1,'Ocular hypertension','Review IOP'),(2,2,'Diabetic macular oedema','OCT before review'),(3,3,'Glaucoma suspect','Monitor'),(4,4,'Keratoconus','Corneal topography'),(5,5,'Ocular hypertension','Visual test'),(6,7,'Laser eye correction','Long sightedness (hyperopia) needed correction'),(7,11,'Lens disorders and refractive errors','Cataract extraction, premium IOLs, LASIK/PRK'),(8,12,'Nerve disorders','Neuro-Optic nerve disorders, visual pathway lesions'),(9,16,'Glaucoma suspect','IOP monitoring required'),(10,13,'Dry eye syndrome','Mild irritation and blurred vision. Artificial tears recommended'),(11,18,'new_patient','Patient complain on double vision'),(13,19,'eye check','routine vision check'),(14,21,'Primary open-angle glaucoma in the right eye','Eye pressure remains above target despite timolol'),(15,21,'Age-related cataract in the right eye','Cataract to be monitored'),(16,20,'Ocular hypertension','Raised pressure in left eye; topical beta-blocker unsuitable.');
/*!40000 ALTER TABLE `diag_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dr_tbl`
--

DROP TABLE IF EXISTS `dr_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dr_tbl` (
  `dr_id` varchar(5) NOT NULL,
  `dr_name` varchar(20) NOT NULL,
  `specialty` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`dr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dr_tbl`
--

LOCK TABLES `dr_tbl` WRITE;
/*!40000 ALTER TABLE `dr_tbl` DISABLE KEYS */;
INSERT INTO `dr_tbl` (`dr_id`, `dr_name`, `specialty`) VALUES ('Dr1','Dr Maya Shah','Glaucoma'),('Dr2','Dr Leo Grant','Retina'),('Dr3','Dr Priya Nair','Cornea'),('dr4','Dr Djamal',NULL),('dr5','Dr M W','Oculoplastic'),('dr6','Dr Elon Must','Pediatric Ophthalmology'),('dr7','Dr Olivia Morgan','Retina'),('dr8','Dr Sarah Patel','Cataract'),('dr9','Dr Hannah Cole','Glaucoma'),('emp1','Katarina Cute-eye','receptionist'),('emp2','Nicole Cage','receptionist');
/*!40000 ALTER TABLE `dr_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow_up`
--

DROP TABLE IF EXISTS `follow_up`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow_up` (
  `follow_id` int NOT NULL AUTO_INCREMENT,
  `ap_id` int NOT NULL,
  `sta` enum('complete','in progress','cancelled') NOT NULL,
  `priority` enum('H','U','R') NOT NULL,
  `next_ap(weeks)` int DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  PRIMARY KEY (`follow_id`),
  UNIQUE KEY `ap_id` (`ap_id`),
  UNIQUE KEY `ap_id_2` (`ap_id`),
  CONSTRAINT `fk_appp` FOREIGN KEY (`ap_id`) REFERENCES `ap_tbl` (`ap_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_followup_weeks` CHECK ((`next_ap(weeks)` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_up`
--

LOCK TABLES `follow_up` WRITE;
/*!40000 ALTER TABLE `follow_up` DISABLE KEYS */;
INSERT INTO `follow_up` (`follow_id`, `ap_id`, `sta`, `priority`, `next_ap(weeks)`, `review_date`) VALUES (1,1,'complete','H',6,'2026-11-16'),(2,2,'complete','U',4,'2026-11-02'),(3,3,'in progress','R',26,'2027-04-06'),(4,4,'in progress','R',8,'2026-12-02'),(5,5,'in progress','R',12,'2027-02-08'),(7,7,'in progress','R',4,'2026-12-24'),(8,11,'in progress','H',6,'2027-02-10'),(9,12,'in progress','U',8,'2027-02-09'),(10,13,'in progress','R',4,'2027-02-10'),(12,16,'in progress','R',4,'2027-02-17'),(13,21,'in progress','H',4,'2027-01-09'),(14,20,'in progress','R',6,'2027-01-23'),(15,19,'complete','R',NULL,NULL);
/*!40000 ALTER TABLE `follow_up` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS CalculateNextAp */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `CalculateNextAp` BEFORE INSERT ON `follow_up` FOR EACH ROW SET NEW.review_date = (
    SELECT DATE_ADD(
        ap_date,
        INTERVAL NEW.`next_ap(weeks)` WEEK
    )
    FROM ap_tbl
    WHERE ap_id = NEW.ap_id
) */;;
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
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS UpdateNextAp */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `UpdateNextAp` BEFORE UPDATE ON `follow_up` FOR EACH ROW SET NEW.review_date = (
    SELECT DATE_ADD(
        ap_date,
        INTERVAL NEW.`next_ap(weeks)` WEEK
    )
    FROM ap_tbl
    WHERE ap_id = NEW.ap_id
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `med_tbl`
--

DROP TABLE IF EXISTS `med_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `med_tbl` (
  `med_id` varchar(10) NOT NULL,
  `med_name` varchar(50) NOT NULL,
  PRIMARY KEY (`med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `med_tbl`
--

LOCK TABLES `med_tbl` WRITE;
/*!40000 ALTER TABLE `med_tbl` DISABLE KEYS */;
INSERT INTO `med_tbl` (`med_id`, `med_name`) VALUES ('med1','Latanoprost'),('med10','Visine drops'),('med11','Dorzolamide'),('med12','Brimonidine'),('med2','Timolol'),('med3','Aflibercept'),('med4','Sodium Chloride'),('med5','Natamycin'),('med6','Phenylephrine'),('med7','Tropicamide'),('med8','Cococamole'),('med9','Ketorolac');
/*!40000 ALTER TABLE `med_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pat_tbl`
--

DROP TABLE IF EXISTS `pat_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pat_tbl` (
  `pat_id` varchar(10) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `post_code` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`pat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pat_tbl`
--

LOCK TABLES `pat_tbl` WRITE;
/*!40000 ALTER TABLE `pat_tbl` DISABLE KEYS */;
INSERT INTO `pat_tbl` (`pat_id`, `first_name`, `last_name`, `post_code`) VALUES ('OP001','Amina','Yusuf','NE1 4AB'),('OP002','Daniel','Reed','N16 7QP'),('OP003','Sofia','Bennett','E8 2LD'),('OP004','Michael','Okoro','SE6 3RT'),('OP005','Adam','Pascal','NN11 2CC'),('OP006','Cat','Alin','B1 2LL'),('OP007','Nomman','Nomman','SE11 2AA'),('OP008','Sahiba','Sahiba','B22 7AA'),('OP009','Dennis ','First','B2 2CA'),('OP010','Nicole','Amasing','B16 1HS'),('OP011','Grace','Taylor','NE1 3CD'),('OP012','Omar','Lewis','SE16 8QP'),('OP013','Diana','Brooks','E6 8QP');
/*!40000 ALTER TABLE `pat_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pre_detail`
--

DROP TABLE IF EXISTS `pre_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pre_detail` (
  `det_id` int NOT NULL AUTO_INCREMENT,
  `pre_id` varchar(10) NOT NULL,
  `med_id` varchar(10) NOT NULL,
  `route` varchar(25) NOT NULL,
  `dose` varchar(25) NOT NULL,
  `freq` varchar(25) NOT NULL,
  `duration` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`det_id`),
  KEY `fk_med` (`med_id`),
  KEY `fk_prescription` (`pre_id`),
  CONSTRAINT `fk_med` FOREIGN KEY (`med_id`) REFERENCES `med_tbl` (`med_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_prescription` FOREIGN KEY (`pre_id`) REFERENCES `pre_tbl` (`pre_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pre_detail`
--

LOCK TABLES `pre_detail` WRITE;
/*!40000 ALTER TABLE `pre_detail` DISABLE KEYS */;
INSERT INTO `pre_detail` (`det_id`, `pre_id`, `med_id`, `route`, `dose`, `freq`, `duration`) VALUES (1,'pre1','med1','eye drops','1 drops','2 x day','5 days'),(2,'pre1','med2','eye drops','1 drop','3 x day','5 days'),(3,'pre2','med3','Intravitreal injection','2 mg','1 x monthly','3 months'),(5,'pre4','med4','eye drops','1 drop','2 x day','5 days'),(6,'pre5','med1','eye drops','1 drop','once daily','30 days'),(7,'pre6','med2','eye drops','1 drop','twice daily','30 days'),(8,'pre7','med4','eye drops','1 drop','twice daily','7 days'),(9,'pre8','med9','eye drops','1 drop','four times daily','7 days'),(10,'pre9','med1','eye drops','1 drop','once daily','30 days'),(12,'pre10','med1','eye drops','1 drop','once daily','7 days'),(15,'pre12','med2','Ophthalmic','1 drop in right eye','Twice daily','Ongoing until review'),(16,'pre12','med11','Ophthalmic','1 drop in right eye','Twice daily','Ongoing until review'),(17,'pre14','med12','Ophthalmic','1 drop','Twice daily','Ongoing');
/*!40000 ALTER TABLE `pre_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pre_tbl`
--

DROP TABLE IF EXISTS `pre_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pre_tbl` (
  `pre_id` varchar(10) NOT NULL,
  `ap_id` int NOT NULL,
  `pre_date` date DEFAULT NULL,
  PRIMARY KEY (`pre_id`),
  KEY `fk_appoitment` (`ap_id`),
  CONSTRAINT `fk_appoitment` FOREIGN KEY (`ap_id`) REFERENCES `ap_tbl` (`ap_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pre_tbl`
--

LOCK TABLES `pre_tbl` WRITE;
/*!40000 ALTER TABLE `pre_tbl` DISABLE KEYS */;
INSERT INTO `pre_tbl` (`pre_id`, `ap_id`, `pre_date`) VALUES ('pre1',1,'2026-10-05'),('pre10',16,'2027-01-20'),('pre11',18,'2027-01-25'),('pre12',21,'2026-12-12'),('pre14',20,NULL),('pre2',2,'2026-10-05'),('pre4',4,'2026-10-07'),('pre5',5,'2026-11-16'),('pre6',7,'2026-11-26'),('pre7',11,'2026-12-30'),('pre8',12,'2026-12-15'),('pre9',13,'2027-01-13');
/*!40000 ALTER TABLE `pre_tbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12 22:22:34
