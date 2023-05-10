-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_classInfo` (
  `classNo` varchar(20)  NOT NULL COMMENT 'classNo',
  `className` varchar(40)  NOT NULL COMMENT '班级名称',
  `college` varchar(30)  NOT NULL COMMENT '所属学院',
  `specialName` varchar(30)  NOT NULL COMMENT '所属专业',
  `bornDate` varchar(20)  NULL COMMENT '成立日期',
  `mainTeacher` varchar(20)  NOT NULL COMMENT '班主任',
  `classMemo` varchar(500)  NULL COMMENT '班级备注',
  PRIMARY KEY (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `classObj` varchar(20)  NOT NULL COMMENT '所在班级',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '学生照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(30)  NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_teacher` (
  `teacherNo` varchar(20)  NOT NULL COMMENT 'teacherNo',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `teacherName` varchar(20)  NOT NULL COMMENT '教师姓名',
  `teacherSex` varchar(4)  NOT NULL COMMENT '教师性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `teacherPhoto` varchar(60)  NOT NULL COMMENT '教师照片',
  `zhicheng` varchar(20)  NOT NULL COMMENT '教师职称',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `teacherDesc` varchar(8000)  NOT NULL COMMENT '教师介绍',
  PRIMARY KEY (`teacherNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_subjectType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型编号',
  `typeName` varchar(20)  NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_subject` (
  `subjectId` int(11) NOT NULL AUTO_INCREMENT COMMENT '题目id',
  `subjectName` varchar(40)  NOT NULL COMMENT '题目名称',
  `subjectTypeObj` int(11) NOT NULL COMMENT '题目类型',
  `sujectContent` varchar(8000)  NOT NULL COMMENT '题目内容',
  `taskFile` varchar(60)  NOT NULL COMMENT '任务书文件',
  `otherFile` varchar(60)  NOT NULL COMMENT '其他资料文件',
  `personNum` int(11) NOT NULL COMMENT '限选人数',
  `teacherObj` varchar(20)  NOT NULL COMMENT '指导老师',
  `addTime` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`subjectId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_subSelect` (
  `selectId` int(11) NOT NULL AUTO_INCREMENT COMMENT '选题id',
  `subjectObj` int(11) NOT NULL COMMENT '论文题目',
  `userObj` varchar(30)  NOT NULL COMMENT '选题学生',
  `selectTime` varchar(20)  NULL COMMENT '选题时间',
  `shenHeState` varchar(20)  NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`selectId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_opus` (
  `opusId` int(11) NOT NULL AUTO_INCREMENT COMMENT '成果id',
  `subjectObj` int(11) NOT NULL COMMENT '论文题目',
  `userObj` varchar(30)  NOT NULL COMMENT '提交学生',
  `ktbg` varchar(60)  NOT NULL COMMENT '开题报告',
  `wwwx` varchar(60)  NOT NULL COMMENT '外文文献翻译',
  `lwcg` varchar(60)  NOT NULL COMMENT '论文初稿',
  `lwzg` varchar(60)  NOT NULL COMMENT '论文终稿',
  `otherFile` varchar(60)  NOT NULL COMMENT '其他文件',
  `chengji` varchar(20)  NULL COMMENT '论文成绩',
  `evaluate` varchar(500)  NULL COMMENT '老师评价',
  PRIMARY KEY (`opusId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_video` (
  `videoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '视频id',
  `subjectObj` int(11) NOT NULL COMMENT '论文题目',
  `userObj` varchar(30)  NOT NULL COMMENT '答辩学生',
  `videoFile` varchar(60)  NOT NULL COMMENT '答辩视频',
  `videoTime` varchar(20)  NOT NULL COMMENT '视频时间',
  `videoDate` varchar(20)  NULL COMMENT '答辩日期',
  `videoMemo` varchar(8000)  NULL COMMENT '附加信息',
  PRIMARY KEY (`videoId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(30)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '老师回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻id',
  `title` varchar(80)  NOT NULL COMMENT '新闻标题',
  `content` varchar(5000)  NOT NULL COMMENT '新闻内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_userInfo ADD CONSTRAINT FOREIGN KEY (classObj) REFERENCES t_classInfo(classNo);
ALTER TABLE t_subject ADD CONSTRAINT FOREIGN KEY (subjectTypeObj) REFERENCES t_subjectType(typeId);
ALTER TABLE t_subject ADD CONSTRAINT FOREIGN KEY (teacherObj) REFERENCES t_teacher(teacherNo);
ALTER TABLE t_subSelect ADD CONSTRAINT FOREIGN KEY (subjectObj) REFERENCES t_subject(subjectId);
ALTER TABLE t_subSelect ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_opus ADD CONSTRAINT FOREIGN KEY (subjectObj) REFERENCES t_subject(subjectId);
ALTER TABLE t_opus ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_video ADD CONSTRAINT FOREIGN KEY (subjectObj) REFERENCES t_subject(subjectId);
ALTER TABLE t_video ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


