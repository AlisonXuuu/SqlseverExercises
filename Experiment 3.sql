--1.	写出实现下列操作的SQL语句，并执行所写代码。
--（1）在Student表上为Sname列建立一个聚集索引，索引名为：IdxSno。（提示：若执行创建索引的代码，请先删除该表的主键约束）
alter table SC drop constraint FK__SC__Sno__08EA5793
alter table Student drop constraint PK__Student__CA1FE4647F60ED59
create clustered index IdSno on Student (Sname)
--（2）在Course表上为Cname列建立一个唯一的非聚集索引，索引名为：IdxCN
create unique clustered index IdxCN on Course(Cname)
--（3）在SC表上为Sno和Cno建立一个组合的聚集索引，索引名为：IdxSnoCno。（提示：若执行创建索引的代码，请先删除该表的主键约束）
create clustered  index IdxSnoCno on SC(Sno, Cno)
--（4）删除Sname列上建立的IdxSno索引。
drop index Student.Sname
--2.	写出创建满足下述要求的视图的SQL语句，并执行所写代码。
--（1）查询学生的学号、姓名、所在系、课程号、课程名、课程学分。
create view a1 as 
select Student.Sno, Sname, Sdept, SC.Cno, Cname, Credit
from Student, SC, Course where Student.Sno = SC.Sno and Course.Cno = SC.Cno
--（2）查询学生的学号、姓名、选修的课程名和考试成绩。
create view a2 as
select Student.Sno, Sname, Course.Cname, SC.Grade
from Student, SC, Course where Student.Sno = SC.Sno and Course.Cno = SC.Cno
--（3）统计每个学生的选课门数，要求列出学生学号和选课门数。
create view a3 as
select Sno, Count(Cno) as '选课门数'
from SC group by Sno
select * from dbo.a3
--（4）统计每个学生的修课总学分，要求列出学生学号和总学分（说明：考试成绩大于等于60才可获得此门课程的学分）。
create view a4 as
select Sno, SUM(Credit) as '总学分'
from SC, Course where SC.Cno = Course.Cno and Grade >= 60 group by Sno
select * from dbo.a4
--3.	利用第2题建立的视图，完成如下查询。
--（1）查询考试成绩大于等于90分的学生的姓名、课程名和成绩。
select Sno, Cname, Grade from dbo.a2 where Grade >= 90
--（2）查询选课门数超过3门的学生的学号和选课门数。
select * from dbo.a3 where 选课门数 > 3
--（3）查询计算机系选课门数超过3门的学生的姓名和选课门数。
select Sname, 选课门数 from Student, dbo.a3 where dbo.a3.Sno = Student.Sno and dbo.a3.选课门数 > 3
and Sdept = '计算机系'
--（4）查询修课总学分超过10分的学生的学号、姓名、所在系和修课总学分。
select Student.Sno, Sname, Sdept, 总学分 from Student, dbo.a4 where dbo.a4.Sno = Student.Sno
and 总学分 > 10
--（5）查询年龄大于等于20岁的学生中，修课总学分超过10分的学生的姓名、年龄、所在系和修课总学分。
select Sname, Sage, Sdept, 总学分 from Student, dbo.a4 where dbo.a4.Sno = Student.Sno and
总学分 > 10 and Sage > 20
--4.	修改第3题（4）定义的视图，使其查询每个学生的学号、总学分以及总的选课门数。
alter view a4 as
select Sno, SUM(Credit) as '总学分', COUNT(SC.Cno) as '选课门数' from SC, Course  where SC.Cno = Course.Cno
group by Sno
select * from dbo.a4