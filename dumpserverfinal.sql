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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db50893_bancoimagenes` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db50893_bancoimagenes`;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `categories` */

insert  into `categories`(`categoryId`,`categoryName`,`created_at`,`updated_at`,`createdBy`,`state`,`deleted_at`) values (1,'Arquitectura','2019-05-31','2019-05-31',1,'Active',NULL),(2,'Negocios','2019-05-31','2019-05-31',1,'Active',NULL),(3,'Ciudad','2019-05-31','2019-05-31',1,'Active',NULL),(4,'Ambientalismo','2019-05-31','2019-05-31',1,'Active',NULL),(5,'Urbano','2019-05-31','2019-05-31',1,'Active',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

/*Data for the table `post_filters_saved` */

insert  into `post_filters_saved`(`postFilterSavedId`,`filterId`,`filterName`,`filterValue`,`postId`,`deleted_at`) values (1,'1','Orientacion',2,1,'2019-05-31 15:27:43'),(2,'2','Conpersonas',3,1,'2019-05-31 15:27:43'),(3,'2-1','Conpersonas-Genero',8,1,'2019-05-31 15:27:43'),(4,'2-2','Conpersonas-Edad',12,1,'2019-05-31 15:27:43'),(5,'2-3','Conpersonas-Cantidad',14,1,'2019-05-31 15:27:43'),(6,'3','Tamano',7,1,'2019-05-31 15:27:43'),(7,'1','Orientacion',2,1,'2019-05-31 16:00:54'),(8,'2','Conpersonas',3,1,'2019-05-31 16:00:54'),(9,'2-1','Conpersonas-Genero',8,1,'2019-05-31 16:00:54'),(10,'2-2','Conpersonas-Edad',12,1,'2019-05-31 16:00:54'),(11,'2-3','Conpersonas-Cantidad',14,1,'2019-05-31 16:00:54'),(12,'3','Tamano',7,1,'2019-05-31 16:00:54'),(13,'1','Orientacion',2,2,NULL),(14,'2','Conpersonas',3,2,NULL),(15,'2-1','Conpersonas-Genero',8,2,NULL),(16,'2-2','Conpersonas-Edad',10,2,NULL),(17,'2-3','Conpersonas-Cantidad',15,2,NULL),(18,'3','Tamano',6,2,NULL),(19,'1','Orientacion',2,3,'2019-05-31 16:01:12'),(20,'2','Conpersonas',3,3,'2019-05-31 16:01:12'),(21,'2-1','Conpersonas-Genero',8,3,'2019-05-31 16:01:12'),(22,'2-2','Conpersonas-Edad',12,3,'2019-05-31 16:01:12'),(23,'2-3','Conpersonas-Cantidad',14,3,'2019-05-31 16:01:12'),(24,'3','Tamano',5,3,'2019-05-31 16:01:12'),(25,'1','Orientacion',2,4,'2019-05-31 16:01:47'),(26,'2','Conpersonas',3,4,'2019-05-31 16:01:47'),(27,'2-1','Conpersonas-Genero',8,4,'2019-05-31 16:01:47'),(28,'2-2','Conpersonas-Edad',12,4,'2019-05-31 16:01:47'),(29,'2-3','Conpersonas-Cantidad',15,4,'2019-05-31 16:01:47'),(30,'3','Tamano',7,4,'2019-05-31 16:01:47'),(31,'1','Orientacion',1,5,'2019-05-31 16:03:18'),(32,'2','Conpersonas',4,5,'2019-05-31 16:03:18'),(33,'3','Tamano',7,5,'2019-05-31 16:03:18'),(34,'1','Orientacion',2,1,NULL),(35,'2','Conpersonas',3,1,NULL),(36,'2-1','Conpersonas-Genero',8,1,NULL),(37,'2-2','Conpersonas-Edad',12,1,NULL),(38,'2-3','Conpersonas-Cantidad',14,1,NULL),(39,'3','Tamano',7,1,NULL),(40,'1','Orientacion',2,3,NULL),(41,'2','Conpersonas',3,3,NULL),(42,'2-1','Conpersonas-Genero',8,3,NULL),(43,'2-2','Conpersonas-Edad',12,3,NULL),(44,'2-3','Conpersonas-Cantidad',14,3,NULL),(45,'3','Tamano',5,3,NULL),(46,'1','Orientacion',2,4,NULL),(47,'2','Conpersonas',3,4,NULL),(48,'2-1','Conpersonas-Genero',8,4,NULL),(49,'2-2','Conpersonas-Edad',12,4,NULL),(50,'2-3','Conpersonas-Cantidad',15,4,NULL),(51,'3','Tamano',7,4,NULL),(52,'1','Orientacion',1,5,NULL),(53,'2','Conpersonas',4,5,NULL),(54,'3','Tamano',7,5,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `posts` */

insert  into `posts`(`postId`,`postName`,`postDescription`,`userId`,`created_at`,`updated_at`,`miniImageUrl`,`postTypeId`,`postCategoryId`,`deleted_at`,`postState`,`awsFilename`,`fileNameImage`,`fileNameAWS`,`downloads`,`favorites`) values (1,'Hombre de negocios orgulloso','Empresario, emprendedor, hombre de negocios en una oficina de brazos cruzados',47,'2019-05-31 15:16:42','2019-05-31 16:22:46','PID_1_US_47_DATE_20190531152743.jpg',1,2,NULL,1,'PID_1_US_47_DATE_20190531152743.jpg','pilo-persona-mini-2.jpg','pilo-persona-2.jpg',2,0),(2,'Empresario exitoso','Empresario cruzado de brazos con fondo de oficina mostrando un nivel de orgullo moderado',47,'2019-05-31 15:45:28','2019-05-31 17:01:44','PID_2_US_47_DATE_20190531154529.jpg',1,2,NULL,1,'PID_2_US_47_DATE_20190531154529.jpg','pilo-persona-mini.jpg','pilo-persona.jpg',1,0),(3,'Cara de empresario feliz','Close up de la cara de un empresario feliz con gafas',47,'2019-05-31 15:49:25','2019-05-31 16:20:33','PID_3_US_47_DATE_20190531154925.jpg',1,2,NULL,1,'PID_3_US_47_DATE_20190531154925.jpg','pilo-persona-3-mini.jpg','pilo-persona-3.jpg',0,0),(4,'Familia comiendo juntos','Familia completa almorzando juntos felices y compartiendo tiempo de calidad',47,'2019-05-31 15:52:07','2019-05-31 16:20:35','PID_4_US_47_DATE_20190531155207.jpg',1,5,NULL,1,'PID_4_US_47_DATE_20190531155207.jpg','familia-1-mini.jpg','familia-1.jpg',2,0),(5,'Luces de Bogotá en la noche','Carros pasando por una calle en Bogotá en una noche clara',47,'2019-05-31 15:55:05','2019-05-31 16:20:35','PID_5_US_47_DATE_20190531155506.jpg',1,1,NULL,1,'PID_5_US_47_DATE_20190531155506.jpg','ciudad-1-mini.jpg','ciudad-1.jpg',0,0);

/*Table structure for table `posts_favorites` */

DROP TABLE IF EXISTS `posts_favorites`;

CREATE TABLE `posts_favorites` (
  `postFavoriteId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID pk',
  `userId` int(11) NOT NULL COMMENT 'who liked the post',
  `postId` int(11) NOT NULL COMMENT 'the post liked',
  `created_at` datetime DEFAULT NULL COMMENT 'when was liked',
  `updated_at` datetime DEFAULT NULL COMMENT 'this field wont be used but is required',
  PRIMARY KEY (`postFavoriteId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `posts_favorites` */

insert  into `posts_favorites`(`postFavoriteId`,`userId`,`postId`,`created_at`,`updated_at`) values (1,48,1,'2019-05-31 16:23:25','2019-05-31 16:23:25'),(2,48,5,'2019-05-31 16:43:09','2019-05-31 16:43:09'),(4,49,3,'2019-05-31 17:03:48','2019-05-31 17:03:48');

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
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=latin1;

/*Data for the table `posts_tags` */

insert  into `posts_tags`(`postTagsId`,`postId`,`tagId`,`deleted_at`) values (1,1,1,'2019-05-31 15:27:42'),(2,1,16,'2019-05-31 15:27:42'),(3,1,20,'2019-05-31 15:27:42'),(4,1,21,'2019-05-31 15:27:42'),(5,1,23,'2019-05-31 15:27:42'),(6,1,25,'2019-05-31 15:27:42'),(7,1,26,'2019-05-31 15:27:42'),(8,1,28,'2019-05-31 15:27:42'),(9,1,30,'2019-05-31 15:27:42'),(10,1,29,'2019-05-31 15:27:42'),(11,1,1,'2019-05-31 16:00:54'),(12,1,16,'2019-05-31 16:00:54'),(13,1,20,'2019-05-31 16:00:54'),(14,1,21,'2019-05-31 16:00:54'),(15,1,23,'2019-05-31 16:00:54'),(16,1,25,'2019-05-31 16:00:54'),(17,1,26,'2019-05-31 16:00:54'),(18,1,28,'2019-05-31 16:00:54'),(19,1,30,'2019-05-31 16:00:54'),(20,1,29,'2019-05-31 16:00:54'),(21,1,4,'2019-05-31 16:00:54'),(22,1,8,'2019-05-31 16:00:54'),(23,2,7,NULL),(24,2,9,NULL),(25,2,10,NULL),(26,2,14,NULL),(27,2,15,NULL),(28,2,16,NULL),(29,2,19,NULL),(30,2,18,NULL),(31,2,21,NULL),(32,2,25,NULL),(33,2,22,NULL),(34,2,26,NULL),(35,2,27,NULL),(36,3,1,'2019-05-31 16:01:11'),(37,3,4,'2019-05-31 16:01:11'),(38,3,5,'2019-05-31 16:01:11'),(39,3,6,'2019-05-31 16:01:11'),(40,3,7,'2019-05-31 16:01:11'),(41,3,8,'2019-05-31 16:01:11'),(42,3,9,'2019-05-31 16:01:11'),(43,3,10,'2019-05-31 16:01:11'),(44,3,11,'2019-05-31 16:01:11'),(45,3,12,'2019-05-31 16:01:11'),(46,3,13,'2019-05-31 16:01:11'),(47,3,14,'2019-05-31 16:01:11'),(48,3,15,'2019-05-31 16:01:11'),(49,3,16,'2019-05-31 16:01:11'),(50,3,17,'2019-05-31 16:01:11'),(51,3,18,'2019-05-31 16:01:11'),(52,3,19,'2019-05-31 16:01:11'),(53,3,20,'2019-05-31 16:01:11'),(54,3,21,'2019-05-31 16:01:11'),(55,3,22,'2019-05-31 16:01:11'),(56,3,23,'2019-05-31 16:01:11'),(57,3,24,'2019-05-31 16:01:11'),(58,3,25,'2019-05-31 16:01:11'),(59,3,26,'2019-05-31 16:01:11'),(60,3,27,'2019-05-31 16:01:11'),(61,3,28,'2019-05-31 16:01:11'),(62,3,29,'2019-05-31 16:01:11'),(63,3,30,'2019-05-31 16:01:11'),(64,4,1,'2019-05-31 16:01:47'),(65,4,4,'2019-05-31 16:01:47'),(66,4,5,'2019-05-31 16:01:47'),(67,4,6,'2019-05-31 16:01:47'),(68,4,7,'2019-05-31 16:01:47'),(69,4,10,'2019-05-31 16:01:47'),(70,4,11,'2019-05-31 16:01:47'),(71,4,12,'2019-05-31 16:01:47'),(72,4,13,'2019-05-31 16:01:47'),(73,4,14,'2019-05-31 16:01:47'),(74,4,15,'2019-05-31 16:01:47'),(75,4,16,'2019-05-31 16:01:47'),(76,4,18,'2019-05-31 16:01:47'),(77,4,19,'2019-05-31 16:01:47'),(78,4,21,'2019-05-31 16:01:47'),(79,4,23,'2019-05-31 16:01:47'),(80,4,24,'2019-05-31 16:01:47'),(81,4,26,'2019-05-31 16:01:47'),(82,4,27,'2019-05-31 16:01:47'),(83,4,29,'2019-05-31 16:01:47'),(84,4,30,'2019-05-31 16:01:47'),(85,5,1,'2019-05-31 16:03:18'),(86,5,4,'2019-05-31 16:03:18'),(87,5,5,'2019-05-31 16:03:18'),(88,5,7,'2019-05-31 16:03:18'),(89,5,8,'2019-05-31 16:03:18'),(90,5,9,'2019-05-31 16:03:18'),(91,5,10,'2019-05-31 16:03:18'),(92,5,11,'2019-05-31 16:03:18'),(93,5,12,'2019-05-31 16:03:18'),(94,5,13,'2019-05-31 16:03:18'),(95,5,14,'2019-05-31 16:03:18'),(96,5,15,'2019-05-31 16:03:18'),(97,5,17,'2019-05-31 16:03:18'),(98,5,18,'2019-05-31 16:03:18'),(99,5,19,'2019-05-31 16:03:18'),(100,5,20,'2019-05-31 16:03:18'),(101,5,21,'2019-05-31 16:03:18'),(102,5,22,'2019-05-31 16:03:18'),(103,5,23,'2019-05-31 16:03:18'),(104,5,25,'2019-05-31 16:03:18'),(105,5,26,'2019-05-31 16:03:18'),(106,5,28,'2019-05-31 16:03:18'),(107,5,29,'2019-05-31 16:03:18'),(108,5,30,'2019-05-31 16:03:18'),(109,1,1,NULL),(110,1,16,NULL),(111,1,20,NULL),(112,1,21,NULL),(113,1,23,NULL),(114,1,25,NULL),(115,1,26,NULL),(116,1,28,NULL),(117,1,30,NULL),(118,1,29,NULL),(119,1,4,NULL),(120,1,8,NULL),(121,3,1,NULL),(122,3,4,NULL),(123,3,5,NULL),(124,3,6,NULL),(125,3,7,NULL),(126,3,8,NULL),(127,3,9,NULL),(128,3,10,NULL),(129,3,11,NULL),(130,3,12,NULL),(131,3,13,NULL),(132,3,14,NULL),(133,3,15,NULL),(134,3,16,NULL),(135,3,17,NULL),(136,3,18,NULL),(137,3,19,NULL),(138,3,20,NULL),(139,3,21,NULL),(140,3,22,NULL),(141,3,23,NULL),(142,3,24,NULL),(143,3,25,NULL),(144,3,26,NULL),(145,3,27,NULL),(146,3,28,NULL),(147,3,29,NULL),(148,3,30,NULL),(149,4,1,NULL),(150,4,4,NULL),(151,4,5,NULL),(152,4,6,NULL),(153,4,7,NULL),(154,4,10,NULL),(155,4,11,NULL),(156,4,12,NULL),(157,4,13,NULL),(158,4,14,NULL),(159,4,15,NULL),(160,4,16,NULL),(161,4,18,NULL),(162,4,19,NULL),(163,4,21,NULL),(164,4,23,NULL),(165,4,24,NULL),(166,4,26,NULL),(167,4,27,NULL),(168,4,29,NULL),(169,4,30,NULL),(170,5,1,NULL),(171,5,4,NULL),(172,5,5,NULL),(173,5,7,NULL),(174,5,8,NULL),(175,5,9,NULL),(176,5,10,NULL),(177,5,11,NULL),(178,5,12,NULL),(179,5,13,NULL),(180,5,14,NULL),(181,5,15,NULL),(182,5,17,NULL),(183,5,18,NULL),(184,5,19,NULL),(185,5,20,NULL),(186,5,21,NULL),(187,5,22,NULL),(188,5,23,NULL),(189,5,25,NULL),(190,5,26,NULL),(191,5,28,NULL),(192,5,29,NULL),(193,5,30,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `posts_user_projects` */

insert  into `posts_user_projects`(`postsUserProjectsId`,`postId`,`projectId`,`created_at`,`updated_at`,`deleted_at`) values (1,4,5,'2019-05-31 16:08:16','2019-05-31 16:08:16',NULL),(2,4,5,'2019-05-31 16:11:21','2019-05-31 16:11:21',NULL),(3,1,6,'2019-05-31 16:21:35','2019-05-31 16:21:35',NULL),(4,1,6,'2019-05-31 16:22:46','2019-05-31 16:22:46',NULL),(5,2,7,'2019-05-31 17:01:44','2019-05-31 17:01:44',NULL);

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

insert  into `profiles`(`profileId`,`profileName`,`created_at`,`updated_at`,`updatedBy`) values (1,'Administrador','2019-04-10 11:03:39','2019-05-07 19:28:14',1),(2,'Fotografo','2019-04-24 18:01:58','2019-05-31 15:10:23',1),(3,'Usuario ','2019-04-24 18:02:24','2019-05-29 15:03:38',1);

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `tags_group_tags` */

insert  into `tags_group_tags`(`tagId`,`tagName`,`created_at`,`updated_at`,`deleted_at`,`createdBy`,`tagGroupId`) values (1,'Bucaramanga','2019-05-31 14:59:06','2019-05-31 14:59:06',NULL,1,1),(2,'Cali','2019-05-31 14:59:27','2019-05-31 15:07:05','2019-05-31 15:07:05',1,1),(3,'Nueva Etiqueta','2019-05-31 15:05:09','2019-05-31 15:05:45','2019-05-31 15:05:45',1,1),(4,'Barrancabermeja','2019-05-31 15:05:52','2019-05-31 15:05:52',NULL,1,1),(5,'San Gil','2019-05-31 15:05:59','2019-05-31 15:05:59',NULL,1,1),(6,'Buenaventura','2019-05-31 15:06:04','2019-05-31 15:06:04',NULL,1,1),(7,'Cartagena','2019-05-31 15:06:09','2019-05-31 15:06:09',NULL,1,1),(8,'Santa Marta','2019-05-31 15:06:15','2019-05-31 15:06:15',NULL,1,1),(9,'Barranquilla','2019-05-31 15:06:20','2019-05-31 15:06:20',NULL,1,1),(10,'Medellín','2019-05-31 15:06:30','2019-05-31 15:06:30',NULL,1,1),(11,'Bogotá DC','2019-05-31 15:06:38','2019-05-31 15:06:38',NULL,1,1),(12,'Zapatoca','2019-05-31 15:06:43','2019-05-31 15:06:43',NULL,1,1),(13,'Sincelejo','2019-05-31 15:06:49','2019-05-31 15:06:49',NULL,1,1),(14,'Cartago','2019-05-31 15:06:54','2019-05-31 15:06:54',NULL,1,1),(15,'Valledupar','2019-05-31 15:06:59','2019-05-31 15:06:59',NULL,1,1),(16,'Grupo Interés 1','2019-05-31 15:07:46','2019-05-31 15:07:46',NULL,1,2),(17,'Grupo Interés 2','2019-05-31 15:07:52','2019-05-31 15:07:52',NULL,1,2),(18,'Grupo Interés 3','2019-05-31 15:07:58','2019-05-31 15:07:58',NULL,1,2),(19,'Grupo Interés 4','2019-05-31 15:08:06','2019-05-31 15:08:06',NULL,1,2),(20,'Grupo Interés 5','2019-05-31 15:08:13','2019-05-31 15:08:13',NULL,1,2),(21,'Materialidad 1','2019-05-31 15:08:40','2019-05-31 15:08:40',NULL,1,3),(22,'Materialidad 2','2019-05-31 15:08:45','2019-05-31 15:08:45',NULL,1,3),(23,'Materialidad 3','2019-05-31 15:08:49','2019-05-31 15:08:49',NULL,1,3),(24,'Materialidad 4','2019-05-31 15:08:56','2019-05-31 15:08:56',NULL,1,3),(25,'Materialidad 5','2019-05-31 15:09:02','2019-05-31 15:09:02',NULL,1,3),(26,'Responsabilidad','2019-05-31 15:09:26','2019-05-31 15:09:26',NULL,1,4),(27,'Tolerancia','2019-05-31 15:09:31','2019-05-31 15:09:31',NULL,1,4),(28,'Honestidad','2019-05-31 15:09:36','2019-05-31 15:09:36',NULL,1,4),(29,'Compromiso','2019-05-31 15:09:40','2019-05-31 15:09:40',NULL,1,4),(30,'Sentido de Pertenencia','2019-05-31 15:09:52','2019-05-31 15:09:52',NULL,1,4);

/*Table structure for table `tags_groups` */

DROP TABLE IF EXISTS `tags_groups`;

CREATE TABLE `tags_groups` (
  `tagGroupId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `tagGroupName` varchar(100) DEFAULT NULL COMMENT 'group name',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was the changed',
  PRIMARY KEY (`tagGroupId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `tags_groups` */

insert  into `tags_groups`(`tagGroupId`,`tagGroupName`,`updated_at`) values (1,'Municipios','2019-05-28 23:11:55'),(2,'Grupos de Interés','2019-05-31 15:07:24'),(3,'Materialidad','2019-05-07 19:23:37'),(4,'Valores','2019-05-07 20:48:07');

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
  `phoneNumber` varchar(15) DEFAULT NULL COMMENT 'phone number',
  `userDepartmentId` int(11) DEFAULT NULL COMMENT 'what deparment has the user assigned',
  `created_at` datetime DEFAULT NULL COMMENT 'when was the user created',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was the user updated',
  `userAvatarFileName` varchar(100) DEFAULT NULL COMMENT 'avatar file',
  `requestPasswordChange` int(1) DEFAULT NULL COMMENT 'to verify is user has requested a passwordchange',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`userId`,`name`,`email`,`identificationNumber`,`password`,`passwordMask`,`registerdDate`,`birthDate`,`profileId`,`userState`,`phoneNumber`,`userDepartmentId`,`created_at`,`updated_at`,`userAvatarFileName`,`requestPasswordChange`) values (1,'Administrador ESSA','dios@dios.com','1234','$2y$10$J7L0d4yL1/f0KkJzah.dKONk6UD5gtzyNnKKsopHHjR.dVCHQgGHK','123456','2019-04-09 11:45:59','2019-04-09',1,1,'3157058839',1,'2019-04-26 09:40:11','2019-05-31 19:16:20','1_20190530143111.jpg',1),(47,'Gustavo Eduardo Pilonieta','pilo@somosvoodoo.com','13514724','$2y$10$vQcvzJdKrR7h2gmavPMXzOZmDgzmvyRCVclV5V3RQIkmFZtgB2bn6','123456',NULL,NULL,2,1,'3164167207',2,'2019-05-31 14:26:39','2019-05-31 14:41:17','47_20190531144117.jpg',NULL),(48,'Stella Castellanos villamizar','stella@somosvoodoo.com','63547449','$2y$10$V5SJj2NfJw4CaANay.rAwup2uY14tud8lLpzyq5tIm9HW08qMhnlm','stella123',NULL,NULL,3,1,'3012947192',2,'2019-05-31 15:52:48','2019-05-31 16:40:03','48_20190531164003.jpg',NULL),(49,'Jovana Diaz Venner','jova@somosvoodoo.com','111111111','$2y$10$y1IS2D3kxkw9PopMM/z4pux/5Kdwba//OWJpo1O48Cw2T3mWHePjS','jova123',NULL,NULL,3,2,'3164647498',2,'2019-05-31 15:54:19','2019-05-31 16:57:25','49_20190531160350.jpg',NULL),(50,'Joynner Robles','joynner@gmail.com','91516269','$2y$10$zgyYVL5mWKDLvRCsCbjgWeSpvI4VyDLNvvIQr2BAee.j50isWzs.S','joy123',NULL,NULL,3,0,'3008904629',2,'2019-05-31 15:56:34','2019-05-31 16:24:25','default.jpg',NULL),(51,'Pedro Perez','pedrito@gmail.com','123456789','$2y$10$foPd2j7R6ePdrSD8YF8AfO7gFUBB6xW/8NgaR8u6NkjADbTKuOdCa','aaaaaaa',NULL,NULL,3,0,'212121212',2,'2019-05-31 15:57:44','2019-05-31 15:58:22','1_20190531155822.jpg',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `users_projects` */

insert  into `users_projects`(`usersProjectId`,`userId`,`projectName`,`created_at`,`updated_at`,`deleted_at`) values (5,49,'','2019-05-31 16:07:48','2019-05-31 17:02:16','2019-05-31 17:02:16'),(6,48,'CAMPAÑAS','2019-05-31 16:21:27','2019-05-31 16:23:05','2019-05-31 16:23:05'),(7,49,'papá','2019-05-31 17:01:36','2019-05-31 17:01:36',NULL);

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
