CREATE TABLE Students(
  Sno char(7) PRIMARY KEY,
  Sname char(10) NOT NULL,
  Ssex char(2) CHECK(Ssex = '��' OR Ssex = 'Ů'),
  Sage tinyint,
  CHECK(Sage >= 15 OR Sage <= 45),
  Sdept nvarchar(20) DEFAULT '�����ϵ',
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

--��Teacher�������һ��ְ����,����Ϊ:Title,����Ϊnchar(4)
ALTER TABLE Teacher
  ADD Title nchar(4)

--ΪTeacher���е�Title���ȡֵ��ΧԼ��,ȡֵ��ΧΪ{����,������,��ʦ}
ALTER TABLE Teacher
  ADD CHECK(Title = '����' OR Title = '������' OR Title = '��ʦ')

--��Course����Credit�е����͸�Ϊtinyint

ALTER TABLE Course
  ALTER COLUMN Credit tinyint

--ɾ��Students���е�Ssid��Sdate��
ALTER  TABLE  Students DROP CONSTRAINT  UQ__Students__D2236E904EDDB18F
ALTER  TABLE  Students DROP COLUMN Sdate
ALTER  TABLE  Students DROP CONSTRAINT  DF__Students__Sdate__53A266AC
ALTER  TABLE  Students DROP COLUMN Ssid

--ΪTeacher���������Լ����������Ϊ��Tno��
ALTER  TABLE   Teacher ADD PRIMARY KEY(Tno)