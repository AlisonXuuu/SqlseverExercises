--利用第4、5章建立的学生数据库和其中的Student，Course，SC表，并利用SSMS工具完成下列操作
--1. 用SSMS工具建立SQL Sever身份验证模式的登录名：log1、log2和log3
--2. 用log1建立一个新的数据库引擎查询，在“可用数据库”下列列表框中是否能选中学生数据库？为什么？
--不能。因为没有权限
--3. 用系统管理员身份建立一个新的数据库引擎查询，将log1、log2和log3映射为学生数据库中的用户，用户名同登录名
--4. 在log1建立的数据库引擎查询中，现在在“可用数据库”下列列表框中是否能选中学生数据库？为什么？
--不能。因为没有权限
--5. 在log1建立的数据库引擎查询中，选中学生数据库，执行下列语句，能否成功？为什么？
select * from Course
--不能。因为没有权限
--6. 在系统管理员的数据库引擎查询中，执行合适的授权语句，授予log1具有对Course表的查询权限，授予log2具有对Course表的插入权限
grant select on Course to log1
grant insert on Course to log2
--7. 利用log2建立一个新的数据库引擎查询，执行下列语句，能否成功？为什么
insert into Course values ('C001','数据库基础',4,5)
--不能。因为没有权限
--   再执行下列语句，能否成功？为什么
select * from Course
--不能。因为没有权限
--8. 在log1建立的数据库引擎查询中，再次执行下述语句：
select * from Course
--   这次能否成功？
--能
--   但如果执行下述语句：
insert into Course values ('C103','软件工程'，4，5)
--   能否成功？为什么？
--不能。因为没有权限
--9. log3建立一个新的数据库引擎查询，执行下述语句，能否成功？为什么？
create table NewTable(
   C1 int,
   C2 char(4)
)
--不能。因为没有权限
--10. 授予log3在学生数据库中具有创建表的权限
grant create table to log3
--11. 在系统管理员的数据库引擎查询中，执行下述语句：
grant create table to log3
go
create schema log3 authorization log3
go
alter user log3 with default_schema = log3
--12. 在log3建立一个新的数据库引擎查询中，再次执行第9题的语句，能否成功？为什么？
--不能。因为没有权限
--    如果执行下述语句：
select * NewTable
--    能否成功？为什么？
--不能。因为没有权限