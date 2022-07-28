/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : mall_user

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2022-07-20 10:10:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mall_user
-- ----------------------------
DROP TABLE IF EXISTS `mall_user`;
CREATE TABLE `mall_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户表id',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '用户密码，MD5加密',
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `question` varchar(100) DEFAULT NULL COMMENT '找回密码问题',
  `answer` varchar(100) DEFAULT NULL COMMENT '找回密码答案',
  `role` int NOT NULL COMMENT '角色0-管理员,1-普通用户',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_unique` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_user
-- ----------------------------
INSERT INTO `mall_user` VALUES ('1', 'admin', '21232F297A57A5A743894A0E4A801FC3', 'admin@qq.com', null, null, null, '0', '2000-08-06 15:12:00', '2000-08-06 15:12:00');
INSERT INTO `mall_user` VALUES ('2', 'jamesx', 'e10adc3949ba59abbe56e057f20f883e', '379249906@QQ.COM', null, null, null, '1', '2022-07-11 17:58:06', '2022-07-11 17:58:06');
INSERT INTO `mall_user` VALUES ('3', '111', 'bcbe3365e6ac95ea2c0343a2395834dd', '222@qq.com', null, null, null, '1', '2022-07-14 11:36:27', '2022-07-14 11:36:27');
INSERT INTO `mall_user` VALUES ('4', 'xuepeng', 'e10adc3949ba59abbe56e057f20f883e', 'xuepeng@cihnasofti.com', null, null, null, '1', '2022-07-19 10:00:38', '2022-07-19 10:00:38');
INSERT INTO `mall_user` VALUES ('5', 'august', '61a590f1b9b5548efbae70fd7bcf45b3', 'aaa@qq.com', null, null, null, '1', '2022-07-19 15:02:20', '2022-07-19 15:02:20');
