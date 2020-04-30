--利用第5章建立的学生数据库以及Student、Course和SC表，完成下列操作
--1. 创建满足以下要求的后触发型触发器
--a. 限制学生的考试成绩必须在1～100
create trigger tri1 on SC after insert as
if exists (select Grade from instered where Grade not between 0 and 100)
rollback
--b. 限制不能删除成绩不及格的考试记录
create trigger tri2 on SC after delete as 
if exists(select * from deleted where grade < 60)
rollback
--c. 限制每个学期开设的课程总学分不能超过20
create trigger tri3 on Course after insert as
if exists (select count(Credit)from Course group by Semester having sum(Credit) > 20)
rollback
--d. 限制每个学生每学期选的课程不能超过5门
create trigger tri4 on SC after insert as
if exists (select count(SC.Cno) from SC.Course where SC.Cno = Course.Cno 
group by Semester, Sno having count(SC.Cno) > 5 ) 
rollback
--2. 创建满足如下要求的存储过程
--a. 查询每个学生的修课总学分，要求列出学生学号及总分
create proc p1
as
select Sno, Sname, SUM(Credit) as '总学分' from Student, SC, Course
where SC.Sno = Student.Sno and Course.Cno = SC.Cno
exec p1
--b. 查询学生的学号、姓名、修的课程号、课程名、课程学分，将学生所在的系作为输入参数，执行此存储过程，并分别指定一些不同的输入参数值
create proc p2 @dept char(20) = '信息管理系'
as
select Student.Sno, Sname, Sdept, SC.Cno, Course.Cname, Credit from Student, Course, SC
where SC.Sno = Student.Sno and Course.Cno = SC.Cno
exec p2
exec p2 @dept = '计算机系'
--c. 查询指定系的男生人数，其中系为输入参数，人数为输出参数
--d. 删除指定学生的修课记录，其中学号为输入参数
--e. 修改指定课程的开课学期。输入参数为课程号和修改后的开课学期