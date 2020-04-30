create database ѧ�����ݿ�
go

use ѧ�����ݿ�
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

insert into student values('0811101','����','��',21,'�����ϵ')
insert into student values('0811102','����','��',20,'�����ϵ')
insert into student values('0811103','����','Ů',20,'�����ϵ')
insert into student values('0811104','��С��','Ů',19,'�����ϵ')
insert into student values('0821101','����','��',20,'��Ϣ����ϵ')
insert into student values('0821102','���','Ů',19,'��Ϣ����ϵ')
insert into student values('0821103','�ź�','��',20,'��Ϣ����ϵ')
insert into student values('0831101','ǮСƽ','Ů',21,'ͨ�Ź���ϵ')
insert into student values('0831102','������','��',20,'ͨ�Ź���ϵ')
insert into student values('0831103','����','Ů',19,'ͨ�Ź���ϵ')

insert into course values('C001','�ߵ���ѧ',4,1)
insert into course values('C002','��ѧӢ��',3,1)
insert into course values('C003','��ѧӢ��',3,2)
insert into course values('C004','������Ļ�ѧ',2,2)
insert into course values('C005','VB',2,3)
insert into course values('C006','���ݿ����',4,5)
insert into course values('C007','���ݽṹ',4,4)
insert into course values('C008','���������',4,4)

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

--1.	��ѯSC���е�ȫ�����ݡ�
select * from SC
--2.	��ѯ�����ϵѧ��������������
select Sname, Sage from Student where Sdept = '�����ϵ'
--3.	��ѯ�ɼ���70��80�ֵ�ѧ����ѧ�š��γ̺źͳɼ�
select Sno, Cno, Grade from SC where Grade between 70 and 80
--4.	��ѯ�����ϵ������18��20֮�����Ա�Ϊ'��'��ѧ�������������䡣
select Sname, Sage from Student where Sage between 18 and 20 and Sdept = '�����ϵ' and Ssex = '��'
--5.    ��ѯC001�γ̵���߷�
select MAX(Grade) as '��߷�' from SC where Cno = 'C001'
--6.    ��ѯ�����ϵѧ��������������С���䡣
select MAX(Sage) as '�������', MIN(Sage) as '��С����' from Student
--7.    ͳ��ÿ��ϵ��ѧ������
select Sdept, COUNT(Sno) from Student group by Sdept
--8.    ͳ��ÿ�ſγ̵�ѡ����������߳ɼ�
select Cno, Count(Sno) as '����', max(Grade) as '��߳ɼ�' from SC group by Cno
--9.    ͳ��ÿ��ѧ����ѡ�������Ϳ����ܳɼ�������ѡ������������ʾ���
select Sno, COUNT(*) as 'ѡ������', SUM(Grade) as '�ܳɼ�' from SC group by Sno order by COUNT(*) asc
--10.   ��ѯ�ɼ�����200��ѧ����ѧ�ź��ܳɼ�
select Sno, SUM(Grade) as '�ܳɼ�' from SC group by Sno having SUM(Grade) > 200
--11.   ��ѯѡ��C002�γ̵�ѧ������������ϵ��
select Sname, Sdept from Student join SC on Student.Sno = SC.Sno  where Cno = 'C002'
--12.   ��ѯ�ɼ�80�����ϵ�ѧ���������γ̺źͳɼ��������ɼ��������н��
select Sname, Cno, Grade from SC join Student on SC.Sno = Student.Sno where Grade >80 order by Grade desc 
--13.   ��ѯ��VB��ͬһѧ�ڿ���Ŀγ̵Ŀγ����Ϳ���ѧ�ڡ�
select c2.Cname, c2.Semester from Course c1 join Course c2 on c1.Semester = c2.Semester where c1.Cname = 'VB' 
--14.   ��ѯ������������ͬ��ѧ��������������ϵ������
select s2.Sname, s2.Sdept, s2.Sage from Student s1 join Student s2 on s1.Sage=s2.Sage where s1.Sname='����'
--15.   ��ѯ��Щ�γ�û��ѧ��ѡ�ޣ��г��γ̺źͿγ�����
select C.Cno, Cname from Course C left join SC on C.Cno = SC.Cno where SC.Cno is null
--16.   ��ѯÿ��ѧ����ѡ�����������δѡ�ε�ѧ�����г�ѧ��ѧ�ţ�������ѡ�Ŀγ̺�
select Student.Sno, Student.Sname, Cno from Student left join SC on SC.Sno = Student.Sno
--17.   ��ѯ�����ϵ��Щѧ��û��ѡ�Σ��г�ѧ������
select Sname from Student where Sdept = '�����ϵ' and Sno not in (select Sno from SC)
--18.   ��ѯ�����ϵ������������ѧ��������������
select top 3 Sname, Sage from Student where Sdept = '�����ϵ' order by Sage desc
--19.   �г�VB�γ̿��Գɼ�ǰ������ѧ����ѧ�š�����������ϵ��VB�ɼ�
select top 3 with ties Sname, Sdept, Grade from Student S join SC on S.Sno = SC.Sno join  Course C on C.Cno = SC.Cno  where  Cname='VB'  order by Grade  desc
--20.   ��ѯѡ����������ǰ����ѧ�����г�ѧ�ź�ѡ������
select top 2 with ties Sno, COUNT(Cno) as 'ѡ������' from SC group by Sno order by COUNT(Cno) desc
--21.   ��ѯ�����ϵѧ���������������������������������Ϊ���������С��18������ʾƫС�����������18~22������ʾ���ʣ�����������22������ʾƫ��
select Sname, Sage, 
case 
when Sage < 18 then 'ƫС' 
when Sage >= 18 and Sage <=22 then '����' 
when Sage > 22 then 'ƫ��' 
end 
as '�������' from Student where Sdept = '�����ϵ'
--22.   ͳ��ÿ�ſε�ѡ����������������ѡ�Ŀγ̺�û����ѡ�Ŀγ̣��г��γ̺ţ�ѡ��������ѡ�����������ѡ�����Ϊ��������ſγ̵�ѡ����������100�ˣ�����ʾ���˶ࡱ��������ſγ̵�ѡ��������40��100������ʾ��һ�㡱��������ſγ̵�ѡ��������1��40������ʾ�����١���������ſγ�û����ѡ������ʾ������ѡ����
select Course.Cno, COUNT(Sno) as 'ѡ������' ,
case 
when COUNT(Sno) > 100 then '�˶�'
when COUNT(Sno) >= 40 and COUNT(Sno) <= 100 then 'һ��'
when COUNT(Sno) >=1 and COUNT(Sno) < 40 then '����'
when COUNT(Sno) = 0 then '����ѡ'
end as 'ѡ�����' from SC right join  Course on Course.Cno=SC.Cno  group by Course.Cno
--23.   ��ѯ�����ϵѡ��VB�γ̵�ѧ������������ϵ�Ϳ��Գɼ�������������浽�±�VB_Grade�С�
select Student.Sname, Sdept, Grade from Student, Course, SC where  Student.Sno=SC.Sno and Course.Cno = SC.Cno and Cname='VB'
select Sname, Sdept, Grade from Student join SC on Student.Sno = SC.Sno join Course on SC.Cno = Course.Cno where Cname = 'VB'
--24.   ͳ��ÿ��ϵ��Ů������������������浽�±�Girls�С�
select Sdept, Ssex, COUNT(Ssex) as '����' into Girls from Student where Ssex = 'Ů' group by Sdept, Ssex
--25.   ���Ӳ�ѯʵ�����²�ѯ��
--     ��1����ѯѡ�ˡ�C001���γ̵�ѧ������������ϵ��
select Sname, Sdept from Student where Sno in (select Sno from SC where Cno = 'C001')
--     ��2����ѯͨ�Ź���ϵ�ɼ�80�����ϵ�ѧ����ѧ�ź�������
select Sno, Sname from Student where Sno in (select Sno from SC where Grade > 80)
--     ��3����ѯ�����ϵ���Գɼ���ߵ�ѧ����������
select Sname from Student,SC where SC.Sno = Student.Sno and Sdept = '�����ϵ' 
and Grade in (select MAX(Grade) from SC, Student where SC.Sno = Student.Sno and Sdept = '�����ϵ')
--     ��4����ѯ������������������������ϵ�����䡣
select Sname, Sdept, Sage from Student where Ssex = '��' and Sage in (select MAX(Sage) from Student where Ssex = '��')
--26.   ��ѯC001�γ̵Ŀ��Գɼ����ڸÿγ�ƽ���ɼ���ѧ����ѧ�źͳɼ���
select Sno, Grade from SC where Cno = 'C001' and Grade > (select AVG(Grade) from SC where Cno = 'C001')
--27.   ��ѯ�����ϵѧ�����Գɼ����ڼ����ϵѧ��ƽ���ɼ���ѧ�������������ԵĿγ����Ϳ��Գɼ���
select  Sname, Sdept, Cname, Grade from Student, SC, Course where Student.Sno=SC.Sno and Course.Cno=SC.Cno and
Sdept = '�����ϵ' and Grade > (select AVG(Grade) from SC, Course, Student where SC.Cno=Course.Cno and Student.Sno=SC.Sno
and Sdept='�����ϵ')
--28.   ��ѯVB�γ̿��Գɼ�����VBƽ���ɼ���ѧ��������VB�ɼ���
select Sname, Grade from Student, SC, Course where Student.Sno=SC.Sno  
and Course.Cno=SC.Cno and Cname='VB' and Grade>
(select AVG(Grade) from SC, Course where Course.Cno=SC.Cno and Cname='VB')
--29.   ��ѯûѡVB��ѧ������������ϵ��
select  Sname, Sdept  from Student where Sno not in (select Sno from SC,Course where SC.Cno=Course.Cno and Cname='VB')
--30.   ��ѯÿ��ѧ��ѧ����ߵĿγ���Ϣ���г�����ѧ�ڡ��γ�����ѧ�֡�
select Cname, Semester, Credit from Course c1 where not exists
(select * from Course c2 where c1.Semester=c2.Semester and c1.Credit<c2.Credit)
--31.   ��ѯÿ�ſγ̿��Գɼ���ߵ�ѧ����Ϣ���г��γ̺š�ѧ����������߳ɼ���������γ̺��������򣬲�����û���ԵĿγ̡�
select Course.Cno, Sname, SC.Cno, Grade from Student join SC on Student.Sno = SC.Cno join Course on Course.Cno = SC.Cno 
where Grade = (select MAX(Grade) from SC where Cno = Course.Cno) order by SC.Cno asc
--32.   ����һ���±�����Ϊtest����ṹΪ��COL1, COL 2, COL 3�������У�
--      COL1�����ͣ������ֵ��
--      COL2����ͨ���붨���ַ��ͣ�����Ϊ10���������ֵ��
--      COL3����ͨ���붨���ַ��ͣ�����Ϊ10�������ֵ��
--      ��д�����в����������ݵ���䣨�հ״���ʾ�ǿ�ֵ����
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
--33.   ����23�⽨����VB_Grade������Ϣ����ϵѡ��VB�γ̵�ѧ������������ϵ�Ϳ��Գɼ����뵽VB_Grade���С�
insert into dbo.VB_Grade select Sname, Sdept, Grade from Student, SC, Course where Student.Sno = SC.Sno and SC.Cno = Course.Cno and Sdept = '�����ϵ' and Cname = 'VB'
--34.   ������ѡ��C001�γ̵�ѧ���ĳɼ���10�֡�
update SC set Grade= Grade + 10 where Cno = 'C001'
--35.   �������ϵ����ѧ���ġ�������Ļ�ѧ���Ŀ��Գɼ���10�֡�
update SC set Grade = Grade + 10 where Sno in(select SC.Sno from Student, Course, SC where Student.Sno = SC.Sno and SC.Cno =  Course.Cno and Sdept = '�����ϵ' and Cname = '������Ļ�ѧ')
--36.   �޸ġ�VB���γ̵Ŀ��Գɼ��������ͨ�Ź���ϵ��ѧ����������10�֣��������Ϣ����ϵ��ѧ��������5�֣�����ϵ��ѧ�����ӷ֡�
update SC set Grade = Grade + 
case Sdept
when 'ͨ�Ź���ϵ' then 10
when '��Ϣ����ϵ' then 5
else 0
end
from Student, SC, Course
where SC.Sno = Student.Sno and Course.Cno = SC.Cno and Cname = 'VB'
--37.   ɾ���ɼ�С��50�ֵ�ѧ����ѡ�μ�¼��
delete from SC where Grade < 50
--38.   ɾ�������ϵVB���Գɼ�������ѧ����VBѡ�μ�¼��
delete from SC from Student, Course, SC where SC.Sno = Student.Sno and Course.Cno = SC.Cno and Sdept = '�����ϵ' and Cname = 'VB' and Grade < 60
--39.   ɾ����VB�����Գɼ���͵�ѧ����VB�޿μ�¼��
delete from SC from SC, Course where Course.Cno = SC.Cno and Cname = 'VB' and Grade = (select MIN(Grade) from SC, Course where Course.Cno = SC.Cno and Cname = 'VB')
--40.   ɾ��û��ѡ�Ŀγ̵Ļ�����Ϣ��
delete from Course from Course left join SC on Course.Cno=SC.Cno where SC.Cno is null