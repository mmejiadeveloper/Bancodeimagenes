/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.1.38-MariaDB : Database - bdbancoimagenes
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bdbancoimagenes` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bdbancoimagenes`;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `categoryName` varchar(100) DEFAULT NULL COMMENT 'category name',
  `created_at` date DEFAULT NULL COMMENT 'when this category was created',
  `updated_at` date DEFAULT NULL COMMENT 'when this category was updated',
  `createdBy` int(11) DEFAULT NULL COMMENT 'which user created this category, being refered by his id on users table',
  `state` varchar(11) DEFAULT 'Active' COMMENT 'state to determinate if the row exists',
  `deleted_at` datetime DEFAULT NULL COMMENT 'when was deleted',
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

/*Data for the table `categories` */

insert  into `categories`(`categoryId`,`categoryName`,`created_at`,`updated_at`,`createdBy`,`state`,`deleted_at`) values (1,'Paisajes','2019-04-10','2019-05-07',1,'Active',NULL),(2,'Grupos de interes','2019-04-10','2019-05-07',1,'Active',NULL),(10,'Infraestructura','2019-04-23','2019-05-07',1,'Active',NULL),(11,'Eventos','2019-04-23','2019-05-07',1,'Inactive',NULL),(12,'Gatos y mas gatos','2019-04-23','2019-05-07',1,'Active','2019-05-07 16:59:51'),(13,'Calles y avenidas ','2019-04-23','2019-04-24',1,'Active','2019-04-24 13:51:25'),(14,'ww','2019-04-23','2019-04-23',1,'Active','2019-04-23 23:03:58'),(15,'Prueba','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:32:20'),(16,'Prueba','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:32:43'),(17,'prueba','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:34:21'),(18,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:36:59'),(19,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:38:46'),(20,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:38:52'),(21,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:41:24'),(22,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:43:11'),(23,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:43:57'),(24,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:46:00'),(25,'Nueva Categoria','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:46:42'),(26,'Nueva Categoria1','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:47:43'),(27,'Nueva Categoria1','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:50:36'),(28,'Nueva Categoria2 33','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:50:51'),(29,'Nueva Categoria xxxx 1112','2019-04-23','2019-04-23',1,'Active','2019-04-23 22:59:38'),(30,'xxx11','2019-04-24','2019-05-07',1,'Active','2019-05-07 16:59:55'),(31,'Nueva fgfghgfh','2019-04-24','2019-05-07',1,'Active','2019-05-07 16:59:58'),(32,'Nueva Categoria','2019-04-25','2019-04-25',1,'Active','2019-04-25 16:13:16'),(33,'Objetosxx','2019-05-07','2019-05-10',1,'Active',NULL),(34,'Prueba 1','2019-05-27','2019-05-27',1,'Active',NULL),(35,'Prueba2 ','2019-05-27','2019-05-27',1,'Active',NULL),(36,'Nueva Categoria 3','2019-05-27','2019-05-27',1,'Active',NULL),(37,'Nueva Categoria 33 ','2019-05-27','2019-05-27',1,'Active',NULL);

/*Table structure for table `outgoing_emailserver` */

DROP TABLE IF EXISTS `outgoing_emailserver`;

CREATE TABLE `outgoing_emailserver` (
  `id` int(11) DEFAULT NULL COMMENT 'id',
  `allowCustomSTMP` int(1) DEFAULT NULL COMMENT 'allows customization for STMP',
  `integration` varchar(100) DEFAULT NULL COMMENT 'integration item selected',
  `APIKEY` varchar(100) DEFAULT NULL COMMENT 'APIKEY for server',
  `outgoingEmailAccount` varchar(100) DEFAULT NULL COMMENT 'number of account',
  `passwordOutgoingEmailAccount` varchar(100) DEFAULT NULL COMMENT 'account password',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was this info updated',
  `updatedBy` int(11) DEFAULT NULL COMMENT 'who updated this info'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `outgoing_emailserver` */

insert  into `outgoing_emailserver`(`id`,`allowCustomSTMP`,`integration`,`APIKEY`,`outgoingEmailAccount`,`passwordOutgoingEmailAccount`,`updated_at`,`updatedBy`) values (1,1,'prueba','https://secure.placetopay.com/redirection/','xxxx111233','l91590alH9O0c0hZ','2019-05-10 15:06:48',NULL);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attempt` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `password_resets` */

insert  into `password_resets`(`id`,`attempt`,`email`,`token`,`created_at`) values (8,NULL,'mmejiadeveloper@gmail.com','$2y$10$6sYyMxRA4b339tG79ytkV.HVDFIJ7NNssVoWIZiqG6wRlmBvZ93x6','2019-05-10 14:06:15');

/*Table structure for table `post_filters_saved` */

DROP TABLE IF EXISTS `post_filters_saved`;

CREATE TABLE `post_filters_saved` (
  `postFilterSavedId` int(11) NOT NULL AUTO_INCREMENT,
  `filterId` varchar(11) DEFAULT NULL COMMENT 'id in filters table',
  `filterName` varchar(100) DEFAULT NULL COMMENT 'name in filters table',
  `filterValue` int(11) DEFAULT NULL COMMENT 'value which was choosed',
  `postId` int(11) DEFAULT NULL COMMENT 'id of the post created',
  `deleted_at` datetime DEFAULT NULL COMMENT 'when was deleted',
  PRIMARY KEY (`postFilterSavedId`)
) ENGINE=InnoDB AUTO_INCREMENT=535 DEFAULT CHARSET=latin1;

/*Data for the table `post_filters_saved` */

insert  into `post_filters_saved`(`postFilterSavedId`,`filterId`,`filterName`,`filterValue`,`postId`,`deleted_at`) values (190,'1','Orientacion',1,7021878,'2019-05-09 17:00:19'),(191,'3','Tamano',6,7021878,'2019-05-09 17:00:19'),(192,'2','Conpersonas',4,7021878,'2019-05-09 17:00:19'),(193,'2-1','Conpersonas-Genero',9,7021878,'2019-05-09 17:00:19'),(194,'2-2','Conpersonas-Edad',13,7021878,'2019-05-09 17:00:19'),(195,'2-3','Conpersonas-Cantidad',15,7021878,'2019-05-09 17:00:19'),(196,'1','Orientacion',1,7021878,'2019-05-09 19:35:38'),(197,'3','Tamano',6,7021878,'2019-05-09 19:35:38'),(198,'2','Conpersonas',3,7021878,'2019-05-09 19:35:38'),(199,'2-1','Conpersonas-Genero',9,7021878,'2019-05-09 19:35:38'),(200,'2-2','Conpersonas-Edad',13,7021878,'2019-05-09 19:35:38'),(201,'2-3','Conpersonas-Cantidad',15,7021878,'2019-05-09 19:35:38'),(202,'1','Orientacion',1,7021878,'2019-05-09 19:35:46'),(203,'3','Tamano',6,7021878,'2019-05-09 19:35:46'),(204,'2','Conpersonas',4,7021878,'2019-05-09 19:35:46'),(205,'2-1','Conpersonas-Genero',9,7021878,'2019-05-09 19:35:46'),(206,'2-2','Conpersonas-Edad',13,7021878,'2019-05-09 19:35:46'),(207,'2-3','Conpersonas-Cantidad',15,7021878,'2019-05-09 19:35:46'),(208,'1','Orientacion',1,7021878,'2019-05-10 15:13:33'),(209,'3','Tamano',6,7021878,'2019-05-10 15:13:33'),(210,'2','Conpersonas',3,7021878,'2019-05-10 15:13:33'),(211,'2-1','Conpersonas-Genero',9,7021878,'2019-05-10 15:13:33'),(212,'2-2','Conpersonas-Edad',13,7021878,'2019-05-10 15:13:33'),(213,'2-3','Conpersonas-Cantidad',15,7021878,'2019-05-10 15:13:33'),(214,'1','Orientacion',1,7021878,'2019-05-20 01:02:22'),(215,'3','Tamano',6,7021878,'2019-05-20 01:02:22'),(216,'2','Conpersonas',3,7021878,'2019-05-20 01:02:22'),(217,'2-1','Conpersonas-Genero',9,7021878,'2019-05-20 01:02:22'),(218,'2-2','Conpersonas-Edad',13,7021878,'2019-05-20 01:02:22'),(219,'2-3','Conpersonas-Cantidad',15,7021878,'2019-05-20 01:02:22'),(220,'1','Orientacion',2,7021879,'2019-05-13 20:00:47'),(221,'2','Conpersonas',3,7021879,'2019-05-13 20:00:47'),(222,'2-1','Conpersonas-Genero',8,7021879,'2019-05-13 20:00:47'),(223,'2-2','Conpersonas-Edad',12,7021879,'2019-05-13 20:00:47'),(224,'3','Tamano',5,7021879,'2019-05-13 20:00:47'),(225,'2-3','Conpersonas-Cantidad',15,7021879,'2019-05-13 20:00:47'),(226,'1','Orientacion',2,7021879,'2019-05-13 20:00:58'),(227,'2','Conpersonas',3,7021879,'2019-05-13 20:00:58'),(228,'2-1','Conpersonas-Genero',8,7021879,'2019-05-13 20:00:58'),(229,'2-2','Conpersonas-Edad',12,7021879,'2019-05-13 20:00:58'),(230,'3','Tamano',5,7021879,'2019-05-13 20:00:58'),(231,'2-3','Conpersonas-Cantidad',15,7021879,'2019-05-13 20:00:58'),(232,'1','Orientacion',2,7021879,NULL),(233,'2','Conpersonas',3,7021879,NULL),(234,'2-1','Conpersonas-Genero',8,7021879,NULL),(235,'2-2','Conpersonas-Edad',12,7021879,NULL),(236,'3','Tamano',5,7021879,NULL),(237,'2-3','Conpersonas-Cantidad',15,7021879,NULL),(238,'1','Orientacion',1,7021880,NULL),(239,'2','Conpersonas',3,7021880,NULL),(240,'2-1','Conpersonas-Genero',8,7021880,NULL),(241,'2-2','Conpersonas-Edad',12,7021880,NULL),(242,'2-3','Conpersonas-Cantidad',14,7021880,NULL),(243,'3','Tamano',7,7021880,NULL),(244,'1','Orientacion',1,7021881,'2019-05-20 02:35:55'),(245,'2','Conpersonas',3,7021881,'2019-05-20 02:35:55'),(246,'2-1','Conpersonas-Genero',8,7021881,'2019-05-20 02:35:55'),(247,'2-2','Conpersonas-Edad',12,7021881,'2019-05-20 02:35:55'),(248,'2-3','Conpersonas-Cantidad',14,7021881,'2019-05-20 02:35:55'),(249,'3','Tamano',6,7021881,'2019-05-20 02:35:55'),(250,'1','Orientacion',2,7021882,'2019-05-27 13:54:35'),(251,'2','Conpersonas',3,7021882,'2019-05-27 13:54:35'),(252,'2-1','Conpersonas-Genero',8,7021882,'2019-05-27 13:54:35'),(253,'2-2','Conpersonas-Edad',12,7021882,'2019-05-27 13:54:35'),(254,'2-3','Conpersonas-Cantidad',14,7021882,'2019-05-27 13:54:35'),(255,'3','Tamano',6,7021882,'2019-05-27 13:54:35'),(256,'1','Orientacion',2,7021887,NULL),(257,'2','Conpersonas',4,7021887,NULL),(258,'3','Tamano',6,7021887,NULL),(259,'1','Orientacion',2,7021888,'2019-05-14 19:32:56'),(260,'2','Conpersonas',4,7021888,'2019-05-14 19:32:57'),(261,'3','Tamano',6,7021888,'2019-05-14 19:32:57'),(262,'1','Orientacion',1,7021889,'2019-05-20 15:00:44'),(263,'2','Conpersonas',4,7021889,'2019-05-20 15:00:44'),(264,'3','Tamano',6,7021889,'2019-05-20 15:00:45'),(265,'1','Orientacion',1,7021890,NULL),(266,'2','Conpersonas',4,7021890,NULL),(267,'3','Tamano',6,7021890,NULL),(268,'1','Orientacion',2,7021891,NULL),(269,'2','Conpersonas',4,7021891,NULL),(270,'3','Tamano',6,7021891,NULL),(271,'1','Orientacion',2,7021892,'2019-05-24 22:23:44'),(272,'2','Conpersonas',4,7021892,'2019-05-24 22:23:44'),(273,'3','Tamano',6,7021892,'2019-05-24 22:23:44'),(274,'1','Orientacion',1,7021893,NULL),(275,'2','Conpersonas',4,7021893,NULL),(276,'3','Tamano',7,7021893,NULL),(277,'1','Orientacion',2,7021894,NULL),(278,'2','Conpersonas',4,7021894,NULL),(279,'3','Tamano',6,7021894,NULL),(280,'1','Orientacion',1,7021895,NULL),(281,'2','Conpersonas',4,7021895,NULL),(282,'3','Tamano',6,7021895,NULL),(283,'1','Orientacion',2,7021896,'2019-05-24 22:14:20'),(284,'2','Conpersonas',4,7021896,'2019-05-24 22:14:20'),(285,'3','Tamano',6,7021896,'2019-05-24 22:14:20'),(286,'1','Orientacion',2,7021888,NULL),(287,'2','Conpersonas',4,7021888,NULL),(288,'3','Tamano',6,7021888,NULL),(289,'1','Orientacion',1,7021883,'2019-05-14 21:38:34'),(290,'2','Conpersonas',4,7021883,'2019-05-14 21:38:34'),(291,'3','Tamano',5,7021883,'2019-05-14 21:38:34'),(292,'1','Orientacion',1,7021883,'2019-05-14 21:39:18'),(293,'2','Conpersonas',4,7021883,'2019-05-14 21:39:18'),(294,'3','Tamano',5,7021883,'2019-05-14 21:39:18'),(295,'1','Orientacion',1,7021883,NULL),(296,'2','Conpersonas',4,7021883,NULL),(297,'3','Tamano',5,7021883,NULL),(298,'1','Orientacion',1,7021897,'2019-05-20 00:17:19'),(299,'2','Conpersonas',4,7021897,'2019-05-20 00:17:19'),(300,'3','Tamano',5,7021897,'2019-05-20 00:17:19'),(301,'1','Orientacion',1,7021897,'2019-05-21 22:47:43'),(302,'2','Conpersonas',4,7021897,'2019-05-21 22:47:43'),(303,'3','Tamano',5,7021897,'2019-05-21 22:47:43'),(304,'1','Orientacion',1,7021878,NULL),(305,'3','Tamano',6,7021878,NULL),(306,'2','Conpersonas',3,7021878,NULL),(307,'2-1','Conpersonas-Genero',9,7021878,NULL),(308,'2-2','Conpersonas-Edad',13,7021878,NULL),(309,'2-3','Conpersonas-Cantidad',15,7021878,NULL),(310,'1','Orientacion',1,7021881,NULL),(311,'2','Conpersonas',3,7021881,NULL),(312,'2-1','Conpersonas-Genero',8,7021881,NULL),(313,'2-2','Conpersonas-Edad',12,7021881,NULL),(314,'2-3','Conpersonas-Cantidad',14,7021881,NULL),(315,'3','Tamano',6,7021881,NULL),(316,'1','Orientacion',1,7021889,'2019-05-20 16:40:51'),(317,'2','Conpersonas',4,7021889,'2019-05-20 16:40:51'),(318,'3','Tamano',6,7021889,'2019-05-20 16:40:51'),(319,'1','Orientacion',1,7021889,'2019-05-20 16:41:24'),(320,'2','Conpersonas',4,7021889,'2019-05-20 16:41:24'),(321,'3','Tamano',6,7021889,'2019-05-20 16:41:24'),(322,'1','Orientacion',1,7021889,'2019-05-20 16:44:41'),(323,'2','Conpersonas',4,7021889,'2019-05-20 16:44:41'),(324,'3','Tamano',6,7021889,'2019-05-20 16:44:41'),(325,'1','Orientacion',1,7021889,'2019-05-20 16:47:52'),(326,'2','Conpersonas',4,7021889,'2019-05-20 16:47:52'),(327,'3','Tamano',6,7021889,'2019-05-20 16:47:52'),(328,'1','Orientacion',1,7021889,'2019-05-20 16:51:56'),(329,'2','Conpersonas',4,7021889,'2019-05-20 16:51:56'),(330,'3','Tamano',6,7021889,'2019-05-20 16:51:56'),(331,'1','Orientacion',1,7021889,'2019-05-20 16:52:13'),(332,'2','Conpersonas',4,7021889,'2019-05-20 16:52:13'),(333,'3','Tamano',6,7021889,'2019-05-20 16:52:13'),(334,'1','Orientacion',1,7021889,'2019-05-20 17:03:38'),(335,'2','Conpersonas',4,7021889,'2019-05-20 17:03:38'),(336,'3','Tamano',6,7021889,'2019-05-20 17:03:38'),(337,'1','Orientacion',1,7021889,'2019-05-20 17:04:05'),(338,'2','Conpersonas',4,7021889,'2019-05-20 17:04:05'),(339,'3','Tamano',6,7021889,'2019-05-20 17:04:05'),(340,'1','Orientacion',1,7021889,'2019-05-20 17:06:50'),(341,'2','Conpersonas',4,7021889,'2019-05-20 17:06:50'),(342,'3','Tamano',6,7021889,'2019-05-20 17:06:50'),(343,'1','Orientacion',1,7021889,'2019-05-20 17:07:12'),(344,'2','Conpersonas',4,7021889,'2019-05-20 17:07:12'),(345,'3','Tamano',6,7021889,'2019-05-20 17:07:12'),(346,'1','Orientacion',1,7021889,'2019-05-20 19:15:27'),(347,'2','Conpersonas',4,7021889,'2019-05-20 19:15:27'),(348,'3','Tamano',6,7021889,'2019-05-20 19:15:27'),(349,'1','Orientacion',1,7021889,'2019-05-20 19:15:42'),(350,'2','Conpersonas',4,7021889,'2019-05-20 19:15:42'),(351,'3','Tamano',6,7021889,'2019-05-20 19:15:42'),(352,'1','Orientacion',1,7021889,'2019-05-20 19:16:18'),(353,'2','Conpersonas',4,7021889,'2019-05-20 19:16:18'),(354,'3','Tamano',6,7021889,'2019-05-20 19:16:18'),(355,'1','Orientacion',1,7021889,'2019-05-20 19:16:43'),(356,'2','Conpersonas',4,7021889,'2019-05-20 19:16:43'),(357,'3','Tamano',6,7021889,'2019-05-20 19:16:43'),(358,'1','Orientacion',1,7021889,'2019-05-20 19:16:54'),(359,'2','Conpersonas',4,7021889,'2019-05-20 19:16:54'),(360,'3','Tamano',6,7021889,'2019-05-20 19:16:54'),(361,'1','Orientacion',1,7021889,'2019-05-20 19:17:56'),(362,'2','Conpersonas',4,7021889,'2019-05-20 19:17:56'),(363,'3','Tamano',6,7021889,'2019-05-20 19:17:56'),(364,'1','Orientacion',1,7021889,'2019-05-20 19:18:09'),(365,'2','Conpersonas',4,7021889,'2019-05-20 19:18:09'),(366,'3','Tamano',6,7021889,'2019-05-20 19:18:09'),(367,'1','Orientacion',1,7021889,'2019-05-20 19:19:02'),(368,'2','Conpersonas',4,7021889,'2019-05-20 19:19:02'),(369,'3','Tamano',6,7021889,'2019-05-20 19:19:02'),(370,'1','Orientacion',1,7021889,'2019-05-20 19:30:02'),(371,'2','Conpersonas',4,7021889,'2019-05-20 19:30:02'),(372,'3','Tamano',6,7021889,'2019-05-20 19:30:02'),(373,'1','Orientacion',1,7021889,'2019-05-20 19:30:20'),(374,'2','Conpersonas',4,7021889,'2019-05-20 19:30:20'),(375,'3','Tamano',6,7021889,'2019-05-20 19:30:20'),(376,'1','Orientacion',1,7021889,'2019-05-20 19:31:42'),(377,'2','Conpersonas',4,7021889,'2019-05-20 19:31:42'),(378,'3','Tamano',6,7021889,'2019-05-20 19:31:42'),(379,'1','Orientacion',1,7021889,'2019-05-20 19:31:55'),(380,'2','Conpersonas',4,7021889,'2019-05-20 19:31:55'),(381,'3','Tamano',6,7021889,'2019-05-20 19:31:55'),(382,'1','Orientacion',1,7021889,'2019-05-20 19:32:12'),(383,'2','Conpersonas',4,7021889,'2019-05-20 19:32:12'),(384,'3','Tamano',6,7021889,'2019-05-20 19:32:12'),(385,'1','Orientacion',1,7021889,'2019-05-20 19:32:32'),(386,'2','Conpersonas',4,7021889,'2019-05-20 19:32:32'),(387,'3','Tamano',6,7021889,'2019-05-20 19:32:32'),(388,'1','Orientacion',1,7021889,'2019-05-20 19:34:14'),(389,'2','Conpersonas',4,7021889,'2019-05-20 19:34:14'),(390,'3','Tamano',6,7021889,'2019-05-20 19:34:14'),(391,'1','Orientacion',1,7021889,'2019-05-20 19:34:32'),(392,'2','Conpersonas',4,7021889,'2019-05-20 19:34:32'),(393,'3','Tamano',6,7021889,'2019-05-20 19:34:32'),(394,'1','Orientacion',1,7021889,'2019-05-20 19:37:12'),(395,'2','Conpersonas',4,7021889,'2019-05-20 19:37:12'),(396,'3','Tamano',6,7021889,'2019-05-20 19:37:12'),(397,'1','Orientacion',1,7021889,'2019-05-20 19:38:09'),(398,'2','Conpersonas',4,7021889,'2019-05-20 19:38:09'),(399,'3','Tamano',6,7021889,'2019-05-20 19:38:09'),(400,'1','Orientacion',1,7021889,'2019-05-20 19:38:15'),(401,'2','Conpersonas',4,7021889,'2019-05-20 19:38:15'),(402,'3','Tamano',6,7021889,'2019-05-20 19:38:15'),(403,'1','Orientacion',1,7021889,'2019-05-20 19:38:30'),(404,'2','Conpersonas',4,7021889,'2019-05-20 19:38:30'),(405,'3','Tamano',6,7021889,'2019-05-20 19:38:30'),(406,'1','Orientacion',1,7021889,'2019-05-20 19:38:52'),(407,'2','Conpersonas',4,7021889,'2019-05-20 19:38:52'),(408,'3','Tamano',6,7021889,'2019-05-20 19:38:52'),(409,'1','Orientacion',1,7021889,NULL),(410,'2','Conpersonas',4,7021889,NULL),(411,'3','Tamano',6,7021889,NULL),(412,'1','Orientacion',1,7021897,NULL),(413,'2','Conpersonas',4,7021897,NULL),(414,'3','Tamano',5,7021897,NULL),(415,'1','Orientacion',2,7021896,NULL),(416,'2','Conpersonas',4,7021896,NULL),(417,'3','Tamano',6,7021896,NULL),(418,'1','Orientacion',2,7021892,NULL),(419,'2','Conpersonas',4,7021892,NULL),(420,'3','Tamano',6,7021892,NULL),(421,'1','Orientacion',2,7021882,NULL),(422,'2','Conpersonas',3,7021882,NULL),(423,'2-1','Conpersonas-Genero',8,7021882,NULL),(424,'2-2','Conpersonas-Edad',12,7021882,NULL),(425,'2-3','Conpersonas-Cantidad',14,7021882,NULL),(426,'3','Tamano',6,7021882,NULL),(427,'1','Orientacion',2,7021898,NULL),(428,'2','Conpersonas',4,7021898,NULL),(429,'3','Tamano',6,7021898,NULL),(430,'1','Orientacion',1,7021899,NULL),(431,'3','Tamano',5,7021899,NULL),(432,'2','Conpersonas',4,7021899,NULL),(433,'1','Orientacion',1,7021900,NULL),(434,'3','Tamano',5,7021900,NULL),(435,'2','Conpersonas',4,7021900,NULL),(436,'1','Orientacion',1,7021901,NULL),(437,'3','Tamano',5,7021901,NULL),(438,'2','Conpersonas',4,7021901,NULL),(439,'1','Orientacion',1,7021902,NULL),(440,'3','Tamano',5,7021902,NULL),(441,'2','Conpersonas',4,7021902,NULL),(442,'1','Orientacion',1,7021903,NULL),(443,'3','Tamano',5,7021903,NULL),(444,'2','Conpersonas',4,7021903,NULL),(445,'1','Orientacion',1,7021904,NULL),(446,'3','Tamano',5,7021904,NULL),(447,'2','Conpersonas',4,7021904,NULL),(448,'1','Orientacion',1,7021905,NULL),(449,'3','Tamano',5,7021905,NULL),(450,'2','Conpersonas',4,7021905,NULL),(451,'1','Orientacion',1,7021906,NULL),(452,'3','Tamano',5,7021906,NULL),(453,'2','Conpersonas',4,7021906,NULL),(454,'1','Orientacion',1,7021907,NULL),(455,'3','Tamano',5,7021907,NULL),(456,'2','Conpersonas',4,7021907,NULL),(457,'1','Orientacion',1,7021908,NULL),(458,'3','Tamano',5,7021908,NULL),(459,'2','Conpersonas',4,7021908,NULL),(460,'1','Orientacion',1,7021909,NULL),(461,'3','Tamano',5,7021909,NULL),(462,'2','Conpersonas',4,7021909,NULL),(463,'1','Orientacion',1,7021910,NULL),(464,'3','Tamano',5,7021910,NULL),(465,'2','Conpersonas',4,7021910,NULL),(466,'1','Orientacion',1,7021911,NULL),(467,'3','Tamano',5,7021911,NULL),(468,'2','Conpersonas',4,7021911,NULL),(469,'1','Orientacion',1,7021912,NULL),(470,'3','Tamano',5,7021912,NULL),(471,'2','Conpersonas',4,7021912,NULL),(472,'1','Orientacion',1,7021913,NULL),(473,'2','Conpersonas',4,7021913,NULL),(474,'3','Tamano',6,7021913,NULL),(475,'1','Orientacion',1,7021914,NULL),(476,'2','Conpersonas',4,7021914,NULL),(477,'3','Tamano',6,7021914,NULL),(478,'1','Orientacion',1,7021915,NULL),(479,'2','Conpersonas',4,7021915,NULL),(480,'3','Tamano',6,7021915,NULL),(481,'1','Orientacion',1,7021916,NULL),(482,'2','Conpersonas',4,7021916,NULL),(483,'3','Tamano',6,7021916,NULL),(484,'1','Orientacion',2,7021917,NULL),(485,'2','Conpersonas',4,7021917,NULL),(486,'3','Tamano',5,7021917,NULL),(487,'1','Orientacion',2,7021918,NULL),(488,'2','Conpersonas',4,7021918,NULL),(489,'3','Tamano',6,7021918,NULL),(490,'1','Orientacion',1,7021919,NULL),(491,'2','Conpersonas',4,7021919,NULL),(492,'3','Tamano',7,7021919,NULL),(493,'1','Orientacion',1,7021920,NULL),(494,'2','Conpersonas',4,7021920,NULL),(495,'3','Tamano',6,7021920,NULL),(496,'1','Orientacion',1,7021921,'2019-05-28 14:12:49'),(497,'2','Conpersonas',4,7021921,'2019-05-28 14:12:49'),(498,'3','Tamano',6,7021921,'2019-05-28 14:12:49'),(499,'1','Orientacion',1,7021921,'2019-05-28 14:14:59'),(500,'2','Conpersonas',4,7021921,'2019-05-28 14:14:59'),(501,'3','Tamano',6,7021921,'2019-05-28 14:14:59'),(502,'1','Orientacion',1,7021921,'2019-05-28 14:16:41'),(503,'2','Conpersonas',4,7021921,'2019-05-28 14:16:41'),(504,'3','Tamano',6,7021921,'2019-05-28 14:16:41'),(505,'1','Orientacion',1,7021921,'2019-05-28 14:17:08'),(506,'2','Conpersonas',4,7021921,'2019-05-28 14:17:08'),(507,'3','Tamano',6,7021921,'2019-05-28 14:17:08'),(508,'1','Orientacion',1,7021921,'2019-05-28 14:53:15'),(509,'2','Conpersonas',4,7021921,'2019-05-28 14:53:15'),(510,'3','Tamano',6,7021921,'2019-05-28 14:53:15'),(511,'1','Orientacion',1,7021921,'2019-05-28 14:56:39'),(512,'2','Conpersonas',4,7021921,'2019-05-28 14:56:39'),(513,'3','Tamano',6,7021921,'2019-05-28 14:56:39'),(514,'1','Orientacion',1,7021921,'2019-05-28 14:57:10'),(515,'2','Conpersonas',4,7021921,'2019-05-28 14:57:10'),(516,'3','Tamano',6,7021921,'2019-05-28 14:57:10'),(517,'1','Orientacion',1,7021921,'2019-05-28 15:00:52'),(518,'2','Conpersonas',4,7021921,'2019-05-28 15:00:52'),(519,'3','Tamano',6,7021921,'2019-05-28 15:00:52'),(520,'1','Orientacion',1,7021921,'2019-05-28 15:01:23'),(521,'2','Conpersonas',4,7021921,'2019-05-28 15:01:23'),(522,'3','Tamano',6,7021921,'2019-05-28 15:01:23'),(523,'1','Orientacion',1,7021921,'2019-05-28 15:01:57'),(524,'2','Conpersonas',4,7021921,'2019-05-28 15:01:57'),(525,'3','Tamano',6,7021921,'2019-05-28 15:01:57'),(526,'1','Orientacion',1,7021921,'2019-05-28 16:55:44'),(527,'2','Conpersonas',4,7021921,'2019-05-28 16:55:44'),(528,'3','Tamano',6,7021921,'2019-05-28 16:55:44'),(529,'1','Orientacion',1,7021921,'2019-05-28 16:59:48'),(530,'2','Conpersonas',4,7021921,'2019-05-28 16:59:48'),(531,'3','Tamano',6,7021921,'2019-05-28 16:59:48'),(532,'1','Orientacion',1,7021921,NULL),(533,'2','Conpersonas',4,7021921,NULL),(534,'3','Tamano',6,7021921,NULL);

/*Table structure for table `posts` */

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `postId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `postName` varchar(100) DEFAULT NULL COMMENT 'post name',
  `postDescription` text COMMENT 'post description',
  `userId` int(11) DEFAULT NULL COMMENT 'who created this post',
  `created_at` datetime DEFAULT NULL COMMENT 'when was created',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was updated',
  `miniImageUrl` varchar(100) DEFAULT NULL COMMENT 'file image url in server',
  `postTypeId` int(11) DEFAULT NULL COMMENT 'what type of post have this post, ej: fotografia,....',
  `postCategoryId` int(11) DEFAULT NULL COMMENT 'what categorty is this post assigned to',
  `deleted_at` datetime DEFAULT NULL COMMENT 'when was deleted',
  `postState` int(11) DEFAULT NULL COMMENT 'post state',
  `awsFilename` varchar(100) DEFAULT NULL COMMENT 'filed uploaded to aws',
  `fileNameImage` varchar(100) DEFAULT NULL COMMENT 'original file name image',
  `fileNameAWS` varchar(100) DEFAULT NULL COMMENT 'original file name aws',
  `downloads` int(11) DEFAULT '0' COMMENT 'how many times was it downloaded',
  `favorites` int(11) DEFAULT '0' COMMENT 'how many favorites has this post earned',
  PRIMARY KEY (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=7021922 DEFAULT CHARSET=latin1;

/*Data for the table `posts` */

insert  into `posts`(`postId`,`postName`,`postDescription`,`userId`,`created_at`,`updated_at`,`miniImageUrl`,`postTypeId`,`postCategoryId`,`deleted_at`,`postState`,`awsFilename`,`fileNameImage`,`fileNameAWS`,`downloads`,`favorites`) values (7021878,'prueba1xxx','prueba',1,'2019-05-08 22:09:13','2019-05-23 21:54:55','PID_14_US_1_DATE_20190508220913.jpg',1,33,NULL,1,'PID_14_US_1_DATE_20190508220913.jpg','adminlogo.jpg','adminlogo.jpg',3,22),(7021881,'zxcxzczxc','qeewqe',38,'2019-05-13 22:10:59','2019-05-20 02:35:54','PID_7021881_US_38_DATE_20190513221059.jpg',1,1,NULL,0,'PID_7021881_US_38_DATE_20190513221059.jpg','KornRAR2013_3.jpg','KornRAR2013_3.jpg',0,56),(7021882,'qqqqqqq','qqqq',38,'2019-05-13 22:11:33','2019-05-27 13:54:35','PID_7021882_US_38_DATE_20190513221133.jpg',1,2,NULL,0,'PID_7021882_US_38_DATE_20190513221133.jpg','images.jpg','images.jpg',0,31),(7021883,'QQWEQWEQWE','QWEQWEQWE',38,'2019-05-13 22:15:52','2019-05-14 21:39:18','PID__US_38_DATE_20190514213834.gif',1,10,NULL,0,'PID__US_38_DATE_20190514213834.gif','avatar.gif','avatar.gif',0,46),(7021884,'zxcxzczxc','qeewqe',38,'2019-05-13 22:10:59','2019-05-13 22:10:59','PID_7021881_US_38_DATE_20190513221059.jpg',1,1,NULL,0,'PID_7021881_US_38_DATE_20190513221059.jpg','KornRAR2013_3.jpg','KornRAR2013_3.jpg',0,16),(7021885,'qqqqqqq','qqqq',38,'2019-05-13 22:11:33','2019-05-13 22:11:33','PID_7021882_US_38_DATE_20190513221133.jpg',1,2,NULL,0,'PID_7021882_US_38_DATE_20190513221133.jpg','images.jpg','images.jpg',0,4),(7021886,'zxcxzczxc','qeewqe',38,'2019-05-13 22:10:59','2019-05-13 22:10:59','PID_7021881_US_38_DATE_20190513221059.jpg',1,1,NULL,0,'PID_7021881_US_38_DATE_20190513221059.jpg','KornRAR2013_3.jpg','KornRAR2013_3.jpg',0,29),(7021887,'qqqqqqq','qqqq',38,'2019-05-13 22:11:33','2019-05-13 22:11:33','PID_7021882_US_38_DATE_20190513221133.jpg',1,2,NULL,0,'PID_7021882_US_38_DATE_20190513221133.jpg','images.jpg','images.jpg',0,12),(7021888,'xxxxxx','xxxxxx',38,'2019-05-13 22:39:17','2019-05-23 23:03:19','PID_7021888_US_38_DATE_20190513223917.jpg',1,2,NULL,1,'PID_7021888_US_38_DATE_20190513223917.jpg','v1.jpg','v1.jpg',4,32),(7021889,'Imagen verde','This image must ñeame àà `w juàn ¿¿ +qweqwe ´qweqwe ´zxcwejmqw eqwe \'\'\'\'\' ??\"\"\" \"\" \" ññññaaaaaa ñññìììiìììiììi\nThis image must ñeame àà `w juàn ¿¿ +qweqwe ´qweqwe ´zxcwejmqw eqwe \'\'\'\'\' ??\"\"\" \"\" \" ññññaaaaaa ñññìììiìììiììi\nThis image must ñeame àà `w juàn ¿¿ +qweqwe ´qweqwe ´zxcwejmqw eqwe \'\'\'\'\' ??\"\"\" \"\" \" ññññaaaaaa ñññìììiìììiììi',39,'2019-05-13 22:39:55','2019-05-20 19:38:52','PID_7021889_US_38_DATE_20190513223955.JPG',1,2,NULL,0,'PID_7021889_US_38_DATE_20190513223955.JPG','v.JPG','v.JPG',0,5),(7021890,'qeqwe','qeqwe',38,'2019-05-14 15:30:32','2019-05-14 15:30:32','PID_7021890_US_38_DATE_20190514153032.jpg',1,10,NULL,0,'PID_7021890_US_38_DATE_20190514153032.jpg','PID_7021881_US_38_DATE_20190513221059.jpg','PID_7021881_US_38_DATE_20190513221059.jpg',0,49),(7021892,'qweqweqweq','qweqweqweq',38,'2019-05-14 16:43:30','2019-05-24 22:23:44','PID_7021892_US_38_DATE_20190514164330.jpg',1,2,NULL,1,'PID_7021892_US_38_DATE_20190514164330.jpg','KornRAR2013_3.jpg','KornRAR2013_3.jpg',3,50),(7021893,'qweqweqweq','qweqweqweq',38,'2019-05-14 16:44:54','2019-05-14 16:44:54',NULL,1,10,NULL,0,NULL,NULL,NULL,0,42),(7021894,'qweqweqweq','qweqweqweq',38,'2019-05-14 16:45:29','2019-05-14 16:45:30','PID_7021894_US_38_DATE_20190514164530.jpg',1,2,NULL,0,'PID_7021894_US_38_DATE_20190514164530.jpg','161.jpg','161.jpg',0,58),(7021895,'me and me','me and me',39,'2019-05-14 16:46:07','2019-05-14 16:46:08','PID_7021895_US_38_DATE_20190514164608.jpg',1,11,NULL,0,'PID_7021895_US_38_DATE_20190514164608.jpg','fiedly.jpg','fiedly.jpg',0,44),(7021896,'me and my friends','me and my friends',39,'2019-05-14 19:24:48','2019-05-24 22:14:20','PID_7021896_US_38_DATE_20190514192449.jpg',1,10,NULL,0,'PID_7021896_US_38_DATE_20190514192449.jpg','KornRAR2013_3.jpg','KornRAR2013_3.jpg',0,46),(7021897,'NFSMW M3','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Autem, doloribus quasi? Accusantium deleniti id voluptate aspernatur alias, commodi enim totam quis atque ipsam nobis quas neque, sint provident repudiandae dolorem.\nLorem ipsum dolor sit amet consectetur, adipisicing elit. Autem, doloribus quasi? Accusantium deleniti id voluptate aspernatur alias, commodi enim totam quis atque ipsam nobis quas neque, sint provident repudiandae dolorem.',39,'2019-05-20 00:11:58','2019-05-24 15:08:50','PID_7021897_US_39_DATE_20190520001158.jpg',1,10,NULL,1,'PID_7021897_US_39_DATE_20190520001158.jpg','1.jpg','1.jpg',4,0),(7021898,'prueba','prueba',39,'2019-05-27 22:52:55','2019-05-27 22:52:55',NULL,1,11,NULL,0,NULL,NULL,NULL,0,0),(7021899,'prueba','qweqwe',40,'2019-05-27 22:54:26','2019-05-27 22:54:26',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021900,'prueba','qweqwe',40,'2019-05-27 22:55:02','2019-05-27 22:55:02',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021901,'prueba','qweqwe',40,'2019-05-27 22:55:26','2019-05-27 22:55:26',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021902,'prueba','qweqwe',40,'2019-05-27 22:57:29','2019-05-27 22:57:29',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021903,'prueba','qweqwe',40,'2019-05-27 22:57:44','2019-05-27 22:57:44',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021904,'prueba','qweqwe',40,'2019-05-27 22:58:00','2019-05-27 22:58:00',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021905,'prueba','qweqwe',40,'2019-05-27 22:59:22','2019-05-27 22:59:22',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021906,'prueba','qweqwe',40,'2019-05-27 22:59:36','2019-05-27 22:59:36',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021907,'prueba','qweqwe',40,'2019-05-27 23:00:13','2019-05-27 23:00:13',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021908,'prueba','qweqwe',40,'2019-05-27 23:00:24','2019-05-27 23:00:24',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021909,'prueba','qweqwe',40,'2019-05-27 23:01:05','2019-05-27 23:01:05',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021910,'prueba','qweqwe',40,'2019-05-27 23:02:37','2019-05-27 23:02:37',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021911,'prueba','qweqwe',40,'2019-05-27 23:02:48','2019-05-27 23:02:48',NULL,1,10,NULL,0,NULL,NULL,NULL,0,0),(7021912,'prueba','qweqwe',40,'2019-05-27 23:03:42','2019-05-27 23:03:43','PID_7021912_US_1_DATE_20190527230342.jpg',1,10,NULL,0,'PID_7021912_US_1_DATE_20190527230342.jpg','images.jpg','images.jpg',0,0),(7021913,'pesada','pesada',38,'2019-05-27 23:04:32','2019-05-27 23:04:32','PID_7021913_US_1_DATE_20190527230432.jpg',1,1,NULL,0,'PID_7021913_US_1_DATE_20190527230432.jpg','Untitled.jpg','20mb.jpg',0,0),(7021914,'prueba pesada','prueba pesada',38,'2019-05-28 13:16:47','2019-05-28 13:16:47','PID_7021914_US_1_DATE_20190528131647.jpg',1,10,NULL,0,'PID_7021914_US_1_DATE_20190528131647.jpg','Untitled.jpg','20mb.jpg',0,0),(7021915,'prueba pesada','prueba pesada',1,'2019-05-28 13:24:22','2019-05-28 13:24:22','PID_7021915_US_1_DATE_20190528132422.jpg',1,2,NULL,0,'PID_7021915_US_1_DATE_20190528132422.jpg','images.jpg','20mb.jpg',0,0),(7021916,'prueba pesada','prueba pesada',39,'2019-05-28 13:27:43','2019-05-28 13:27:43','PID_7021916_US_1_DATE_20190528132743.jpg',1,2,NULL,0,'PID_7021916_US_1_DATE_20190528132743.jpg','Untitled.jpg','20mb.jpg',0,0),(7021917,'pesada','pesada',1,'2019-05-28 13:40:15','2019-05-28 13:40:15','PID_7021917_US_1_DATE_20190528134015.jpg',1,2,NULL,0,'PID_7021917_US_1_DATE_20190528134015.jpg','Untitled.jpg','20mb.jpg',0,0),(7021918,'prueba ph','prueba ph',39,'2019-05-28 13:49:26','2019-05-28 13:49:26','PID_7021918_US_1_DATE_20190528134926.jpg',1,1,NULL,0,'PID_7021918_US_1_DATE_20190528134926.jpg','Untitled.jpg','20mb.jpg',0,0),(7021919,'prueba ph','prueba ph',39,'2019-05-28 13:51:10','2019-05-28 13:51:10','PID_7021919_US_1_DATE_20190528135110.jpg',1,11,NULL,0,'PID_7021919_US_1_DATE_20190528135110.jpg','Untitled.jpg','20mb.jpg',0,0),(7021920,'prueba','prueba',39,'2019-05-28 14:02:29','2019-05-28 14:02:30','PID_7021920_US_1_DATE_20190528140230.jpg',1,11,NULL,0,'PID_7021920_US_1_DATE_20190528140230.jpg','Untitled.jpg','20mb.jpg',0,0),(7021921,'prueba','prueba',39,'2019-05-28 14:08:03','2019-05-28 17:02:36','PID_7021921_US_1_DATE_20190528165948.jpg',1,11,NULL,1,'PID_7021921_US_1_DATE_20190528165948.jpg','images.jpg','20mb.jpg',5,0);

/*Table structure for table `posts_favorites` */

DROP TABLE IF EXISTS `posts_favorites`;

CREATE TABLE `posts_favorites` (
  `postFavoriteId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID pk',
  `userId` int(11) NOT NULL COMMENT 'who liked the post',
  `postId` int(11) NOT NULL COMMENT 'the post liked',
  `created_at` datetime DEFAULT NULL COMMENT 'when was liked',
  `updated_at` datetime DEFAULT NULL COMMENT 'this field wont be used but is required',
  PRIMARY KEY (`postFavoriteId`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

/*Data for the table `posts_favorites` */

insert  into `posts_favorites`(`postFavoriteId`,`userId`,`postId`,`created_at`,`updated_at`) values (10,39,7021897,'2019-05-20 21:58:23','2019-05-20 21:58:23'),(21,39,7021878,'2019-05-21 13:27:52','2019-05-21 13:27:52'),(22,39,7021888,'2019-05-21 20:49:01','2019-05-21 20:49:01'),(23,39,7021892,'2019-05-21 20:49:17','2019-05-21 20:49:17'),(29,41,7021888,'2019-05-21 20:55:52','2019-05-21 20:55:52'),(30,41,7021897,'2019-05-21 20:56:05','2019-05-21 20:56:05'),(31,41,7021878,'2019-05-21 21:40:58','2019-05-21 21:40:58'),(38,40,7021878,'2019-05-24 20:07:49','2019-05-24 20:07:49'),(40,40,7021892,'2019-05-24 21:02:33','2019-05-24 21:02:33'),(42,40,7021888,'2019-05-24 21:03:38','2019-05-24 21:03:38');

/*Table structure for table `posts_filters` */

DROP TABLE IF EXISTS `posts_filters`;

CREATE TABLE `posts_filters` (
  `postFiltersId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id pk',
  `postFilterName` varchar(100) DEFAULT NULL COMMENT 'name of the filter',
  `postFilverValue` varchar(100) DEFAULT NULL COMMENT 'value of the filter',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was updated',
  `created_at` datetime DEFAULT NULL COMMENT 'when was created',
  `deleted_at` datetime DEFAULT NULL COMMENT 'when was deleted',
  `created_by` int(11) DEFAULT NULL COMMENT 'who created',
  PRIMARY KEY (`postFiltersId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `posts_filters` */

insert  into `posts_filters`(`postFiltersId`,`postFilterName`,`postFilverValue`,`updated_at`,`created_at`,`deleted_at`,`created_by`) values (1,'Orientacion','si',NULL,'2019-05-02 15:58:18',NULL,NULL),(2,'Con personas','si',NULL,'2019-05-02 15:58:18',NULL,NULL),(3,'Tamano','si',NULL,'2019-05-02 15:58:18',NULL,NULL);

/*Table structure for table `posts_filters_subfilters` */

DROP TABLE IF EXISTS `posts_filters_subfilters`;

CREATE TABLE `posts_filters_subfilters` (
  `postFiltersSubFilterId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `postFilterId` int(11) DEFAULT NULL COMMENT 'filter parent',
  `postFilterSubFilterName` varchar(100) DEFAULT NULL COMMENT 'name of subfilter',
  `postFilterSubFilterValue` varchar(100) DEFAULT NULL COMMENT 'value of subfilter',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`postFiltersSubFilterId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `posts_filters_subfilters` */

insert  into `posts_filters_subfilters`(`postFiltersSubFilterId`,`postFilterId`,`postFilterSubFilterName`,`postFilterSubFilterValue`,`created_at`,`updated_at`,`deleted_at`) values (1,2,'Genero',NULL,NULL,NULL,NULL),(2,2,'Edad',NULL,NULL,NULL,NULL),(3,2,'Cantidad',NULL,NULL,NULL,NULL);

/*Table structure for table `posts_filters_values` */

DROP TABLE IF EXISTS `posts_filters_values`;

CREATE TABLE `posts_filters_values` (
  `postFiltersValueId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `postFilterId` int(11) DEFAULT NULL COMMENT 'filter value',
  `postFiltersSubFilterId` int(11) DEFAULT NULL COMMENT 'id of the subfilter',
  `postFilterValue` varchar(100) DEFAULT NULL COMMENT 'value of the filter',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`postFiltersValueId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `posts_filters_values` */

insert  into `posts_filters_values`(`postFiltersValueId`,`postFilterId`,`postFiltersSubFilterId`,`postFilterValue`,`created_at`,`updated_at`,`deleted_at`) values (1,1,0,'Vertical',NULL,NULL,NULL),(2,1,0,'Horizontal',NULL,NULL,NULL),(3,2,0,'Si',NULL,NULL,NULL),(4,2,0,'No',NULL,NULL,NULL),(5,3,0,'S',NULL,NULL,NULL),(6,3,0,'2x2',NULL,NULL,NULL),(7,3,0,'3x3',NULL,NULL,NULL),(8,2,1,'Masculino',NULL,NULL,NULL),(9,2,1,'Femenino',NULL,NULL,NULL),(10,2,2,'1 a 10',NULL,NULL,NULL),(11,2,2,'11 a 20',NULL,NULL,NULL),(12,2,2,'21 a 50',NULL,NULL,NULL),(13,2,2,'51 en adelante',NULL,NULL,NULL),(14,2,3,'1 a 10',NULL,NULL,NULL),(15,2,3,'11 a 20',NULL,NULL,NULL),(16,NULL,2,'21 a 50',NULL,NULL,NULL);

/*Table structure for table `posts_tags` */

DROP TABLE IF EXISTS `posts_tags`;

CREATE TABLE `posts_tags` (
  `postTagsId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `postId` int(11) DEFAULT NULL COMMENT 'id of the post',
  `tagId` int(11) DEFAULT NULL COMMENT 'id of the tag',
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`postTagsId`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=latin1;

/*Data for the table `posts_tags` */

insert  into `posts_tags`(`postTagsId`,`postId`,`tagId`,`deleted_at`) values (47,14,36,NULL),(48,14,36,NULL),(49,14,36,NULL),(50,14,36,NULL),(51,14,36,NULL),(52,14,36,NULL),(53,14,36,NULL),(54,14,36,NULL),(55,14,36,NULL),(56,14,36,NULL),(57,14,36,NULL),(58,14,36,NULL),(59,14,36,NULL),(60,14,36,NULL),(61,14,36,NULL),(62,7021879,36,'2019-05-13 20:00:58'),(63,7021879,36,'2019-05-13 20:00:58'),(64,7021879,49,NULL),(65,7021880,50,NULL),(66,7021881,36,NULL),(67,7021882,42,'2019-05-27 13:54:35'),(68,7021887,40,NULL),(69,7021888,42,NULL),(70,7021889,42,'2019-05-20 16:51:56'),(71,7021890,42,NULL),(72,7021891,42,NULL),(73,7021892,42,'2019-05-24 22:23:44'),(74,7021893,42,NULL),(75,7021894,42,NULL),(76,7021895,42,NULL),(77,7021896,42,'2019-05-24 22:14:20'),(78,7021888,42,NULL),(79,7021883,42,NULL),(80,7021883,42,NULL),(81,7021883,42,NULL),(82,7021897,41,'2019-05-21 22:47:43'),(83,7021897,41,'2019-05-21 22:47:43'),(84,7021878,42,NULL),(85,7021881,36,NULL),(86,7021881,58,NULL),(87,7021881,50,NULL),(88,7021889,42,'2019-05-20 16:51:56'),(89,7021889,41,'2019-05-20 16:51:56'),(90,7021889,40,'2019-05-20 16:51:56'),(91,7021889,36,'2019-05-20 16:51:56'),(92,7021889,42,'2019-05-20 16:51:56'),(93,7021889,41,'2019-05-20 16:51:56'),(94,7021889,40,'2019-05-20 16:51:56'),(95,7021889,36,'2019-05-20 16:51:56'),(96,7021889,42,'2019-05-20 16:51:56'),(97,7021889,41,'2019-05-20 16:51:56'),(98,7021889,40,'2019-05-20 16:51:56'),(99,7021889,36,'2019-05-20 16:51:56'),(100,7021889,42,'2019-05-20 16:51:56'),(101,7021889,41,'2019-05-20 16:51:56'),(102,7021889,40,'2019-05-20 16:51:56'),(103,7021889,36,'2019-05-20 16:51:56'),(104,7021889,42,'2019-05-20 16:51:56'),(105,7021889,41,'2019-05-20 16:51:56'),(106,7021889,40,'2019-05-20 16:51:56'),(107,7021889,36,'2019-05-20 16:51:56'),(108,7021889,42,'2019-05-20 16:52:13'),(109,7021889,41,'2019-05-20 16:52:13'),(110,7021889,40,'2019-05-20 16:52:13'),(111,7021889,36,'2019-05-20 16:52:13'),(112,7021889,42,'2019-05-20 16:52:13'),(113,7021889,41,'2019-05-20 16:52:13'),(114,7021889,40,'2019-05-20 16:52:13'),(115,7021889,36,'2019-05-20 16:52:13'),(116,7021889,42,'2019-05-20 17:06:50'),(117,7021889,41,'2019-05-20 17:06:50'),(118,7021889,40,'2019-05-20 17:06:50'),(119,7021889,36,'2019-05-20 17:06:50'),(120,7021889,42,'2019-05-20 17:07:12'),(121,7021889,41,'2019-05-20 17:07:12'),(122,7021889,40,'2019-05-20 17:07:12'),(123,7021889,36,'2019-05-20 17:07:12'),(124,7021889,42,'2019-05-20 19:15:27'),(125,7021889,41,'2019-05-20 19:15:27'),(126,7021889,40,'2019-05-20 19:15:27'),(127,7021889,36,'2019-05-20 19:15:27'),(128,7021889,42,'2019-05-20 19:15:27'),(129,7021889,41,'2019-05-20 19:15:27'),(130,7021889,40,'2019-05-20 19:15:27'),(131,7021889,36,'2019-05-20 19:15:42'),(132,7021889,36,'2019-05-20 19:15:42'),(133,7021889,40,'2019-05-20 19:16:18'),(134,7021889,40,'2019-05-20 19:16:43'),(135,7021889,36,'2019-05-20 19:16:43'),(136,7021889,41,'2019-05-20 19:16:43'),(137,7021889,40,'2019-05-20 19:16:54'),(138,7021889,36,'2019-05-20 19:16:54'),(139,7021889,41,'2019-05-20 19:16:54'),(140,7021889,40,'2019-05-20 19:17:55'),(141,7021889,36,'2019-05-20 19:17:55'),(142,7021889,41,'2019-05-20 19:17:55'),(143,7021889,40,'2019-05-20 19:18:09'),(144,7021889,36,'2019-05-20 19:18:09'),(145,7021889,41,'2019-05-20 19:18:09'),(146,7021889,42,'2019-05-20 19:18:09'),(147,7021889,40,'2019-05-20 19:19:02'),(148,7021889,36,'2019-05-20 19:19:02'),(149,7021889,41,'2019-05-20 19:19:02'),(150,7021889,42,'2019-05-20 19:19:02'),(151,7021889,40,'2019-05-20 19:30:02'),(152,7021889,36,'2019-05-20 19:30:02'),(153,7021889,41,'2019-05-20 19:30:02'),(154,7021889,42,'2019-05-20 19:30:02'),(155,7021889,37,'2019-05-20 19:31:55'),(156,7021889,37,'2019-05-20 19:32:12'),(157,7021889,47,'2019-05-20 19:32:12'),(158,7021889,37,'2019-05-20 19:32:32'),(159,7021889,47,'2019-05-20 19:32:32'),(160,7021889,37,'2019-05-20 19:34:14'),(161,7021889,47,'2019-05-20 19:34:14'),(162,7021889,48,'2019-05-20 19:34:14'),(163,7021889,37,'2019-05-20 19:34:32'),(164,7021889,47,'2019-05-20 19:34:32'),(165,7021889,48,'2019-05-20 19:34:32'),(166,7021889,42,'2019-05-20 19:34:32'),(167,7021889,37,'2019-05-20 19:36:11'),(168,7021889,47,'2019-05-20 19:36:11'),(169,7021889,48,'2019-05-20 19:36:11'),(170,7021889,42,'2019-05-20 19:36:11'),(171,7021889,37,'2019-05-20 19:38:09'),(172,7021889,37,'2019-05-20 19:38:15'),(173,7021889,47,'2019-05-20 19:38:15'),(174,7021889,37,'2019-05-20 19:38:30'),(175,7021889,48,'2019-05-20 19:38:52'),(176,7021889,49,'2019-05-20 19:38:52'),(177,7021889,50,'2019-05-20 19:38:52'),(178,7021889,42,'2019-05-20 19:38:52'),(179,7021889,41,'2019-05-20 19:38:52'),(180,7021889,40,'2019-05-20 19:38:52'),(181,7021889,36,'2019-05-20 19:38:52'),(182,7021889,48,NULL),(183,7021889,50,NULL),(184,7021889,42,NULL),(185,7021889,40,NULL),(186,7021897,41,NULL),(187,7021896,62,NULL),(188,7021892,62,NULL),(189,7021882,42,NULL),(190,7021898,62,NULL),(191,7021899,62,NULL),(192,7021900,62,NULL),(193,7021901,62,NULL),(194,7021902,62,NULL),(195,7021903,62,NULL),(196,7021904,62,NULL),(197,7021905,62,NULL),(198,7021906,62,NULL),(199,7021907,62,NULL),(200,7021908,62,NULL),(201,7021909,62,NULL),(202,7021910,62,NULL),(203,7021911,62,NULL),(204,7021912,62,NULL),(205,7021913,62,NULL),(206,7021914,62,NULL),(207,7021915,62,NULL),(208,7021916,62,NULL),(209,7021917,62,NULL),(210,7021918,62,NULL),(211,7021919,62,NULL),(212,7021920,62,NULL),(213,7021921,62,'2019-05-28 14:12:49'),(214,7021921,62,'2019-05-28 14:14:59'),(215,7021921,62,'2019-05-28 14:16:41'),(216,7021921,62,'2019-05-28 14:17:08'),(217,7021921,62,'2019-05-28 14:53:15'),(218,7021921,62,'2019-05-28 14:56:39'),(219,7021921,62,'2019-05-28 14:57:10'),(220,7021921,62,'2019-05-28 15:00:52'),(221,7021921,62,'2019-05-28 15:01:23'),(222,7021921,62,'2019-05-28 15:01:56'),(223,7021921,62,'2019-05-28 16:55:43'),(224,7021921,62,'2019-05-28 16:59:48'),(225,7021921,62,NULL);

/*Table structure for table `posts_types` */

DROP TABLE IF EXISTS `posts_types`;

CREATE TABLE `posts_types` (
  `postTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `postTypeName` varchar(100) DEFAULT NULL COMMENT 'type name',
  `createdAt` datetime DEFAULT NULL COMMENT 'when was created',
  `updatedAt` datetime DEFAULT NULL COMMENT 'when was updated',
  `createdBy` int(11) DEFAULT NULL COMMENT 'who created',
  PRIMARY KEY (`postTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `posts_types` */

insert  into `posts_types`(`postTypeId`,`postTypeName`,`createdAt`,`updatedAt`,`createdBy`) values (1,'Fotografia','2019-04-10 11:44:07','2019-04-10 11:44:10',1);

/*Table structure for table `posts_user_projects` */

DROP TABLE IF EXISTS `posts_user_projects`;

CREATE TABLE `posts_user_projects` (
  `postsUserProjectsId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk incre',
  `postId` int(11) DEFAULT NULL COMMENT 'post id',
  `projectId` int(11) DEFAULT NULL COMMENT 'project id',
  `created_at` datetime DEFAULT NULL COMMENT 'laravel bussines',
  `updated_at` datetime DEFAULT NULL COMMENT 'laravel bussines',
  `deleted_at` datetime DEFAULT NULL COMMENT 'laravel bussines',
  PRIMARY KEY (`postsUserProjectsId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `posts_user_projects` */

insert  into `posts_user_projects`(`postsUserProjectsId`,`postId`,`projectId`,`created_at`,`updated_at`,`deleted_at`) values (1,7021888,1,'2019-05-21 20:48:54','2019-05-21 20:48:54',NULL),(2,7021892,4,'2019-05-21 21:40:07','2019-05-21 21:40:07',NULL),(3,7021878,5,'2019-05-21 21:40:33','2019-05-21 21:40:33',NULL),(4,7021878,4,'2019-05-21 21:40:48','2019-05-21 21:40:48',NULL),(5,7021878,5,'2019-05-21 21:40:48','2019-05-21 21:40:48',NULL),(6,7021878,3,'2019-05-21 21:40:48','2019-05-21 21:40:48',NULL),(7,7021892,6,'2019-05-22 21:59:10','2019-05-23 23:01:28','2019-05-23 23:01:28'),(8,7021888,6,'2019-05-23 19:53:40','2019-05-23 23:01:28','2019-05-23 23:01:28'),(9,7021897,7,'2019-05-23 21:48:31','2019-05-23 23:02:48','2019-05-23 23:02:48'),(10,7021878,8,'2019-05-23 21:54:55','2019-05-23 23:04:25','2019-05-23 23:04:25'),(11,7021888,8,'2019-05-23 23:02:58','2019-05-23 23:04:25','2019-05-23 23:04:25'),(12,7021888,9,'2019-05-23 23:03:19','2019-05-23 23:03:31','2019-05-23 23:03:31'),(13,7021897,10,'2019-05-23 23:06:15','2019-05-23 23:06:21','2019-05-23 23:06:21'),(14,7021897,11,'2019-05-24 13:11:42','2019-05-24 13:11:42',NULL),(15,7021892,12,'2019-05-24 15:08:32','2019-05-24 15:08:32',NULL),(16,7021897,13,'2019-05-24 15:08:50','2019-05-24 15:08:50',NULL),(17,7021921,12,'2019-05-28 15:16:07','2019-05-28 15:16:07',NULL),(18,7021921,12,'2019-05-28 15:16:46','2019-05-28 15:16:46',NULL),(19,7021921,12,'2019-05-28 15:17:02','2019-05-28 15:17:02',NULL),(20,7021921,12,'2019-05-28 17:01:50','2019-05-28 17:01:50',NULL),(21,7021921,11,'2019-05-28 17:02:36','2019-05-28 17:02:36',NULL);

/*Table structure for table `profiles` */

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `profileId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `profileName` varchar(100) DEFAULT NULL COMMENT 'profile name, god, profesional, end user',
  `created_at` datetime DEFAULT NULL COMMENT 'when this profile was created',
  `updated_at` datetime DEFAULT NULL COMMENT 'when this profile was updated',
  `updatedBy` int(11) DEFAULT NULL COMMENT 'which user created this category, being refered by his id on users table',
  PRIMARY KEY (`profileId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `profiles` */

insert  into `profiles`(`profileId`,`profileName`,`created_at`,`updated_at`,`updatedBy`) values (1,'Administrador','2019-04-10 11:03:39','2019-05-07 19:28:14',1),(2,'Fotografo','2019-04-24 18:01:58','2019-05-13 15:59:09',1),(3,'Usuario final','2019-04-24 18:02:24','2019-05-13 15:59:15',1);

/*Table structure for table `tags_group_tags` */

DROP TABLE IF EXISTS `tags_group_tags`;

CREATE TABLE `tags_group_tags` (
  `tagId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `tagName` varchar(100) DEFAULT NULL COMMENT 'name of the tag',
  `created_at` datetime DEFAULT NULL COMMENT 'when was created',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was updated',
  `deleted_at` datetime DEFAULT NULL COMMENT 'when was deleted',
  `createdBy` int(11) DEFAULT NULL COMMENT 'who created this',
  `tagGroupId` int(11) DEFAULT NULL COMMENT 'group of this tag',
  PRIMARY KEY (`tagId`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

/*Data for the table `tags_group_tags` */

insert  into `tags_group_tags`(`tagId`,`tagName`,`created_at`,`updated_at`,`deleted_at`,`createdBy`,`tagGroupId`) values (36,'Municipio 1','2019-04-24 20:36:12','2019-05-07 17:02:42',NULL,1,1),(37,'Clientes','2019-04-24 20:36:23','2019-05-07 17:03:15',NULL,1,2),(38,'Etiqueta','2019-04-24 20:36:23','2019-04-25 16:17:31','2019-04-25 16:17:31',1,3),(39,'Calidez','2019-04-24 20:36:23','2019-05-07 19:27:15',NULL,1,4),(40,'Municipio 2','2019-04-24 21:38:13','2019-05-07 17:02:48',NULL,1,1),(41,'Municipio 3','2019-04-24 21:38:19','2019-05-07 17:02:52',NULL,1,1),(42,'Municipio 4','2019-04-24 21:38:22','2019-05-07 17:02:57',NULL,1,1),(43,'Nueva Etiqueta','2019-04-24 21:38:25','2019-04-24 22:24:40','2019-04-24 22:24:40',1,4),(44,'Nueva Etiqueta','2019-04-24 21:38:27','2019-04-24 22:22:00','2019-04-24 22:22:00',1,4),(45,'Nueva Etiqueta1','2019-04-24 21:38:29','2019-04-24 22:22:00','2019-04-24 22:22:00',1,4),(46,'Responsabilidad','2019-04-25 15:59:36','2019-05-07 19:27:24',NULL,1,4),(47,'Proveedores','2019-05-07 17:03:54','2019-05-07 17:03:54',NULL,1,2),(48,'Gente ESSA','2019-05-07 17:04:13','2019-05-07 19:22:28',NULL,1,2),(49,'Lideres','2019-05-07 19:23:07','2019-05-07 19:23:07',NULL,1,2),(50,'Estado','2019-05-07 19:23:29','2019-05-07 19:23:29',NULL,1,2),(51,'Acceso al servicio','2019-05-07 19:24:47','2019-05-07 19:24:47',NULL,1,3),(52,'Clima laboral','2019-05-07 19:24:59','2019-05-07 19:24:59',NULL,1,3),(53,' Contratacion responsable','2019-05-07 19:25:20','2019-05-07 19:25:20',NULL,1,3),(54,'Poblacion sin servicio','2019-05-07 19:25:36','2019-05-07 19:25:36',NULL,1,3),(55,'Derechos humanos','2019-05-07 19:25:50','2019-05-07 19:25:50',NULL,1,3),(56,'Tarifas y precios','2019-05-07 19:26:08','2019-05-07 19:26:08',NULL,1,3),(57,'Transparencia (relacionamiento)','2019-05-07 19:26:24','2019-05-07 19:26:24',NULL,1,3),(58,'Desempeno ambiental','2019-05-07 19:26:36','2019-05-07 19:26:36',NULL,1,3),(59,'Biodiversidad','2019-05-07 19:26:50','2019-05-07 19:26:50',NULL,1,3),(60,'Cuidado del agua','2019-05-07 19:27:05','2019-05-07 19:27:05',NULL,1,3),(61,'Transparencia','2019-05-07 19:27:34','2019-05-07 19:27:34',NULL,1,4),(62,'Prueba','2019-05-21 13:32:51','2019-05-21 13:34:13',NULL,1,1);

/*Table structure for table `tags_groups` */

DROP TABLE IF EXISTS `tags_groups`;

CREATE TABLE `tags_groups` (
  `tagGroupId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `tagGroupName` varchar(100) DEFAULT NULL COMMENT 'group name',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was the changed',
  PRIMARY KEY (`tagGroupId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `tags_groups` */

insert  into `tags_groups`(`tagGroupId`,`tagGroupName`,`updated_at`) values (1,'Municipios','2019-05-07 17:02:23'),(2,'Grupos de interes','2019-05-07 17:03:07'),(3,'Materialidad','2019-05-07 19:23:37'),(4,'Valores','2019-05-07 20:48:07');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'autoinc and pk for users table',
  `name` varchar(50) DEFAULT NULL COMMENT 'user name',
  `email` varchar(50) NOT NULL COMMENT 'user email',
  `identificationNumber` varchar(50) DEFAULT NULL COMMENT 'number of identification',
  `password` varchar(300) NOT NULL COMMENT 'password in sha256 encryption',
  `passwordMask` varchar(100) DEFAULT NULL COMMENT 'this is the face of the password, only for front-end data display, not working for system user validations',
  `registerdDate` datetime DEFAULT NULL COMMENT 'when was the user created',
  `birthDate` date DEFAULT NULL COMMENT 'user bith date',
  `profileId` int(11) DEFAULT NULL COMMENT 'what profile is this user assigned to',
  `userState` int(11) DEFAULT NULL COMMENT 'what status have this user',
  `phoneNumber` decimal(10,0) DEFAULT NULL COMMENT 'phone number',
  `userDepartmentId` int(11) DEFAULT NULL COMMENT 'what deparment has the user assigned',
  `created_at` datetime DEFAULT NULL COMMENT 'when was the user created',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was the user updated',
  `userAvatarFileName` varchar(100) DEFAULT NULL COMMENT 'avatar file',
  `requestPasswordChange` int(1) DEFAULT NULL COMMENT 'to verify is user has requested a passwordchange',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`userId`,`name`,`email`,`identificationNumber`,`password`,`passwordMask`,`registerdDate`,`birthDate`,`profileId`,`userState`,`phoneNumber`,`userDepartmentId`,`created_at`,`updated_at`,`userAvatarFileName`,`requestPasswordChange`) values (1,'god12','mmejiadeveloper@gmail.com','1','$2y$10$K5RZ1co.6e/AwNLR/mJIWOIPyFvXtFkq0yuqFIev5Odj0kAeBimUi','sa123456','2019-04-09 11:45:59','2019-04-09',1,1,3157058839,1,'2019-04-26 09:40:11','2019-05-20 20:06:07','1_20190503221331.jpg',1),(38,'Miguel Mejia ','lanh03@hotmail.com','1095814675','$2y$10$a6Nx/HRVXvb6Z3pSJQN2BeW.oSAwBUs3SeyqBEy.oT2zn.heDNEkW','sa123456',NULL,NULL,2,1,3157058839,1,'2019-04-29 23:11:58','2019-05-22 19:54:22','38_20190522195422.jpg',1),(39,'Maryerly Hernandez','maroch@gmail.com','10985678899','$2y$10$Yufl3qeGer.btH8kEK3Jz.CrpJ6SiSWYvwpfJez7TEi9ParuATlDG','sa123456',NULL,NULL,3,1,3150000000,2,'2019-05-17 21:20:08','2019-05-21 22:42:52','39_20190521224252.png',NULL),(40,'Usuario final de prueba','ufp1@bdi.com','1112233','$2y$10$7ts7uEqCBefXmz6OqfOh4OeciOG8X8GroxQH8eOVYfUlcroXEvBi.','sa123456',NULL,NULL,3,1,3150000000,2,'2019-05-21 20:50:57','2019-05-21 20:50:57','1_20190521205057.jpg',NULL),(41,'Usuario final de prueba 2','ufp2@bdi.com','999999999','$2y$10$BAKMOQ/hKSYUlKUjYwfKmuPNV6XeIg3.3y8ZOX0vsz/y55wizrC8e','sa123456',NULL,NULL,3,1,3150000000,2,'2019-05-21 20:52:07','2019-05-21 20:52:07','1_20190521205207.jpg',NULL);

/*Table structure for table `users_deparments` */

DROP TABLE IF EXISTS `users_deparments`;

CREATE TABLE `users_deparments` (
  `userDepartmentId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `departmentName` varchar(11) DEFAULT NULL COMMENT 'department name',
  `createdBy` int(11) DEFAULT NULL COMMENT 'who created this row',
  PRIMARY KEY (`userDepartmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `users_deparments` */

insert  into `users_deparments`(`userDepartmentId`,`departmentName`,`createdBy`) values (1,'Creador',1),(2,'Usuario',1);

/*Table structure for table `users_projects` */

DROP TABLE IF EXISTS `users_projects`;

CREATE TABLE `users_projects` (
  `usersProjectId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk increment',
  `userId` int(11) DEFAULT NULL COMMENT 'who''s this project owner',
  `projectName` varchar(100) DEFAULT NULL COMMENT 'project name',
  `created_at` datetime DEFAULT NULL COMMENT 'laravel created at',
  `updated_at` datetime DEFAULT NULL COMMENT 'laravel updated at',
  `deleted_at` datetime DEFAULT NULL COMMENT 'larave soft delete',
  PRIMARY KEY (`usersProjectId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `users_projects` */

insert  into `users_projects`(`usersProjectId`,`userId`,`projectName`,`created_at`,`updated_at`,`deleted_at`) values (1,39,'Prueba 1',NULL,NULL,NULL),(2,39,'Prueba 2',NULL,NULL,NULL),(3,41,'qwewqe','2019-05-21 21:38:24','2019-05-21 21:38:24',NULL),(4,41,'sonee ','2019-05-21 21:39:12','2019-05-21 21:39:12',NULL),(5,41,'Investigaciones','2019-05-21 21:40:29','2019-05-21 21:40:29',NULL),(6,40,'prueba','2019-05-22 21:59:07','2019-05-23 23:01:28','2019-05-23 23:01:28'),(7,40,'prueba 2','2019-05-23 21:48:29','2019-05-23 23:02:48','2019-05-23 23:02:48'),(8,40,'prueba 3','2019-05-23 21:54:53','2019-05-23 23:04:25','2019-05-23 23:04:25'),(9,40,'xxx','2019-05-23 23:03:16','2019-05-23 23:03:31','2019-05-23 23:03:31'),(10,40,'most wanted','2019-05-23 23:06:13','2019-05-23 23:06:21','2019-05-23 23:06:21'),(11,40,'nfsmw','2019-05-24 13:11:40','2019-05-24 13:11:40',NULL),(12,40,'concerts','2019-05-24 15:08:29','2019-05-24 15:08:29',NULL),(13,40,'games','2019-05-24 15:08:47','2019-05-24 15:08:47',NULL);

/*Table structure for table `users_states` */

DROP TABLE IF EXISTS `users_states`;

CREATE TABLE `users_states` (
  `userStateId` int(11) NOT NULL COMMENT 'pk autoincrement',
  `userState` varchar(100) DEFAULT NULL COMMENT 'name of the state',
  `createdBy` int(11) DEFAULT NULL COMMENT 'who created this',
  PRIMARY KEY (`userStateId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users_states` */

insert  into `users_states`(`userStateId`,`userState`,`createdBy`) values (0,'Activo',1),(2,'Inactivo',1);

/*Table structure for table `users_views` */

DROP TABLE IF EXISTS `users_views`;

CREATE TABLE `users_views` (
  `viewId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `viewName` varchar(100) DEFAULT NULL COMMENT 'view name',
  `viewIcon` varchar(100) DEFAULT NULL COMMENT 'view Icon',
  `viewRoute` varchar(100) DEFAULT NULL COMMENT 'spa vue route',
  `order` int(11) DEFAULT NULL COMMENT 'render order',
  PRIMARY KEY (`viewId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `users_views` */

insert  into `users_views`(`viewId`,`viewName`,`viewIcon`,`viewRoute`,`order`) values (1,'Actualizar mis datos','fas fa-list',NULL,1),(2,'Gestionar usuarios','fas fa-users','adminUsers',2),(3,'Listado de recursos','fas fa-sitemap','/',3),(4,'Subir nuevo recurso','fas fa-arrow-up','createPost',4),(5,'Informes','fas fa-list-alt','reports',5),(6,'Parametrizaci&oacute;n','fas fa-sort-numeric-up','settings',6),(7,'Cerrar sesion','fas fa-door-open',NULL,10),(8,'Mis proyectos','fas fa-folder-open','enduserprojects',7),(9,'Mis descargas','fas fa-download','enduserdownloads',8),(10,'Mis favoritos','fas fa-heart ','enduserfavorites',9);

/*Table structure for table `views_roles_permisions` */

DROP TABLE IF EXISTS `views_roles_permisions`;

CREATE TABLE `views_roles_permisions` (
  `viewsRolesPermisionsId` int(11) NOT NULL AUTO_INCREMENT,
  `userProfileId` int(11) DEFAULT NULL COMMENT 'the role',
  `viewProfileId` int(11) DEFAULT NULL COMMENT 'the view',
  PRIMARY KEY (`viewsRolesPermisionsId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `views_roles_permisions` */

insert  into `views_roles_permisions`(`viewsRolesPermisionsId`,`userProfileId`,`viewProfileId`) values (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,2,1),(8,2,3),(9,2,4),(10,2,7),(11,1,7),(12,3,1),(13,3,8),(14,3,9),(15,3,10),(16,3,7);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
