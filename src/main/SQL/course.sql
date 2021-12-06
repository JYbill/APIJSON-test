/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 127.0.0.1:3306
 Source Schema         : course

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 06/12/2021 17:18:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `debug` tinyint NOT NULL DEFAULT 0 COMMENT '是否为调试表，只允许在开发环境使用，测试和线上环境禁用',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实际表名，例如 apijson_user',
  `alias` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部调用的表别名，例如 User',
  `get` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]' COMMENT '允许 get 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]\n用 JSON 类型不能设置默认值，反正权限对应的需求是明确的，也不需要自动转 JSONArray。\nTODO: 直接 LOGIN,CONTACT,CIRCLE,OWNER 更简单，反正是开发内部用，不需要复杂查询。',
  `head` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]' COMMENT '允许 head 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]',
  `gets` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]' COMMENT '允许 gets 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]',
  `heads` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]' COMMENT '允许 heads 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"OWNER\", \"ADMIN\"]' COMMENT '允许 post 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]',
  `put` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"OWNER\", \"ADMIN\"]' COMMENT '允许 put 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]',
  `delete` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[\"OWNER\", \"ADMIN\"]' COMMENT '允许 delete 的角色列表，例如 [\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\"]',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `detail` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE,
  UNIQUE INDEX `alias_UNIQUE`(`alias`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限配置(必须)' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (1, 0, 'User', NULL, '[\"UNKNOWN\",\"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\",\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '2021-07-28 22:02:41', '可公开用户表');
INSERT INTO `access` VALUES (2, 0, 'Credential', NULL, '[\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\",\"LOGIN\",\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"ADMIN\"]', '2021-07-28 22:04:01', '用户凭证表');
INSERT INTO `access` VALUES (3, 0, 'Classroom', NULL, '[\"UNKNOWN\",\"LOGIN\",\"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\",\"LOGIN\",\"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"ADMIN\"]', '[\"ADMIN\"]', '[\"ADMIN\"]', '2021-07-28 22:02:41', '教室表');
INSERT INTO `access` VALUES (5, 0, 'Function', NULL, '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[]', '[]', '[]', '2018-11-29 00:38:15', '框架本身需要');
INSERT INTO `access` VALUES (6, 0, 'Comment', NULL, '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"OWNER\",\"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '2021-12-01 17:04:07', '评论表');
INSERT INTO `access` VALUES (7, 0, 'Course', NULL, '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"TEACHER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '[\"OWNER\", \"ADMIN\"]', '2021-12-02 19:36:41', '课程表');
INSERT INTO `access` VALUES (8, 0, 'Message', NULL, '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"UNKNOWN\", \"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"LOGIN\", \"CONTACT\", \"CIRCLE\", \"OWNER\", \"ADMIN\"]', '[\"ADMIN\"]', '[\"ADMIN\"]', '[\"ADMIN\"]', '2021-12-02 19:37:11', '活动信息表');

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom`  (
  `id` bigint NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教室房间号',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教室描述',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '教室状态:[0:空闲,1:正在使用]',
  `courseId` bigint NULL DEFAULT NULL COMMENT '课程id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of classroom
-- ----------------------------
INSERT INTO `classroom` VALUES (1, '2021-12-02 14:55:58', '2021-12-05 19:59:42', '魔法1班', '精通水系魔法, 中介魔法预备班', 0, 0);
INSERT INTO `classroom` VALUES (2, '2021-12-02 14:55:58', '2021-12-02 14:56:01', '专属教室2', '专属教室2', 0, 0);
INSERT INTO `classroom` VALUES (3, '2021-12-02 14:55:58', '2021-12-02 14:56:01', '专属教室3', '专属教室3', 0, 0);
INSERT INTO `classroom` VALUES (4, '2021-12-02 14:55:58', '2021-12-02 14:56:01', '专属教室4', '专属教室4', 1, 4);
INSERT INTO `classroom` VALUES (5, '2021-12-02 14:55:58', '2021-12-02 14:56:01', '专属教室5', '专属教室5', 1, 5);
INSERT INTO `classroom` VALUES (6, '2021-12-02 14:55:58', '2021-12-02 14:56:01', '专属教室6', '专属教室6', 0, 0);
INSERT INTO `classroom` VALUES (7, '2021-12-03 17:37:35', '2021-12-03 17:37:43', 'VIP教室1', 'VIP专属教室...', 1, 6);
INSERT INTO `classroom` VALUES (1638529004696, '2021-12-03 18:56:42', '2021-12-03 18:56:42', '好丽友教室', NULL, 1, 1638683401766);
INSERT INTO `classroom` VALUES (1638536712073, '2021-12-03 21:05:12', '2021-12-03 21:05:12', '好丽友教室', NULL, 0, 0);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `userId` bigint NULL DEFAULT NULL COMMENT '用户id',
  `courseId` bigint NULL DEFAULT NULL COMMENT '课程id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1638778443325, '2021-12-06 16:14:03', '2021-12-06 16:30:36', 'admin修改评论测试...', 2, 4);
INSERT INTO `comment` VALUES (1638778483529, '2021-12-06 16:14:44', '2021-12-06 16:14:44', '哈哈哈哈, 很好的一节课', 2, 4);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` bigint NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT NULL,
  `userId` bigint NOT NULL COMMENT '老师id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程描述',
  `start_date` datetime NOT NULL COMMENT '课程开始时间',
  `end_date` datetime NOT NULL COMMENT '课程结束时间',
  `classroomId` bigint NOT NULL COMMENT '教室id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (4, '2021-12-02 14:51:38', '2021-12-02 14:51:40', 1, '测试课程2', '测试2', '2021-12-14 14:55:05', '2021-12-14 17:55:10', 4);
INSERT INTO `course` VALUES (5, '2021-12-02 14:51:38', '2021-12-02 14:51:40', 1, '测试课程3', '测试3', '2021-12-13 14:55:05', '2021-12-13 17:55:10', 5);
INSERT INTO `course` VALUES (6, '2021-12-02 14:51:38', '2021-12-05 16:01:42', 1, '测试修改课程哈哈哈', '测试描述1', '2021-12-06 00:00:00', '2021-12-07 00:00:00', 7);
INSERT INTO `course` VALUES (1638683401766, '2021-12-05 13:50:02', '2021-12-05 15:33:29', 1, '测试修改课程', '测试描述', '2021-12-05 00:00:00', '2021-12-06 00:00:00', 1638529004696);

-- ----------------------------
-- Table structure for credential
-- ----------------------------
DROP TABLE IF EXISTS `credential`;
CREATE TABLE `credential`  (
  `id` bigint NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `userId` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of credential
-- ----------------------------
INSERT INTO `credential` VALUES (1, '2021-12-02 15:00:48', '2021-12-02 15:00:50', '123456', 1);
INSERT INTO `credential` VALUES (2, '2021-12-02 15:00:57', '2021-12-02 15:00:59', '111111', 2);
INSERT INTO `credential` VALUES (3, '2021-12-02 15:00:57', '2021-12-02 15:00:59', '111112', 3);
INSERT INTO `credential` VALUES (4, '2021-12-02 15:00:57', '2021-12-02 15:00:59', '888888', 4);
INSERT INTO `credential` VALUES (5, '2021-12-02 15:00:57', '2021-12-02 15:00:59', '000000', 5);
INSERT INTO `credential` VALUES (1638777086944, '2021-12-06 15:51:19', '2021-12-06 15:51:19', '111111', 1638777078788);

-- ----------------------------
-- Table structure for function
-- ----------------------------
DROP TABLE IF EXISTS `function`;
CREATE TABLE `function`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userId` bigint NOT NULL COMMENT '管理员用户Id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法名',
  `arguments` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数列表，每个参数的类型都是 String。\n用 , 分割的字符串 比 [JSONArray] 更好，例如 array,item ，更直观，还方便拼接函数。',
  `demo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '可用的示例。\nTODO 改成 call，和返回值示例 back 对应。',
  `detail` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细描述',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Object' COMMENT '返回值类型。TODO RemoteFunction 校验 type 和 back',
  `version` tinyint NOT NULL DEFAULT 0 COMMENT '允许的最低版本号，只限于GET,HEAD外的操作方法。\nTODO 使用 requestIdList 替代 version,tag,methods',
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许的标签.\nnull - 允许全部\nTODO 使用 requestIdList 替代 version,tag,methods',
  `methods` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许的操作方法。\nnull - 允许全部\nTODO 使用 requestIdList 替代 version,tag,methods',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `back` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返回值示例',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '远程函数。强制在启动时校验所有demo是否能正常运行通过' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of function
-- ----------------------------
INSERT INTO `function` VALUES (1, 0, 'updateClassroom', 'id', '{\"id\":0}', '课程关联教室', 'Object', 0, NULL, NULL, '2021-07-28 20:04:27', NULL);
INSERT INTO `function` VALUES (10, 0, 'countArray', 'array', '{\"array\": [1, 2, 3]}', '（框架启动自检需要）获取数组长度。没写调用键值对，会自动补全 \"result()\": \"countArray(array)\"', 'Object', 0, NULL, NULL, '2018-10-13 16:23:23', NULL);
INSERT INTO `function` VALUES (11, 0, 'isContain', 'array,value', '{\"array\": [1, 2, 3], \"value\": 2}', '（框架启动自检需要）判断是否数组包含值。', 'Object', 0, NULL, NULL, '2018-10-13 16:23:23', NULL);
INSERT INTO `function` VALUES (12, 0, 'getFromArray', 'array,position', '{\"array\": [1, 2, 3], \"result()\": \"getFromArray(array,1)\"}', '（框架启动自检需要）根据下标获取数组里的值。position 传数字时直接作为值，而不是从所在对象 request 中取值', 'Object', 0, NULL, NULL, '2018-10-13 16:30:31', NULL);
INSERT INTO `function` VALUES (13, 0, 'getFromObject', 'object,key', '{\"key\": \"id\", \"object\": {\"id\": 1}}', '（框架启动自检需要）根据键获取对象里的值。', 'Object', 0, NULL, NULL, '2018-10-13 16:30:31', NULL);
INSERT INTO `function` VALUES (14, 0, 'clearClassRoomBefore', 'id', '{\"id\": 0}', '清除教室状态为空闲(id为课程ID)', 'Object', 0, NULL, NULL, '2021-12-05 14:33:42', NULL);
INSERT INTO `function` VALUES (15, 0, 'clearClassRoomAfter', 'id', '{\"id\": 0}', '添加教室后设置信息(id为课程ID)', 'Object', 0, NULL, NULL, '2021-12-05 15:13:57', NULL);
INSERT INTO `function` VALUES (16, 0, 'registerFunc', 'account,nikename,password', '{\"account\":\"\",\"nikename\":\"\",\"password\":\"\"}', '注册账号', 'Object', 0, NULL, NULL, '2021-12-06 14:54:09', NULL);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` bigint NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息标题',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息描述',
  `courseId` json NULL COMMENT '课程id(JSON数组)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1638707124124, '2021-12-05 20:25:24', '2021-12-06 14:03:57', 'VIP通知', '推荐课程', '[1, 2, 3]');

-- ----------------------------
-- Table structure for request
-- ----------------------------
DROP TABLE IF EXISTS `request`;
CREATE TABLE `request`  (
  `id` bigint NOT NULL COMMENT '唯一标识',
  `version` tinyint NOT NULL DEFAULT 1 COMMENT 'GET,HEAD可用任意结构访问任意开放内容，不需要这个字段。\n其它的操作因为写入了结构和内容，所以都需要，按照不同的version选择对应的structure。\n\n自动化版本管理：\nRequest JSON最外层可以传  “version”:Integer 。\n1.未传或 <= 0，用最新版。 “@order”:”version-“\n2.已传且 > 0，用version以上的可用版本的最低版本。 “@order”:”version+”, “version{}”:”>={version}”',
  `method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'GETS' COMMENT '只限于GET,HEAD外的操作方法。',
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签',
  `structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '结构。\nTODO 里面的 PUT 改为 UPDATE，避免和请求 PUT 搞混。',
  `detail` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细说明',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '请求参数校验配置(必须)。\n最好编辑完后删除主键，这样就是只读状态，不能随意更改。需要更改就重新加上主键。\n\n每次启动服务器时加载整个表到内存。\n这个表不可省略，model内注解的权限只是客户端能用的，其它可以保证即便服务端代码错误时也不会误删数据。' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of request
-- ----------------------------
INSERT INTO `request` VALUES (1, 1, 'POST', 'addClassRoom', '{\"Classroom\": {\"MUST\": \"name\",\"INSERT\":{\"@role\":\"ADMIN\"}}}', '添加教室(ADMIN)', '2021-07-29 02:15:40');
INSERT INTO `request` VALUES (2, 1, 'POST', '+course', '{\"Course\": {\"MUST\": \"name,start_date,end_date,classroomId\",\"REFUSE\": \"id\",\"UPDATE\": {\"@role\": \"TEACHER\",\"updateClassroomCourse()\": \"updateClassroom(id)\"}}}', '添加课程并且选择教室(TEACHER)', '2021-12-04 14:53:20');
INSERT INTO `request` VALUES (3, 1, 'PUT', 'updSelfInfo', '{\"User\": {\"MUST\": \"nikename\", \"REFUSE\": \"create_date,update_date,account,role\",\"INSERT\":{\"@role\": \"OWNER\"}}}', '修改个人信息(OWNER/ADMIN)', '2021-12-05 14:03:01');
INSERT INTO `request` VALUES (4, 1, 'PUT', 'updSelfCourse', '{\"Course\": {\"MUST\": \"id,name,description,start_date,end_date,classroomId\", \"REFUSE\": \"create_date,update_date,userId\", \"INSERT\": {\"@role\": \"OWNER\"}, \"UPDATE\": {\"clearClassRoomBefore-()\": \"clearClassRoomBefore(id)\", \"clearClassRoomAfter+()\": \"clearClassRoomAfter(id)\"}}}', '修改课程信息(TEACHER/ADMIN)', '2021-12-05 14:31:11');
INSERT INTO `request` VALUES (5, 1, 'DELETE', 'delSelfCourse', '{\"Course\":{\"MUST\":\"id\",\"INSERT\":{\"@role\":\"OWNER\"},\"UPDATE\":{\"clearClassRoomBefore-()\":\"clearClassRoomBefore(id)\"}}}', '删除课程信息(TEACHER/ADMIN)', '2021-12-05 15:38:41');
INSERT INTO `request` VALUES (6, 1, 'PUT', 'updClassroom', '{\"Classroom\":{\"MUST\":\"id,name,description\",\"REFUSE\":\"status,courseId,create_date,update_date\",\"UPDATE\":{\"@role\":\"ADMIN\"}}}', '修改教室信息(ADMIN)', '2021-12-05 19:54:48');
INSERT INTO `request` VALUES (7, 1, 'DELETE', 'delClassroom', '{\"Classroom\":{\"MUST\":\"id\",\"UPDATE\":{\"@role\":\"ADMIN\"}}}', '删除教室(ADMIN)', '2021-12-05 20:01:50');
INSERT INTO `request` VALUES (8, 1, 'POST', '+msg', '{\"Message\":{\"MUST\":\"title\",\"REFUSE\":\"id,create_date,update_date\",\"UPDATE\":{\"@role\":\"ADMIN\"}}}', '添加公共信息(ADMIN)', '2021-12-05 20:18:57');
INSERT INTO `request` VALUES (9, 1, 'DELETE', '-msg', '{\"Message\":{\"MUST\":\"id\",\"UPDATE\":{\"@role\":\"ADMIN\"}}}', '删除公共信息(ADMIN)', '2021-12-06 12:37:58');
INSERT INTO `request` VALUES (10, 1, 'PUT', 'updMsg', '{\"Message\":{\"MUST\":\"id,title\",\"REFUSE\":\"create_date,update_date\",\"TYPE\":{\"courseId+\":\"NUMBER[]\"},\"UPDATE\":{\"@role\":\"ADMIN\"}}}', '更新公共信息(ADMIN)', '2021-12-06 13:04:08');
INSERT INTO `request` VALUES (11, 1, 'POST', 'register', '{\"MUST\":\"account, nikename, password\",\"TYPE\":{\"account\":\"STRING\",\"nikename\":\"STRING\",\"password\":\"STRING\"},\"UPDATE\":{\"registerFunc-()\":\"registerFunc(account,nikename,password)\"}}', '注册账号', '2021-12-06 14:37:16');
INSERT INTO `request` VALUES (12, 1, 'POST', '+comment', '{\"Comment\":{\"MUST\":\"content, userId, courseId\",\"REFUSE\":\"id\",\"UPDATE\":{\"@role\":\"OWNER\"}}}', '用户评论(OWNER)', '2021-12-06 16:02:29');
INSERT INTO `request` VALUES (13, 1, 'DELETE', '-comment', '{\"Comment\":{\"MUST\":\"id, userId\",\"UPDATE\":{\"@role\":\"OWNER\"}}}', '用户删除评论(OWNER)', '2021-12-06 16:15:10');
INSERT INTO `request` VALUES (14, 1, 'PUT', 'updComment', '{\"Comment\":{\"MUST\":\"id, content\",\"REFUSE\":\"userId, create_date, update_date, courseId\",\"INSERT\":{\"@role\":\"OWNER\"}}}', '更新评论(OWNER)', '2021-12-06 16:19:21');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT NULL,
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nikename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `courseId` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '课程id',
  `role` int NOT NULL COMMENT '[1:普通用户,2:教师,3:管理员]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2021-12-02 14:49:50', '2021-12-05 14:19:30', '123456', '小明TEACHER', '[1638683401766,1638768709947]', 1);
INSERT INTO `user` VALUES (2, '2021-12-02 14:49:50', '2021-12-02 14:49:53', '234567', '小东', NULL, 0);
INSERT INTO `user` VALUES (3, '2021-12-02 14:49:50', '2021-12-02 14:49:53', '098767', '小洋', NULL, 0);
INSERT INTO `user` VALUES (4, '2021-12-02 14:49:50', '2021-12-02 14:49:53', '888888', '小黑', NULL, 2);
INSERT INTO `user` VALUES (5, '2021-12-02 14:49:50', '2021-12-02 14:49:53', '098989', '小白', NULL, 0);
INSERT INTO `user` VALUES (1638777078788, '2021-12-06 15:51:19', '2021-12-06 15:51:19', '111111', '小青蛙', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
