-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: agricoltura_moderna
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `acquisto`
--

DROP TABLE IF EXISTS `acquisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acquisto` (
  `RifFornitore` varchar(11) NOT NULL,
  `RifProdotto` varchar(100) NOT NULL,
  `DataAcquisto` date NOT NULL,
  `Importo` decimal(10,2) NOT NULL,
  `QuantitaAcquistata` decimal(10,2) NOT NULL,
  PRIMARY KEY (`RifFornitore`,`RifProdotto`,`DataAcquisto`),
  KEY `RifProdotto` (`RifProdotto`),
  CONSTRAINT `acquisto_ibfk_1` FOREIGN KEY (`RifFornitore`) REFERENCES `fornitore` (`PartitaIVA`),
  CONSTRAINT `acquisto_ibfk_2` FOREIGN KEY (`RifProdotto`) REFERENCES `prodotto` (`NomeProdotto`),
  CONSTRAINT `acquisto_chk_1` CHECK ((`Importo` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acquisto`
--

LOCK TABLES `acquisto` WRITE;
/*!40000 ALTER TABLE `acquisto` DISABLE KEYS */;
/*!40000 ALTER TABLE `acquisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campo`
--

DROP TABLE IF EXISTS `campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campo` (
  `IDCampo` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `LocalitaGPS` varchar(255) DEFAULT NULL,
  `Superficie` decimal(10,2) NOT NULL,
  PRIMARY KEY (`IDCampo`),
  CONSTRAINT `campo_chk_1` CHECK ((`Superficie` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campo`
--

LOCK TABLES `campo` WRITE;
/*!40000 ALTER TABLE `campo` DISABLE KEYS */;
INSERT INTO `campo` VALUES (1,'Campo Nord','45.123, 9.456',15.50),(2,'Il Girasole','45.124, 9.457',8.00),(3,'Campo Est','45.125, 9.459',12.20);
/*!40000 ALTER TABLE `campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciclocolturale`
--

DROP TABLE IF EXISTS `ciclocolturale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclocolturale` (
  `IDCiclo` int NOT NULL AUTO_INCREMENT,
  `DataSemina` date NOT NULL,
  `DataRaccoltaPrevista` date DEFAULT NULL,
  `DataRaccoltaEffettiva` date DEFAULT NULL,
  `RifCampo` int NOT NULL,
  `RifTipoColtura` varchar(100) NOT NULL,
  PRIMARY KEY (`IDCiclo`),
  KEY `RifCampo` (`RifCampo`),
  KEY `RifTipoColtura` (`RifTipoColtura`),
  CONSTRAINT `ciclocolturale_ibfk_1` FOREIGN KEY (`RifCampo`) REFERENCES `campo` (`IDCampo`),
  CONSTRAINT `ciclocolturale_ibfk_2` FOREIGN KEY (`RifTipoColtura`) REFERENCES `tipocoltura` (`NomeColtura`),
  CONSTRAINT `ciclocolturale_chk_1` CHECK (((`DataRaccoltaEffettiva` is null) or (`DataRaccoltaEffettiva` > `DataSemina`)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclocolturale`
--

LOCK TABLES `ciclocolturale` WRITE;
/*!40000 ALTER TABLE `ciclocolturale` DISABLE KEYS */;
INSERT INTO `ciclocolturale` VALUES (1,'2024-03-15',NULL,NULL,1,'Mais Dolce'),(2,'2024-04-01',NULL,NULL,2,'Grano Duro'),(3,'2024-03-20',NULL,NULL,3,'Mais Dolce');
/*!40000 ALTER TABLE `ciclocolturale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `esegue`
--

DROP TABLE IF EXISTS `esegue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `esegue` (
  `RifPersonale` varchar(16) NOT NULL,
  `RifIntervento` int NOT NULL,
  PRIMARY KEY (`RifPersonale`,`RifIntervento`),
  KEY `RifIntervento` (`RifIntervento`),
  CONSTRAINT `esegue_ibfk_1` FOREIGN KEY (`RifPersonale`) REFERENCES `personale` (`CodiceFiscale`),
  CONSTRAINT `esegue_ibfk_2` FOREIGN KEY (`RifIntervento`) REFERENCES `intervento` (`IDIntervento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `esegue`
--

LOCK TABLES `esegue` WRITE;
/*!40000 ALTER TABLE `esegue` DISABLE KEYS */;
/*!40000 ALTER TABLE `esegue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitore`
--

DROP TABLE IF EXISTS `fornitore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornitore` (
  `PartitaIVA` varchar(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Indirizzo` text,
  PRIMARY KEY (`PartitaIVA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitore`
--

LOCK TABLES `fornitore` WRITE;
/*!40000 ALTER TABLE `fornitore` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornitore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ha_ruolo`
--

DROP TABLE IF EXISTS `ha_ruolo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ha_ruolo` (
  `RifPersonale` varchar(16) NOT NULL,
  `RifRuolo` varchar(50) NOT NULL,
  PRIMARY KEY (`RifPersonale`,`RifRuolo`),
  KEY `RifRuolo` (`RifRuolo`),
  CONSTRAINT `ha_ruolo_ibfk_1` FOREIGN KEY (`RifPersonale`) REFERENCES `personale` (`CodiceFiscale`),
  CONSTRAINT `ha_ruolo_ibfk_2` FOREIGN KEY (`RifRuolo`) REFERENCES `ruolo` (`NomeRuolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ha_ruolo`
--

LOCK TABLES `ha_ruolo` WRITE;
/*!40000 ALTER TABLE `ha_ruolo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ha_ruolo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `intervento`
--

DROP TABLE IF EXISTS `intervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intervento` (
  `IDIntervento` int NOT NULL AUTO_INCREMENT,
  `DataOra` timestamp NOT NULL,
  `DescrizioneOperato` text,
  `RifCicloColturale` int NOT NULL,
  `RifTipoIntervento` varchar(100) NOT NULL,
  PRIMARY KEY (`IDIntervento`),
  KEY `RifTipoIntervento` (`RifTipoIntervento`),
  KEY `IDX_INTERVENTO_CICLO` (`RifCicloColturale`),
  CONSTRAINT `intervento_ibfk_1` FOREIGN KEY (`RifCicloColturale`) REFERENCES `ciclocolturale` (`IDCiclo`),
  CONSTRAINT `intervento_ibfk_2` FOREIGN KEY (`RifTipoIntervento`) REFERENCES `tipointervento` (`NomeIntervento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `intervento`
--

LOCK TABLES `intervento` WRITE;
/*!40000 ALTER TABLE `intervento` DISABLE KEYS */;
/*!40000 ALTER TABLE `intervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personale`
--

DROP TABLE IF EXISTS `personale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personale` (
  `CodiceFiscale` varchar(16) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Cognome` varchar(100) NOT NULL,
  `DataNascita` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`CodiceFiscale`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personale`
--

LOCK TABLES `personale` WRITE;
/*!40000 ALTER TABLE `personale` DISABLE KEYS */;
INSERT INTO `personale` VALUES ('BNCLRA85M50F205K','Laura','Bianchi','1985-08-10','l.bianchi@agri.it','pass123'),('RSSMRA80A01H501Z','Mario','Rossi','1980-01-01','m.rossi@agri.it','pass123'),('VRDFNC90C05L219P','Franco','Verdi','1990-03-05','f.verdi@agri.it','pass123');
/*!40000 ALTER TABLE `personale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `NomeProdotto` varchar(100) NOT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`NomeProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES ('Diserbante Totale','Pesticida'),('Fertilizzante Super-N','Fertilizzante'),('Pesticida Stop-Bug','Pesticida'),('Seme Grano Duro','Semente'),('Seme Mais Dolce','Semente');
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raccolto`
--

DROP TABLE IF EXISTS `raccolto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raccolto` (
  `IDRaccolto` int NOT NULL AUTO_INCREMENT,
  `Quantita` decimal(10,2) NOT NULL,
  `Qualita` varchar(50) DEFAULT NULL,
  `RifCicloColturale` int NOT NULL,
  PRIMARY KEY (`IDRaccolto`),
  UNIQUE KEY `RifCicloColturale` (`RifCicloColturale`),
  CONSTRAINT `raccolto_ibfk_1` FOREIGN KEY (`RifCicloColturale`) REFERENCES `ciclocolturale` (`IDCiclo`),
  CONSTRAINT `raccolto_chk_1` CHECK ((`Quantita` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raccolto`
--

LOCK TABLES `raccolto` WRITE;
/*!40000 ALTER TABLE `raccolto` DISABLE KEYS */;
/*!40000 ALTER TABLE `raccolto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rilevazione`
--

DROP TABLE IF EXISTS `rilevazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rilevazione` (
  `IDRilevazione` bigint NOT NULL AUTO_INCREMENT,
  `Valore` decimal(10,2) NOT NULL,
  `UnitaMisura` varchar(20) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RifSensore` varchar(100) NOT NULL,
  PRIMARY KEY (`IDRilevazione`),
  KEY `IDX_RILEVAZIONE_SENSOR_TIME` (`RifSensore`,`Timestamp` DESC),
  CONSTRAINT `rilevazione_ibfk_1` FOREIGN KEY (`RifSensore`) REFERENCES `sensore` (`SerialNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rilevazione`
--

LOCK TABLES `rilevazione` WRITE;
/*!40000 ALTER TABLE `rilevazione` DISABLE KEYS */;
INSERT INTO `rilevazione` VALUES (1,15.20,NULL,'2024-05-10 06:00:00','SN-T-001'),(2,65.00,NULL,'2024-05-10 06:00:00','SN-H-001'),(3,14.80,NULL,'2024-05-10 06:00:00','SN-T-002'),(4,6.80,NULL,'2024-05-10 06:00:00','SN-PH-001'),(5,15.50,NULL,'2024-05-10 07:00:00','SN-T-001');
/*!40000 ALTER TABLE `rilevazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruolo`
--

DROP TABLE IF EXISTS `ruolo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ruolo` (
  `NomeRuolo` varchar(50) NOT NULL,
  `DescrizionePermessi` text,
  PRIMARY KEY (`NomeRuolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruolo`
--

LOCK TABLES `ruolo` WRITE;
/*!40000 ALTER TABLE `ruolo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruolo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensore`
--

DROP TABLE IF EXISTS `sensore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensore` (
  `SerialNumber` varchar(100) NOT NULL,
  `TipoSensore` varchar(50) NOT NULL,
  `DataInstallazione` date DEFAULT NULL,
  `RifCampo` int NOT NULL,
  PRIMARY KEY (`SerialNumber`),
  KEY `IDX_SENSORE_CAMPO` (`RifCampo`),
  CONSTRAINT `sensore_ibfk_1` FOREIGN KEY (`RifCampo`) REFERENCES `campo` (`IDCampo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensore`
--

LOCK TABLES `sensore` WRITE;
/*!40000 ALTER TABLE `sensore` DISABLE KEYS */;
INSERT INTO `sensore` VALUES ('SN-H-001','Umidità','2024-01-10',1),('SN-PH-001','pH','2024-01-15',2),('SN-T-001','Temperatura','2024-01-10',1),('SN-T-002','Temperatura','2024-01-15',2),('SN-T-003','Temperatura','2024-01-20',3);
/*!40000 ALTER TABLE `sensore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipocoltura`
--

DROP TABLE IF EXISTS `tipocoltura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipocoltura` (
  `NomeColtura` varchar(100) NOT NULL,
  `Descrizione` text,
  PRIMARY KEY (`NomeColtura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipocoltura`
--

LOCK TABLES `tipocoltura` WRITE;
/*!40000 ALTER TABLE `tipocoltura` DISABLE KEYS */;
INSERT INTO `tipocoltura` VALUES ('Grano Duro','Grano per pasta'),('Mais Dolce','Mais per consumo fresco');
/*!40000 ALTER TABLE `tipocoltura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipointervento`
--

DROP TABLE IF EXISTS `tipointervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipointervento` (
  `NomeIntervento` varchar(100) NOT NULL,
  `Descrizione` text,
  PRIMARY KEY (`NomeIntervento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipointervento`
--

LOCK TABLES `tipointervento` WRITE;
/*!40000 ALTER TABLE `tipointervento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipointervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilizza`
--

DROP TABLE IF EXISTS `utilizza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizza` (
  `RifIntervento` int NOT NULL,
  `RifProdotto` varchar(100) NOT NULL,
  `Quantita` decimal(10,2) NOT NULL,
  PRIMARY KEY (`RifIntervento`,`RifProdotto`),
  KEY `RifProdotto` (`RifProdotto`),
  CONSTRAINT `utilizza_ibfk_1` FOREIGN KEY (`RifIntervento`) REFERENCES `intervento` (`IDIntervento`),
  CONSTRAINT `utilizza_ibfk_2` FOREIGN KEY (`RifProdotto`) REFERENCES `prodotto` (`NomeProdotto`),
  CONSTRAINT `utilizza_chk_1` CHECK ((`Quantita` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizza`
--

LOCK TABLES `utilizza` WRITE;
/*!40000 ALTER TABLE `utilizza` DISABLE KEYS */;
/*!40000 ALTER TABLE `utilizza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'agricoltura_moderna'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-07 16:09:07
