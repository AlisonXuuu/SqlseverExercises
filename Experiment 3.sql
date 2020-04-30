--1.	д��ʵ�����в�����SQL��䣬��ִ����д���롣
--��1����Student����ΪSname�н���һ���ۼ�������������Ϊ��IdxSno������ʾ����ִ�д��������Ĵ��룬����ɾ���ñ������Լ����
alter table SC drop constraint FK__SC__Sno__08EA5793
alter table Student drop constraint PK__Student__CA1FE4647F60ED59
create clustered index IdSno on Student (Sname)
--��2����Course����ΪCname�н���һ��Ψһ�ķǾۼ�������������Ϊ��IdxCN
create unique clustered index IdxCN on Course(Cname)
--��3����SC����ΪSno��Cno����һ����ϵľۼ�������������Ϊ��IdxSnoCno������ʾ����ִ�д��������Ĵ��룬����ɾ���ñ������Լ����
create clustered  index IdxSnoCno on SC(Sno, Cno)
--��4��ɾ��Sname���Ͻ�����IdxSno������
drop index Student.Sname
--2.	д��������������Ҫ�����ͼ��SQL��䣬��ִ����д���롣
--��1����ѯѧ����ѧ�š�����������ϵ���γ̺š��γ������γ�ѧ�֡�
create view a1 as 
select Student.Sno, Sname, Sdept, SC.Cno, Cname, Credit
from Student, SC, Course where Student.Sno = SC.Sno and Course.Cno = SC.Cno
--��2����ѯѧ����ѧ�š�������ѡ�޵Ŀγ����Ϳ��Գɼ���
create view a2 as
select Student.Sno, Sname, Course.Cname, SC.Grade
from Student, SC, Course where Student.Sno = SC.Sno and Course.Cno = SC.Cno
--��3��ͳ��ÿ��ѧ����ѡ��������Ҫ���г�ѧ��ѧ�ź�ѡ��������
create view a3 as
select Sno, Count(Cno) as 'ѡ������'
from SC group by Sno
select * from dbo.a3
--��4��ͳ��ÿ��ѧ�����޿���ѧ�֣�Ҫ���г�ѧ��ѧ�ź���ѧ�֣�˵�������Գɼ����ڵ���60�ſɻ�ô��ſγ̵�ѧ�֣���
create view a4 as
select Sno, SUM(Credit) as '��ѧ��'
from SC, Course where SC.Cno = Course.Cno and Grade >= 60 group by Sno
select * from dbo.a4
--3.	���õ�2�⽨������ͼ��������²�ѯ��
--��1����ѯ���Գɼ����ڵ���90�ֵ�ѧ�����������γ����ͳɼ���
select Sno, Cname, Grade from dbo.a2 where Grade >= 90
--��2����ѯѡ����������3�ŵ�ѧ����ѧ�ź�ѡ��������
select * from dbo.a3 where ѡ������ > 3
--��3����ѯ�����ϵѡ����������3�ŵ�ѧ����������ѡ��������
select Sname, ѡ������ from Student, dbo.a3 where dbo.a3.Sno = Student.Sno and dbo.a3.ѡ������ > 3
and Sdept = '�����ϵ'
--��4����ѯ�޿���ѧ�ֳ���10�ֵ�ѧ����ѧ�š�����������ϵ���޿���ѧ�֡�
select Student.Sno, Sname, Sdept, ��ѧ�� from Student, dbo.a4 where dbo.a4.Sno = Student.Sno
and ��ѧ�� > 10
--��5����ѯ������ڵ���20���ѧ���У��޿���ѧ�ֳ���10�ֵ�ѧ�������������䡢����ϵ���޿���ѧ�֡�
select Sname, Sage, Sdept, ��ѧ�� from Student, dbo.a4 where dbo.a4.Sno = Student.Sno and
��ѧ�� > 10 and Sage > 20
--4.	�޸ĵ�3�⣨4���������ͼ��ʹ���ѯÿ��ѧ����ѧ�š���ѧ���Լ��ܵ�ѡ��������
alter view a4 as
select Sno, SUM(Credit) as '��ѧ��', COUNT(SC.Cno) as 'ѡ������' from SC, Course  where SC.Cno = Course.Cno
group by Sno
select * from dbo.a4