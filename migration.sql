CREATE DATABASE  IF NOT EXISTS `indahlia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `indahlia`;
-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: indahlia
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.20.04.3

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
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `timestamp` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `isi` varchar(255) DEFAULT NULL,
  `cuplikan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (1,'Hasheemi','Laut Halmahera Timur Tercemar Parah Limbah Nikel','laut-halmahera-timur-tercemar-parah-limbah-nikel','/cdn/laut-halmahera-timur-tercemar-parah-limbah-nikel-1715302879606.jpg','1715302879606','hasemiandika78@gmail.com','/cdn/laut-halmahera-timur-tercemar-parah-limbah-nikel-1715302879606.txt','Dampak industri ekstraktif terhadap kerusakan dan pencemaran laut di provinsi Maluku Utara tak terhindarkan. Masifnya industri tambang nikel di pulau Halmahera dan pulau kecil lainnya menjadi sirene'),(2,'Hasheemi','KTT AIS akan Berlangsung di Bali, Bahas Perubahan Iklim hingga Ekonomi Biru','ktt-ais-akan-berlangsung-di-bali-bahas-perubahan-iklim-hingga-ekonomi-biru','/cdn/ktt-ais-akan-berlangsung-di-bali-bahas-perubahan-iklim-hingga-ekonomi-biru-1715305163366.jpg','1715305163366','hasemiandika78@gmail.com','/cdn/ktt-ais-akan-berlangsung-di-bali-bahas-perubahan-iklim-hingga-ekonomi-biru-1715305163366.txt','Konferensi Tingkat Tinggi Archipelagic and Island States atau KTT AIS Forum 2023 akan diselenggarakan di Bali pada 10–11 Oktober 2023. Acara ini bertujuan meningkatkan kualitas ekosistem pesisir dan laut untuk ');
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `classId` int NOT NULL AUTO_INCREMENT,
  `teacherId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `syllabus` text,
  `banner` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,6378,'Budi Arianto','Mengenal dan Merawat Tanaman Obat Keluarga','/cdn/mengenal-dan-merawat-tanaman-obat-keluarga-cls-1733825208751.txt','/cdn/mengenal-dan-merawat-tanaman-obat-keluarga-cls-1733825208751.jpg','/cdn/mengenal-dan-merawat-tanaman-obat-keluarga-cls-1733825208751.jpg','2024-12-10 10:08:35','2024-12-10 10:17:48','mengenal-dan-merawat-tanaman-obat-keluarga'),(2,6378,'Budi Arianto','Mengenal dan Merawat Tanaman Obat Keluarga 2','/cdn/mengenal-dan-merawat-tanaman-obat-keluarga-2-cls-1734275299015.txt','/cdn/mengenal-dan-merawat-tanaman-obat-keluarga-2-banner-cls-1734275299015.jpg','/cdn/mengenal-dan-merawat-tanaman-obat-keluarga-2-thumb-cls-1734275299015.png','2024-12-15 15:12:39','2024-12-15 15:12:39','mengenal-dan-merawat-tanaman-obat-keluarga-2');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson` (
  `lessonId` int NOT NULL AUTO_INCREMENT,
  `classId` int NOT NULL,
  `className` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `youtubeUrl` varchar(255) DEFAULT NULL,
  `quiz` varchar(255) DEFAULT NULL,
  `material` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lessonId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;
INSERT INTO `lesson` VALUES (1,1,'ii','Mengenal Jenis-Jenis TOGA','/cdn/mengenal-jenis-jenis-toga-thumb-lsn-1734241752608.jpg','https://www.youtube.com/embed/eXF-sRu4mYs','/cdn/mengenal-jenis-jenis-toga-quiz-lsn-1734241752608.json','/cdn/mengenal-jenis-jenis-toga-lsn-1734241752608.txt','2024-12-15 05:50:42','2024-12-15 05:50:42'),(2,2,'ii','Pengenalan Tanaman Obat Keluarga','/cdn/pengenalan-tanaman-obat-keluarga-thumb-lsn-1734275603285.png','https://www.youtube.com/embed/JPrHcX9Ya5k','/cdn/pengenalan-tanaman-obat-keluarga-quiz-lsn-1734275603285.json','/cdn/pengenalan-tanaman-obat-keluarga-lsn-1734275603285.txt','2024-12-15 15:16:33','2024-12-15 15:16:33'),(3,2,'ii','Penanaman Tanaman Obat Keluarga','/cdn/penanaman-tanaman-obat-keluarga-thumb-lsn-1734275794366.png','https://www.youtube.com/embed/TMlks7igOfU','/cdn/penanaman-tanaman-obat-keluarga-quiz-lsn-1734275794366.json','/cdn/penanaman-tanaman-obat-keluarga-lsn-1734275794366.txt','2024-12-15 15:18:45','2024-12-15 15:18:45'),(4,2,'ii','Perawatan dan Pemanenan Tanaman Obat Keluarga','/cdn/perawatan-dan-pemanenan-tanaman-obat-keluarga-thumb-lsn-1734275926519.png','https://www.youtube.com/embed/cT2MxXke2Yo','/cdn/perawatan-dan-pemanenan-tanaman-obat-keluarga-quiz-lsn-1734275926519.json','/cdn/perawatan-dan-pemanenan-tanaman-obat-keluarga-lsn-1734275926519.txt','2024-12-15 15:20:52','2024-12-15 15:20:52'),(5,2,'ii','Pe','/cdn/pe-thumb-lsn-1734276052473.png','https://www.youtube.com/embed/Y7I3Kklu-E4','/cdn/pe-quiz-lsn-1734276052473.json','/cdn/pe-lsn-1734276052473.txt','2024-12-15 15:22:20','2024-12-15 15:22:20');
/*!40000 ALTER TABLE `lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `prov` varchar(255) DEFAULT NULL,
  `kab` varchar(255) DEFAULT NULL,
  `jenis` varchar(255) DEFAULT NULL,
  `kondisi` varchar(255) DEFAULT NULL,
  `notel` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `koordinat` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `timestamp` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place`
--

LOCK TABLES `place` WRITE;
/*!40000 ALTER TABLE `place` DISABLE KEYS */;
INSERT INTO `place` VALUES (1,'Hasheemi','Air terjun madakaripura','','35','3513','4','1','','https://maps.app.goo.gl/aa4maRpbQg5wtSPg7','-7.8478713,113.0161214','/cdn/air-terjun-madakaripura-1715297631705.jpg','1715297631705','hasemiandika78@gmail.com'),(2,'Hasheemi','Air terjun triban','','35','3513','4','1','','https://maps.app.goo.gl/bex6ETgcDSmmuaFP8','-7.8763344,113.0607876','/cdn/air-terjun-triban-1715324159622.jpeg','1715324159622','hasemiandika78@gmail.com');
/*!40000 ALTER TABLE `place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensei`
--

DROP TABLE IF EXISTS `sensei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensei` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6379 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensei`
--

LOCK TABLES `sensei` WRITE;
/*!40000 ALTER TABLE `sensei` DISABLE KEYS */;
INSERT INTO `sensei` VALUES (6378,'budi07','budididi34@gmail.com','Budi Arianto','1m373f343g2r2w3031302s2r3a','2024-12-08 10:28:33','2024-12-08 10:28:33');
/*!40000 ALTER TABLE `sensei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `classId` int NOT NULL,
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `currentLesson` int DEFAULT '1',
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `userId` (`userId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2,'42','Hasheemi','hasemiandika78@gmail.com',1,'2024-12-15 10:22:35',1);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `gid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (42,'Hasheemi Rafsanjani','hasemiandika78@gmail.com','https://lh3.googleusercontent.com/a/ACg8ocJXYzXm_F4aOpMCTD84pHDYmALCRIic9gck8bgvkrQYAq4HnEU=s96-c',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'indahlia'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-15 22:27:12
