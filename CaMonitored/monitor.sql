/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.55-log : Database - monitor
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`monitor` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `monitor`;

/*Table structure for table `app` */

DROP TABLE IF EXISTS `app`;

CREATE TABLE `app` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `appName` varchar(20) DEFAULT NULL COMMENT '服务主键',
  `appIp` varchar(20) DEFAULT NULL COMMENT '服务Ip',
  `appstate` varchar(10) DEFAULT NULL COMMENT '服务状态',
  `appPort` int(11) DEFAULT NULL COMMENT '服务端口',
  `serverId` varchar(50) DEFAULT NULL COMMENT '服务的erukaid',
  `createTime` datetime DEFAULT NULL COMMENT '第一次连接的时间',
  `updateTime` datetime DEFAULT NULL COMMENT '最后一次修改状态的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

/*Table structure for table `app_user` */

DROP TABLE IF EXISTS `app_user`;

CREATE TABLE `app_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `appId` int(11) DEFAULT NULL COMMENT '服务id',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `emailTime` bigint(20) DEFAULT NULL COMMENT '邮件相隔多久发',
  `phoneTime` bigint(20) DEFAULT NULL COMMENT '短信多久发',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `notify_user` */

DROP TABLE IF EXISTS `notify_user`;

CREATE TABLE `notify_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `realName` varchar(10) DEFAULT NULL COMMENT '姓名',
  `phone` char(11) DEFAULT NULL COMMENT '电话',
  `email` varchar(20) DEFAULT NULL COMMENT '邮箱',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `state` tinyint(2) DEFAULT NULL COMMENT '禁用启用状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Table structure for table `sys_logs` */

DROP TABLE IF EXISTS `sys_logs`;

CREATE TABLE `sys_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `createdTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=890 DEFAULT CHARSET=utf8 COMMENT='系统日志';

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `certSn` varchar(64) DEFAULT NULL COMMENT '证书号',
  `realName` varchar(50) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(100) DEFAULT NULL COMMENT '手机号',
  `isUse` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常  默认值 ：1',
  `post` varchar(50) DEFAULT NULL COMMENT '权限信息',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `lastLoginTime` datetime DEFAULT NULL COMMENT '最后一次登录时间',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`realName`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='系统用户';

/*Table structure for table `tb_application` */

DROP TABLE IF EXISTS `tb_application`;

CREATE TABLE `tb_application` (
  `appId` int(11) NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `appName` varchar(30) DEFAULT NULL COMMENT '应用名称',
  `appState` tinyint(255) unsigned DEFAULT NULL COMMENT '应用状态 1 在线 2 离线',
  `serverIden` varchar(50) DEFAULT NULL COMMENT '服务ID',
  `onlineTime` datetime DEFAULT NULL COMMENT '上线时间',
  `offlineTime` datetime DEFAULT NULL COMMENT '下线时间',
  PRIMARY KEY (`appId`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
