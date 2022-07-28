/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : mall_product

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2022-07-20 10:09:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mall_category
-- ----------------------------
DROP TABLE IF EXISTS `mall_category`;
CREATE TABLE `mall_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '类别Id',
  `parent_id` int DEFAULT NULL COMMENT '父类别id当id=0时说明是根节点,一级类别',
  `name` varchar(50) DEFAULT NULL COMMENT '类别名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '类别状态1-正常,2-已废弃',
  `sort_order` int DEFAULT NULL COMMENT '排序编号,同类展示顺序,数值相等则自然排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100031 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_category
-- ----------------------------
INSERT INTO `mall_category` VALUES ('100001', '0', '家用电器', '1', null, '2000-03-25 16:46:00', '2000-03-25 16:46:00');
INSERT INTO `mall_category` VALUES ('100002', '0', '数码3C', '1', null, '2000-03-25 16:46:21', '2000-03-25 16:46:21');
INSERT INTO `mall_category` VALUES ('100003', '0', '服装箱包', '1', null, '2000-03-25 16:49:53', '2000-03-25 16:49:53');
INSERT INTO `mall_category` VALUES ('100004', '0', '食品生鲜', '1', null, '2000-03-25 16:50:19', '2000-03-25 16:50:19');
INSERT INTO `mall_category` VALUES ('100005', '0', '酒水饮料', '1', null, '2000-03-25 16:50:29', '2000-03-25 16:50:29');
INSERT INTO `mall_category` VALUES ('100006', '100001', '冰箱', '1', null, '2000-03-25 16:52:15', '2000-03-25 16:52:15');
INSERT INTO `mall_category` VALUES ('100007', '100001', '电视', '1', null, '2000-03-25 16:52:26', '2000-03-25 16:52:26');
INSERT INTO `mall_category` VALUES ('100008', '100001', '洗衣机', '1', null, '2000-03-25 16:52:39', '2000-03-25 16:52:39');
INSERT INTO `mall_category` VALUES ('100009', '100001', '空调', '1', null, '2000-03-25 16:52:45', '2000-03-25 16:52:45');
INSERT INTO `mall_category` VALUES ('100010', '100001', '电热水器', '1', null, '2000-03-25 16:52:54', '2000-03-25 16:52:54');
INSERT INTO `mall_category` VALUES ('100011', '100002', '电脑', '1', null, '2000-03-25 16:53:18', '2000-03-25 16:53:18');
INSERT INTO `mall_category` VALUES ('100012', '100002', '手机', '1', null, '2000-03-25 16:53:27', '2000-03-25 16:53:27');
INSERT INTO `mall_category` VALUES ('100013', '100002', '平板电脑', '1', null, '2000-03-25 16:53:35', '2000-03-25 16:53:35');
INSERT INTO `mall_category` VALUES ('100014', '100002', '数码相机', '1', null, '2000-03-25 16:53:56', '2000-03-25 16:53:56');
INSERT INTO `mall_category` VALUES ('100015', '100002', '3C配件', '1', null, '2000-03-25 16:54:07', '2000-03-25 16:54:07');
INSERT INTO `mall_category` VALUES ('100016', '100003', '女装', '1', null, '2000-03-25 16:54:44', '2000-03-25 16:54:44');
INSERT INTO `mall_category` VALUES ('100017', '100003', '帽子', '1', null, '2000-03-25 16:54:51', '2000-03-25 16:54:51');
INSERT INTO `mall_category` VALUES ('100018', '100003', '旅行箱', '1', null, '2000-03-25 16:55:02', '2000-03-25 16:55:02');
INSERT INTO `mall_category` VALUES ('100019', '100003', '手提包', '1', null, '2000-03-25 16:55:09', '2000-03-25 16:55:09');
INSERT INTO `mall_category` VALUES ('100020', '100003', '保暖内衣', '1', null, '2000-03-25 16:55:18', '2000-03-25 16:55:18');
INSERT INTO `mall_category` VALUES ('100021', '100004', '零食', '1', null, '2000-03-25 16:55:30', '2000-03-25 16:55:30');
INSERT INTO `mall_category` VALUES ('100022', '100004', '生鲜', '1', null, '2000-03-25 16:55:37', '2000-03-25 16:55:37');
INSERT INTO `mall_category` VALUES ('100023', '100004', '半成品菜', '1', null, '2000-03-25 16:55:47', '2000-03-25 16:55:47');
INSERT INTO `mall_category` VALUES ('100024', '100004', '速冻食品', '1', null, '2000-03-25 16:55:56', '2000-03-25 16:55:56');
INSERT INTO `mall_category` VALUES ('100025', '100004', '进口食品', '1', null, '2000-03-25 16:56:06', '2000-03-25 16:56:06');
INSERT INTO `mall_category` VALUES ('100026', '100005', '白酒', '1', null, '2000-03-25 16:56:22', '2000-03-25 16:56:22');
INSERT INTO `mall_category` VALUES ('100027', '100005', '红酒', '1', null, '2000-03-25 16:56:30', '2000-03-25 16:56:30');
INSERT INTO `mall_category` VALUES ('100028', '100005', '饮料', '1', null, '2000-03-25 16:56:37', '2000-03-25 16:56:37');
INSERT INTO `mall_category` VALUES ('100029', '100005', '调制鸡尾酒', '1', null, '2000-03-25 16:56:45', '2000-03-25 16:56:45');
INSERT INTO `mall_category` VALUES ('100030', '100005', '进口洋酒', '1', null, '2000-03-25 16:57:05', '2000-03-25 16:57:05');

-- ----------------------------
-- Table structure for mall_product
-- ----------------------------
DROP TABLE IF EXISTS `mall_product`;
CREATE TABLE `mall_product` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `category_id` int NOT NULL COMMENT '分类id,对应mall_category表的主键',
  `name` varchar(100) NOT NULL COMMENT '商品名称',
  `subtitle` varchar(200) DEFAULT NULL COMMENT '商品副标题',
  `main_image` varchar(500) DEFAULT NULL COMMENT '产品主图,url相对地址',
  `sub_images` text COMMENT '图片地址,json格式,扩展用',
  `detail` text COMMENT '商品详情',
  `price` decimal(20,2) NOT NULL COMMENT '价格,单位-元保留两位小数',
  `stock` int NOT NULL COMMENT '库存数量',
  `status` int DEFAULT '1' COMMENT '商品状态.1-在售 2-下架 3-删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_product
-- ----------------------------
INSERT INTO `mall_product` VALUES ('26', '100012', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'iPhone 7，现更以红色呈现。', 'http://img.springboot.cn/241997c4-9e62-4824-b7f0-7425c3c28917.jpeg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '6999.00', '76', '1', null, '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('27', '100006', 'Midea/美的 BCD-535WKZM(E)冰箱双开门对开门风冷无霜智能电家用', '送品牌烤箱，五一大促', 'http://img.springboot.cn/ac3e571d-13ce-4fad-89e8-c92c2eccf536.jpeg', 'ac3e571d-13ce-4fad-89e8-c92c2eccf536.jpeg,4bb02f1c-62d5-48cc-b358-97b05af5740d.jpeg,36bdb49c-72ae-4185-9297-78829b54b566.jpeg', '<p><img alt=\"miaoshu.jpg\" src=\"http://img.springboot.cn/9c5c74e6-6615-4aa0-b1fc-c17a1eff6027.jpg\" width=\"790\" height=\"444\"><br></p><p><img alt=\"miaoshu2.jpg\" src=\"http://img.springboot.cn/31dc1a94-f354-48b8-a170-1a1a6de8751b.jpg\" width=\"790\" height=\"1441\"><img alt=\"miaoshu3.jpg\" src=\"http://img.springboot.cn/7862594b-3063-4b52-b7d4-cea980c604e0.jpg\" width=\"790\" height=\"1442\"><img alt=\"miaoshu4.jpg\" src=\"http://img.springboot.cn/9a650563-dc85-44d6-b174-d6960cfb1d6a.jpg\" width=\"790\" height=\"1441\"><br></p>', '3299.00', '99', '1', '2000-04-13 18:51:54', '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('28', '100012', '4+64G送手环/Huawei/华为 nova 手机P9/P10plus青春123', 'NOVA青春版1999元', 'http://img.springboot.cn/0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg', '0093f5d3-bdb4-4fb0-bec5-5465dfd26363.jpeg,13da2172-4445-4eb5-a13f-c5d4ede8458c.jpeg,58d5d4b7-58d4-4948-81b6-2bae4f79bf02.jpeg', '<p><img alt=\"11TB2fKK3cl0kpuFjSsziXXa.oVXa_!!1777180618.jpg\" src=\"http://img.springboot.cn/5c2d1c6d-9e09-48ce-bbdb-e833b42ff664.jpg\" width=\"790\" height=\"966\"><img alt=\"22TB2YP3AkEhnpuFjSZFpXXcpuXXa_!!1777180618.jpg\" src=\"http://img.springboot.cn/9a10b877-818f-4a27-b6f7-62887f3fb39d.jpg\" width=\"790\" height=\"1344\"><img alt=\"33TB2Yyshk.hnpuFjSZFpXXcpuXXa_!!1777180618.jpg\" src=\"http://img.springboot.cn/7d7fbd69-a3cb-4efe-8765-423bf8276e3e.jpg\" width=\"790\" height=\"700\"><img alt=\"TB2diyziB8kpuFjSspeXXc7IpXa_!!1777180618.jpg\" src=\"http://img.springboot.cn/1d7160d2-9dba-422f-b2a0-e92847ba6ce9.jpg\" width=\"790\" height=\"393\"><br></p>', '1999.00', '94', '1', '2000-04-13 18:57:18', '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('29', '100008', 'Haier/海尔HJ100-1HU1 10公斤滚筒洗衣机全自动带烘干家用大容量 洗烘一体', '门店机型 德邦送货', 'http://img.springboot.cn/173335a4-5dce-4afd-9f18-a10623724c4e.jpeg', '173335a4-5dce-4afd-9f18-a10623724c4e.jpeg,42b1b8bc-27c7-4ee1-80ab-753d216a1d49.jpeg,2f1b3de1-1eb1-4c18-8ca2-518934931bec.jpeg', '<p><img alt=\"1TB2WLZrcIaK.eBjSspjXXXL.XXa_!!2114960396.jpg\" src=\"http://img.springboot.cn/ffcce953-81bd-463c-acd1-d690b263d6df.jpg\" width=\"790\" height=\"920\"><img alt=\"2TB2zhOFbZCO.eBjSZFzXXaRiVXa_!!2114960396.jpg\" src=\"http://img.springboot.cn/58a7bd25-c3e7-4248-9dba-158ef2a90e70.jpg\" width=\"790\" height=\"1052\"><img alt=\"3TB27mCtb7WM.eBjSZFhXXbdWpXa_!!2114960396.jpg\" src=\"http://img.springboot.cn/2edbe9b3-28be-4a8b-a9c3-82e40703f22f.jpg\" width=\"790\" height=\"820\"><br></p>', '4299.00', '100', '1', '2000-04-13 19:07:47', '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('30', '100012', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机11', 'iPhone 7，现更以红色呈现。', '/imgs/iphone13.jpg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '1999.00', '95', '1', null, '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('31', '100012', '华为p50e 新品手机 曜金黑 【官方标配】8G+256G送 品牌66W充电套装', '华为（HUAWEI）华为P50E', '/imgs/huawei.jpg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '2000.00', '96', '1', null, '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('32', '100012', '小米12S Pro 骁龙8+处理器 徕卡光学镜头 2K超视感屏 120Hz高刷 120W秒充 12GB+256GB 黑色 5G手机', '小米12S Pro', '/imgs/xiaomi.jpg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '3000.00', '95', '1', null, '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('33', '100012', 'OPPO Find X5 Pro 12+256GB 白瓷 全新骁龙8 自研影像芯片 5000万双主摄 80W超级闪充 5G手机', 'OPPOFind X5 Pro 5G', '/imgs/oppo.jpg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '4000.00', '94', '1', null, '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('34', '100012', '三星 SAMSUNG Galaxy A53 5G手机 120Hz超顺滑全视屏 IP67级防尘防水 6400万超清四摄 8GB+128GB 晴天蓝', '三星Galaxy A53 5G', '/imgs/samsung.jpg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '5999.00', '84', '1', null, '2000-04-13 21:45:41');
INSERT INTO `mall_product` VALUES ('35', '100012', 'vivo iQOO Neo5 SE 8GB+256GB 矿影蓝 骁龙870手机', 'vivoiQOO Neo5 SE', '/imgs/vivo.jpg', '241997c4-9e62-4824-b7f0-7425c3c28917.jpeg,b6c56eb0-1748-49a9-98dc-bcc4b9788a54.jpeg,92f17532-1527-4563-aa1d-ed01baa0f7b2.jpeg,3adbe4f7-e374-4533-aa79-cc4a98c529bf.jpeg', '<p><img alt=\"10000.jpg\" src=\"http://img.springboot.cn/00bce8d4-e9af-4c8d-b205-e6c75c7e252b.jpg\" width=\"790\" height=\"553\"><br></p><p><img alt=\"20000.jpg\" src=\"http://img.springboot.cn/4a70b4b4-01ee-46af-9468-31e67d0995b8.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"30000.jpg\" src=\"http://img.springboot.cn/0570e033-12d7-49b2-88f3-7a5d84157223.jpg\" width=\"790\" height=\"365\"><br></p><p><img alt=\"40000.jpg\" src=\"http://img.springboot.cn/50515c02-3255-44b9-a829-9e141a28c08a.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"50000.jpg\" src=\"http://img.springboot.cn/c138fc56-5843-4287-a029-91cf3732d034.jpg\" width=\"790\" height=\"525\"><br></p><p><img alt=\"60000.jpg\" src=\"http://img.springboot.cn/c92d1f8a-9827-453f-9d37-b10a3287e894.jpg\" width=\"790\" height=\"525\"><br></p><p><br></p><p><img alt=\"TB24p51hgFkpuFjSspnXXb4qFXa-1776456424.jpg\" src=\"http://img.springboot.cn/bb1511fc-3483-471f-80e5-c7c81fa5e1dd.jpg\" width=\"790\" height=\"375\"><br></p><p><br></p><p><img alt=\"shouhou.jpg\" src=\"http://img.springboot.cn/698e6fbe-97ea-478b-8170-008ad24030f7.jpg\" width=\"750\" height=\"150\"><br></p><p><img alt=\"999.jpg\" src=\"http://img.springboot.cn/ee276fe6-5d79-45aa-8393-ba1d210f9c89.jpg\" width=\"790\" height=\"351\"><br></p>', '2999.00', '86', '1', null, '2000-04-13 21:45:41');
