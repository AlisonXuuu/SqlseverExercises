create database 学生数据库
go

use 学生数据库
go

CREATE TABLE Student (
  Sno     CHAR(7)       PRIMARY KEY,
  Sname   CHAR(8)       NOT NULL,
  Ssex    NCHAR(1), 
  Sage    TINYINT,
  Sdept   NVARCHAR(20) 
)

CREATE TABLE Course (
  Cno       CHAR(6),
  Cname     NVARCHAR(20)  NOT NULL,
  Credit    TINYINT,
  Semester TINYINT,
  PRIMARY KEY(Cno)
)

CREATE TABLE SC (
  Sno    CHAR(7)  NOT NULL,
  Cno    CHAR(6)  NOT NULL,
  Grade  TINYINT,
  PRIMARY KEY (Sno, Cno),
  FOREIGN KEY (Sno)  REFERENCES  Student (Sno),
  FOREIGN KEY (Cno)  REFERENCES  Course (Cno)  
)  

insert into student values('0811101','李勇','男',21,'计算机系')
insert into student values('0811102','刘晨','男',20,'计算机系')
insert into student values('0811103','王敏','女',20,'计算机系')
insert into student values('0811104','张小红','女',19,'计算机系')
insert into student values('0821101','张立','男',20,'信息管理系')
insert into student values('0821102','吴宾','女',19,'信息管理系')
insert into student values('0821103','张海','男',20,'信息管理系')
insert into student values('0831101','钱小平','女',21,'通信工程系')
insert into student values('0831102','王大力','男',20,'通信工程系')
insert into student values('0831103','张姗姗','女',19,'通信工程系')

insert into course values('C001','高等数学',4,1)
insert into course values('C002','大学英语',3,1)
insert into course values('C003','大学英语',3,2)
insert into course values('C004','计算机文化学',2,2)
insert into course values('C005','VB',2,3)
insert into course values('C006','数据库基础',4,5)
insert into course values('C007','数据结构',4,4)
insert into course values('C008','计算机网络',4,4)

insert into sc values('0811101','C001',96)
insert into sc values('0811101','C002',80)
insert into sc values('0811101','C003',84)
insert into sc values('0811101','C005',62)
insert into sc values('0811102','C001',92)
insert into sc values('0811102','C002',90)
insert into sc values('0811102','C004',84)
insert into sc values('0821102','C001',76)
insert into sc values('0821102','C004',85)
insert into sc values('0821102','C005',73)
insert into sc values('0821102','C007',NULL)
insert into sc values('0821103','C001',50)
insert into sc values('0821103','C004',80)
insert into sc values('0831101','C001',55)
insert into sc values('0831101','C004',80)
insert into sc values('0831102','C007',NULL)
insert into sc values('0831103','C004',78)
insert into sc values('0831103','C005',65)
insert into sc values('0831103','C007',NULL)

--1.	查询SC表中的全部数据。
select * from SC
--2.	查询计算机系学生的姓名和年龄
select Sname, Sage from Student where Sdept = '计算机系'
--3.	查询成绩在70～80分的学生的学号、课程号和成绩
select Sno, Cno, Grade from SC where Grade between 70 and 80
--4.	查询计算机系年龄在18到20之间且性别为'男'的学生的姓名、年龄。
select Sname, Sage from Student where Sage between 18 and 20 and Sdept = '计算机系' and Ssex = '男'
--5.    查询C001课程的最高分
select MAX(Grade) as '最高分' from SC where Cno = 'C001'
--6.    查询计算机系学生的最大年龄和最小年龄。
select MAX(Sage) as '最大年龄', MIN(Sage) as '最小年龄' from Student
--7.    统计每个系的学生人数
select Sdept, COUNT(Sno) from Student group by Sdept
--8.    统计每门课程的选课人数和最高成绩
select Cno, Count(Sno) as '人数', max(Grade) as '最高成绩' from SC group by Cno
--9.    统计每个学生的选课门数和考试总成绩，并按选课门数升序显示结果
select Sno, COUNT(*) as '选课门数', SUM(Grade) as '总成绩' from SC group by Sno order by COUNT(*) asc
--10.   查询成绩超过200的学生的学号和总成绩
select Sno, SUM(Grade) as '总成绩' from SC group by Sno having SUM(Grade) > 200
--11.   查询选了C002课程的学生姓名和所在系。
select Sname, Sdept from Student join SC on Student.Sno = SC.Sno  where Cno = 'C002'
--12.   查询成绩80分以上的学生姓名，课程号和成绩，并按成绩降序排列结果
select Sname, Cno, Grade from SC join Student on SC.Sno = Student.Sno where Grade >80 order by Grade desc 
--13.   查询与VB在同一学期开设的课程的课程名和开课学期。
select c2.Cname, c2.Semester from Course c1 join Course c2 on c1.Semester = c2.Semester where c1.Cname = 'VB' 
--14.   查询与李勇年龄相同的学生的姓名、所在系和年龄
select s2.Sname, s2.Sdept, s2.Sage from Student s1 join Student s2 on s1.Sage=s2.Sage where s1.Sname='李勇'
--15.   查询哪些课程没有学生选修，列出课程号和课程名。
select C.Cno, Cname from Course C left join SC on C.Cno = SC.Cno where SC.Cno is null
--16.   查询每个学生的选课情况，包括未选课的学生，列出学生学号，姓名，选的课程号
select Student.Sno, Student.Sname, Cno from Student left join SC on SC.Sno = Student.Sno
--17.   查询计算机系那些学生没有选课，列出学生姓名
select Sname from Student where Sdept = '计算机系' and Sno not in (select Sno from SC)
--18.   查询计算机系年龄最大的三个学生的姓名和年龄
select top 3 Sname, Sage from Student where Sdept = '计算机系' order by Sage desc
--19.   列出VB课程考试成绩前三名的学生的学号、姓名、所在系和VB成绩
select top 3 with ties Sname, Sdept, Grade from Student S join SC on S.Sno = SC.Sno join  Course C on C.Cno = SC.Cno  where  Cname='VB'  order by Grade  desc
--20.   查询选课门数最多的前两名学生，列出学号和选课门数
select top 2 with ties Sno, COUNT(Cno) as '选课门数' from SC group by Sno order by COUNT(Cno) desc
--21.   查询计算机系学生姓名、年龄和年龄情况，其中年龄情况为：如果年龄小于18，则显示偏小；如果年龄在18~22，则显示合适；如果年龄大于22，则显示偏大
select Sname, Sage, 
case 
when Sage < 18 then '偏小' 
when Sage >= 18 and Sage <=22 then '合适' 
when Sage > 22 then '偏大' 
end 
as '年龄情况' from Student where Sdept = '计算机系'
--22.   统计每门课的选课人数，包括有人选的课程和没有人选的课程，列出课程号，选课人数及选课情况，其中选课情况为：如果此门课程的选课人数超过100人，则显示“人多”；如果此门课程的选课人数在40～100，则显示“一般”；如果此门课程的选课人数在1～40，则显示“人少”；如果此门课程没有人选，则显示“无人选”。
select Course.Cno, COUNT(Sno) as '选课人数' ,
case 
when COUNT(Sno) > 100 then '人多'
when COUNT(Sno) >= 40 and COUNT(Sno) <= 100 then '一般'
when COUNT(Sno) >=1 and COUNT(Sno) < 40 then '人少'
when COUNT(Sno) = 0 then '无人选'
end as '选课情况' from SC right join  Course on Course.Cno=SC.Cno  group by Course.Cno
--23.   查询计算机系选了VB课程的学生姓名、所在系和考试成绩，并将结果保存到新表VB_Grade中。
select Student.Sname, Sdept, Grade from Student, Course, SC where  Student.Sno=SC.Sno and Course.Cno = SC.Cno and Cname='VB'
select Sname, Sdept, Grade from Student join SC on Student.Sno = SC.Sno join Course on SC.Cno = Course.Cno where Cname = 'VB'
--24.   统计每个系的女生人数，并将结果保存到新表Girls中。
select Sdept, Ssex, COUNT(Ssex) as '人数' into Girls from Student where Ssex = '女' group by Sdept, Ssex
--25.   用子查询实现如下查询：
--     （1）查询选了“C001”课程的学生姓名和所在系。
select Sname, Sdept from Student where Sno in (select Sno from SC where Cno = 'C001')
--     （2）查询通信工程系成绩80分以上的学生的学号和姓名。
select Sno, Sname from Student where Sno in (select Sno from SC where Grade > 80)
--     （3）查询计算机系考试成绩最高的学生的姓名。
select Sname from Student,SC where SC.Sno = Student.Sno and Sdept = '计算机系' 
and Grade in (select MAX(Grade) from SC, Student where SC.Sno = Student.Sno and Sdept = '计算机系')
--     （4）查询年龄最大的男生的姓名、所在系和年龄。
select Sname, Sdept, Sage from Student where Ssex = '男' and Sage in (select MAX(Sage) from Student where Ssex = '男')
--26.   查询C001课程的考试成绩高于该课程平均成绩的学生的学号和成绩。
select Sno, Grade from SC where Cno = 'C001' and Grade > (select AVG(Grade) from SC where Cno = 'C001')
--27.   查询计算机系学生考试成绩高于计算机系学生平均成绩的学生的姓名、考试的课程名和考试成绩。
select  Sname, Sdept, Cname, Grade from Student, SC, Course where Student.Sno=SC.Sno and Course.Cno=SC.Cno and
Sdept = '计算机系' and Grade > (select AVG(Grade) from SC, Course, Student where SC.Cno=Course.Cno and Student.Sno=SC.Sno
and Sdept='计算机系')
--28.   查询VB课程考试成绩高于VB平均成绩的学生姓名和VB成绩。
select Sname, Grade from Student, SC, Course where Student.Sno=SC.Sno  
and Course.Cno=SC.Cno and Cname='VB' and Grade>
(select AVG(Grade) from SC, Course where Course.Cno=SC.Cno and Cname='VB')
--29.   查询没选VB的学生姓名和所在系。
select  Sname, Sdept  from Student where Sno not in (select Sno from SC,Course where SC.Cno=Course.Cno and Cname='VB')
--30.   查询每个学期学分最高的课程信息，列出开课学期、课程名和学分。
select Cname, Semester, Credit from Course c1 where not exists
(select * from Course c2 where c1.Semester=c2.Semester and c1.Credit<c2.Credit)
--31.   查询每门课程考试成绩最高的学生信息，列出课程号、学生姓名和最高成绩，结果按课程号升序排序，不包括没考试的课程。
select Course.Cno, Sname, SC.Cno, Grade from Student join SC on Student.Sno = SC.Cno join Course on Course.Cno = SC.Cno 
where Grade = (select MAX(Grade) from SC where Cno = Course.Cno) order by SC.Cno asc
--32.   创建一个新表，表名为test，其结构为（COL1, COL 2, COL 3），其中，
--      COL1：整型，允许空值。
--      COL2：普通编码定长字符型，长度为10，不允许空值。
--      COL3：普通编码定长字符型，长度为10，允许空值。
--      试写出按行插入如下数据的语句（空白处表示是空值）。
--      COL1      COL2      COL3
--                 B1
--       1         B2        C2
--       2         B3
create table test(
COL1 int,
COL2 char(10) not null,
COL3 char(10)
)
insert into test(COL2) values ('B1')
insert into test values (1, 'B2', 'C2')
insert into test(COL1, COL2) values (2, 'B3')
--33.   利用23题建立的VB_Grade表，将信息管理系选了VB课程的学生姓名、所在系和考试成绩插入到VB_Grade表中。
insert into dbo.VB_Grade select Sname, Sdept, Grade from Student, SC, Course where Student.Sno = SC.Sno and SC.Cno = Course.Cno and Sdept = '计算机系' and Cname = 'VB'
--34.   将所有选修C001课程的学生的成绩加10分。
update SC set Grade= Grade + 10 where Cno = 'C001'
--35.   将计算机系所有学生的“计算机文化学”的考试成绩加10分。
update SC set Grade = Grade + 10 where Sno in(select SC.Sno from Student, Course, SC where Student.Sno = SC.Sno and SC.Cno =  Course.Cno and Sdept = '计算机系' and Cname = '计算机文化学')
--36.   修改“VB”课程的考试成绩，如果是通信工程系的学生，则增加10分；如果是信息管理系的学生则增加5分，其他系的学生不加分。
update SC set Grade = Grade + 
case Sdept
when '通信工程系' then 10
when '信息管理系' then 5
else 0
end
from Student, SC, Course
where SC.Sno = Student.Sno and Course.Cno = SC.Cno and Cname = 'VB'
--37.   删除成绩小于50分的学生的选课记录。
delete from SC where Grade < 50
--38.   删除计算机系VB考试成绩不及格学生的VB选课记录。
delete from SC from Student, Course, SC where SC.Sno = Student.Sno and Course.Cno = SC.Cno and Sdept = '计算机系' and Cname = 'VB' and Grade < 60
--39.   删除“VB”考试成绩最低的学生的VB修课记录。
delete from SC from SC, Course where Course.Cno = SC.Cno and Cname = 'VB' and Grade = (select MIN(Grade) from SC, Course where Course.Cno = SC.Cno and Cname = 'VB')
--40.   删除没人选的课程的基本信息。
delete from Course from Course left join SC on Course.Cno=SC.Cno where SC.Cno is null