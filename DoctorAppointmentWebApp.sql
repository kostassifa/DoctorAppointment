CREATE DATABASE  IF NOT EXISTS `doctorappointmentwebapp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `doctorappointmentwebapp`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: doctorappointmentwebapp
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `appoitment`
--

DROP TABLE IF EXISTS `appoitment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appoitment` (
  `category` varchar(255) DEFAULT NULL,
  `Doctor` varchar(255) DEFAULT NULL,
  `Appoitment_Date` date DEFAULT NULL,
  `Appoitment_Time` time DEFAULT NULL,
  `book_notes` varchar(3000) DEFAULT NULL,
  `amka` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appoitment`
--

LOCK TABLES `appoitment` WRITE;
/*!40000 ALTER TABLE `appoitment` DISABLE KEYS */;
INSERT INTO `appoitment` VALUES ('Cardiology','Doctor_4','2024-09-23','09:30:00','test','41410057935'),('Cardiology','Doctor_4','2024-09-20','17:00:00','test','6238616012'),('Dermatology','Doctor_3','2024-09-21','13:00:00','test','6238616012'),('Gastroenterology','Doctor_6','2024-11-03','09:30:00','TSET','74537996342'),('Gastroenterology','Doctor_6','2024-10-08','10:00:00','TEST','74537996342'),('Dermatology','Doctor_3','2024-10-01','09:30:00','test','12345678902'),('Cardiology','Doctor_4','2024-09-26','11:00:00','TEST','74537996342'),('Cardiology','κατερινα λαζαρη','2024-09-27','09:30:00','TEST','74537996342'),('Cardiology','κατερινα λαζαρη','2024-10-02','10:00:00','test','6238616012'),('Dermatology','Doctor_3','2024-09-30','09:00:00','test','6238616012'),('Gastroenterology','Doctor_6','2024-09-30','10:00:00','tets','6238616012'),('Dermatology','Doctor_5','2024-10-03','11:00:00','test','6238616012'),('Dermatology','Doctor_5','2024-09-30','10:30:00','test','12345678901'),('Dermatology','Doctor_5','2024-10-10','09:00:00','test','6238616012'),('Cardiology','κατερινα λαζαρη','2024-10-03','11:00:00','test','6238616012'),('Dermatology','Doctor_5','2024-10-23','09:30:00','test','6238616012'),('Cardiology','κατερινα λαζαρη','2024-10-04','12:00:00','test','6238616012');
/*!40000 ALTER TABLE `appoitment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `city` text,
  `lat` text,
  `lng` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES ('Athens','37.9842','23.7281'),('Thessaloníki','40.6403','22.9347'),('Piraeus','37.9430','23.6469'),('Irákleio','35.3403','25.1344'),('Pátra','38.2500','21.7333'),('Lárisa','39.6417','22.4167'),('Peristéri','38.0167','23.6833'),('Acharnés','38.0833','23.7333'),('Kallithéa','37.9500','23.7000'),('Kalamariá','40.5833','22.9500'),('Glyfáda','37.8667','23.7500'),('Níkaia','37.9667','23.6333'),('Vólos','39.3667','22.9333'),('Ílion','38.0333','23.7000'),('Évosmos','40.6689','22.9083'),('Ilioúpoli','37.9333','23.7500'),('Chalándri','38.0167','23.8000'),('Keratsíni','37.9667','23.6167'),('Néa Smýrni','37.9500','23.7167'),('Maroúsi','38.0500','23.8000'),('Ágios Dimítrios','37.9333','23.7333'),('Zográfos','37.9783','23.7717'),('Aigáleo','37.9920','23.6780'),('Néa Ionía','38.0333','23.7500'),('Kavála','40.9333','24.4000'),('Ioánnina','39.6636','20.8522'),('Palaió Fáliro','37.9333','23.7000'),('Korydallós','37.9833','23.6500'),('Agía Paraskeví','38.0117','23.8200'),('Výronas','37.9617','23.7533'),('Galátsi','38.0167','23.7500'),('Chalkída','38.4625','23.5950'),('Petroúpoli','38.0333','23.6833'),('Kalamáta','37.0378','22.1111'),('Ródos','36.4412','28.2225'),('Thérmi','40.5500','23.0167'),('Pallíni','38.0000','23.8833'),('Komotiní','41.1219','25.4042'),('Chaniá','35.5167','24.0167'),('Irákleio','38.0500','23.7667'),('Lamía','38.9000','22.4333'),('Kifisiá','38.0833','23.8167'),('Chaïdári','38.0167','23.6500'),('Stavroúpoli','40.6667','22.9333'),('Kozáni','40.3000','21.7833'),('Álimos','37.9167','23.7167'),('Kardítsa','39.3667','21.9167'),('Oraiókastro','40.7333','22.9167'),('Lagkadás','40.7500','23.0667'),('Pylaía','40.6000','22.9833'),('Ampelókipoi','40.6500','22.9167'),('Sykiés','40.6500','22.9500'),('Ágioi Anárgyroi','38.0267','23.7183'),('Argyroúpoli','37.9000','23.7500'),('Áno Liósia','38.0833','23.7000'),('Vrilíssia','38.0333','23.8333'),('Ptolemaḯda','40.5167','21.6833'),('Salamína','37.9667','23.5000'),('Cholargós','38.0000','23.8000'),('Kórinthos','37.9386','22.9272'),('Giannitsá','40.7833','22.4000'),('Trípoli','37.5167','22.3833'),('Asprópyrgos','38.0667','23.5833'),('Gérakas','38.0333','23.8500'),('Metamórfosi','38.0500','23.7500'),('Amaliáda','37.8000','21.3500'),('Voúla','37.8500','23.7500'),('Kamateró','38.0597','23.7120'),('Mytilíni','39.1000','26.5500'),('Ágios Nikólaos','35.1833','25.7167'),('Chíos','38.3725','26.1375'),('Paianía','37.9500','23.8500'),('Agía Varvára','38.0000','23.6500'),('Kaisarianí','37.9683','23.7583'),('Grevená','40.0850','21.4275'),('Néa Filadélfeia','38.0367','23.7367'),('Moscháto','37.9500','23.6667'),('Pérama','37.9667','23.5667'),('Elefsína','38.0333','23.5333'),('Kérkyra','39.6239','19.9214'),('Pýrgos','37.6667','21.4333'),('Kilkís','40.9833','22.8667'),('Dáfni','37.9500','23.7333'),('Melíssia','38.0500','23.8333'),('Árgos','37.6167','22.7167'),('Árta','39.1650','20.9875'),('Artémida','37.9667','24.0000'),('Péfki','38.0667','23.8000'),('Irákleia','41.1833','23.2833'),('Aígio','38.2506','22.0811'),('Kos','36.8500','27.2333'),('Gázi','35.3250','25.0667'),('Koropí','37.9000','23.8733'),('Orestiáda','41.5000','26.5333'),('Skýdra','40.7667','22.1500'),('Édessa','40.8000','22.0500'),('Flórina','40.7833','21.4000'),('Panórama','40.5833','23.0333'),('Néa Erythraía','38.0833','23.8167'),('Ellinikó','37.8667','23.7333'),('Peraía','40.5000','22.9250'),('Néa Mákri','38.0833','23.9833'),('Kastoriá','40.5167','21.2667'),('Spárti','37.0739','22.4294'),('Ágios Ioánnis Réntis','37.9667','23.6667'),('Alexándreia','40.6333','22.4500'),('Vári','37.8333','23.8000'),('Efkarpía','40.6833','22.9500'),('Távros','37.9667','23.6950'),('Chrysoúpoli','40.9833','24.7000'),('Néa Alikarnassós','35.3167','25.1833'),('Kalývia Thorikoú','37.8333','23.9167'),('Náfplio','37.5658','22.8000'),('Drapetsóna','37.9467','23.6250'),('Ermoúpoli','37.4333','24.9167'),('Papágos','37.9900','23.7933'),('Péfka','40.6500','22.9833'),('Náfpaktos','38.3939','21.8306'),('Xylókastro','38.0667','22.6333'),('Giánnouli','39.6667','22.4000'),('Ierápetra','35.0117','25.7414'),('Rafína','38.0167','24.0000'),('Anatolí','39.6333','20.8667'),('Ialysós','36.4167','28.1500'),('Týrnavos','39.7333','22.2833'),('Glyká Nerá','37.9917','23.8483'),('Vochaïkó','37.9333','22.8000'),('Ymittós','37.9500','23.7333'),('Arkalochóri','35.1441','25.2606'),('Néo Karlovási','37.7833','26.7000'),('Néo Psychikó','38.0000','23.7833'),('Tympáki','35.0667','24.7667'),('Zefýri','38.0667','23.7167'),('Diavatá','40.6883','22.8583'),('Messíni','37.0500','22.0000'),('Kiáto','38.0117','22.7467'),('Lykóvrysi','38.0667','23.7833'),('Pórto Ráfti','37.8869','24.0042'),('Psychikó','38.0167','23.7667'),('Néa Artáki','38.5167','23.6333'),('Néa Moudaniá','40.2333','23.2833'),('Fársala','39.3000','22.3833'),('Síndos','40.6667','22.8000'),('Spáta','37.9667','23.9167'),('Zacháro','37.4833','21.6500'),('Árgos Orestikó','40.4500','21.2500'),('Néa Michanióna','40.4644','22.8606'),('Soúda','35.4833','24.0667'),('Néa Péramos','38.0000','23.4167'),('Vélo','37.9667','22.7833'),('Spercheiáda','38.9167','22.1333'),('Amýntaio','40.6833','21.6833'),('Mourniés','35.4850','24.0130'),('Ampelákia','37.9500','23.5167'),('Krýa Vrýsi','40.6833','22.3000'),('Néa Kallikráteia','40.3139','23.0633'),('Schimatári','38.3500','23.5833'),('Lixoúri','38.3000','20.4167'),('Lávrio','37.7000','24.0500'),('Náxos','37.1019','25.3794'),('Aígina','37.7467','23.4275'),('Kárystos','38.0167','24.4167'),('Káto Achaḯa','38.1500','21.5500'),('Aridaía','40.9667','22.0500'),('Diónysos','38.1000','23.8667'),('Asvestochóri','40.6417','23.0250'),('Kounoupidianá','35.5360','24.0760'),('Anávyssos','37.7333','23.9500'),('Néoi Epivátes','40.5010','22.9090'),('Vartholomió','37.8667','21.2000'),('Itéa','38.4333','22.4250'),('Lefkímmi','39.4167','20.0667'),('Megalópoli','37.4000','22.1333'),('Tínos','37.5333','25.1667'),('Mýrina','39.8833','25.0667'),('Agriá','39.3333','23.0333'),('Makrakómi','38.9333','22.1167'),('Nerokoúros','35.4758','24.0383'),('Fílyro','40.6911','23.0042'),('Plagiári','40.4728','22.9578'),('Kremastí','36.4120','28.1207'),('Río','38.3028','21.7847'),('Alykés','37.8333','20.7667'),('Makrochóri','40.5486','22.2417'),('Kyparissía','37.2500','21.6667'),('Sélero','41.1333','25.0000'),('Magoúla','38.0833','23.5167'),('Pentéli','38.0504','23.8613'),('Alivéri','38.4167','24.0333'),('Léfktro','36.8500','22.2667'),('Kalochóri','40.6409','22.8578'),('Vrachnaíika','38.1617','21.6667'),('Filippiáda','39.2000','20.8833'),('Vouliagméni','37.8000','23.7833'),('Néa Magnisía','40.6883','22.8433'),('Kíssamos','35.4833','23.6500'),('Kítsi','37.8456','23.8267'),('Katsikás','39.6167','20.8833'),('Néa Raidestós','40.5250','23.0533'),('Potamós','39.6236','19.8783'),('Spétses','37.2575','23.1400'),('Stavrós','40.6650','23.6967'),('Lagyná','40.7238','23.0050'),('Néa Péramos','40.8383','24.3033'),('Palaiá Fókaia','37.7167','23.9500'),('Kardiá','40.4683','22.9950'),('Vracháti','37.9500','22.8000'),('Thásos','40.7750','24.7083'),('Mália','35.2833','25.4647'),('Kallithéa','40.2750','22.5750'),('Neápoli','36.5000','23.0500'),('Ntráfi','38.0333','23.9000'),('Maniákoi','40.5017','21.2450'),('Liménas Chersonísou','35.3167','25.3900'),('Néo Rýsi','40.4950','22.9883'),('Vlachérna','39.1667','21.0000'),('Saronída','37.7333','23.9000'),('Néa Kíos','37.5833','22.7333'),('Néa Palátia','38.3167','23.7833'),('Kárpathos','35.5075','27.2136'),('Antírrio','38.3333','21.7667'),('Rododáfni','38.2667','22.0500'),('Perístasi','40.2750','22.5417'),('Néa Seléfkeia','39.5236','20.2564'),('Néa Koútali','39.9000','25.2000'),('Kanaláki','39.3833','20.3333'),('Filiátes','39.6011','20.3119'),('Agía Paraskeví','40.4817','23.0483'),('Anthoúsa','38.0333','23.8667'),('Mintilógli','38.1833','21.7000'),('Tagarádes','40.4883','23.0217'),('Kostakioí','39.1363','20.9591'),('Rodópoli','38.1000','23.8667'),('Néa Manoláda','38.0500','21.3833'),('Dílesi','38.3425','23.6728'),('Mouzáki','39.4297','21.6636'),('Svorónos','40.2667','22.4667'),('Emporeío','36.3583','25.4444'),('Graikochóri','39.4978','20.2750'),('Gaïtáni','37.7833','20.8667'),('Sámos','37.7475','26.9825'),('Kréstena','37.5917','21.6200'),('Kontokáli','39.6460','19.8500'),('Perigiáli','37.9380','22.8360'),('Firá','36.4200','25.4317'),('Ampelókipoi','37.7581','20.8725'),('Néa Flogitá','40.4333','23.3667'),('Vári','37.3906','24.9447'),('Thymianá','38.3144','26.1325'),('Pérama','35.3703','24.6994'),('Gra Lygiá','35.0150','25.6922'),('Aigeíra','38.1500','22.3500'),('Skála Oropoú','38.3167','23.8000'),('Magoúla','37.0833','22.4000'),('Atsipópoulo','35.3500','24.4333'),('Kírra','38.4325','22.4505'),('Perivóli','39.4167','20.0167'),('Kamári','36.3768','25.4818'),('Skarmagkás','38.0100','23.6000'),('Kavásila','37.8750','21.2667'),('Karterádos','36.4133','25.4458'),('Koróni','36.7949','21.9629'),('Angelochórion','40.4970','22.8340'),('Sylivainiótika','38.1600','22.3300'),('Isthmía','37.9167','23.0000'),('Andromáchi','40.2724','22.4811'),('Parálio Ástros','37.4159','22.7662'),('Vanáto','37.7930','20.8530'),('Acharávi','39.7833','19.8167'),('Archaía Olympía','37.6383','21.6300'),('Pezá','35.2178','25.1928'),('Ágios Stéfanos','38.1408','23.8591'),('Zevgolatió','38.0815','22.6193'),('Moíres','35.0517','24.8750'),('Igoumenítsa','39.5034','20.2673'),('Goúrnes','35.3248','25.2776'),('Gastoúni','37.8506','21.2534'),('Eleoúsa','39.7059','20.7928'),('Markópoulo','37.8833','23.9333'),('Geráni','35.5168','23.8780'),('Ándros','37.8158','24.8269');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialties`
--

DROP TABLE IF EXISTS `specialties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialties` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialties`
--

LOCK TABLES `specialties` WRITE;
/*!40000 ALTER TABLE `specialties` DISABLE KEYS */;
INSERT INTO `specialties` VALUES (1,'Accident and emergency medicine'),(2,'Allergology'),(3,'Anaesthetics'),(4,'Biological hematology'),(5,'Cardiology'),(6,'Child psychiatry'),(7,'Clinical biology'),(8,'Clinical chemistry'),(9,'Clinical neurophysiology'),(10,'Clinical radiology'),(11,'Dental, oral and maxillo-facial surgery'),(12,'Dermato-venerology'),(13,'Dermatology'),(14,'Endocrinology'),(15,'Gastro-enterologic surgery'),(16,'Gastroenterology'),(17,'General hematology'),(18,'General Practice'),(19,'General surgery'),(20,'Geriatrics'),(21,'Immunology'),(22,'Infectious diseases'),(23,'Internal medicine'),(24,'Laboratory medicine'),(25,'Maxillo-facial surgery'),(26,'Microbiology'),(27,'Nephrology'),(28,'Neuro-psychiatry'),(29,'Neurology'),(30,'Neurosurgery'),(31,'Nuclear medicine'),(32,'Obstetrics and gynecology'),(33,'Occupational medicine'),(34,'Ophthalmology'),(35,'Orthopaedics'),(36,'Otorhinolaryngology'),(37,'Paediatric surgery'),(38,'Paediatrics'),(39,'Pathology'),(40,'Pharmacology'),(41,'Physical medicine and rehabilitation'),(42,'Plastic surgery'),(43,'Podiatric Medicine'),(44,'Podiatric Surgery'),(45,'Psychiatry'),(46,'Public health and Preventive Medicine'),(47,'Radiology'),(48,'Radiotherapy'),(49,'Respiratory medicine'),(50,'Rheumatology'),(51,'Stomatology'),(52,'Thoracic surgery'),(53,'Tropical medicine'),(54,'Urology'),(55,'Vascular surgery'),(56,'Venereology');
/*!40000 ALTER TABLE `specialties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `amka` decimal(11,0) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `speciality` varchar(255) DEFAULT NULL,
  `phone` decimal(10,0) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ResetPasswordToken` varchar(255) DEFAULT NULL,
  `ResetTokenExpiry` datetime DEFAULT NULL,
  PRIMARY KEY (`amka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (6238616012,'1234567','Patient_1',NULL,2102316580,'agia paraskevi 12','Patient','Agía Paraskeví','sifavs@yahoo.com','dd2210af-b702-4edc-9d3e-c16a0f496162','2024-10-01 12:03:54'),(12270306093,'123','Doctor_5','Dermatology',2102316584,'evosmos 14','Doctor','Évosmos','sifavs@yahoo.com',NULL,NULL),(12345678901,'123','AIKATERINI LAZARI',NULL,6982523195,'irakleiou 13','Patient','Néa Filadélfeia','sifavs@yahoo.com',NULL,NULL),(12345678902,'123','κατερινα λαζαρη','Cardiology',2102316588,'METSOBOU 24','Doctor','Ágios Stéfanos','sifavs@yahoo.com',NULL,NULL),(12792007911,'123','Patient_4',NULL,2102316580,'agio steafanos 15','Patient','Ágios Stéfanos','sifavs@yahoo.com',NULL,NULL),(14959828736,'123','Doctor_6','Gastroenterology',2102316522,'irakleiou 13','Doctor','Álimos','sifavs@yahoo.com',NULL,NULL),(21041747282,'1234','Doctor_7','Child psychiatry',2102316531,'agia varvara 11','Doctor','Agía Varvára','sifavs@yahoo.com',NULL,NULL),(21041747283,'123','Patient_10',NULL,2102316544,'aigalew 15','Patient','Aigáleo','sifavs@yahoo.com',NULL,NULL),(37816851946,'123','Doctor_3','Dermatology',2102316583,'kerkyra 7','Doctor','Kérkyra','sifavs@yahoo.com',NULL,NULL),(41410057935,'123','Patient_5',NULL,2102316581,'aigalie 17','Patient','Aigáleo','sifavs@yahoo.com',NULL,NULL),(56174538891,'123','Doctor_1','Accident and emergency medicine',2102316588,'METSOBOU 24','Doctor','Acharnés','sifavs@yahoo.com',NULL,NULL),(56784082550,'123','Doctor_2','Cardiology',2102316581,'agioi anargyroi 23','Doctor','Ágioi Anárgyroi','sifavs@yahoo.com',NULL,NULL),(62854178148,'123','Patient_6',NULL,2102316585,'METSOBOU 21','Patient','Álimos','sifavs@yahoo.com',NULL,NULL),(65885794290,'1234','TAKIS',NULL,6982523195,'ARTIS 25','Patient','Kamateró','sifavs@yahoo.com',NULL,NULL),(68629083956,'123','Patient_7',NULL,2102316582,'irakleiou 13','Patient','Alivéri','sifavs@yahoo.com',NULL,NULL),(74537996342,'123','Patient_9',NULL,2102316583,'irakleiou 13','Patient','Alykés','sifavs@yahoo.com',NULL,NULL),(79180434529,'123','Patient_3',NULL,2102316583,'aigio 7','Patient','Aígio','sifavs@yahoo.com',NULL,NULL),(89079842443,'123','Patient_2',NULL,2102316583,'ilion 26','Patient','Ilioúpoli','sifavs@yahoo.com',NULL,NULL),(98921936632,'123','Doctor_4','Cardiology',2102316589,'antiro 34','Doctor','Antírrio','sifavs@yahoo.com',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'doctorappointmentwebapp'
--

--
-- Dumping routines for database 'doctorappointmentwebapp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-07 21:49:21
