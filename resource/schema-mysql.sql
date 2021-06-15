/*
Navicat MySQL Data Transfer

Source Server         : 本地Mysql
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : dams

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2016-01-27 13:24:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for da_categories_ident
-- ----------------------------
DROP TABLE IF EXISTS `da_categories_ident`;
CREATE TABLE `da_categories_ident` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identity` varchar(20) DEFAULT NULL COMMENT '类目标识',
  `name` varchar(20) DEFAULT NULL COMMENT '类目名称',
  `p_id` int(11) DEFAULT NULL COMMENT '上级类目ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_categories_range
-- ----------------------------
DROP TABLE IF EXISTS `da_categories_range`;
CREATE TABLE `da_categories_range` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fir_identity` varchar(32) DEFAULT NULL,
  `fir_categories` varchar(32) DEFAULT NULL COMMENT '一级类目',
  `sec_identity` varchar(32) DEFAULT NULL,
  `sec_categories` varchar(32) DEFAULT NULL COMMENT '二级类目',
  `range_da` varchar(1024) DEFAULT NULL COMMENT '归  档  范  围',
  `remark` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_doc_no
-- ----------------------------
DROP TABLE IF EXISTS `da_doc_no`;
CREATE TABLE `da_doc_no` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seq` int(11) DEFAULT NULL COMMENT '顺序',
  `item` varchar(32) DEFAULT NULL COMMENT '分类项目',
  `length` int(11) DEFAULT NULL COMMENT '长度',
  `split` varchar(20) DEFAULT NULL COMMENT '分隔符',
  `cate_identity` varchar(32) DEFAULT NULL COMMENT '所属标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_doc_profile
-- ----------------------------
DROP TABLE IF EXISTS `da_doc_profile`;
CREATE TABLE `da_doc_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_no` varchar(64) DEFAULT NULL COMMENT '档号',
  `ref_no` varchar(64) DEFAULT NULL COMMENT '文号',
  `author` varchar(24) DEFAULT NULL COMMENT '责任人',
  `name` varchar(64) DEFAULT NULL COMMENT '题名',
  `type` varchar(5) DEFAULT NULL COMMENT '档案类型',
  `dispatch_date` date DEFAULT NULL COMMENT '发文日期',
  `pages` int(10) DEFAULT NULL COMMENT '页数',
  `retent_period` varchar(10) DEFAULT NULL COMMENT '保管期限',
  `place` varchar(64) DEFAULT NULL COMMENT '位置',
  `arch_date` varchar(10) DEFAULT NULL COMMENT '归档年份',
  `remark` varchar(32) DEFAULT NULL COMMENT '备注',
  `file_path` varchar(64) DEFAULT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2667 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for df_field
-- ----------------------------
DROP TABLE IF EXISTS `df_field`;
CREATE TABLE `df_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `plugins` varchar(200) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `flow` varchar(10) DEFAULT NULL,
  `tableName` varchar(50) DEFAULT NULL,
  `formId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for df_form
-- ----------------------------
DROP TABLE IF EXISTS `df_form`;
CREATE TABLE `df_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `displayName` varchar(200) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `createTime` varchar(50) DEFAULT NULL,
  `originalHtml` text,
  `parseHtml` text,
  `fieldNum` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_approval
-- ----------------------------
DROP TABLE IF EXISTS `flow_approval`;
CREATE TABLE `flow_approval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) NOT NULL,
  `operateTime` varchar(50) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `orderId` varchar(50) DEFAULT NULL,
  `taskId` varchar(50) DEFAULT NULL,
  `taskName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_borrow
-- ----------------------------
DROP TABLE IF EXISTS `flow_borrow`;
CREATE TABLE `flow_borrow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `operateTime` varchar(50) DEFAULT NULL,
  `repaymentDate` varchar(50) DEFAULT NULL,
  `orderId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary`;
CREATE TABLE `sys_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cnName` varchar(200) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_dictitem
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictitem`;
CREATE TABLE `sys_dictitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `orderby` int(11) DEFAULT NULL,
  `dictionary` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_DICTITEM_DICTIONARY` (`dictionary`),
  CONSTRAINT `sys_dictitem_ibfk_1` FOREIGN KEY (`dictionary`) REFERENCES `sys_dictionary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mesname` varchar(30) DEFAULT NULL,
  `mescontent` varchar(1024) DEFAULT NULL,
  `from_user` varchar(60) DEFAULT NULL,
  `to_user` varchar(60) DEFAULT NULL,
  `cc_user` varchar(60) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` varchar(255) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `fullname` varchar(200) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `type` varchar(200) DEFAULT NULL,
  `parent_org` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ORG_PARENT` (`parent_org`)
) ENGINE=InnoDB AUTO_INCREMENT=200205 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_res`;
CREATE TABLE `sys_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单，资源',
  `pid` int(11) DEFAULT NULL,
  `name` varchar(111) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `desc` varchar(111) DEFAULT NULL,
  `icon` varchar(255) DEFAULT 'am-icon-file',
  `seq` int(11) DEFAULT '1',
  `type` int(1) DEFAULT '2' COMMENT '1 功能 2 权限',
  `last_updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `seq` int(11) DEFAULT '1',
  `icon` varchar(55) DEFAULT 'status_online',
  `status` int(11) DEFAULT '0',
  `create_date` datetime DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_role_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_res`;
CREATE TABLE `sys_role_res` (
  `role_id` int(32) DEFAULT NULL,
  `res_id` int(64) DEFAULT NULL,
  KEY `fk_role_res1` (`role_id`),
  KEY `fk_role_res2` (`res_id`),
  CONSTRAINT `fk_role_res1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `fk_role_res2` FOREIGN KEY (`res_id`) REFERENCES `sys_res` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(55) DEFAULT NULL,
  `username` varchar(55) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT 'images/guest.jpg',
  `email` varchar(222) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `org` int(11) DEFAULT NULL COMMENT '组织代码',
  `salt` varchar(55) DEFAULT NULL,
  `account_status` int(1) DEFAULT '1' COMMENT '#1 不在线 2.封号状态 ',
  `last_updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_org` (`org`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `fk_user_role1` (`user_id`),
  KEY `fk_user_role2` (`role_id`),
  CONSTRAINT `fk_user_role1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_user_role2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表关系表，管理csh_login表';

-- ----------------------------
-- Table structure for wf_cc_order
-- ----------------------------
DROP TABLE IF EXISTS `wf_cc_order`;
CREATE TABLE `wf_cc_order` (
  `order_Id` varchar(32) DEFAULT NULL COMMENT '流程实例ID',
  `actor_Id` varchar(50) DEFAULT NULL COMMENT '参与者ID',
  `creator` varchar(50) DEFAULT NULL COMMENT '发起人',
  `create_Time` varchar(50) DEFAULT NULL COMMENT '抄送时间',
  `finish_Time` varchar(50) DEFAULT NULL COMMENT '完成时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  KEY `IDX_CCORDER_ORDER` (`order_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抄送实例表';

-- ----------------------------
-- Table structure for wf_hist_order
-- ----------------------------
DROP TABLE IF EXISTS `wf_hist_order`;
CREATE TABLE `wf_hist_order` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `process_Id` varchar(32) NOT NULL COMMENT '流程定义ID',
  `order_State` tinyint(1) NOT NULL COMMENT '状态',
  `creator` varchar(50) DEFAULT NULL COMMENT '发起人',
  `create_Time` varchar(50) NOT NULL COMMENT '发起时间',
  `end_Time` varchar(50) DEFAULT NULL COMMENT '完成时间',
  `expire_Time` varchar(50) DEFAULT NULL COMMENT '期望完成时间',
  `priority` tinyint(1) DEFAULT NULL COMMENT '优先级',
  `parent_Id` varchar(32) DEFAULT NULL COMMENT '父流程ID',
  `order_No` varchar(50) DEFAULT NULL COMMENT '流程实例编号',
  `variable` varchar(2000) DEFAULT NULL COMMENT '附属变量json存储',
  PRIMARY KEY (`id`),
  KEY `IDX_HIST_ORDER_PROCESSID` (`process_Id`),
  KEY `IDX_HIST_ORDER_NO` (`order_No`),
  KEY `FK_HIST_ORDER_PARENTID` (`parent_Id`),
  CONSTRAINT `FK_HIST_ORDER_PARENTID` FOREIGN KEY (`parent_Id`) REFERENCES `wf_hist_order` (`id`),
  CONSTRAINT `FK_HIST_ORDER_PROCESSID` FOREIGN KEY (`process_Id`) REFERENCES `wf_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史流程实例表';

-- ----------------------------
-- Table structure for wf_hist_task
-- ----------------------------
DROP TABLE IF EXISTS `wf_hist_task`;
CREATE TABLE `wf_hist_task` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `order_Id` varchar(32) NOT NULL COMMENT '流程实例ID',
  `task_Name` varchar(100) NOT NULL COMMENT '任务名称',
  `display_Name` varchar(200) NOT NULL COMMENT '任务显示名称',
  `task_Type` tinyint(1) NOT NULL COMMENT '任务类型',
  `perform_Type` tinyint(1) DEFAULT NULL COMMENT '参与类型',
  `task_State` tinyint(1) NOT NULL COMMENT '任务状态',
  `operator` varchar(50) DEFAULT NULL COMMENT '任务处理人',
  `create_Time` varchar(50) NOT NULL COMMENT '任务创建时间',
  `finish_Time` varchar(50) DEFAULT NULL COMMENT '任务完成时间',
  `expire_Time` varchar(50) DEFAULT NULL COMMENT '任务期望完成时间',
  `action_Url` varchar(200) DEFAULT NULL COMMENT '任务处理url',
  `parent_Task_Id` varchar(32) DEFAULT NULL COMMENT '父任务ID',
  `variable` varchar(2000) DEFAULT NULL COMMENT '附属变量json存储',
  PRIMARY KEY (`id`),
  KEY `IDX_HIST_TASK_ORDER` (`order_Id`),
  KEY `IDX_HIST_TASK_TASKNAME` (`task_Name`),
  KEY `IDX_HIST_TASK_PARENTTASK` (`parent_Task_Id`),
  CONSTRAINT `FK_HIST_TASK_ORDERID` FOREIGN KEY (`order_Id`) REFERENCES `wf_hist_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史任务表';

-- ----------------------------
-- Table structure for wf_hist_task_actor
-- ----------------------------
DROP TABLE IF EXISTS `wf_hist_task_actor`;
CREATE TABLE `wf_hist_task_actor` (
  `task_Id` varchar(32) NOT NULL COMMENT '任务ID',
  `actor_Id` varchar(50) NOT NULL COMMENT '参与者ID',
  KEY `IDX_HIST_TASKACTOR_TASK` (`task_Id`),
  CONSTRAINT `FK_HIST_TASKACTOR` FOREIGN KEY (`task_Id`) REFERENCES `wf_hist_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史任务参与者表';

-- ----------------------------
-- Table structure for wf_order
-- ----------------------------
DROP TABLE IF EXISTS `wf_order`;
CREATE TABLE `wf_order` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `parent_Id` varchar(32) DEFAULT NULL COMMENT '父流程ID',
  `process_Id` varchar(32) NOT NULL COMMENT '流程定义ID',
  `creator` varchar(50) DEFAULT NULL COMMENT '发起人',
  `create_Time` varchar(50) NOT NULL COMMENT '发起时间',
  `expire_Time` varchar(50) DEFAULT NULL COMMENT '期望完成时间',
  `last_Update_Time` varchar(50) DEFAULT NULL COMMENT '上次更新时间',
  `last_Updator` varchar(50) DEFAULT NULL COMMENT '上次更新人',
  `priority` tinyint(1) DEFAULT NULL COMMENT '优先级',
  `parent_Node_Name` varchar(100) DEFAULT NULL COMMENT '父流程依赖的节点名称',
  `order_No` varchar(50) DEFAULT NULL COMMENT '流程实例编号',
  `variable` varchar(2000) DEFAULT NULL COMMENT '附属变量json存储',
  `version` int(3) DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`),
  KEY `IDX_ORDER_PROCESSID` (`process_Id`),
  KEY `IDX_ORDER_NO` (`order_No`),
  KEY `FK_ORDER_PARENTID` (`parent_Id`),
  CONSTRAINT `FK_ORDER_PARENTID` FOREIGN KEY (`parent_Id`) REFERENCES `wf_order` (`id`),
  CONSTRAINT `FK_ORDER_PROCESSID` FOREIGN KEY (`process_Id`) REFERENCES `wf_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程实例表';

-- ----------------------------
-- Table structure for wf_process
-- ----------------------------
DROP TABLE IF EXISTS `wf_process`;
CREATE TABLE `wf_process` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `name` varchar(100) DEFAULT NULL COMMENT '流程名称',
  `display_Name` varchar(200) DEFAULT NULL COMMENT '流程显示名称',
  `type` varchar(100) DEFAULT NULL COMMENT '流程类型',
  `instance_Url` varchar(200) DEFAULT NULL COMMENT '实例url',
  `state` tinyint(1) DEFAULT NULL COMMENT '流程是否可用',
  `content` longblob COMMENT '流程模型定义',
  `version` int(2) DEFAULT NULL COMMENT '版本',
  `create_Time` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `IDX_PROCESS_NAME` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程定义表';

-- ----------------------------
-- Table structure for wf_surrogate
-- ----------------------------
DROP TABLE IF EXISTS `wf_surrogate`;
CREATE TABLE `wf_surrogate` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `process_Name` varchar(100) DEFAULT NULL COMMENT '流程名称',
  `operator` varchar(50) DEFAULT NULL COMMENT '授权人',
  `surrogate` varchar(50) DEFAULT NULL COMMENT '代理人',
  `odate` varchar(64) DEFAULT NULL COMMENT '操作时间',
  `sdate` varchar(64) DEFAULT NULL COMMENT '开始时间',
  `edate` varchar(64) DEFAULT NULL COMMENT '结束时间',
  `state` tinyint(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `IDX_SURROGATE_OPERATOR` (`operator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托代理表';

-- ----------------------------
-- Table structure for wf_task
-- ----------------------------
DROP TABLE IF EXISTS `wf_task`;
CREATE TABLE `wf_task` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `order_Id` varchar(32) NOT NULL COMMENT '流程实例ID',
  `task_Name` varchar(100) NOT NULL COMMENT '任务名称',
  `display_Name` varchar(200) NOT NULL COMMENT '任务显示名称',
  `task_Type` tinyint(1) NOT NULL COMMENT '任务类型',
  `perform_Type` tinyint(1) DEFAULT NULL COMMENT '参与类型',
  `operator` varchar(50) DEFAULT NULL COMMENT '任务处理人',
  `create_Time` varchar(50) DEFAULT NULL COMMENT '任务创建时间',
  `finish_Time` varchar(50) DEFAULT NULL COMMENT '任务完成时间',
  `expire_Time` varchar(50) DEFAULT NULL COMMENT '任务期望完成时间',
  `action_Url` varchar(200) DEFAULT NULL COMMENT '任务处理的url',
  `parent_Task_Id` varchar(32) DEFAULT NULL COMMENT '父任务ID',
  `variable` varchar(2000) DEFAULT NULL COMMENT '附属变量json存储',
  `version` tinyint(1) DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`),
  KEY `IDX_TASK_ORDER` (`order_Id`),
  KEY `IDX_TASK_TASKNAME` (`task_Name`),
  KEY `IDX_TASK_PARENTTASK` (`parent_Task_Id`),
  CONSTRAINT `FK_TASK_ORDERID` FOREIGN KEY (`order_Id`) REFERENCES `wf_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务表';

-- ----------------------------
-- Table structure for wf_task_actor
-- ----------------------------
DROP TABLE IF EXISTS `wf_task_actor`;
CREATE TABLE `wf_task_actor` (
  `task_Id` varchar(32) NOT NULL COMMENT '任务ID',
  `actor_Id` varchar(50) NOT NULL COMMENT '参与者ID',
  KEY `IDX_TASKACTOR_TASK` (`task_Id`),
  CONSTRAINT `FK_TASK_ACTOR_TASKID` FOREIGN KEY (`task_Id`) REFERENCES `wf_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参与者表';
