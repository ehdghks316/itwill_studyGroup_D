[����88] pivot�� �̿��ؼ� �Ʒ� ȭ��� ���� ������ּ���.

�⵵       SA_REP               SH_CLERK             ST_CLERK             ������
---------- -------------------- -------------------- -------------------- ------------------------------------------
2003                     ��0��                ��0��            ��7,100��            ��7,100��
2004                ��39,500��            ��8,200��            ��3,300��           ��51,000��
2005                ��74,800��           ��15,400��           ��18,100��          ��108,300��
2006                ��59,100��           ��21,900��           ��15,900��           ��96,900��
2007                ��38,200��           ��13,400��            ��6,900��           ��58,500��
2008                ��38,900��            ��5,400��            ��4,400��           ��48,700��
������              ��250,500��           ��64,300��           ��55,700��           ��370,500��

select nvl(�⵵,'������') �⵵,
        to_char(nvl(SA_REP,0),'L999,999')||'��' SA_REP,
        to_char(nvl(SH_CLERK,0),'L999,999')||'��' SH_CLERK,
        to_char(nvl(ST_CLERK,0),'L999,999')||'��' ST_CLERK,
        to_char(������,'L999,999')||'��' ������
from (select �⵵, nvl(job_id,'x') job_id, sum_sal
        from (select to_char(hire_date,'yyyy') �⵵, job_id, sum(salary) sum_sal
                from employees
                where job_id in ('SA_REP','SH_CLERK','ST_CLERK')
                group by cube(to_char(hire_date,'yyyy'), job_id)))
pivot(max(sum_sal) for job_id in ('SA_REP' "SA_REP", 'SH_CLERK' "SH_CLERK",'ST_CLERK' "ST_CLERK", 'x' "������"))
order by 1;

-------------------

�ڰ����˻�(hierarchical query) --�м��� �� ���� ����

SELECT employee_id, last_name, manager_id
FROM employees;

                               100
                 101
         108           200 203 204 205
109 110 111 112 113                206


SELECT employee_id, last_name, manager_id
FROM employees
START WITH employee_id = 101  --������, �����ؾ� �� ������ ����
CONNECT BY PRIOR employee_id = manager_id; --����� ����

>����� (top-down���, ������ �Ʒ���)
SELECT employee_id, last_name, manager_id
FROM employees
START WITH employee_id = 108  --������, �����ؾ� �� ������ ����
CONNECT BY PRIOR employee_id = manager_id; --����� ����
              -------------------------->
>����� (bottom-up���, �ؿ��� ����)
SELECT employee_id, last_name, manager_id
FROM employees
START WITH employee_id = 100  --������, �����ؾ� �� ������ ����
CONNECT BY employee_id =  PRIOR manager_id; --����� ����
            <----------------------------

SELECT LEVEL, employee_id, last_name, manager_id --LEVEL �����˻����� ���Ǵ� ����
FROM employees
START WITH employee_id = 100 
CONNECT BY PRIOR employee_id = manager_id;            

100
    101
        108
            109
            110
            111
            112
            113
            
SELECT LEVEL, lpad(salary,2*level-2,' ') || last_name
FROM employees
START WITH employee_id = 100 
CONNECT BY PRIOR employee_id = manager_id;             

SELECT LEVEL, lpad(' ',2*level-2,' ') || last_name, employee_id, manager_id
FROM employees
WHERE employee_id != 101 --101�� ����� ����
START WITH employee_id = 100 
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name; -- ���� �˻��� ������ ������ ���� siblings �ɼ��� �����ؾ� �ϰ� ��ġǥ����� ����� �� ����.

SELECT LEVEL, lpad(' ',2*level-2,' ') || last_name, employee_id, manager_id
FROM employees
START WITH employee_id = 100 
CONNECT BY PRIOR employee_id = manager_id
--ORDER SIBLINGS BY last_name
AND employee_id != 101;

[���� 89] select ���� �̿��ؼ� 1~100 ������ּ���.
SELECT level
FROM dual
connect by level <=100;

[���� 90] select���� �̿��ؼ� 2���� ������ּ���.
2��
---
2 * 1 = 2
2 * 2 = 4
...
2 * 9 = 18

SELECT '2 * '|| level || ' = ' || 2 * level "2��"
FROM dual
CONNECT BY level <= 9;


[���� 91] ���������
SELECT 2 || ' * '|| level || ' = ' || 2 * level "2��",
        3 || ' * '|| level || ' = ' || 3 * level "3��",
        4 || ' * '|| level || ' = ' || 4 * level "4��",
        5 || ' * '|| level || ' = ' || 5 * level "5��",
        6 || ' * '|| level || ' = ' || 6 * level "6��",
        7 || ' * '|| level || ' = ' || 7 * level "7��",
        8 || ' * '|| level || ' = ' || 8 * level "8��",
        9 || ' * '|| level || ' = ' || 9 * level "9��"
FROM dual
CONNECT BY level <=9;

SELECT dan || '*' || num || ' = ' || dan*num ������
FROM (SELECT level + 1 dan
        FROM dual
        CONNECT BY level <= 8),
     (SELECT level num
        FROM dual
        CONNECT BY level <= 9); --īƼ�ǰ��� �߻����Ѽ� �۾��ϴ� ���
        
DQL(Data Query Language)
SELECT : �����ͺ��̽��� �ִ� �����͸� ��ȸ�ϴ� SQL��

DDL(Data Definition Language)
- create
- alter
- drop
- rename
- truncate
- comment

�� ��������
����(privilege)
- Ư���� SQL���� ������ �� �ִ� �Ǹ�
- �ý��۱��� : �����ͺ��̽��� ������ �� �� �ִ� ����
- ��ü���� : ��ü�� ����� �� �ִ� ����
- ROLE(��) : �������� �ο��� �� �ִ� ������ ��� ���� ��ü, ���������� ���� ����

- ���� ���� �ý��۱����� Ȯ��
SELECT * FROM user_sys_privs; --���� ���� �ý��۱����� Ȯ��
--create session ���� �߿��� ����

- ���� ���� �Ǵ� ���� �ο��� ��ü������ Ȯ��
SELECT * FROM user_tab_privs;

- ���� ���� ���� Ȯ��
SELECT * FROM session_roles;

- ���� ���� �Ѿȿ� �ý��� ������ Ȯ��
SELECT * FROM role_sys_privs;

- ���� ���� �Ѿȿ� ��ü������ Ȯ��
SELECT * FROM role_tab_privs;

- �� �� ����
SELECT * FROM user_users;


�� table ����(object, segment)
- �����͸� �����ϴ� ��ü
- ��� ���� �����Ǿ� �ִ�.

�����̺��� �����Ϸ��� �ΰ����� üũ�ؾ��Ѵ�.
1. ���̺��� ������ �� �ִ� ����
    create table �ý��۱���
select * from session_privs;
2. ���̺��� ������ �� �ִ� ���̺����̽� ����
select * from user_ts_quotas; --hr(�Ϲ�����)���忡�� Ȯ��
select * from dba_ts_quotas; -- sys���忡�� Ȯ��

# ���̺��̸�, �÷��̸�, �����̸�, �ٸ���ü�̸�, ���������̸�
- ���ڷ� ����(���ڷ� ����x)
- ������ ���̴� 1~30
- ����, ����, Ư������(_,#,$) �����ϴ�.
- ��ҹ��ڱ������� �ʽ��ϴ�.
- ������ ������ ������ ��ü�̸��� �ߺ��Ǹ� �ȵȴ�. --hr.emp, insa.emp
- ������ ����� �� ����.(select, distinct, ...)

# �÷��� Ÿ��
desc employees
- number(p,s) : �������� ���� Ÿ��, p : ��ü�ڸ���, s : �Ҽ����ڸ���, number(5,2) --��ü 5�ڸ��߿� �Ҽ����� 2�ڸ��� ����ϰڴ�
- varchar2(4000) :  �������� ���� Ÿ�� --���� ��ŭ�� , �ִ� 4000���� ��밡��
- char(2000) : �������� ���� Ÿ�� --������
- date : ��¥Ÿ��
- clob : �������� ���� Ÿ��, 4gbyte(�Ⱑ����Ʈ)
- blob : �������� ���� ������ Ÿ��, 4gbyte(�Ⱑ����Ʈ)
- bfile : �ܺ����Ͽ� ����� ���� ������Ÿ��, 4gbyte --�̹��� ���� ���� �ַ� bfile�� ���, ���� ������ �ִ� ���� os

�����̺� ����

create table hr.emp(
        id number(4),
        name varchar2(30),
        day date default sysdate);
        
hr.emp ���̺��� ��� ���̺����̽��� ������ �ǳ���??
���̺��� �����ϽǶ� ���̺����̽��� �������� ������ ���� �����ÿ� ������
default tablespace�� ����ȴ�.

select * from user_users;

select * from user_tables where table_name = 'EMP';

- ���̺� ����
drop table hr.emp purge;
        

create table hr.emp(
        id number(4),
        name varchar2(30),
        day date default sysdate)
tablespace users;

select * from user_tables where table_name = 'EMP';

desc emp 

DML(Data Manipulation Language)
- insert(�Է�)
- update(����)
- delete(����)
- merge(insert, update, delete)

TCL(Transaction Control Language)
- commit(DML ������ �����ϰڴ�)
- rollback(DML ������ ����ϰڴ�)
- savepoint(rollback ����� �����ִ� ǥ����)

Transaction(Ʈ�����) : �������� DML�� �ϳ��� ��� ó���ϴ� �۾�����

��insert��
���̺� ���ο� ���� �Է��ϴ� sql��
desc emp --insert �ϱ� ���� ���̺��� ������ Ȯ���� �Ŀ� insert���� ��������'
insert into ������.���̺�(�÷�,�÷�,...) --�������ڸ� �� �ᵵ�ǰ� ���� ������ �����
values(������,������,..);

--select * from nls_session_parameters;
insert into hr.emp(id, name,day)
values(1,'ȫ�浿', to_date('2021-12-16', 'yyyy-mm-dd')); --�� ����
select * from hr.emp; --Ȯ��(�̸�����) ->������ ������ x ->sqlplus���� �Ⱥ���
commit; --������ ����

insert into hr.emp(id,name,day) -- transaction ����
values(2,'����ȣ', sysdate);
select * from hr.emp; --�̸�����

insert into hr.emp(id,name,day)
values(3,'����',to_date('2021-11-20', 'yyyy-mm-dd'));
select * from hr.emp; --�̸�����

commit; --transaction ����

select * from hr.emp;

insert into hr.emp(id,name,day) -- transaction ����
values(4,'����',to_date('2020-1-10', 'yyyy-mm-dd'));

select * from emp;
rollback; --������ ���, transaction ����
select * from emp;

desc emp

insert into hr.emp(id,name,day)
values(4,'����', to_date('2021-01-01', 'yyyy-mm-dd'));

--day�÷��� default ���� �����Ǿ� ������ default���� �Էµȴ�.
-- insert�� �����ϴ� ������ default������ ������ sysdate���� �Էµȴ�.
insert into hr.emp(id,name)
values(5,'�̹���');

insert into hr.emp(id,name,day)
values(6,'�����',default);

select * from emp;

commit;

# null���� �Է��ϴ� ���
insert into hr.emp(id,name,day)
values(7,'�ϵ�',null); --day �÷��� default���� �����Ǿ��ִ��� null�� �켱������ ����. ������� �����ϴ� nba�󱸼���
select * from emp; --�̸�����

insert into hr.emp(id,name,day)
values(8,null,null);
select * from emp;--�̸����� 

commit; --Ŀ���ϱ� ���� �̸������ ���� Ȯ�� �Ϸ��ϰ� �Ϻ��� �Ǹ� Ŀ���ϵ���
rollback; --�̹� transaction�� commit�� �����߱⶧���� rollback�� �����ص� �ǹ̰� ����.
select * from hr.emp;

�� update
- Ư���� �ʵ尪�� �����ϴ� SQL��

update ������.���̺�
set ������ �ʵ尡 �ִ� �÷� = ���ο� ��
where ����;

update hr.emp -- transaction ����
set day = to_date('2002-01-01', 'yyyy-mm-dd');

select * from hr.emp; -- �̸�����

rollback; --������ ���, transaction ����
select * from hr.emp;

update hr.emp
set day = to_date('2001-01-01','yyyy-mm-dd')
where id =1;

select * from hr.emp; --�̸�����
commit;

-- �����÷��� �ʵ尪�� ����
update hr.emp
set name = 'Ŀ��', day = default
where id = 8;

select * from hr.emp where id = 8;

commit;

- null������ ����(�࿡ �ִ� �ʵ� ����)
update hr.emp
set day = null
where id =2;
select * from hr.emp;
commit;
�� delete��
- ���� �����ϴ� SQL��
delete from ������.���̺�;
delete from ������.���̺� where �����ؾ��� ���� ����;

delete from hr.emp; --��ü�� �� ������
select * from hr.emp;
rollback;
select * from hr.emp;

delete from hr.emp
where id = 1;

select * from hr.emp;
commit;

delete from hr.emp where id in (2,3,4);
select * from hr.emp;
rollback;