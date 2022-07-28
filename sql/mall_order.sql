/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : mall_order

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2022-07-20 10:08:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mall_order
-- ----------------------------
DROP TABLE IF EXISTS `mall_order`;
CREATE TABLE `mall_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_no` bigint DEFAULT NULL COMMENT '订单号',
  `user_id` int DEFAULT NULL COMMENT '用户id',
  `shipping_id` int DEFAULT NULL,
  `payment` decimal(20,2) DEFAULT NULL COMMENT '实际付款金额,单位是元,保留两位小数',
  `payment_type` int DEFAULT NULL COMMENT '支付类型,1-在线支付',
  `postage` int DEFAULT NULL COMMENT '运费,单位是元',
  `code_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '订单状态:0-已取消-10-未付款，20-已付款，40-已发货，50-交易成功，60-交易关闭',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `send_time` datetime DEFAULT NULL COMMENT '发货时间',
  `end_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `close_time` datetime DEFAULT NULL COMMENT '交易关闭时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no_index` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_order
-- ----------------------------
INSERT INTO `mall_order` VALUES ('1', '1657606899033', '1', '4', '13998.00', '1', '0', null, '10', null, null, null, null, null, null);
INSERT INTO `mall_order` VALUES ('21', '1658119795904', '1', '4', '10999.00', '1', '0', null, '10', null, null, null, null, null, null);
INSERT INTO `mall_order` VALUES ('22', '1658135501425', '1', '4', '6999.00', '1', '0', null, '10', null, null, null, null, null, null);
INSERT INTO `mall_order` VALUES ('23', '1658195979026', '1', '6', '12998.00', '1', '0', null, '10', null, null, null, null, null, null);
INSERT INTO `mall_order` VALUES ('24', '1658196116397', '4', '8', '10999.00', '1', '0', null, '10', null, null, null, null, null, null);
INSERT INTO `mall_order` VALUES ('25', '1658214109194', '1', '7', '4999.00', '1', '0', null, '10', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for mall_order_item
-- ----------------------------
DROP TABLE IF EXISTS `mall_order_item`;
CREATE TABLE `mall_order_item` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单子表id',
  `user_id` int DEFAULT NULL,
  `order_no` bigint DEFAULT NULL,
  `product_id` int DEFAULT NULL COMMENT '商品id',
  `product_name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `product_image` varchar(500) DEFAULT NULL COMMENT '商品图片地址',
  `current_unit_price` decimal(20,2) DEFAULT NULL COMMENT '生成订单时的商品单价，单位是元,保留两位小数',
  `quantity` int DEFAULT NULL COMMENT '商品数量',
  `total_price` decimal(20,2) DEFAULT NULL COMMENT '商品总价,单位是元,保留两位小数',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_no_index` (`order_no`) USING BTREE,
  KEY `order_no_user_id_index` (`user_id`,`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_order_item
-- ----------------------------
INSERT INTO `mall_order_item` VALUES ('1', '1', '1657606899033', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '2', '13998.00', null, null);
INSERT INTO `mall_order_item` VALUES ('2', '1', '1657613839219', '30', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', '/imgs/iphone13.jpg', '1999.00', '1', '1999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('3', '1', '1657614156007', '28', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '1999.00', '1', '1999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('4', '1', '1657614629553', '28', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '1999.00', '1', '1999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('5', '1', '1657614828825', '28', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '1999.00', '1', '1999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('6', '1', '1657614878128', '28', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '1999.00', '1', '1999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('7', '1', '1657618182666', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '3', '20997.00', null, null);
INSERT INTO `mall_order_item` VALUES ('8', '1', '1657618182666', '28', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '1999.00', '1', '1999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('9', '1', '1657706389841', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '1', '6999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('37', '1', '1658119414331', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '1', '6999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('38', '1', '1658119414331', '34', '三星 SAMSUNG Galaxy A53 5G手机 120Hz超顺滑全视屏 IP67级防尘防水 6400万超清四摄 8GB+128GB 晴天蓝', '/imgs/samsung.jpg', '5999.00', '1', '5999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('39', '1', '1658119414331', '35', 'vivo iQOO Neo5 SE 8GB+256GB 矿影蓝 骁龙870手机', '/imgs/vivo.jpg', '2999.00', '1', '2999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('40', '1', '1658119676454', '34', '三星 SAMSUNG Galaxy A53 5G手机 120Hz超顺滑全视屏 IP67级防尘防水 6400万超清四摄 8GB+128GB 晴天蓝', '/imgs/samsung.jpg', '5999.00', '1', '5999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('41', '1', '1658119795904', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '1', '6999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('42', '1', '1658119795904', '33', 'OPPO Find X5 Pro 12+256GB 白瓷 全新骁龙8 自研影像芯片 5000万双主摄 80W超级闪充 5G手机', '/imgs/oppo.jpg', '4000.00', '1', '4000.00', null, null);
INSERT INTO `mall_order_item` VALUES ('43', '1', '1658135501425', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '1', '6999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('44', '1', '1658195979026', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '1', '6999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('45', '1', '1658195979026', '34', '三星 SAMSUNG Galaxy A53 5G手机 120Hz超顺滑全视屏 IP67级防尘防水 6400万超清四摄 8GB+128GB 晴天蓝', '/imgs/samsung.jpg', '5999.00', '1', '5999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('46', '4', '1658196116397', '26', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '6999.00', '1', '6999.00', null, null);
INSERT INTO `mall_order_item` VALUES ('47', '4', '1658196116397', '33', 'OPPO Find X5 Pro 12+256GB 白瓷 全新骁龙8 自研影像芯片 5000万双主摄 80W超级闪充 5G手机', '/imgs/oppo.jpg', '4000.00', '1', '4000.00', null, null);
INSERT INTO `mall_order_item` VALUES ('48', '1', '1658214109194', '32', '小米12S Pro 骁龙8+处理器 徕卡光学镜头 2K超视感屏 120Hz高刷 120W秒充 12GB+256GB 黑色 5G手机', '/imgs/xiaomi.jpg', '3000.00', '1', '3000.00', null, null);
INSERT INTO `mall_order_item` VALUES ('49', '1', '1658214109194', '28', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '1999.00', '1', '1999.00', null, null);
