--���õ�5�½�����ѧ�����ݿ��Լ�Student��Course��SC��������в���
--1. ������������Ҫ��ĺ󴥷��ʹ�����
--a. ����ѧ���Ŀ��Գɼ�������1��100
create trigger tri1 on SC after insert as
if exists (select Grade from instered where Grade not between 0 and 100)
rollback
--b. ���Ʋ���ɾ���ɼ�������Ŀ��Լ�¼
create trigger tri2 on SC after delete as 
if exists(select * from deleted where grade < 60)
rollback
--c. ����ÿ��ѧ�ڿ���Ŀγ���ѧ�ֲ��ܳ���20
create trigger tri3 on Course after insert as
if exists (select count(Credit)from Course group by Semester having sum(Credit) > 20)
rollback
--d. ����ÿ��ѧ��ÿѧ��ѡ�Ŀγ̲��ܳ���5��
create trigger tri4 on SC after insert as
if exists (select count(SC.Cno) from SC.Course where SC.Cno = Course.Cno 
group by Semester, Sno having count(SC.Cno) > 5 ) 
rollback
--2. ������������Ҫ��Ĵ洢����
--a. ��ѯÿ��ѧ�����޿���ѧ�֣�Ҫ���г�ѧ��ѧ�ż��ܷ�
create proc p1
as
select Sno, Sname, SUM(Credit) as '��ѧ��' from Student, SC, Course
where SC.Sno = Student.Sno and Course.Cno = SC.Cno
exec p1
--b. ��ѯѧ����ѧ�š��������޵Ŀγ̺š��γ������γ�ѧ�֣���ѧ�����ڵ�ϵ��Ϊ���������ִ�д˴洢���̣����ֱ�ָ��һЩ��ͬ���������ֵ
create proc p2 @dept char(20) = '��Ϣ����ϵ'
as
select Student.Sno, Sname, Sdept, SC.Cno, Course.Cname, Credit from Student, Course, SC
where SC.Sno = Student.Sno and Course.Cno = SC.Cno
exec p2
exec p2 @dept = '�����ϵ'
--c. ��ѯָ��ϵ����������������ϵΪ�������������Ϊ�������
--d. ɾ��ָ��ѧ�����޿μ�¼������ѧ��Ϊ�������
--e. �޸�ָ���γ̵Ŀ���ѧ�ڡ��������Ϊ�γ̺ź��޸ĺ�Ŀ���ѧ��