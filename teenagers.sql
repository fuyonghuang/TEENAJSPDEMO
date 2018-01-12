/*
Navicat MySQL Data Transfer

Source Server         : loca
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : teenagers

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2018-01-05 10:12:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for s_checkitem_info
-- ----------------------------
DROP TABLE IF EXISTS `s_checkitem_info`;
CREATE TABLE `s_checkitem_info` (
  `ITEM_ID` varchar(100) NOT NULL COMMENT 'ID',
  `INFO_TYPE` int(11) DEFAULT NULL COMMENT '信息类型(0，系统，1单位自定义)',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '单位代码',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '单位名称',
  `CEHCK_CONTENT` varchar(500) DEFAULT NULL COMMENT '检查内容',
  `ITEM_INFO` text COMMENT '检查信息,json 数组格式',
  `IS_DANGER_CHECK` int(11) DEFAULT '1' COMMENT '判断是否有隐患',
  `DANGER_VALUE` varchar(100) DEFAULT NULL COMMENT '隐患值',
  `DANGER_LEVER` int(11) DEFAULT '0' COMMENT '隐患等级(0,1,2,3,4隐患等级)',
  `TYPE_NAME1` varchar(50) DEFAULT NULL COMMENT '分类名称1(索引)',
  `TYPE_NAME2` varchar(50) DEFAULT NULL COMMENT '分类名称2(索引)',
  `TYPE_NAME3` varchar(50) DEFAULT NULL COMMENT '分类名称3(索引)',
  `SORTNO` int(11) DEFAULT NULL COMMENT '排序号()由小到大排序',
  PRIMARY KEY (`ITEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='检查库表';

-- ----------------------------
-- Table structure for s_checkitem_type
-- ----------------------------
DROP TABLE IF EXISTS `s_checkitem_type`;
CREATE TABLE `s_checkitem_type` (
  `TYPE_ID` varchar(100) NOT NULL COMMENT 'ID',
  `TYPE_NAME` varchar(50) DEFAULT NULL COMMENT '分类名称(索引)',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '父类ID号(0为第一级)',
  `SORTNO` int(11) DEFAULT NULL COMMENT '排序号(由小到大排序)',
  `GRADE` int(11) DEFAULT NULL COMMENT '分类等级(用来判断该类型属于哪一级，如果是第三级就不能添加下级，方便分级\r\n            )',
  PRIMARY KEY (`TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='检查项分类表';

-- ----------------------------
-- Table structure for s_check_content
-- ----------------------------
DROP TABLE IF EXISTS `s_check_content`;
CREATE TABLE `s_check_content` (
  `CONETN_ID` varchar(100) NOT NULL COMMENT 'ID',
  `ITEM_ID` varchar(100) DEFAULT NULL COMMENT '检查内容库ID(自定义时不存在，索引，可通过检查内容库选择)',
  `FORM_ID` varchar(100) DEFAULT NULL COMMENT '表单ID号(索引)',
  `CONTENT_TITLE` varchar(100) DEFAULT NULL COMMENT '标题内容',
  `CONTNET_NO` int(11) DEFAULT NULL COMMENT '编号(由小到大排序)',
  `SHOW_TYPE` varchar(20) DEFAULT NULL COMMENT '显示方式,(text(文本),radio(单选,checkbox(多选))',
  `CONTENT_VALUE` float(5,1) DEFAULT NULL COMMENT '单项分值(一位小数)',
  `CONTENT_ANSWER` text COMMENT '答案(对应CONTENT_ITEMS中的itemNo。必须全部匹配才得分。多个答案为逗号分隔的字符串.1234567)',
  `IS_DANGER_CHECK` int(11) DEFAULT '1' COMMENT '是否有隐患判断',
  `DANGER_VALUE` varchar(150) DEFAULT NULL COMMENT '隐患值',
  `DANGER_LEVER` int(11) DEFAULT '0' COMMENT '隐患等级,(0,1,2,3,4隐患等级)',
  `CONTENT_ITEMS` varchar(500) DEFAULT NULL COMMENT '选项(json数组\r\n            [{itemNo:1;itemTitle:xx;itemValue:0}]\r\n            itemno全部采用1234567来表示序号\r\n            )',
  `ISDANAGERSHOW` int(11) DEFAULT '0' COMMENT '是否有隐患时才可上传(0否，1是, 选择1时只有选择了有隐患时才显示图片视频等上传内容)',
  `ISEXITSOTHER` int(11) DEFAULT '1' COMMENT '是否有其它,0无，1有，有其它时，可手工输入内容。',
  `ISEXITESVIDIO` int(11) DEFAULT '0' COMMENT '是否有视频上传,0无，1有。',
  `ISEXITESPHOTO` int(11) DEFAULT NULL COMMENT '是否有图片上传,0无，1有。',
  `ISEXITESAUDIO` int(11) DEFAULT NULL COMMENT '是否有声音上传,0无，1有。',
  `ISEXITESFILEUPLOAD` int(11) DEFAULT NULL COMMENT '是否有文件上传,0无，1有。',
  `UPLOAD_FILE_TYPE` varchar(100) DEFAULT NULL COMMENT '允许上传文件类型(.DOC.DOCX等)',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间(YYYY-MM-DD HH:MM:SS)',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间(YYYY-MM-DD HH:MM:SS)',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  `TYPE_NAME1` varchar(50) DEFAULT NULL COMMENT '分类名称1(索引)',
  `TYPE_NAME2` varchar(50) DEFAULT NULL COMMENT '分类名称2(索引)',
  `TYPE_NAME3` varchar(50) DEFAULT NULL COMMENT '分类名称3(索引)',
  PRIMARY KEY (`CONETN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='检查内容表';

-- ----------------------------
-- Table structure for s_company_info
-- ----------------------------
DROP TABLE IF EXISTS `s_company_info`;
CREATE TABLE `s_company_info` (
  `COMPANY_ID` varchar(100) NOT NULL COMMENT '单位ID(主键longTime+”-"+javauuid（唯一）)',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '公司编码系统,(没有，手动分配3101010001前两位为省代码3,4位为市代码5,6位为区代码7-11为街道代码（或企业代码）12-16（企业代码）前6位对应S_DISTRICT中的DCODE唯一索引。原则上按组织机构编码，但注意有些单位尽管位于某一个区，但上级机构代码可能不属于区。以上级单位编码为准\r\n            )',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '单位名称',
  `COMPANY_TYPE` varchar(100) DEFAULT NULL COMMENT '单位类型',
  `PY_COMPANY` varchar(100) DEFAULT NULL COMMENT '单位拼音(对应S_COMPANY_TYPE中的COMPANY_TYPE)',
  `PNAME` varchar(30) DEFAULT NULL COMMENT '省(中文，对应S_DISTRICT的DNAME，冗余)',
  `CNAME` varchar(30) DEFAULT NULL COMMENT '市(S_DISTRICT的DNAME，冗余)',
  `DNAME` varchar(30) DEFAULT NULL COMMENT '区县(S_DISTRICT的DNAME，冗余\r\n            上海以该字段建索引\r\n            )',
  `STREETNAME` varchar(50) DEFAULT NULL COMMENT '街道（乡镇）',
  `PARENT_CODE` varchar(100) DEFAULT NULL COMMENT '上级代码(索引，对应COMPANY_CODE\r\n            上海第一级父代码为310101.\r\n            )',
  `PARENT_NAME` varchar(50) DEFAULT NULL COMMENT '上级机构名称(父机构，冗余，便于查询)',
  `ORG_CODE` varchar(50) DEFAULT NULL COMMENT '组织机构代码(业机构代码或组织机构代码证号，唯一，只做登记用)',
  `COMPANY_TEL` varchar(20) DEFAULT NULL COMMENT '电话',
  `COMPANY_ADDRESS` varchar(100) DEFAULT NULL COMMENT '地址',
  `GPS_LNG` varchar(20) DEFAULT NULL COMMENT '地址经度(对应百度api的值\r\n            预留，暂不实现\r\n            )',
  `GPS_LAT` varchar(20) DEFAULT NULL COMMENT '地址纬度(对应百度api的值\r\n            预留，暂不实现\r\n            )',
  `COMPANY_ZIP` varchar(20) DEFAULT NULL COMMENT '邮编',
  `COMPANY_DEPARTMENTS` text COMMENT '单位部门(用逗号分隔的多个部门。便于录入用户时选择。)',
  `FIRST_LEADER` varchar(50) DEFAULT NULL COMMENT '第一责任人(第一责任人、校长、法人)',
  `FIRST_LEADER_MOBILE` varchar(20) DEFAULT NULL COMMENT '第一责任人电话',
  `LEADER_PERSON` varchar(50) DEFAULT NULL COMMENT '责任人',
  `CONTACT_PERSON` varchar(50) DEFAULT NULL COMMENT '日常工作联系人、安全负责人，',
  `CONTACT_PERSON_MOBILE` varchar(50) DEFAULT NULL COMMENT '日常工作负责人电话',
  `SAFTY_PERSON` varchar(50) DEFAULT NULL COMMENT '安全联络员',
  `REGISTER_TYPE` int(11) DEFAULT NULL COMMENT '注册类型',
  `REGISTER_TIME` varchar(20) DEFAULT NULL COMMENT '注册时间(yyyy-mm-dd hh:MM:ss)',
  `STATUS` int(11) DEFAULT NULL COMMENT '状态(0正常1 已注销2已关停3信息有误)',
  `SAFE_MANAGER_DEPARTMENT` varchar(50) DEFAULT NULL COMMENT '安全管理部门',
  `SAFE_PERSONNUM` int(11) DEFAULT NULL COMMENT '专职安全员数',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  PRIMARY KEY (`COMPANY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='单位信息表';

-- ----------------------------
-- Table structure for s_company_model
-- ----------------------------
DROP TABLE IF EXISTS `s_company_model`;
CREATE TABLE `s_company_model` (
  `COMPANY_ID` varchar(100) DEFAULT NULL COMMENT '单位ID',
  `MODEL_CODE` varchar(50) DEFAULT NULL COMMENT '功能代码'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='单位模块表,暂不使用，单位开通的模块列表';

-- ----------------------------
-- Table structure for s_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `s_dict_type`;
CREATE TABLE `s_dict_type` (
  `ID` varchar(100) NOT NULL COMMENT '主键',
  `SORTNO` int(11) DEFAULT NULL COMMENT '排序号(由小到大排序)',
  `DIC_NAME` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `DIC_TYPE` varchar(50) DEFAULT NULL COMMENT '配置代码',
  `DIC_CODE` varchar(50) DEFAULT NULL COMMENT '字典CODE',
  `DIC_DESC` varchar(100) DEFAULT NULL COMMENT '备注',
  `DIC_STATUS` int(11) DEFAULT '0' COMMENT '状态 0 启动 1 禁用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统字典表';

-- ----------------------------
-- Table structure for s_district
-- ----------------------------
DROP TABLE IF EXISTS `s_district`;
CREATE TABLE `s_district` (
  `DCODE` varchar(50) DEFAULT NULL COMMENT '地区代码 (主键，上海31)',
  `DNAME` varchar(50) DEFAULT NULL COMMENT '地区名称(英文，唯一)',
  `PARENT_CODE` varchar(50) DEFAULT NULL COMMENT '父代码'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='地区表';

-- ----------------------------
-- Table structure for s_entity_info
-- ----------------------------
DROP TABLE IF EXISTS `s_entity_info`;
CREATE TABLE `s_entity_info` (
  `ENTITY_ID` varchar(100) NOT NULL COMMENT 'ID',
  `TABLE_NAME` varchar(100) DEFAULT NULL COMMENT '表名',
  `FIELD_NAME` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `FIELD_CODE` varchar(100) DEFAULT NULL COMMENT '字段代码(全大写英文字母)',
  `FIELD_TYPE` varchar(100) DEFAULT NULL COMMENT '字段类型(TEXT,INT,DECEIMAL,对应数据库类型)',
  `FIELD_LENGTH` int(11) DEFAULT NULL COMMENT '字段长度（默认50，超过500用TEXT创建）',
  `DATA_TYPE` varchar(100) DEFAULT NULL COMMENT '数据类型(INT数字,TIME时间,DATE日期,TEXT字符，EMAIL，MOBILE手机号,DECIMAL)',
  `DATA_CHECK` int(11) DEFAULT NULL COMMENT '数据检查(0不判断1必须判断2非空时判断)',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '所属单位(表单归属单位)',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间(YYYY-MM-DD HH:MM:SS)',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间(YYYY-MM-DD HH:MM:SS)',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  PRIMARY KEY (`ENTITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='自定义实体表信息  ( 同一数据库表是先删除再增加方式产生数据。 )';

-- ----------------------------
-- Table structure for s_form_info
-- ----------------------------
DROP TABLE IF EXISTS `s_form_info`;
CREATE TABLE `s_form_info` (
  `FORM_ID` varchar(100) NOT NULL,
  `FORM_TYPE` int(11) DEFAULT NULL COMMENT '表单类型(0，选项表单（通过检查项设置），1模板文件表单（通过模板文件设置）,2其它填报表单（暂无需求，不依赖任务可以直接发布，默认对所有人要求）)',
  `INPUT_TYPE` int(11) DEFAULT NULL COMMENT '填报类型(任务表单输入类型任务设置，非任务表单通过这个来限制输入类型0不限制可随时填报1每周1次，2每月1次3只一次)',
  `FORM_NAME` varchar(100) DEFAULT NULL COMMENT '表单名称',
  `TEMPLATE_CONTENT` text COMMENT '模板文件(模板html代码)',
  `TABLE_NAME` varchar(100) DEFAULT NULL COMMENT '实体表名称(唯一，只能创建一个实体表\r\n            创建的实体表默认包含一些字段。\r\n            )',
  `OPEN_STATUS` int(11) DEFAULT NULL COMMENT '开发状态(0未开放1已开放)',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '所属单位(表单归属单位)',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间(YYYY-MM-DD HH:MM:SS)',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间(YYYY-MM-DD HH:MM:SS)',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  `START_TIME` varchar(20) DEFAULT NULL COMMENT '其他填报开始时间',
  `END_TIME` varchar(20) DEFAULT NULL COMMENT '其他填报结束时间',
  PRIMARY KEY (`FORM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='自定义表单表';

-- ----------------------------
-- Table structure for s_functioninfo
-- ----------------------------
DROP TABLE IF EXISTS `s_functioninfo`;
CREATE TABLE `s_functioninfo` (
  `FUNCTION_ID` varchar(100) NOT NULL COMMENT '单位ID',
  `FUNCTION_CODE` varchar(200) DEFAULT NULL COMMENT '功能代码,控制代码，对应代码中的控制代码(可分配url类型，但必须严格按照代码传递参数来设置) ',
  `FUNCTION_NAME` varchar(100) DEFAULT NULL COMMENT '功能名称,',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '父代码,0父级，只显示。',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号,由小到大排序，偏于权限分配中显示',
  `FUNCTION_TYPE` int(11) DEFAULT NULL COMMENT '函数类型,0,控制代码，1 url类型，2操作按钮、3数据筛选类型。暂不使用，如果同时企业url和控制代码方式需要设置。',
  `MODEL_CODE` varchar(100) DEFAULT '0' COMMENT '功能模块代码,对应功能模块代码',
  PRIMARY KEY (`FUNCTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统功能表,不做页面维护，通过初始化操作，对应代码编码文件';

-- ----------------------------
-- Table structure for s_roleinfo
-- ----------------------------
DROP TABLE IF EXISTS `s_roleinfo`;
CREATE TABLE `s_roleinfo` (
  `ROLE_ID` varchar(100) NOT NULL COMMENT '角色ID(主键、LONGTIME+”-"+JAVAUUID（唯一）)',
  `ROLE_CODE` varchar(50) DEFAULT NULL COMMENT '角色代码',
  `ROLE_NAME` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `ROLE_DESC` varchar(200) DEFAULT NULL COMMENT '备注(角色描述)',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统角色表  配置界面，ROLE_CODE暂时不做录入';

-- ----------------------------
-- Table structure for s_role_funtion
-- ----------------------------
DROP TABLE IF EXISTS `s_role_funtion`;
CREATE TABLE `s_role_funtion` (
  `ROLE_ID` varchar(100) NOT NULL COMMENT '角色ID',
  `FUNCTION_ID` varchar(50) NOT NULL COMMENT '功能ID',
  PRIMARY KEY (`ROLE_ID`,`FUNCTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='维护修改时，先删除角色下所有功能信息，重新新增角色下功能信息';

-- ----------------------------
-- Table structure for s_system_model
-- ----------------------------
DROP TABLE IF EXISTS `s_system_model`;
CREATE TABLE `s_system_model` (
  `MODEL_CODE` varchar(50) DEFAULT NULL COMMENT '模块代码',
  `MODEL_NAME` varchar(50) DEFAULT NULL COMMENT '模块名称'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统模块表';

-- ----------------------------
-- Table structure for s_user_extned_right
-- ----------------------------
DROP TABLE IF EXISTS `s_user_extned_right`;
CREATE TABLE `s_user_extned_right` (
  `USER_ID` varchar(100) NOT NULL COMMENT '角色ID',
  `REGISTER_TYPE` int(11) DEFAULT '0' COMMENT '单位注册类型扩展(0不扩展1扩展,为1时，必须在\r\n            S_USER_EXTNED_REGISTER_TYPE存在记录\r\n            )',
  `COMPANY_INFO` int(11) DEFAULT '0' COMMENT '管理单位扩展(0默认不扩展，1含下级所有单位2仅限选定单位，3除下级单位外、包含选定单位，4不包含选定单位。)',
  `CHECK_POINT` int(11) DEFAULT '0' COMMENT '检查点（设备）(0默认不扩展，1限定选定的检查点)',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户权限扩展表';

-- ----------------------------
-- Table structure for s_user_extned_right_detail
-- ----------------------------
DROP TABLE IF EXISTS `s_user_extned_right_detail`;
CREATE TABLE `s_user_extned_right_detail` (
  `EXTEND_ID` varchar(100) NOT NULL COMMENT 'ID',
  `EXTEND_TYPE` int(11) DEFAULT '0' COMMENT '扩展类型(0，管理单位扩展，1注册类型（单位类型提示）扩展，2检查点（后续需要）)',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '用户ID(索引)',
  `EXTEND_VALUE` varchar(200) DEFAULT NULL COMMENT '注册类型(对于管理单位则为单位ID号，\r\n            对于注册类型则为注册类型值，对于其它则为相应的主键值\r\n            )',
  PRIMARY KEY (`EXTEND_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户权限扩展明细表,该表存在记录，\r\n则S_USER_EXTNED_RIGHT中相应类型字段为1，\r\n                                               -&#&';

-- ----------------------------
-- Table structure for s_user_info
-- ----------------------------
DROP TABLE IF EXISTS `s_user_info`;
CREATE TABLE `s_user_info` (
  `USER_ID` varchar(100) NOT NULL COMMENT '主键LONGTIME+”-"+JAVA UUID（唯一）ID',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `USER_CODE` varchar(50) DEFAULT NULL COMMENT '账号(唯一索引)',
  `PASSWORD` varchar(100) DEFAULT NULL COMMENT '密码(MD5加密，使用统一加密函数加密)',
  `COMPANY_ID` varchar(100) DEFAULT NULL COMMENT '所属单位ID(索引)',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '单位名称(冗余，便于单表查询)',
  `DEPARTMENT_NAME` varchar(50) DEFAULT NULL COMMENT '所属部门（可手工录入，可通过单位信息中部门选择）',
  `POSITION_NAME` varchar(50) DEFAULT NULL COMMENT '职务',
  `MOBILE` varchar(20) DEFAULT NULL COMMENT '电话',
  `EMAIL` varchar(100) DEFAULT NULL COMMENT 'EMAIL',
  `LAST_LOGIN_TIME` varchar(20) DEFAULT NULL COMMENT '上次登录时间',
  `LAST_LOGIN_IP` varchar(20) DEFAULT NULL COMMENT '上次登录IP',
  `PY_USER` varchar(20) DEFAULT NULL,
  `OPEN_TYPE` int(11) DEFAULT '1' COMMENT '开放类型(0不开放，1本单位开放，2对上级开放，3同级开放，4下级开放，5所有开放)',
  `STATUS` int(11) DEFAULT NULL COMMENT '状态(0不可用1 可用)',
  `IS_EXTEND_RIGHT` int(11) DEFAULT '0' COMMENT '是否扩展权限(0不扩展，1扩展，扩展后登陆后才会判断规则，进入权限扩展界面。)',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户信息表';

-- ----------------------------
-- Table structure for s_user_role
-- ----------------------------
DROP TABLE IF EXISTS `s_user_role`;
CREATE TABLE `s_user_role` (
  `USER_ID` varchar(100) NOT NULL COMMENT '用户ID',
  `ROLE_ID` varchar(100) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`USER_ID`,`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户角色表\r\n维护修改时，先删除用户下所有角色后，\r\n再重新新增角色信息。一个用户可多个角色。';

-- ----------------------------
-- Table structure for s_web_config
-- ----------------------------
DROP TABLE IF EXISTS `s_web_config`;
CREATE TABLE `s_web_config` (
  `ID` varchar(100) NOT NULL COMMENT '主键，longTime+”-"+uuid',
  `CONFIG_CODE` varchar(100) DEFAULT NULL COMMENT '配置代码,英文，唯一',
  `CONFIG_VALUE` text COMMENT '值,可多种格式录入，如json等',
  `CONFIG_STATUS` smallint(1) DEFAULT NULL COMMENT '状态   0不可用、1可用',
  `CONFIG_DESC` varchar(100) DEFAULT NULL COMMENT '描述: 备注',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间 格式：  yyyy-mm-dd hh:MM:ss',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户：用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间  格式：  yyyy-mm-dd hh:MM:ss',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户：用户名',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='配置总表';

-- ----------------------------
-- Table structure for t_attach_info
-- ----------------------------
DROP TABLE IF EXISTS `t_attach_info`;
CREATE TABLE `t_attach_info` (
  `ID` varchar(64) NOT NULL COMMENT '主键ID',
  `REFER_ID` varchar(64) DEFAULT NULL COMMENT '引用者ID',
  `REFER_TABLE` varchar(50) DEFAULT NULL COMMENT '引用表名称',
  `TASK_NAME` varchar(100) DEFAULT NULL COMMENT '任务名称',
  `TYPE_NAME1` varchar(50) DEFAULT NULL COMMENT '检查项分类名称1',
  `TYPE_NAME2` varchar(50) DEFAULT NULL COMMENT '检查项分类名称2',
  `TYPE_NAME3` varchar(50) DEFAULT NULL COMMENT '检查项分类名称3',
  `TASK_FROM` varchar(50) DEFAULT NULL COMMENT '附件来源',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '归属单位名称',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '归属单位代码',
  `ATTACH_TYPE` int(11) DEFAULT NULL COMMENT '附件类型（如：任务，检查项）',
  `ATTACH_URL` varchar(500) DEFAULT NULL COMMENT '附件访问地址',
  `ATTACH_NAME` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `REMARKS` varchar(200) DEFAULT NULL COMMENT '备注',
  `FILE_SIZE` varchar(100) DEFAULT NULL COMMENT '文件大小',
  `ATTACH_STATUS` int(11) DEFAULT NULL COMMENT '删除标志 0:删除 1：有效',
  `GPS_LNG` varchar(20) DEFAULT NULL COMMENT '地址经度',
  `GPS_LAT` varchar(20) DEFAULT NULL COMMENT '地址纬度',
  `ATTACH_SUFFIX` varchar(20) DEFAULT NULL COMMENT '后缀',
  `ATTACH_YEAR` varchar(10) DEFAULT NULL COMMENT '年',
  `ATTACH_MONTH` varchar(10) DEFAULT NULL COMMENT '两位月01,02',
  `ATTACH_DATE` varchar(10) DEFAULT NULL COMMENT '8位日期YYYYMMDD',
  `ATTACH_WEEK` int(11) DEFAULT NULL COMMENT '周',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='附件表';

-- ----------------------------
-- Table structure for t_check_info
-- ----------------------------
DROP TABLE IF EXISTS `t_check_info`;
CREATE TABLE `t_check_info` (
  `CHECK_RESULT_ID` varchar(100) NOT NULL COMMENT 'ID',
  `TASK_ID` varchar(100) DEFAULT NULL COMMENT '任务ID',
  `FORM_ID` varchar(100) DEFAULT NULL COMMENT '表单ID',
  `TASK_FROM` varchar(100) DEFAULT NULL COMMENT '任务来源',
  `FORM_NAME` varchar(100) DEFAULT NULL COMMENT '检查点名称(冗余字段)',
  `TABLE_NAME` varchar(100) DEFAULT NULL COMMENT '主表名（根据TASK_FROM 对应不同的表）',
  `TABLE_ID` varchar(100) DEFAULT NULL COMMENT '主表ID值（对应的主表名ID值）',
  `PNAME` varchar(30) DEFAULT NULL COMMENT '省',
  `CNAME` varchar(30) DEFAULT NULL COMMENT '市',
  `DNAME` varchar(30) DEFAULT NULL COMMENT '区县',
  `STREETNAME` varchar(30) DEFAULT NULL COMMENT '街道（乡镇）',
  `SCORE` float(5,1) DEFAULT NULL COMMENT '得分（获得分数，1位小数）',
  `CHECK_RESULT` int(11) DEFAULT '0' COMMENT '是否正常（0正常1异常（有隐患））',
  `CHECK_STATUS` int(11) DEFAULT NULL COMMENT '状态 0未开始，1未完成，2已完成',
  `COMPANY_ID` varchar(100) DEFAULT NULL COMMENT '所属单位ID号',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '所属单位代码（目标单位、检查点（设备等）单位代码）',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '单位名称（检查点单位名称）',
  `CHECK_COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '检查单位代码',
  `CHECK_COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '检查单位(执行填报的单位名称)',
  `PARENT_CODE` varchar(100) DEFAULT NULL COMMENT '父代码(检查点单位父代码)',
  `CHECK_BELONG_COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '检查归属单位,(检查表单归属单位，冗余\r\n            同表单归属相同。\r\n            )',
  `CHECK_USER_ID` varchar(100) DEFAULT NULL COMMENT '用户ID,检查人ID',
  `CHECK_USER_NAME` varchar(50) DEFAULT NULL COMMENT '检查用户名',
  `CHECK_YEAR` varchar(10) DEFAULT NULL COMMENT '4位年',
  `CHECK_MONTH` varchar(10) DEFAULT NULL COMMENT '两位月01,02',
  `CHECK_DATE` varchar(10) DEFAULT NULL COMMENT '8位日期YYYYMMDD',
  `CHECK_WEEK` int(11) DEFAULT NULL COMMENT '1-7周1，7周日',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间(YYYY-MM-DD HH:MM:SS)',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间(YYYY-MM-DD HH:MM:SS)',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  PRIMARY KEY (`CHECK_RESULT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='检查信息表';

-- ----------------------------
-- Table structure for t_check_result
-- ----------------------------
DROP TABLE IF EXISTS `t_check_result`;
CREATE TABLE `t_check_result` (
  `ITEM_RESULT_ID` varchar(100) DEFAULT NULL COMMENT 'ID  主键longTime+”-"+java uuid（唯一）',
  `CHECK_RESULT_ID` varchar(100) DEFAULT NULL COMMENT '检查id',
  `TASK_ID` varchar(100) DEFAULT NULL COMMENT '任务Id',
  `FORM_ID` varchar(100) DEFAULT NULL COMMENT '表单Id',
  `TASK_FROM` varchar(100) DEFAULT NULL COMMENT '任务来源',
  `FORM_NAME` varchar(100) DEFAULT NULL COMMENT '检查点名称',
  `TABLE_NAME` varchar(100) DEFAULT NULL COMMENT '主表名根据task_from 对应不同的表',
  `TABLE_ID` varchar(100) DEFAULT NULL COMMENT '主表id值对应的主表名id值',
  `PNAME` varchar(30) DEFAULT NULL COMMENT '省',
  `CNAME` varchar(30) DEFAULT NULL COMMENT '市',
  `DNAME` varchar(30) DEFAULT NULL COMMENT '区县',
  `STREETNAME` varchar(50) DEFAULT NULL COMMENT '街道乡镇',
  `ITEM_ID` varchar(100) DEFAULT NULL COMMENT '检查内容库id。自定义时不存在，索引',
  `ITEM_TITLE` varchar(300) DEFAULT NULL COMMENT '标题内容',
  `ITEM_NO` int(11) DEFAULT NULL COMMENT '编号，由小到大排序',
  `TYPE_NAME1` varchar(50) DEFAULT NULL COMMENT '分类名称1',
  `TYPE_NAME2` varchar(50) DEFAULT NULL COMMENT '分类名称2',
  `TYPE_NAME3` varchar(50) DEFAULT NULL COMMENT '分类名称3',
  `CONTENT_TITLE` varchar(300) DEFAULT NULL COMMENT '标题内容',
  `ANSWER_RESULT` varchar(100) DEFAULT NULL COMMENT '回答选择。选择结果值，如1,2,3,4',
  `ITEM_CONTENT` text COMMENT '选项json格式',
  `SCORE` float DEFAULT NULL COMMENT '得分获得分数，1位小数',
  `CHECK_RESULT` varchar(100) DEFAULT NULL COMMENT '是否正常，0正常1异常（有隐患）',
  `CHECK_DESC` varchar(100) DEFAULT NULL COMMENT '备注隐患备注，默认为选项内容。',
  `PHOTO_PATH` varchar(500) DEFAULT NULL COMMENT '上传图片路径多个用逗号分隔',
  `VIEDIO_PATH` varchar(200) DEFAULT NULL COMMENT '视频路径',
  `FILE_PATH` varchar(200) DEFAULT NULL COMMENT '文件路径',
  `AUDIO_PATH` varchar(200) DEFAULT NULL COMMENT '声音路径',
  `COMPANY_ID` varchar(100) DEFAULT NULL COMMENT '单位id号',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '检查点单位代码',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '检查点单位名称',
  `CHECK_COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '检查人单位代码',
  `CHECK_COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '检查人单位名称',
  `PARENT_CODE` varchar(100) DEFAULT NULL COMMENT '父代码',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '用户id',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `CHECK_YEAR` varchar(10) DEFAULT NULL COMMENT '4位年',
  `CHECK_MONTH` varchar(10) DEFAULT NULL COMMENT '两位月01,02',
  `CHECK_DATE` varchar(10) DEFAULT NULL COMMENT '8位日期yyyymmdd',
  `CHECK_WEEK` int(11) DEFAULT NULL COMMENT '1-7周1，7周日',
  `CHECK_TIME` varchar(20) DEFAULT NULL COMMENT '检查时间yyyy-mm-dd hh:MM:ss',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间yyyy-mm-dd hh:MM:ss',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间yyyy-mm-dd hh:MM:ss',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='任务执行明细表';

-- ----------------------------
-- Table structure for t_danger_info
-- ----------------------------
DROP TABLE IF EXISTS `t_danger_info`;
CREATE TABLE `t_danger_info` (
  `DANGER_ID` varchar(100) DEFAULT NULL COMMENT 'ID主键longTime+”-"+java uuid（唯一）',
  `ITEM_RESULT_ID` varchar(100) DEFAULT NULL COMMENT '检查id号，如果有添加',
  `CHECK_RESULT_ID` varchar(100) DEFAULT NULL COMMENT '检查id',
  `TASK_ID` varchar(100) DEFAULT NULL COMMENT '任务Id',
  `FORM_ID` varchar(100) DEFAULT NULL COMMENT '表单Id',
  `TASK_FROM` varchar(100) DEFAULT NULL COMMENT '任务来源',
  `FORM_NAME` varchar(100) DEFAULT NULL COMMENT '检查点名称。。。冗余',
  `TABLE_NAME` varchar(100) DEFAULT NULL COMMENT '主表名，根据task_from 对应不同的表',
  `TABLE_ID` varchar(100) DEFAULT NULL COMMENT '主表id值。对应的主表名id值',
  `PNAME` varchar(30) DEFAULT NULL COMMENT '省',
  `CNAME` varchar(30) DEFAULT NULL COMMENT '市',
  `DNAME` varchar(30) DEFAULT NULL COMMENT '区县',
  `STREETNAME` varchar(50) DEFAULT NULL COMMENT '街道乡镇',
  `CONTENT_TITLE` varchar(300) DEFAULT NULL COMMENT '标题内容',
  `ANSWER_RESULT` varchar(100) DEFAULT NULL COMMENT '回答选择。选择结果值，如1,2,3,4',
  `ITEM_CONTENT` text COMMENT '选项。json格式',
  `DANGER_FROM` varchar(50) DEFAULT NULL COMMENT '隐患来源。task，device，timereport（随手报）',
  `DANGER_DESC` char(10) DEFAULT NULL COMMENT '隐患备注，默认为选项内容。',
  `PHOTO_PATH` varchar(500) DEFAULT NULL COMMENT '上传图片路径，多个用逗号分隔',
  `VIEDIO_PATH` varchar(200) DEFAULT NULL COMMENT '视频路径',
  `FILE_PATH` varchar(200) DEFAULT NULL COMMENT '文件路径',
  `AUDIO_PATH` varchar(200) DEFAULT NULL COMMENT '声音路径',
  `COMPANY_ID` varchar(100) DEFAULT NULL COMMENT '单位id号',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '单位代码，检查点单位代码',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '检查点单位名称',
  `CHECK_COMPANY_CODE` char(10) DEFAULT NULL COMMENT '检查人单位代码',
  `CHECK_COMPANY_NAME` char(10) DEFAULT NULL COMMENT '检查人单位名称',
  `PARENT_CODE` varchar(100) DEFAULT NULL COMMENT '父代码，便于统计',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '用户id',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `CHECK_YEAR` varchar(10) DEFAULT NULL COMMENT '4位，年',
  `CHECK_MONTH` varchar(10) DEFAULT NULL COMMENT '月两位月01,02',
  `CHECK_DATE` varchar(10) DEFAULT NULL COMMENT '8位日期yyyymmdd',
  `CHECK_WEEK` int(11) DEFAULT NULL COMMENT '1-7周1，7周日',
  `CHECK_TIME` varchar(20) DEFAULT NULL COMMENT '检查时间yyyy-mm-dd hh:MM:ss',
  `DANGER_LEVEL` int(11) DEFAULT NULL COMMENT '隐患等级。0,12,34',
  `DANGER_HANDLE_TIME` varchar(20) DEFAULT NULL COMMENT '整改时间',
  `DANGER_HANDLE_USERID` varchar(100) DEFAULT NULL COMMENT '整改人id，指定整改时需要',
  `DANGER_HANDLE_USER` varchar(20) DEFAULT NULL COMMENT '整改人',
  `DANGER_HANDLE_DESC` text COMMENT '整改描述',
  `DANGER_HANDLE_FILE` text COMMENT '整改附件，主要是图片',
  `PALN_FINISH_DATE` varchar(20) DEFAULT NULL COMMENT '计划完成日期yyyy-mm-dd',
  `FINISHED_TIME` varchar(20) DEFAULT NULL COMMENT '整改完成时间yyyy-mm-dd hh:MM:ss',
  `RECHECK_TIME` char(10) DEFAULT NULL COMMENT '复查时间',
  `RECHECK_USER` char(10) DEFAULT NULL COMMENT '复查人',
  `RECHECK_FILE` text COMMENT '复查附件，主图片',
  `DANGER_STATUS` int(11) DEFAULT NULL COMMENT '状态  0待整改1整改完成待复查2已复查通过，3复查不通过',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间yyyy-mm-dd hh:MM:ss',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间yyyy-mm-dd hh:MM:ss',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  `PROC_FLOW_INFO` text COMMENT '流程扭转信息保存JSON数据，包括流程描述、审批时间，审批意见，审批人，通过状态，经办人（操作用户）（0不通过1通过）'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='隐患表';

-- ----------------------------
-- Table structure for t_device_info
-- ----------------------------
DROP TABLE IF EXISTS `t_device_info`;
CREATE TABLE `t_device_info` (
  `DEVICE_ID` varchar(100) DEFAULT NULL COMMENT '主键longTime+”-"+java uuid（唯一）',
  `DEVICE_TYPE` int(11) DEFAULT NULL COMMENT '设备类型',
  `DEVICE_NAME` int(11) DEFAULT NULL COMMENT '填报类型，任务表单输入类型任务设置，非任务表单通过这个来限制输入类型0不限制可随时填报1每周1次，2每月1次3只一次',
  `DEVICE_STATUS` char(10) DEFAULT NULL COMMENT '设备状态',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '所属单位代码',
  `COMPNAY_NAME` varchar(255) DEFAULT NULL COMMENT '所属单位名称',
  `PNAME` varchar(30) DEFAULT NULL COMMENT '省',
  `CNAME` varchar(30) DEFAULT NULL COMMENT '市',
  `DNAME` varchar(30) DEFAULT NULL COMMENT '区县',
  `STREETNAME` varchar(30) DEFAULT NULL COMMENT '街道、乡镇',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间yyyy-mm-dd hh:MM:ss',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='设备表';

-- ----------------------------
-- Table structure for t_device_task
-- ----------------------------
DROP TABLE IF EXISTS `t_device_task`;
CREATE TABLE `t_device_task` (
  `TASK_FORM_ID` varchar(100) DEFAULT NULL COMMENT '主键longTime+”-"+java uuid（唯一）',
  `TASK_ID` varchar(100) DEFAULT NULL COMMENT '索引',
  `DEVICE_ID` varchar(100) DEFAULT NULL COMMENT '索引'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='设备检查任务表';

-- ----------------------------
-- Table structure for t_task_form
-- ----------------------------
DROP TABLE IF EXISTS `t_task_form`;
CREATE TABLE `t_task_form` (
  `TASK_FORM_ID` varchar(100) NOT NULL,
  `TASK_ID` varchar(100) DEFAULT NULL COMMENT '任务id',
  `FORM_ID` varchar(100) DEFAULT NULL COMMENT '表单id',
  PRIMARY KEY (`TASK_FORM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='任务表单表关联表';

-- ----------------------------
-- Table structure for t_task_info
-- ----------------------------
DROP TABLE IF EXISTS `t_task_info`;
CREATE TABLE `t_task_info` (
  `TASK_ID` varchar(100) NOT NULL COMMENT 'ID',
  `TASK_NAME` varchar(50) DEFAULT NULL COMMENT '任务名称(索引)',
  `TASK_CATEGORY` int(11) DEFAULT NULL COMMENT '任务分类(0单任务，1多任务（由多个任务组成），多任务时只需设置子任务下发，主任务不单独发布2)',
  `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '任务类型(该值从字典里面取值，只放DIC_NAME值)',
  `TASK_FROM` varchar(50) DEFAULT NULL COMMENT '任务来源任务（TASK），设备（DEVICE），CHECKPOINT检查点等。',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '父类ID号,(多个任务用。通过父类任务更新时更新。)',
  `START_DATE` varchar(20) DEFAULT NULL COMMENT '开始时间(YYYY-MM-DD 不设置则为长期)',
  `END_DATE` varchar(20) DEFAULT NULL COMMENT '结束时间YYYY-MM-DD不设置则为长期\r\n            设置后在规定时间范围内执行任务\r\n            ',
  `START_TIME` varchar(10) DEFAULT NULL COMMENT '开始时间 (HH:MM)',
  `END_TIME` varchar(10) DEFAULT NULL COMMENT '结束时间(HH:MM)',
  `NOT_HANDLE_DAY` text COMMENT '不包含节假日,指定节假日例外，逗号分隔的YYYY-MM-DD日期',
  `ONLY_WORK_DAY` int(11) DEFAULT NULL COMMENT '工作日处理(0不限制1限制，\r\n            限制后周6、7不用检查\r\n            )',
  `INFO_HANDLE_TYPE` int(11) DEFAULT NULL COMMENT '处理方式,0仅1次，1每日、2每周，3每月，4每年',
  `COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '发布单位',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '单位名称(便于单表查询)',
  `RELEASE_PERSION` varchar(50) DEFAULT NULL COMMENT '发布人',
  `RELEASE_TIME` varchar(20) DEFAULT NULL COMMENT '发布时间',
  `CHECK_TYPE` int(11) DEFAULT NULL COMMENT '任务检查方式0目标单位自查1检查单位抽查2以上2者',
  `CHECK_COMPAN_CODE` varchar(100) DEFAULT NULL COMMENT '检查单位代码,(只单个单位,建索引)',
  `CHECK_COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '检查单位名称',
  `FORM_TYPE` int(11) DEFAULT NULL COMMENT '任务内容类型(0单表单1多表单。)',
  `INFO_STATUS` int(11) DEFAULT NULL COMMENT '状态,0待审核，1审核通过，2审核拒绝，3已发布，4已完成',
  `OBJECT_COMPANY_TYPE` varchar(500) DEFAULT NULL COMMENT '对象单位类型(对应单位类型中COMPANY_TYPE,可多个（依赖单位信息分类正确）。按单位类型来选择，多个逗号分隔)',
  `OBJECT_COMPANY_PARENT_CODE` varchar(500) DEFAULT NULL COMMENT '对象父代码,单位类型中PARENT_CODE,按上级单位选择，多个逗号分隔',
  `OBJECT_COMPANY` int(11) DEFAULT '0' COMMENT '指定单位,0所有下级，1本单位，2本单位及下级，3指定单位，9为所有 (注册类型为0,1的只能是0,1,2、3)',
  `OBJECT_USER` int(11) DEFAULT '0' COMMENT '指定用户 0不指定1，指定人',
  `TOTAL_OBJECT_NUM` int(11) DEFAULT '0' COMMENT '总指定对象数',
  `CONFIRM_NUM` int(11) DEFAULT '0' COMMENT '认领数自查单位认领数',
  `CHECK_COMPANY_CONFIRM_NUM` int(11) DEFAULT '0' COMMENT '检查单位认领数',
  `FINISHED_NUM` int(11) DEFAULT '0' COMMENT '完成数,自查单位完成数',
  `CHECK_COMPANY_FINISHED_NUM` int(11) DEFAULT '0' COMMENT '检查单位完成数',
  `DANGER_NUM` int(11) DEFAULT '0' COMMENT '隐患数,自查隐患数',
  `CHECK_COMPANY_DANGER_NUM` int(11) DEFAULT '0' COMMENT '检查单位检查隐患数',
  `HANDLE_DANGER_NUM` int(11) DEFAULT '0' COMMENT '整改隐患数',
  `APPLY_PERSON` varchar(50) DEFAULT NULL COMMENT '申请人',
  `APPLY_TIME` varchar(20) DEFAULT NULL COMMENT '申请时间',
  `CHECK_PERSON` varchar(50) DEFAULT NULL COMMENT '审批人',
  `CHECK_DESC` varchar(200) DEFAULT NULL COMMENT '审批备注',
  `CHECK_TIME` varchar(20) DEFAULT NULL COMMENT '审批时间',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间(YYYY-MM-DD HH:MM:SS)',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间(YYYY-MM-DD HH:MM:SS)',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  `PROC_FLOW_INFO` text COMMENT '流程扭转信息',
  PRIMARY KEY (`TASK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='下发任务信息表';

-- ----------------------------
-- Table structure for t_task_object_info
-- ----------------------------
DROP TABLE IF EXISTS `t_task_object_info`;
CREATE TABLE `t_task_object_info` (
  `TASK_OBJCT_ID` varchar(100) NOT NULL COMMENT 'ID',
  `TASK_ID` varchar(100) DEFAULT NULL COMMENT '任务ID,索引',
  `COMPANY_CODE` varchar(50) DEFAULT NULL COMMENT '单位代码,指定单位时存在\r\n            索引\r\n            ',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '单位名称,冗余，便于单表查询',
  `CHECK_COMPANY_CODE` varchar(50) DEFAULT NULL COMMENT '第三方检查单位代码',
  `CHECK_COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '第三方检查单位名称',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '用户ID,指定人时存在',
  `USER_NAME` varchar(50) DEFAULT NULL COMMENT '用户名   ,冗余，便于单表查询',
  `TASK_OBJCT_TYPE` int(11) DEFAULT '0' COMMENT '对象分类   0 单位1指定人',
  `CONFIRM_TIME` varchar(20) DEFAULT NULL COMMENT '认领时间  YYYY-MM-DD HH:MM:SS',
  `CONFIRM_USER_ID` varchar(100) DEFAULT NULL COMMENT '认领用户ID',
  `CONFIRM_USER_NAME` varchar(50) DEFAULT NULL COMMENT '认领用户名',
  `TASK_START_TIME` varchar(20) DEFAULT NULL COMMENT '开始处理时间\r\n            YYYY-MM-DD HH:MM:SS\r\n            第一次处理时间\r\n            ',
  `TASK_END_TIME` varchar(20) DEFAULT NULL COMMENT '完成时间  YYYY-MM-DD HH:MM:SS',
  `HANDLE_TIME` varchar(20) DEFAULT NULL COMMENT '处理时间  ,最近一次处理时间YYYY-MM-DD HH:MM:SS',
  `HANDLE_USER_ID` varchar(100) DEFAULT NULL COMMENT '处理人ID',
  `HANDLE_USER_NAME` varchar(50) DEFAULT NULL COMMENT '处理人名',
  `STATUS` int(11) DEFAULT NULL COMMENT '任务状态(0待认领1已认领处理中2退回，3已完成4已过期)',
  `CHECK_REMARK` text COMMENT '备注',
  `TOTAL_CHECK_NUM` int(11) DEFAULT NULL COMMENT '总共检查项数(对于定制表单无)',
  `FINISHED_CHECK_NUM` int(11) DEFAULT NULL COMMENT '完成检查项数(对于定制表单无)',
  `DANGER_NUM` int(11) DEFAULT NULL COMMENT '隐患数',
  `HANDLE_DANGER_NUM` int(11) DEFAULT NULL COMMENT '整改隐患数',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间(YYYY-MM-DD HH:MM:SS)',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建用户名',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间(YYYY-MM-DD HH:MM:SS)',
  `UPDATE_USER` varchar(50) DEFAULT NULL COMMENT '更新用户名',
  `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '任务类型(该值从字典里面取值 只放DIC_NAME)',
  PRIMARY KEY (`TASK_OBJCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='任务对象表';
