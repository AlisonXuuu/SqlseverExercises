CREATE TABLE Students(
  Sno char(7) PRIMARY KEY,
  Sname char(10) NOT NULL,
  Ssex char(2) CHECK(Ssex = '男' OR Ssex = '女'),
  Sage tinyint,
  CHECK(Sage >= 15 OR Sage <= 45),
  Sdept nvarchar(20) DEFAULT '计算机系',
  Ssid char(10) UNIQUE,
  Sdate datetime DEFAULT GetDate()
)

CREATE TABLE Course(
  Cno char(10) PRIMARY KEY,
  Cname nvarchar(20) NOT NULL,
  Credit int,
  CHECK (Credit > 0),
  Semester Smallint,
)

CREATE TABLE SC(
  Sno char(7),
  Cno char(10),
  Grade smallint,
  CHECK(Grade >= 0 OR Grade <= 100),
  PRIMARY KEY(Sno,Cno),
  FOREIGN KEY(Sno) REFERENCES Students(Sno),
  FOREIGN KEY(Cno) REFERENCES Course(Cno),
)

CREATE TABLE Teacher(
  Tno char(8) NOT NULL,
  Tname char(10) NOT NULL,
  Salary numeric(6,2),
)

--在Teacher表中添加一个职称列,列名为:Title,类型为nchar(4)
ALTER TABLE Teacher
  ADD Title nchar(4)

--为Teacher表中的Title添加取值范围约束,取值范围为{教授,副教授,讲师}
ALTER TABLE Teacher
  ADD CHECK(Title = '教授' OR Title = '副教授' OR Title = '讲师')

--将Course表中Credit列的类型改为tinyint

ALTER TABLE Course
  ALTER COLUMN Credit tinyint

--删除Students表中的Ssid和Sdate列
ALTER  TABLE  Students DROP CONSTRAINT  UQ__Students__D2236E904EDDB18F
ALTER  TABLE  Students DROP COLUMN Sdate
ALTER  TABLE  Students DROP CONSTRAINT  DF__Students__Sdate__53A266AC
ALTER  TABLE  Students DROP COLUMN Ssid

--为Teacher表添加主键约束，其主键为：Tno。
ALTER  TABLE   Teacher ADD PRIMARY KEY(Tno)