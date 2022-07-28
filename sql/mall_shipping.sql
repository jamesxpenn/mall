/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : mall_shipping

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2022-07-20 10:09:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mall_shipping
-- ----------------------------
DROP TABLE IF EXISTS `mall_shipping`;
CREATE TABLE `mall_shipping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL COMMENT '用户id',
  `receiver_name` varchar(20) DEFAULT NULL COMMENT '收货姓名',
  `receiver_phone` varchar(20) DEFAULT NULL COMMENT '收货固定电话',
  `receiver_mobile` varchar(20) DEFAULT NULL COMMENT '收货移动电话',
  `receiver_province` varchar(20) DEFAULT NULL COMMENT '省份',
  `receiver_city` varchar(20) DEFAULT NULL COMMENT '城市',
  `receiver_district` varchar(20) DEFAULT NULL COMMENT '区/县',
  `receiver_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `receiver_zip` varchar(6) DEFAULT NULL COMMENT '邮编',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_shipping
-- ----------------------------
INSERT INTO `mall_shipping` VALUES ('4', '1', '薛鹏', '010', '18688888888', '陕西省', '西安市', '莲湖区', '自强西路', '100000', '2000-01-22 14:26:25', '2000-01-22 14:26:25');
INSERT INTO `mall_shipping` VALUES ('6', '1', '张三', '0', '13313122233', '湖北省', '湖北省', '湖北省', '11111', '710013', null, null);
INSERT INTO `mall_shipping` VALUES ('7', '1', 'aaa', '0', '13488231234', '湖南省', '湖北省', '湖北省', '1111', '710014', null, null);
INSERT INTO `mall_shipping` VALUES ('8', '4', 'xuepeng', '0', '13488236316', '湖北省', '湖北省', '湖北省', 'xuepengxuepeng', '710014', null, null);
