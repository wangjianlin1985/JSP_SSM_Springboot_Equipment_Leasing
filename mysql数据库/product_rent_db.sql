/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : product_rent_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-08 21:56:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '我想租苹果产品', '我同学都是用的苹果手机，我也要！', 'user1', '2018-03-27 12:50:00', '可以租赁的哈', '2018-03-27 12:50:05');
INSERT INTO `t_leaveword` VALUES ('2', '租赁数码产品贵吗', '我钱不多，买不起，租赁要多少钱一天呢?', 'user1', '2018-04-01 11:37:20', '一般就几十吧！', '2018-04-01 14:54:22');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '电子设备租赁网站成立了', '<p>需要租赁设备产品的朋友们，可以来这里看看！</p>', '2018-03-27 12:50:14');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL auto_increment COMMENT '商品id',
  `productClassObj` int(11) NOT NULL COMMENT '商品类别',
  `productName` varchar(50) NOT NULL COMMENT '商品名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '商品主图',
  `price` float NOT NULL COMMENT '租赁价格',
  `productCount` int(11) NOT NULL COMMENT '商品库存',
  `productDesc` varchar(5000) NOT NULL COMMENT '商品描述',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`productId`),
  KEY `productClassObj` (`productClassObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', '苹果iPhone 8 Plus双网通手机', 'upload/861a8755-37a6-4880-8774-c68ca8ce35c0.jpg', '68', '100', '<ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>证书编号：2017011606009777</p></li><li><p>证书状态：有效</p></li><li><p>产品名称：TD-LTE 数字移动电话机</p></li><li><p>3C规格型号：A1899(电源适配器可选：A1443 输出：5.0VDC 1A)</p></li><li><p>产品名称：Apple/苹果 iPhone 8 Plu...</p></li><li><p>Apple型号:&nbsp;iPhone 8 Plus</p></li><li><p>机身颜色:&nbsp;银色&nbsp;金色&nbsp;深空灰色</p></li><li><p>运行内存RAM:&nbsp;不详</p></li><li><p>存储容量:&nbsp;64GB</p></li><li><p>网络模式:&nbsp;不详</p></li></ul><p><br/></p>', '2018-03-27 12:48:51');
INSERT INTO `t_product` VALUES ('2', '2', 'Canon/佳能750D套机', 'upload/6d7dc9ca-c3de-4c0e-8872-332b6d14c2e2.jpg', '50', '98', '<ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>产品名称：Canon/佳能 EOS 750D 套机...</p></li><li><p>单反级别:&nbsp;入门级</p></li><li><p>屏幕尺寸:&nbsp;3英寸</p></li><li><p>像素:&nbsp;2426万</p></li><li><p>储存介质:&nbsp;SD卡</p></li><li><p>电池类型:&nbsp;锂电池</p></li><li><p>单反画幅:&nbsp;APS-C画幅</p></li><li><p>感光元件类型:&nbsp;CMOS</p></li><li><p>对焦点数:&nbsp;19点</p></li><li><p>是否支持外接闪光灯:&nbsp;支持</p></li><li><p>是否支持机身除尘:&nbsp;支持</p></li><li><p>是否支持机身马达:&nbsp;不支持</p></li><li><p>传感器尺寸:&nbsp;22.3mmx14.9mm</p></li><li><p>品牌:&nbsp;Canon/佳能</p></li><li><p>曝光模式:&nbsp;快门优先&nbsp;光圈优先&nbsp;手动曝光&nbsp;AE自动曝光</p></li><li><p>影像处理类型:&nbsp;DIGIC 6</p></li></ul><p><br/></p>', '2018-03-28 14:50:06');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `classId` int(11) NOT NULL auto_increment COMMENT '类别id',
  `className` varchar(40) NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500) NOT NULL COMMENT '类别描述',
  PRIMARY KEY  (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '手机相关', '手机相关');
INSERT INTO `t_productclass` VALUES ('2', '数码产品', '数码产品');

-- ----------------------------
-- Table structure for `t_rentorder`
-- ----------------------------
DROP TABLE IF EXISTS `t_rentorder`;
CREATE TABLE `t_rentorder` (
  `orderId` int(11) NOT NULL auto_increment COMMENT '订单id',
  `userObj` varchar(30) NOT NULL COMMENT '下单用户',
  `productObj` int(11) NOT NULL COMMENT '租赁商品',
  `rentCount` int(11) NOT NULL COMMENT '租赁数量',
  `rentDate` varchar(20) default NULL COMMENT '租赁开始日期',
  `days` int(11) NOT NULL COMMENT '租赁天数',
  `returnDate` varchar(20) default NULL COMMENT '回收日期',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `orderStateObj` varchar(20) NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20) default NULL COMMENT '下单时间',
  `receiveName` varchar(20) NOT NULL COMMENT '收货人',
  `telephone` varchar(20) NOT NULL COMMENT '收货电话',
  `address` varchar(80) NOT NULL COMMENT '收货地址',
  `wuliu` varchar(8000) default NULL COMMENT '订单物流',
  `orderMemo` varchar(800) default NULL COMMENT '订单备注',
  PRIMARY KEY  (`orderId`),
  KEY `userObj` (`userObj`),
  KEY `productObj` (`productObj`),
  CONSTRAINT `t_rentorder_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_rentorder_ibfk_2` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_rentorder
-- ----------------------------
INSERT INTO `t_rentorder` VALUES ('1', 'user1', '1', '2', '2018-03-13', '3', '2018-03-29', '408', '已回收', '2018-03-09 12:15:53', '王忠林', '13080808934', '四川成都红星路13号', '<p>2018-03-09 13:40:23 顺丰快递开始揽件</p><p>2018-03-09 17:52:50 顺丰航空件开始起飞，目的地成都</p>', '测试');
INSERT INTO `t_rentorder` VALUES ('2', 'user2', '1', '1', '2018-04-05', '2', '--', '136', '待处理', '2018-04-01 14:41:14', '张迪', '13598089834', '四川自贡营渠路12号', '<p>--</p>', '快点发货给我哦！');
INSERT INTO `t_rentorder` VALUES ('3', 'user1', '2', '2', '2018-04-04', '2', '2018-04-01', '200', '已发货', '2018-04-01 15:08:25', '李明阳', '13958098342', '四川德阳阳光路11号', '<p>2017-04-01 16:01:22 顺丰快递上门揽件</p><p>2017-04-01 17:00:52 快件准备发往四川德阳</p>', '测试租赁');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '王忠林', '男', '2018-03-06', 'upload/c7c33f80-bb96-4817-b2f8-95603bc81157.jpg', '13989508013', 'zhonglin@126.com', '四川成都红星路', '2018-03-27 12:48:28');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '李萌萌', '女', '2018-04-01', 'upload/339b4661-9d74-4e26-ac71-dd527b34b058.jpg', '13598080834', 'mengmeng@163.com', '四川南充滨江路', '2018-04-01 11:47:21');
