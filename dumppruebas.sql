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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `categories` */

insert  into `categories`(`categoryId`,`categoryName`,`created_at`,`updated_at`,`createdBy`,`state`,`deleted_at`) values (1,'Paisajes','2019-05-29','2019-05-29',1,'Active',NULL),(2,'Grupos de interpès','2019-05-29','2019-05-29',1,'Active',NULL),(3,'Infraestructura','2019-05-29','2019-05-29',1,'Active',NULL),(4,'Eventos','2019-05-29','2019-05-29',1,'Active',NULL),(5,'Objetos','2019-05-29','2019-05-29',1,'Active',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;

/*Data for the table `post_filters_saved` */

insert  into `post_filters_saved`(`postFilterSavedId`,`filterId`,`filterName`,`filterValue`,`postId`,`deleted_at`) values (1,'1','Orientacion',1,1,NULL),(2,'2','Conpersonas',4,1,NULL),(3,'3','Tamano',6,1,NULL),(4,'1','Orientacion',2,2,NULL),(5,'2','Conpersonas',4,2,NULL),(6,'3','Tamano',5,2,NULL),(7,'1','Orientacion',2,3,NULL),(8,'2','Conpersonas',4,3,NULL),(9,'3','Tamano',5,3,NULL),(10,'1','Orientacion',2,4,NULL),(11,'2','Conpersonas',4,4,NULL),(12,'3','Tamano',5,4,NULL),(13,'1','Orientacion',2,5,NULL),(14,'2','Conpersonas',4,5,NULL),(15,'3','Tamano',5,5,NULL),(16,'1','Orientacion',2,6,NULL),(17,'2','Conpersonas',4,6,NULL),(18,'3','Tamano',5,6,NULL),(19,'1','Orientacion',2,7,NULL),(20,'2','Conpersonas',4,7,NULL),(21,'3','Tamano',5,7,NULL),(22,'1','Orientacion',2,8,NULL),(23,'2','Conpersonas',4,8,NULL),(24,'3','Tamano',5,8,NULL),(25,'1','Orientacion',2,9,NULL),(26,'2','Conpersonas',4,9,NULL),(27,'3','Tamano',5,9,NULL),(28,'1','Orientacion',2,10,NULL),(29,'2','Conpersonas',4,10,NULL),(30,'3','Tamano',5,10,NULL),(31,'1','Orientacion',2,11,NULL),(32,'2','Conpersonas',4,11,NULL),(33,'3','Tamano',5,11,NULL),(34,'1','Orientacion',2,12,NULL),(35,'2','Conpersonas',4,12,NULL),(36,'3','Tamano',5,12,NULL),(37,'1','Orientacion',2,13,NULL),(38,'2','Conpersonas',4,13,NULL),(39,'3','Tamano',5,13,NULL),(40,'1','Orientacion',2,14,NULL),(41,'2','Conpersonas',4,14,NULL),(42,'3','Tamano',5,14,NULL),(43,'1','Orientacion',2,15,NULL),(44,'2','Conpersonas',4,15,NULL),(45,'3','Tamano',7,15,NULL),(46,'1','Orientacion',2,16,NULL),(47,'2','Conpersonas',4,16,NULL),(48,'3','Tamano',7,16,NULL),(49,'1','Orientacion',2,17,NULL),(50,'2','Conpersonas',4,17,NULL),(51,'3','Tamano',7,17,NULL),(52,'1','Orientacion',2,18,NULL),(53,'2','Conpersonas',4,18,NULL),(54,'3','Tamano',7,18,NULL),(55,'1','Orientacion',2,19,NULL),(56,'2','Conpersonas',4,19,NULL),(57,'3','Tamano',7,19,NULL),(58,'1','Orientacion',2,20,NULL),(59,'2','Conpersonas',4,20,NULL),(60,'3','Tamano',7,20,NULL),(61,'1','Orientacion',2,21,NULL),(62,'2','Conpersonas',4,21,NULL),(63,'3','Tamano',7,21,NULL),(64,'1','Orientacion',2,22,NULL),(65,'2','Conpersonas',4,22,NULL),(66,'3','Tamano',7,22,NULL),(67,'1','Orientacion',2,23,NULL),(68,'2','Conpersonas',4,23,NULL),(69,'3','Tamano',7,23,NULL),(70,'1','Orientacion',2,24,NULL),(71,'2','Conpersonas',4,24,NULL),(72,'3','Tamano',7,24,NULL),(73,'1','Orientacion',1,25,NULL),(74,'2','Conpersonas',4,25,NULL),(75,'3','Tamano',6,25,NULL),(76,'1','Orientacion',1,26,NULL),(77,'2','Conpersonas',4,26,NULL),(78,'3','Tamano',6,26,NULL),(79,'1','Orientacion',1,27,NULL),(80,'2','Conpersonas',4,27,NULL),(81,'3','Tamano',6,27,NULL),(82,'1','Orientacion',1,28,NULL),(83,'2','Conpersonas',4,28,NULL),(84,'3','Tamano',6,28,NULL),(85,'1','Orientacion',1,29,NULL),(86,'2','Conpersonas',4,29,NULL),(87,'3','Tamano',6,29,NULL),(88,'1','Orientacion',1,30,NULL),(89,'2','Conpersonas',4,30,NULL),(90,'3','Tamano',6,30,NULL),(91,'1','Orientacion',2,31,NULL),(92,'2','Conpersonas',4,31,NULL),(93,'3','Tamano',6,31,NULL),(94,'1','Orientacion',2,32,NULL),(95,'2','Conpersonas',4,32,NULL),(96,'3','Tamano',6,32,NULL),(97,'1','Orientacion',2,33,NULL),(98,'2','Conpersonas',4,33,NULL),(99,'3','Tamano',6,33,NULL),(100,'1','Orientacion',2,34,NULL),(101,'2','Conpersonas',4,34,NULL),(102,'3','Tamano',7,34,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

/*Data for the table `posts` */

insert  into `posts`(`postId`,`postName`,`postDescription`,`userId`,`created_at`,`updated_at`,`miniImageUrl`,`postTypeId`,`postCategoryId`,`deleted_at`,`postState`,`awsFilename`,`fileNameImage`,`fileNameAWS`,`downloads`,`favorites`) values (32,'Prueba ','qweqwewqe',1,'2019-05-29 20:35:30','2019-05-29 21:32:42','PID_32_US_1_DATE_20190529203530.jpg',1,3,NULL,1,'PID_32_US_1_DATE_20190529203530.jpg','images.jpg','20mb.jpg',1,0),(33,'Lejania','recurso',43,'2019-05-29 21:04:45','2019-05-29 23:07:09','PID_33_US_43_DATE_20190529210445.jpg',1,2,NULL,1,'PID_33_US_43_DATE_20190529210445.jpg','Untitled.jpg','Untitled.jpg',3,0);

/*Table structure for table `posts_favorites` */

DROP TABLE IF EXISTS `posts_favorites`;

CREATE TABLE `posts_favorites` (
  `postFavoriteId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID pk',
  `userId` int(11) NOT NULL COMMENT 'who liked the post',
  `postId` int(11) NOT NULL COMMENT 'the post liked',
  `created_at` datetime DEFAULT NULL COMMENT 'when was liked',
  `updated_at` datetime DEFAULT NULL COMMENT 'this field wont be used but is required',
  PRIMARY KEY (`postFavoriteId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `posts_favorites` */

insert  into `posts_favorites`(`postFavoriteId`,`userId`,`postId`,`created_at`,`updated_at`) values (1,44,32,'2019-05-29 21:29:10','2019-05-29 21:29:10');

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

/*Data for the table `posts_tags` */

insert  into `posts_tags`(`postTagsId`,`postId`,`tagId`,`deleted_at`) values (1,1,2,NULL),(2,1,4,NULL),(3,1,6,NULL),(4,1,7,NULL),(5,1,8,NULL),(6,1,9,NULL),(7,1,11,NULL),(8,1,3,NULL),(9,1,12,NULL),(10,1,14,NULL),(11,1,15,NULL),(12,1,16,NULL),(13,1,17,NULL),(14,1,19,NULL),(15,1,20,NULL),(16,1,22,NULL),(17,1,23,NULL),(18,1,25,NULL),(19,1,26,NULL),(20,1,27,NULL),(21,1,29,NULL),(22,2,7,NULL),(23,3,7,NULL),(24,4,7,NULL),(25,5,7,NULL),(26,6,7,NULL),(27,7,7,NULL),(28,8,7,NULL),(29,9,7,NULL),(30,10,7,NULL),(31,11,7,NULL),(32,12,7,NULL),(33,13,7,NULL),(34,14,7,NULL),(35,15,7,NULL),(36,16,7,NULL),(37,17,7,NULL),(38,18,7,NULL),(39,19,7,NULL),(40,20,7,NULL),(41,21,7,NULL),(42,22,7,NULL),(43,23,7,NULL),(44,24,7,NULL),(45,25,7,NULL),(46,26,7,NULL),(47,27,7,NULL),(48,28,7,NULL),(49,29,7,NULL),(50,30,7,NULL),(51,31,7,NULL),(52,32,7,NULL),(53,33,7,NULL),(54,34,7,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `posts_user_projects` */

insert  into `posts_user_projects`(`postsUserProjectsId`,`postId`,`projectId`,`created_at`,`updated_at`,`deleted_at`) values (1,32,1,'2019-05-29 21:32:42','2019-05-29 21:32:42',NULL),(2,33,1,'2019-05-29 21:50:10','2019-05-29 21:50:10',NULL),(3,33,3,'2019-05-29 22:25:28','2019-05-29 22:25:28',NULL),(4,33,4,'2019-05-29 23:07:09','2019-05-29 23:07:09',NULL);

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

insert  into `profiles`(`profileId`,`profileName`,`created_at`,`updated_at`,`updatedBy`) values (1,'Administrador','2019-04-10 11:03:39','2019-05-07 19:28:14',1),(2,'Creador','2019-04-24 18:01:58','2019-05-29 15:03:38',1),(3,'Usuario ','2019-04-24 18:02:24','2019-05-29 15:03:38',1);

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `tags_group_tags` */

insert  into `tags_group_tags`(`tagId`,`tagName`,`created_at`,`updated_at`,`deleted_at`,`createdBy`,`tagGroupId`) values (1,'Pruebao','2019-05-28 23:12:05','2019-05-29 14:37:05','2019-05-29 14:37:05',1,1),(2,'Municipio 1','2019-05-29 14:37:22','2019-05-29 14:57:02',NULL,1,1),(3,'Clientes','2019-05-29 14:37:52','2019-05-29 14:58:29',NULL,1,2),(4,'Municipio 2','2019-05-29 14:56:49','2019-05-29 14:56:49',NULL,1,1),(5,'Municipio 3','2019-05-29 14:57:12','2019-05-29 14:57:12',NULL,1,1),(6,'Municipio 4','2019-05-29 14:57:17','2019-05-29 14:57:17',NULL,1,1),(7,'Municipio 5','2019-05-29 14:57:23','2019-05-29 14:57:23',NULL,1,1),(8,'Municipio 6','2019-05-29 14:57:36','2019-05-29 14:57:36',NULL,1,1),(9,'Municipio 7','2019-05-29 14:57:56','2019-05-29 14:57:56',NULL,1,1),(10,'Municipio 8','2019-05-29 14:58:03','2019-05-29 14:58:03',NULL,1,1),(11,'Municipio 9','2019-05-29 14:58:16','2019-05-29 14:58:16',NULL,1,1),(12,'Proveedores','2019-05-29 14:58:37','2019-05-29 14:58:37',NULL,1,2),(13,'Gente ESSA','2019-05-29 14:58:44','2019-05-29 14:58:44',NULL,1,2),(14,'Lìderes','2019-05-29 14:58:53','2019-05-29 14:58:53',NULL,1,2),(15,'Estado','2019-05-29 14:59:11','2019-05-29 14:59:11',NULL,1,2),(16,'Accionistas','2019-05-29 14:59:19','2019-05-29 14:59:19',NULL,1,2),(17,'Acceso al servicio','2019-05-29 14:59:38','2019-05-29 14:59:38',NULL,1,3),(18,'Clima laboral','2019-05-29 14:59:46','2019-05-29 14:59:46',NULL,1,3),(19,'Contrataciòn responsable','2019-05-29 14:59:57','2019-05-29 14:59:57',NULL,1,3),(20,'Poblaciòn sin servicio','2019-05-29 15:00:12','2019-05-29 15:00:12',NULL,1,3),(21,'Derechos humanos','2019-05-29 15:00:21','2019-05-29 15:00:21',NULL,1,3),(22,'Tarifas y precios','2019-05-29 15:00:39','2019-05-29 15:00:39',NULL,1,3),(23,'Transparencia','2019-05-29 15:00:50','2019-05-29 15:00:50',NULL,1,3),(24,'Desempeño ambiental','2019-05-29 15:01:04','2019-05-29 15:01:04',NULL,1,3),(25,'Biodiversidad','2019-05-29 15:01:15','2019-05-29 15:01:15',NULL,1,3),(26,'Cuidado del agua','2019-05-29 15:01:23','2019-05-29 15:01:23',NULL,1,3),(27,'Calidez','2019-05-29 15:01:39','2019-05-29 15:01:39',NULL,1,4),(28,'Responsabilidad','2019-05-29 15:01:48','2019-05-29 15:01:48',NULL,1,4),(29,'Transparencia','2019-05-29 15:02:36','2019-05-29 15:02:36',NULL,1,4);

/*Table structure for table `tags_groups` */

DROP TABLE IF EXISTS `tags_groups`;

CREATE TABLE `tags_groups` (
  `tagGroupId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk autoincrement',
  `tagGroupName` varchar(100) DEFAULT NULL COMMENT 'group name',
  `updated_at` datetime DEFAULT NULL COMMENT 'when was the changed',
  PRIMARY KEY (`tagGroupId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `tags_groups` */

insert  into `tags_groups`(`tagGroupId`,`tagGroupName`,`updated_at`) values (1,'Municipios','2019-05-28 23:11:55'),(2,'Grupos de interes','2019-05-07 17:03:07'),(3,'Materialidad','2019-05-07 19:23:37'),(4,'Valores','2019-05-07 20:48:07');

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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`userId`,`name`,`email`,`identificationNumber`,`password`,`passwordMask`,`registerdDate`,`birthDate`,`profileId`,`userState`,`phoneNumber`,`userDepartmentId`,`created_at`,`updated_at`,`userAvatarFileName`,`requestPasswordChange`) values (1,'dios','mmejiadeveloper@gmail.com','1234','$2y$10$eGP0hICJE1XZSDx320CLiO/VFfIfokkBstDgAmmDzei.4KJge2.5q','sa123456','2019-04-09 11:45:59','2019-04-09',1,1,3157058839,1,'2019-04-26 09:40:11','2019-05-29 21:02:48','1_20190529205938.jpg',1),(43,'lanh03@hotmail.com','lanh03@hotmail.com','1095814675','$2y$10$LtTDz/CZYjyg0T3ZiAN.c.TKY6iBV8GpGbf4tSnmuhhGRVy1B3GGy','sa123456',NULL,NULL,2,1,3157058831,1,'2019-05-28 22:44:39','2019-05-29 21:03:19','43_20190529210319.jpg',NULL),(44,'Mayerly Hernandez','marochhernandez@gmail.com','1095909090','$2y$10$oJAyoD4YwmWs0Gb1135nQuOm93VzmR3yTWxdAti1VPF3bwBrGY11G','sa123456',NULL,NULL,3,1,316800800,2,'2019-05-28 23:01:56','2019-05-28 23:02:06','1_20190528230206.png',NULL),(45,'ufp','ufp1@bdi.com','123','$2y$10$MBdhLLSh6yWtBgdO.K4y2.2/.P2xqsqYI6P6tkjcM0cFlg5k5nii6','sa123456',NULL,NULL,3,1,1111,2,'2019-05-29 23:06:40','2019-05-29 23:06:40','1_20190529230640.jpg',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `users_projects` */

insert  into `users_projects`(`usersProjectId`,`userId`,`projectName`,`created_at`,`updated_at`,`deleted_at`) values (1,44,'Proyecto de prueba','2019-05-29 21:32:38','2019-05-29 21:32:38',NULL),(3,44,'Proyecto de prueba 2 ','2019-05-29 22:25:25','2019-05-29 22:25:25',NULL),(4,45,'ufp proyecto 1','2019-05-29 23:07:07','2019-05-29 23:07:07',NULL);

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
