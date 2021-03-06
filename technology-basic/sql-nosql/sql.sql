-- 
-- 创建 JWGL 数据库
-- 

CREATE DATABASE IF NOT EXISTS JWGL;

USE JWGL;

CREATE TABLE STUDENT (
    SNO CHAR(8) PRIMARY KEY,
    SNAME VARCHAR(10) NOT NULL,
    SSEX CHAR(2) NOT NULL,
    SAGE TINYINT NOT NULL,
    PHONE_NUMBER CHAR(12)
) CHARACTER SET = UTF8;

ALTER TABLE STUDENT ADD SDEPT VARCHAR(20) NOT NULL;

INSERT INTO STUDENT VALUES ('04153088', '韩亦乐', '男', 18, '18829533255', '软件工程系');
INSERT INTO STUDENT VALUES ('04153086', '王力', '男', 18, '15129145794', '软件工程系');
INSERT INTO STUDENT VALUES ('04153087', '石永超', '男', 18, '15529343201', '软件工程系');
INSERT INTO STUDENT VALUES ('04153075', '袁凯明', '男', 18, '15760939122', '软件工程系');
INSERT INTO STUDENT VALUES ('04153089', '刘陈诚', '男', 18, '18090743691', '软件工程系');
INSERT INTO STUDENT VALUES ('04153090', '艾尔肯', '男', 18, '13289227071', '软件工程系');
INSERT INTO STUDENT VALUES ('04153097', '古丽拜尔', '女', 18, '13201626806', '软件工程系');

CREATE TABLE COURSE (
    CNO CHAR(10) PRIMARY KEY,
    CNAME VARCHAR(20) NOT NULL UNIQUE,
    TOTAL_PERIOR TINYINT,
    WEEK_PERIOR TINYINT,
    CREDIT TINYINT NOT NULL,
    CPNO CHAR(10)
) CHARACTER SET = UTF8;

INSERT INTO COURSE VALUES ('001', '数据库原理及应用A', 64, 4, 4.0, '001');
INSERT INTO COURSE VALUES ('002', '软件工程', 64, 4, 4.0, '002');
INSERT INTO COURSE VALUES ('003', '算法设计与分析A', 48, 3, 3.0, '003');
INSERT INTO COURSE VALUES ('004', '人机界面设计', 48, 3, 3.0, '004');
INSERT INTO COURSE VALUES ('005', '数字电路与逻辑设计B', 48, 3, 3.0, '005');
INSERT INTO COURSE VALUES ('006', '数学建模B', 48, 3, 3.0, '006');

CREATE TABLE SC (
    SNO CHAR(8) NOT NULL,
    CNO CHAR(10) NOT NULL,
    GRADE SMALLINT,
    PRIMARY KEY (SNO, CNO),
    FOREIGN KEY (SNO) REFERENCES STUDENT (SNO),
    FOREIGN KEY (CNO) REFERENCES COURSE (CNO)
) CHARACTER SET = UTF8;

INSERT INTO SC VALUES ('04153088', '001', 100);
INSERT INTO SC VALUES ('04153088', '002', 100);
INSERT INTO SC VALUES ('04153086', '001', 100);
INSERT INTO SC VALUES ('04153086', '002', 100);
INSERT INTO SC VALUES ('04153087', '001', 100);
INSERT INTO SC VALUES ('04153087', '002', 100);
INSERT INTO SC VALUES ('04153075', '001', 100);
INSERT INTO SC VALUES ('04153075', '002', 100);
INSERT INTO SC VALUES ('04153089', '001', 100);
INSERT INTO SC VALUES ('04153089', '002', 100);
INSERT INTO SC VALUES ('04153090', '001', 100);
INSERT INTO SC VALUES ('04153090', '002', 100);
INSERT INTO SC VALUES ('04153097', '001', 100);
INSERT INTO SC VALUES ('04153097', '002', 100);

UPDATE STUDENT SET SNAME = '凝尘'
WHERE SNAME = '韩亦乐';

UPDATE STUDENT SET SNAME = '韩亦乐'
WHERE SNAME = '凝尘';

SELECT SNO, SNAME, SDEPT
FROM STUDENT;

SELECT *
FROM STUDENT;

SELECT SNAME, 2015 - SAGE
FROM STUDENT;

SELECT SNAME, 'YEAR OF BIRTH', 2015 - SAGE
FROM STUDENT;

SELECT SNAME, 2015 - SAGE BIRTHDAY
FROM STUDENT;

SELECT SNO, SNAME, LOWER (SDEPT)
FROM STUDENT;

SELECT DISTINCT SNO
FROM SC;

SELECT SNO, SNAME
FROM STUDENT
WHERE SDEPT = '软件工程系';

SELECT DISTINCT SNO
FROM SC
WHERE NOT GRADE < 60;

SELECT SNAME, SDEPT, SAGE
FROM STUDENT
WHERE SAGE BETWEEN 18 AND 22;

SELECT SNAME, SDEPT, SAGE
FROM STUDENT
WHERE SAGE >= 18 AND SAGE <= 22;

SELECT SNAME, SAGE
FROM STUDENT
WHERE SDEPT IN ('软件工程系', '网络工程系', '计算机科学系');

SELECT SNAME, SAGE
FROM STUDENT
WHERE SDEPT = '软件工程系' OR SDEPT = '网络工程系' OR SDEPT = '计算机科学系';

SELECT SNAME, SAGE
FROM STUDENT
WHERE SDEPT NOT IN ('网络工程系', '计算机科学系');

SELECT *
FROM STUDENT
WHERE SDEPT LIKE '软件工程系';

SELECT SNAME, SNO, SSEX
FROM STUDENT
WHERE SDEPT LIKE '软%工%';

SELECT SNO, CNO
FROM SC
WHERE NOT GRADE IS NULL;

SELECT SNO, SNAME, SSEX
FROM STUDENT
WHERE SDEPT = '软件工程系' AND SAGE <= 18;

SELECT SNO, GRADE
FROM SC
WHERE CNO = '001'
ORDER BY SNO DESC;

SELECT *
FROM STUDENT
ORDER BY SNO, SNAME DESC;

-- 聚集函数

SELECT AVG(SNO)
AS '平均学号'
FROM STUDENT
WHERE SSEX = '男';

SELECT MIN(SNO)
AS '最低学号'
FROM STUDENT
WHERE SSEX = '女';

SELECT MAX(GRADE)
AS '课程号为 001 的最高分'
FROM SC
WHERE CNO = '001';

SELECT SUM(GRADE)
AS '课程号为 002 的分数总和'
FROM SC
WHERE CNO = '002';

SELECT COUNT(*)
AS '所有学生总人数'
FROM STUDENT;

SELECT COUNT(DISTINCT SNO)
AS '选修了课程的学生人数'
FROM SC;

-- 查询结果分组

SELECT CNO, COUNT(SNO)
FROM SC
GROUP BY CNO;

SELECT SNO
FROM SC
WHERE GRADE >= 90
GROUP BY SNO
HAVING COUNT(*) >= 2;

-- 连接查询

SELECT STUDENT.*, SC.*
FROM STUDENT, SC
WHERE STUDENT.SNO = SC.SNO;

SELECT STUDENT.SNO, SNAME, SSEX, SAGE, SDEPT, CNO, GRADE
FROM STUDENT, SC
WHERE STUDENT.SNO = SC.SNO;

SELECT FIRST.CNO, SECOND.CPNO
FROM COURSE FIRST, COURSE SECOND
WHERE FIRST.CPNO = SECOND.CNO;

SELECT STUDENT.SNO, SNAME, SSEX, SAGE, SDEPT, CNO, GRADE
FROM STUDENT LEFT OUTER JOIN SC
ON STUDENT.SNO = SC.SNO;

SELECT STUDENT.SNO, SNAME
FROM STUDENT, COURSE, SC
WHERE STUDENT.SNO = SC.SNO AND SC.CNO = COURSE.CNO AND CNAME = '数据库原理及应用A' AND GRADE > 90;

SELECT STUDENT.SNAME
FROM STUDENT
INNER JOIN SC
ON STUDENT.SNO = SC.SNO;

-- 嵌套查询

-- 3.40 查询选修了 001 号课程的学生的姓名

SELECT SNAME
FROM STUDENT
WHERE SNO IN (
    SELECT SNO
    FROM SC
    WHERE CNO = '001'
);

SELECT SNAME
FROM STUDENT, SC
WHERE CNO = '001' AND STUDENT.SNO = SC.SNO;

-- 3.41 查询和张明在同一个系学习的学生的学号和姓名

SELECT SNO AS '学号', SNAME AS '姓名'
FROM STUDENT
WHERE SDEPT = (
    SELECT SDEPT
    FROM STUDENT
    WHERE SNAME = '韩亦乐'
);

-- 3.42 查询除了网络工程系中比软件工程系某一学生年龄小的学生姓名和年龄

SELECT SNAME SAGE
FROM STUDENT
WHERE SDEPT <> '网络工程系'
    AND SAGE <= (
            SELECT MAX(SAGE)
            FROM STUDENT
            WHERE SDEPT = '软件工程系'
        );

-- 3.43 查询每个学生超过他所选课程平均成绩的课程号

SELECT SNO, CNO
FROM SC X
WHERE GRADE >= (
    SELECT AVG(GRADE)
    FROM SC Y
    WHERE Y.CNO = X.CNO
);

-- 3.44 查询所有选修了 3 号课程的学生的姓名

SELECT SNAME
FROM STUDENT
WHERE EXISTS (
    SELECT *
    FROM SC
    WHERE SNO = STUDENT.SNO AND CNO = '001'
);

-- 3.45 查询选修了全部课程的学生姓名

SELECT SNAME
FROM STUDENT
WHERE NOT EXISTS (
    SELECT *
    FROM COURSE
    WHERE NOT EXISTS (
        SELECT *
        FROM SC
        WHERE SNO = STUDENT.SNO AND CNO = COURSE.CNO
    )
);

-- 3.46 查询至少选修了学生 '04153088' 选修的全部课程的学生学号

SELECT DISTINCT SNO
FROM SC SCX
WHERE NOT EXISTS (
    SELECT *
    FROM SC SCY
    WHERE SCY.SNO = '04153088' AND NOT EXISTS (
        SELECT *
        FROM SC SCZ
        WHERE SCZ.SNO = SCX.SNO AND SCZ.CNO = SCY.CNO
    )
);

-- 集合查询

-- 查询选修了 001 号课程或 002 号课程的所有学生的学号

SELECT SNO
FROM SC
WHERE CNO = '001'
UNION
SELECT SNO
FROM SC
WHERE CNO = '002';

-- 
-- 创建 MARKET 数据库
-- 

CREATE DATABASE IF NOT EXISTS MARKET;

USE MARKET;

CREATE TABLE CUSTOMERS (
    CUSTOMER_ID INT PRIMARY KEY,
    -- CUSTOMER_ID INT INENTITY(1,1) PRIMARY KEY,
    CNAME VARCHAR(8) NOT NULL,
    ADDRESS VARCHAR(50),
    CITY VARCHAR(10),
    TEL VARCHAR(20) UNIQUE,
    COMPANY VARCHAR(50),
    BIRTHDAY DATETIME,
    TYPE TINYINT DEFAULT 1
) CHARACTER SET = UTF8;

INSERT INTO CUSTOMERS VALUES (1, '韩亦乐', '陕西省西安邮电大学长安校区东区', '陕西西安', '18829533255', '西安邮电大学', '1997-10-09', 1);
INSERT INTO CUSTOMERS VALUES (2, '王力', '陕西省西安邮电大学长安校区东区', '陕西西安', '15129145794', '西安邮电大学', '1996-09-05', 1);
INSERT INTO CUSTOMERS VALUES (3, '石永超', '陕西省西安邮电大学长安校区东区', '陕西西安', '15529343201', '西安邮电大学', '1996-03-03', 1);

CREATE TABLE GOODS (
    GOODS_ID INT PRIMARY KEY,
    -- GOODS_ID INT CONSTRAINT C1 PRIMARY KEY,
    GOODS_NAME VARCHAR(20) NOT NULL,
    PRICE FLOAT(16, 2),
    DESCRIPTION VARCHAR(200),
    STORAGE INT,
    PROVIDER VARCHAR(50),
    STATUS TINYINT DEFAULT 0
) CHARACTER SET = UTF8;

INSERT INTO GOODS() VALUES (1, '矿泉水', 1.0, '用来喝', 999, '韩亦乐', 0);
INSERT INTO GOODS() VALUES (2, '面包', 2.00, '用来吃', 999, '韩亦乐', 0);
INSERT INTO GOODS() VALUES (3, '可乐', 3.00, '用来喝', 999, '韩亦乐', 0);

CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY,
    -- ORDER_ID INT CONSTRAINT C2 PRIMARY KEY,
    CUSTOMER_ID INT NOT NULL,
    GOODS_ID INT NOT NULL,
    QUANTITY INT NOT NULL CHECK (QUANTITY > 0),
    -- QUANTITY INT NOT NULL CONSTRAINT C3 CHECK(QUANTITY > 0),
    ORDER_SUM FLOAT(16, 2) NOT NULL,
    ORDER_DATE DATETIME DEFAULT NOW(),
    FOREIGN KEY (GOODS_ID) REFERENCES GOODS (GOODS_ID),
    -- FOREIGN KEY(CUSTOMER_ID) REFERENCES GOODS (GOODS_ID) ON DELETE CASCADE,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID)
    -- FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID) ON DELETE NO ACTION
) CHARACTER SET = UTF8;

INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (1, 1, 1, 9.00, 9.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (2, 1, 2, 9.00, 18.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (3, 1, 3, 9.00, 27.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (4, 2, 1, 9.00, 9.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (5, 2, 2, 9.00, 18.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (6, 2, 3, 9.00, 27.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (7, 3, 1, 9.00, 9.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (8, 3, 2, 9.00, 18.00);
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, GOODS_ID, QUANTITY, ORDER_SUM) VALUES (9, 3, 3, 9.00, 27.00);

SELECT *
FROM CUSTOMERS
WHERE CITY = '陕西西安';

-- 
-- 创建 SPJ 数据库
-- 

CREATE DATABASE IF NOT EXISTS SPJ;

USE SPJ;

CREATE TABLE S (
    SNO CHAR(8) PRIMARY KEY,
    SNAME VARCHAR(20) NOT NULL,
    STATUS TINYINT NOT NULL,
    CITY VARCHAR(20) NOT NULL
) CHARACTER SET = UTF8;

INSERT INTO S VALUES ('S1', '精益', 10, '北京');
INSERT INTO S VALUES ('S2', '东方红', 20, '天津');
INSERT INTO S VALUES ('S3', '群众', 30, '北京');
INSERT INTO S VALUES ('S4', '大众', 20, '上海');
INSERT INTO S VALUES ('S5', '为民', 30, '天津');

CREATE TABLE P (
    PNO CHAR(8) PRIMARY KEY,
    PNAME VARCHAR(20) NOT NULL,
    COLOR VARCHAR(10) NOT NULL,
    WEIGHT INT NOT NULL
) CHARACTER SET = UTF8;

INSERT INTO P VALUES ('P1', '螺母', '红', 13);
INSERT INTO P VALUES ('P2', '螺栓', '红', 16);
INSERT INTO P VALUES ('P3', '螺丝刀', '红', 15);
INSERT INTO P VALUES ('P4', '螺丝刀', '红', 15);
INSERT INTO P VALUES ('P5', '凸轮', '红', 30);
INSERT INTO P VALUES ('P6', '齿轮', '红', 30);

CREATE TABLE J (
    JNO CHAR(8) PRIMARY KEY,
    JNAME VARCHAR(20) NOT NULL,
    CITY VARCHAR(20) NOT NULL
) CHARACTER SET = UTF8;

INSERT INTO J VALUES ('J1', '三建', '北京');
INSERT INTO J VALUES ('J2', '一汽', '长春');
INSERT INTO J VALUES ('J3', '弹簧厂', '天津');
INSERT INTO J VALUES ('J4', '机车厂', '北京');
INSERT INTO J VALUES ('J5', '无线电厂', '福州');
INSERT INTO J VALUES ('J6', '半导体厂', '上海');
INSERT INTO J VALUES ('J7', '重机厂', '太原');

CREATE TABLE SPJ (
    SNO CHAR(8),
    PNO CHAR(8),
    JNO CHAR(8),
    QTY INT NOT NULL,
    FOREIGN KEY (SNO) REFERENCES S (SNO),
    FOREIGN KEY (PNO) REFERENCES P (PNO),
    FOREIGN KEY (JNO) REFERENCES J (JNO)
) CHARACTER SET = UTF8;

INSERT INTO SPJ VALUES ('S1', 'P1', 'J1', 200);
INSERT INTO SPJ VALUES ('S1', 'P1', 'J2', 200);
INSERT INTO SPJ VALUES ('S1', 'P1', 'J4', 200);
INSERT INTO SPJ VALUES ('S1', 'P2', 'J3', 200);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J1', 200);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J2', 200);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J5', 200);
INSERT INTO SPJ VALUES ('S2', 'P5', 'J1', 200);
INSERT INTO SPJ VALUES ('S2', 'P5', 'J2', 200);
INSERT INTO SPJ VALUES ('S3', 'P1', 'J1', 200);
INSERT INTO SPJ VALUES ('S3', 'P3', 'J1', 200);
INSERT INTO SPJ VALUES ('S4', 'P5', 'J1', 200);
INSERT INTO SPJ VALUES ('S4', 'P5', 'J3', 200);
INSERT INTO SPJ VALUES ('S4', 'P6', 'J4', 200);
INSERT INTO SPJ VALUES ('S5', 'P2', 'J3', 200);
INSERT INTO SPJ VALUES ('S5', 'P3', 'J1', 200);
INSERT INTO SPJ VALUES ('S5', 'P6', 'J2', 200);
INSERT INTO SPJ VALUES ('S5', 'P6', 'J5', 200);

-- 
-- 创建 TSGL 数据库
-- 

CREATE DATABASE IF NOT EXISTS TSGL;

USE TSGL;

CREATE TABLE BOOK (
    BNO CHAR(20) PRIMARY KEY,
    BNAME VARCHAR(20) NOT NULL,
    CLASS VARCHAR(20) NOT NULL,
    AUTHOR VARCHAR(20) NOT NULL,
    PRICE FLOAT(16, 2) NOT NULL,
    PUBLISH_DATE DATETIME DEFAULT NOW()
) CHARACTER SET = UTF8;

INSERT INTO BOOK (BNO, BNAME, CLASS, AUTHOR, PRICE) VALUES (1, '数据库系统原理与应用', '数据库', '孟彩霞', 26.00);
INSERT INTO BOOK (BNO, BNAME, CLASS, AUTHOR, PRICE) VALUES (2, '软件工程', '软件工程', '萨默维尔', 55.50);
INSERT INTO BOOK (BNO, BNAME, CLASS, AUTHOR, PRICE) VALUES (3, '算法设计与分析A', '算法', '王晓东', 31.80);

CREATE TABLE READER (
    RNO CHAR(20) PRIMARY KEY,
    RNAME VARCHAR(20) NOT NULL,
    UNIT VARCHAR(20) NOT NULL,
    SEX CHAR(2) NOT NULL,
    ADDRESS VARCHAR(50) NOT NULL,
    TEL VARCHAR(20) NOT NULL
) CHARACTER SET = UTF8;

INSERT INTO READER VALUES ('04153088', '韩亦乐', '西安邮电大学', '男', '陕西省西安邮电大学长安校区东区', '18829533255');
INSERT INTO READER VALUES ('04153086', '王力', 'x西安邮电大学', '男', '陕西省西安邮电大学长安校区东区', '15129145794');
INSERT INTO READER VALUES ('04153087', '石永超', '西安邮电大学', '男', '陕西省西安邮电大学长安校区东区', '15529343201');

CREATE TABLE BORROW (
    BNO CHAR(20) NOT NULL,
    RNO CHAR(20) NOT NULL,
    BORROW_DATE DATETIME DEFAULT NOW(),
    PRIMARY KEY (BNO, RNO),
    FOREIGN KEY (BNO) REFERENCES BOOK (BNO),
    FOREIGN KEY (RNO) REFERENCES READER (RNO)
) CHARACTER SET = UTF8;

INSERT INTO BORROW (BNO, RNO) VALUES (1, '04153088');
INSERT INTO BORROW (BNO, RNO) VALUES (2, '04153088');
INSERT INTO BORROW (BNO, RNO) VALUES (3, '04153088');
INSERT INTO BORROW (BNO, RNO) VALUES (1, '04153086');
INSERT INTO BORROW (BNO, RNO) VALUES (2, '04153086');
INSERT INTO BORROW (BNO, RNO) VALUES (3, '04153086');
INSERT INTO BORROW (BNO, RNO) VALUES (1, '04153087');
INSERT INTO BORROW (BNO, RNO) VALUES (2, '04153087');
INSERT INTO BORROW (BNO, RNO) VALUES (3, '04153087');


-- 存储过程和触发器



