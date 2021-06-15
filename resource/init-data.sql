/*
Navicat MySQL Data Transfer

Source Server         : 本地Mysql
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : dams

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2016-01-27 14:54:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Records of da_categories_ident
-- ----------------------------
INSERT INTO `da_categories_ident` VALUES ('1', 'DQ', '党群', '15');
INSERT INTO `da_categories_ident` VALUES ('2', 'XZ', '行政', '15');
INSERT INTO `da_categories_ident` VALUES ('3', 'JY', '经营', '15');
INSERT INTO `da_categories_ident` VALUES ('4', 'KJ', '会计', '15');
INSERT INTO `da_categories_ident` VALUES ('5', 'GC', '工程', '15');
INSERT INTO `da_categories_ident` VALUES ('6', 'TS', '特殊载体', '15');
INSERT INTO `da_categories_ident` VALUES ('7', '01', '凭证', '4');
INSERT INTO `da_categories_ident` VALUES ('8', '02', '账簿', '4');
INSERT INTO `da_categories_ident` VALUES ('9', '03', '报表', '4');
INSERT INTO `da_categories_ident` VALUES ('10', '04', '其它', '4');
INSERT INTO `da_categories_ident` VALUES ('11', '01', '照片', '6');
INSERT INTO `da_categories_ident` VALUES ('12', '02', '磁盘', '6');
INSERT INTO `da_categories_ident` VALUES ('13', '03', '权证', '6');
INSERT INTO `da_categories_ident` VALUES ('14', '04', '实物', '6');
INSERT INTO `da_categories_ident` VALUES ('15', 'JDJT', 'XX集团', '0');

-- ----------------------------
-- Records of da_doc_no
-- ----------------------------
INSERT INTO `da_doc_no` VALUES ('1', '1', 'CZ', '4', '-', '1');
INSERT INTO `da_doc_no` VALUES ('2', '2', 'DL', '8', '*', '1');
INSERT INTO `da_doc_no` VALUES ('3', '3', 'GD', '4', '@', '1');
INSERT INTO `da_doc_no` VALUES ('4', '4', 'LX', '4', '-', '1');

-- ----------------------------
-- Records of sys_dictionary
-- ----------------------------
INSERT INTO `sys_dictionary` VALUES ('1', '是否', '', 'yesNo');
INSERT INTO `sys_dictionary` VALUES ('2', '性别', '', 'sex');
INSERT INTO `sys_dictionary` VALUES ('3', '表单类型', '', 'formType');
INSERT INTO `sys_dictionary` VALUES ('4', '字段类型', '', 'fieldType');
INSERT INTO `sys_dictionary` VALUES ('5', '默认字段值', '', 'fieldDefault');
-- ----------------------------
-- Records of sys_dictitem
-- ----------------------------
INSERT INTO `sys_dictitem` VALUES ('11', '1', '', '是', '1', '1');
INSERT INTO `sys_dictitem` VALUES ('12', '2', '', '否', '2', '1');
INSERT INTO `sys_dictitem` VALUES ('21', '1', '', '男', '1', '2');
INSERT INTO `sys_dictitem` VALUES ('22', '2', '', '女', '2', '2');
INSERT INTO `sys_dictitem` VALUES ('31', '1', '', '公文管理', '1', '3');
INSERT INTO `sys_dictitem` VALUES ('32', '2', '', '案例管理', '2', '3');
INSERT INTO `sys_dictitem` VALUES ('41', '1', '', '字符', '1', '4');
INSERT INTO `sys_dictitem` VALUES ('42', '2', '', '整数', '2', '4');
INSERT INTO `sys_dictitem` VALUES ('43', '3', '', '小数', '3', '4');
INSERT INTO `sys_dictitem` VALUES ('44', '4', '', '日期', '4', '4');
INSERT INTO `sys_dictitem` VALUES ('45', '5', '', '文本', '5', '4');
INSERT INTO `sys_dictitem` VALUES ('51', '1', '', '当前用户Id', '1', '5');
INSERT INTO `sys_dictitem` VALUES ('52', '2', '', '当前用户名称', '2', '5');
INSERT INTO `sys_dictitem` VALUES ('53', '3', '', '当前用户部门Id', '3', '5');
INSERT INTO `sys_dictitem` VALUES ('54', '4', '', '当前用户部门名称', '4', '5');
INSERT INTO `sys_dictitem` VALUES ('55', '5', '', '当前日期yyyy-MM-dd', '5', '5');
INSERT INTO `sys_dictitem` VALUES ('56', '6', '', '当前时间yyyy-MM-dd HH:mm:ss', '6', '5');
INSERT INTO `sys_dictitem` VALUES ('57', '7', '', '当前年月yyyy-MM', '7', '5');
-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('200', '0', null, null, 'XXX有限公司', '1', '0');
INSERT INTO `sys_org` VALUES ('2000', '0', null, null, '行政部', '2', '200');
INSERT INTO `sys_org` VALUES ('2001', '0', null, null, '市场部', '2', '200');
INSERT INTO `sys_org` VALUES ('2002', '0', null, null, '研发部', '2', '200');
INSERT INTO `sys_org` VALUES ('2003', '0', null, null, '客服部', '2', '200');
INSERT INTO `sys_org` VALUES ('200200', '0', null, null, '测试组', '3', '2002');
INSERT INTO `sys_org` VALUES ('200201', '0', null, null, '质量组', '3', '2002');
INSERT INTO `sys_org` VALUES ('200202', '0', null, null, '研发组', '3', '2002');
INSERT INTO `sys_org` VALUES ('200203', '0', null, null, '需求组', '3', '2002');
INSERT INTO `sys_org` VALUES ('200204', '0', null, null, 'UI组', '3', '2002');
-- ----------------------------
-- Records of sys_res
-- ----------------------------
INSERT INTO `sys_res` VALUES ('1', '0', '系统管理', '#', null, '/styles/images/leftico03.png', '2', '1', null);
INSERT INTO `sys_res` VALUES ('2', '1', '资源管理', '/ms/shiro/res', null, 'am-icon-coffee', '2', '1', null);
INSERT INTO `sys_res` VALUES ('3', '1', '角色管理', '/ms/shiro/role', null, 'fa-cogs', '3', '1', null);
INSERT INTO `sys_res` VALUES ('4', '1', '用户管理', '/ms/shiro/user', null, 'fa-users', '4', '1', null);
INSERT INTO `sys_res` VALUES ('9', '4', '用户删除', '/ms/shiro/user/delete', null, 'icon-fire', '1', '2', null);
INSERT INTO `sys_res` VALUES ('12', '4', '搜索用户', '/ms/shiro/user/serach', null, 'icon-files-o', '1', '2', null);
INSERT INTO `sys_res` VALUES ('18', '2', '资源删除', '/ms/shiro/res/delete', null, 'icon-bookmark-o', '11', '2', null);
INSERT INTO `sys_res` VALUES ('19', '2', '资源保存', '/ms/shiro/res/save', null, 'icon-bookmark', '11', '2', null);
INSERT INTO `sys_res` VALUES ('28', '3', '角色删除', '/ms/shiro/role/delete', null, 'icon-bookmark-o', '11', '2', null);
INSERT INTO `sys_res` VALUES ('29', '3', '角色保存', '/ms/shiro/role/save', null, 'icon-bookmark', '11', '2', null);
INSERT INTO `sys_res` VALUES ('63', '4', '冻结用户', '/ms/shiro/user/freeze', null, 'icon-bookmark-o', '11', '2', null);
INSERT INTO `sys_res` VALUES ('160', '0', '示例页面', '#', null, '/styles/images/leftico01.png', '99', '1', null);
INSERT INTO `sys_res` VALUES ('161', '160', '首页', '/ms', null, '', '1', '1', null);
INSERT INTO `sys_res` VALUES ('163', '160', '数据列表', '/ms/com/right', null, '', '3', '1', null);
INSERT INTO `sys_res` VALUES ('164', '160', '图片数据表', '/ms/com/imgtable', null, 'am-icon-file', '4', '1', null);
INSERT INTO `sys_res` VALUES ('165', '160', '添加编辑', '/ms/com/form', null, 'am-icon-file', '5', '1', null);
INSERT INTO `sys_res` VALUES ('166', '160', '图片列表', '/ms/com/imglist', null, 'am-icon-file', '6', '1', null);
INSERT INTO `sys_res` VALUES ('167', '160', '自定义', '/ms/com/imglist1', null, 'am-icon-file', '7', '1', null);
INSERT INTO `sys_res` VALUES ('168', '160', '常用工具', '/ms/com/tools', null, 'am-icon-file', '8', '1', null);
INSERT INTO `sys_res` VALUES ('169', '160', '信息管理', '/ms/com/filelist', null, 'am-icon-file', '9', '1', null);
INSERT INTO `sys_res` VALUES ('170', '160', 'Tab页', '/ms/com/tab', null, 'am-icon-file', '10', '1', null);
INSERT INTO `sys_res` VALUES ('171', '160', '404页面', '/ms/com/error', null, 'am-icon-file', '11', '1', null);
INSERT INTO `sys_res` VALUES ('172', '0', '档案管理', '#', null, '/styles/images/leftico02.png', '1', '1', null);
INSERT INTO `sys_res` VALUES ('173', '172', '文书管理', '/ms/doc', null, '', '1', '1', null);
INSERT INTO `sys_res` VALUES ('174', '172', '实体分类', '/ms/docCate', null, 'am-icon-file', '2', '1', null);
INSERT INTO `sys_res` VALUES ('175', '172', '档号格式设置', '/ms/docNo', null, 'am-icon-file', '3', '1', null);
INSERT INTO `sys_res` VALUES ('177', '1', '组织机构管理', '/ms/shiro/org', null, 'am-icon-file', '6', '1', null);
INSERT INTO `sys_res` VALUES ('179', '172', '类目含盖材料范围', '/ms/docCateRange', null, 'am-icon-file', '5', '1', null);
INSERT INTO `sys_res` VALUES ('181', '160', 'bui测试页面', '/ms/com/buiOpenGridTest', null, 'am-icon-file', '1', '1', null);
INSERT INTO `sys_res` VALUES ('182', '160', '首页测试', '/ms/com/workSpace', '', 'am-icon-file', '3', '1', '2016-01-25 09:31:18');
-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'admin', '系统级管理员', '1', 'status_online', '0', '2015-05-05 14:24:26', '2016-01-20');
INSERT INTO `sys_role` VALUES ('2', 'user', '系统用户', '2', 'status_online', '0', null, '2016-01-20');
INSERT INTO `sys_role` VALUES ('3', 'role1', 'aws', '3', null, '0', '2016-01-21 13:06:40', null);
-- ----------------------------
-- Records of sys_role_res
-- ----------------------------
INSERT INTO `sys_role_res` VALUES ('1', '1');
INSERT INTO `sys_role_res` VALUES ('1', '2');
INSERT INTO `sys_role_res` VALUES ('1', '18');
INSERT INTO `sys_role_res` VALUES ('1', '19');
INSERT INTO `sys_role_res` VALUES ('1', '3');
INSERT INTO `sys_role_res` VALUES ('1', '28');
INSERT INTO `sys_role_res` VALUES ('1', '29');
INSERT INTO `sys_role_res` VALUES ('1', '4');
INSERT INTO `sys_role_res` VALUES ('1', '9');
INSERT INTO `sys_role_res` VALUES ('1', '12');
INSERT INTO `sys_role_res` VALUES ('1', '63');
INSERT INTO `sys_role_res` VALUES ('1', '177');
INSERT INTO `sys_role_res` VALUES ('1', '178');
INSERT INTO `sys_role_res` VALUES ('1', '160');
INSERT INTO `sys_role_res` VALUES ('1', '161');
INSERT INTO `sys_role_res` VALUES ('1', '163');
INSERT INTO `sys_role_res` VALUES ('1', '164');
INSERT INTO `sys_role_res` VALUES ('1', '165');
INSERT INTO `sys_role_res` VALUES ('1', '166');
INSERT INTO `sys_role_res` VALUES ('1', '167');
INSERT INTO `sys_role_res` VALUES ('1', '168');
INSERT INTO `sys_role_res` VALUES ('1', '169');
INSERT INTO `sys_role_res` VALUES ('1', '170');
INSERT INTO `sys_role_res` VALUES ('1', '171');
INSERT INTO `sys_role_res` VALUES ('1', '181');
INSERT INTO `sys_role_res` VALUES ('1', '182');
INSERT INTO `sys_role_res` VALUES ('1', '172');
INSERT INTO `sys_role_res` VALUES ('1', '173');
INSERT INTO `sys_role_res` VALUES ('1', '174');
INSERT INTO `sys_role_res` VALUES ('1', '175');
INSERT INTO `sys_role_res` VALUES ('1', '176');
INSERT INTO `sys_role_res` VALUES ('1', '179');
INSERT INTO `sys_role_res` VALUES ('1', '183');
INSERT INTO `sys_role_res` VALUES ('3', '172');
INSERT INTO `sys_role_res` VALUES ('3', '173');
INSERT INTO `sys_role_res` VALUES ('3', '174');
INSERT INTO `sys_role_res` VALUES ('3', '175');
INSERT INTO `sys_role_res` VALUES ('3', '176');
INSERT INTO `sys_role_res` VALUES ('3', '179');
INSERT INTO `sys_role_res` VALUES ('3', '183');
INSERT INTO `sys_role_res` VALUES ('2', '172');
INSERT INTO `sys_role_res` VALUES ('2', '173');
INSERT INTO `sys_role_res` VALUES ('2', '174');
INSERT INTO `sys_role_res` VALUES ('2', '175');
INSERT INTO `sys_role_res` VALUES ('2', '176');
INSERT INTO `sys_role_res` VALUES ('2', '179');
INSERT INTO `sys_role_res` VALUES ('2', '183');
INSERT INTO `sys_role_res` VALUES ('2', '184');
INSERT INTO `sys_role_res` VALUES ('3', '184');
INSERT INTO `sys_role_res` VALUES ('3', '185');
INSERT INTO `sys_role_res` VALUES ('1', '184');
INSERT INTO `sys_role_res` VALUES ('1', '185');
-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '管理员', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '/styles/images/i07.png', 'admin@admin.com', null, '200', 'e97e0cea2389225f', '0', null);
INSERT INTO `sys_user` VALUES ('2', '张三', 'zhangsan', 'E10ADC3949BA59ABBE56E057F20F883E', '/styles/images/img14.png', '热热热特', null, '2001', 'e97e0cea2389225f', '0', '2016-01-19 17:05:37');
INSERT INTO `sys_user` VALUES ('3', '王五', 'wangw', 'E10ADC3949BA59ABBE56E057F20F883E', '/styles/images/i07.png', '', '2016-01-25 11:51:00', '2000', '1f4f09094836ae11', '0', null);
-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '2');
INSERT INTO `sys_user_role` VALUES ('7', '2');
INSERT INTO `sys_user_role` VALUES ('8', '1');
-- ----------------------------
-- Records of wf_process
-- ----------------------------
INSERT INTO `wf_process` VALUES ('8d59fb6d8d414c7893ada4d1e0f897f0', 'borrow', '借款申请流程', null, '/ms/flow/flow/all', '1', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D3822207374616E64616C6F6E653D226E6F223F3E0A3C70726F6365737320646973706C61794E616D653D22E5809FE6ACBEE794B3E8AFB7E6B581E7A88B2220696E7374616E636555726C3D222F736E616B65722F666C6F772F616C6C22206E616D653D22626F72726F77223E0A3C737461727420646973706C61794E616D653D2273746172743122206C61796F75743D2234322C3131382C2D312C2D3122206E616D653D22737461727431223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3122206F66667365743D22302C302220746F3D226170706C79222F3E0A3C2F73746172743E0A3C656E6420646973706C61794E616D653D22656E643122206C61796F75743D223437392C3131382C2D312C2D3122206E616D653D22656E6431222F3E0A3C7461736B2061737369676E65653D226170706C792E6F70657261746F7222206175746F457865637574653D22592220646973706C61794E616D653D22E5809FE6ACBEE794B3E8AFB72220666F726D3D222F666C6F772F626F72726F772F6170706C7922206C61796F75743D223132362C3131362C2D312C2D3122206E616D653D226170706C792220706572666F726D547970653D22414E5922207461736B547970653D224D616A6F72223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3222206F66667365743D22302C302220746F3D22617070726F76616C222F3E0A3C2F7461736B3E0A3C7461736B2061737369676E65653D22617070726F76616C2E6F70657261746F7222206175746F457865637574653D22592220646973706C61794E616D653D22E5AEA1E689B92220666F726D3D222F736E616B65722F666C6F772F617070726F76616C22206C61796F75743D223235322C3131362C2D312C2D3122206E616D653D22617070726F76616C2220706572666F726D547970653D22414E5922207461736B547970653D224D616A6F72223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3322206F66667365743D22302C302220746F3D226465636973696F6E31222F3E0A3C2F7461736B3E0A3C6465636973696F6E20646973706C61794E616D653D226465636973696F6E312220657870723D22247B726573756C747D22206C61796F75743D223338342C3131382C2D312C2D3122206E616D653D226465636973696F6E31223E0A3C7472616E736974696F6E20646973706C61794E616D653D22E5908CE6848F2220673D2222206E616D653D22616772656522206F66667365743D22302C302220746F3D22656E6431222F3E0A3C7472616E736974696F6E20646973706C61794E616D653D22E4B88DE5908CE6848F2220673D223430382C36383B3137322C363822206E616D653D22646973616772656522206F66667365743D22302C302220746F3D226170706C79222F3E0A3C2F6465636973696F6E3E0A3C2F70726F636573733E0A, '0', '2016-01-25 13:42:46', null);
INSERT INTO `wf_process` VALUES ('f3de74e9332343f4b42a39050b221020', 'leave', '请假流程测试', null, '/snaker/flow/all', '1', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D3822207374616E64616C6F6E653D226E6F223F3E0A3C70726F6365737320646973706C61794E616D653D22E8AFB7E58187E6B581E7A88BE6B58BE8AF952220696E7374616E636555726C3D222F736E616B65722F666C6F772F616C6C22206E616D653D226C65617665223E0A3C737461727420646973706C61794E616D653D2273746172743122206C61796F75743D2232342C3132342C2D312C2D3122206E616D653D22737461727431223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3122206F66667365743D22302C302220746F3D226170706C79222F3E0A3C2F73746172743E0A3C656E6420646973706C61794E616D653D22656E643122206C61796F75743D223537302C3132342C2D312C2D3122206E616D653D22656E6431222F3E0A3C7461736B2061737369676E65653D226170706C792E6F70657261746F722220646973706C61794E616D653D22E8AFB7E58187E794B3E8AFB72220666F726D3D222F666C6F772F6C656176652F6170706C7922206C61796F75743D223131372C3132322C2D312C2D3122206E616D653D226170706C792220706572666F726D547970653D22414E59223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3222206F66667365743D22302C302220746F3D22617070726F766544657074222F3E0A3C2F7461736B3E0A3C7461736B2061737369676E65653D22617070726F7665446570742E6F70657261746F722220646973706C61794E616D653D22E983A8E997A8E7BB8FE79086E5AEA1E689B92220666F726D3D222F666C6F772F6C656176652F617070726F76654465707422206C61796F75743D223237322C3132322C2D312C2D3122206E616D653D22617070726F7665446570742220706572666F726D547970653D22414E59223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3322206F66667365743D22302C302220746F3D226465636973696F6E31222F3E0A3C2F7461736B3E0A3C6465636973696F6E20646973706C61794E616D653D226465636973696F6E312220657870723D22247B646179202667743B2032203F20277472616E736974696F6E3527203A20277472616E736974696F6E34277D22206C61796F75743D223432362C3132342C2D312C2D3122206E616D653D226465636973696F6E31223E0A3C7472616E736974696F6E20646973706C61794E616D653D22266C743B3D32E5A4A92220673D2222206E616D653D227472616E736974696F6E3422206F66667365743D22302C302220746F3D22656E6431222F3E0A3C7472616E736974696F6E20646973706C61794E616D653D222667743B32E5A4A92220673D2222206E616D653D227472616E736974696F6E3522206F66667365743D22302C302220746F3D22617070726F7665426F7373222F3E0A3C2F6465636973696F6E3E0A3C7461736B2061737369676E65653D22617070726F7665426F73732E6F70657261746F722220646973706C61794E616D653D22E680BBE7BB8FE79086E5AEA1E689B92220666F726D3D222F666C6F772F6C656176652F617070726F7665426F737322206C61796F75743D223430342C3233312C2D312C2D3122206E616D653D22617070726F7665426F73732220706572666F726D547970653D22414E59223E0A3C7472616E736974696F6E20673D2222206E616D653D227472616E736974696F6E3622206F66667365743D22302C302220746F3D22656E6431222F3E0A3C2F7461736B3E0A3C2F70726F636573733E0A, '0', '2016-01-25 13:42:45', null);
