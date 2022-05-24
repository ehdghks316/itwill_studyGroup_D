�����̺� ����, ctas
-���̺���, ��(������),���������߿� not null�� �����ȴ�.

desc employees
drop table hr.emp purge;
-���̺� ����

create table hr.emp
as select * from hr.employees;
-emp���̺� ����,  emp���̺�� employees���̺��� ����
desc hr.emp_20 
select * from hr.employees;

create table emp_20
as select employee_id, upper(last_name) name, salary
from employees
where department_id =20;
-emp_20���̺��� ����, employees���̺��� employee_id, last_name, salary�� ����, ������ department_id�� 20�� ��
select * from emp_20;

drop table emp purge; --emp ���̺� ����
drop table emp_20 purge; --emp_20���̺� ����

> �����ʹ� �����ϰ� ���̺��� ������ ����
create table emp
as select * from employees where 1=2;
-emp���̺� employees���̺��� �����ϴµ� ������ ���� 1=2 �� �´� ���� �� �� �ְ� ���ǿ� �����ϴ� �����Ͱ� ���⿡ �ƹ��͵� ������ �����ʰ� ����(����,�÷�)�� �����ȴ�
desc emp
select * from emp;

��insert subquery

select * from emp;

insert into emp --transaction ����
select * from employees;
select * from emp;
commit; -- ������ ����, transaction ����

drop table emp purge;

create table emp(
        id number,
        name varchar2(60),
        dept_id number,
        dept_name varchar2(30))
tablespace users;

desc emp

insert into emp(id,name)
select employee_id, last_name || ' '|| first_name
from employees;


select * from emp;

commit;

��ETL(Extraction(����), Transformation(����), Loading(����))


�� update subquery
select * from emp;

update emp -- transaction ����
set name = null
where id = 100;
select * from emp where id = 100; --�̸�����
commit; --������ ����, transaction ����

update emp
set name = (select last_name ||' '|| first_name
        from employees
        where employee_id = 100);
        
select * from emp;
rollback;

update emp
set name = (select last_name ||' '|| first_name
        from employees
        where employee_id = 100)
where id = 100;        

select * from emp where id =100;
commit;
        
select * from emp;

update emp
set dept_id = (select department_id
                from employees
                where employee_id = 100)
where id = 100;

select * from emp;

update emp
set dept_id = (select department_id
                from employees
                where employee_id = 101)
where id = 101;

select * from emp;

rollback;

- correlated subquery �̿��� update
update emp e
set dept_id = (select department_id
                from employees
                where employee_id = e.id);

select * from emp;              

commit;
select * from emp;

update emp e
set dept_name = (select department_name
                    from departments
                    where department_id = e.dept_id);

select * from emp;
commit;
select * from emp;

�� delete subquery

select * from emp where name like 'K%';

delete from emp
where id in (select id from emp where name like 'K%');

select * from emp where name like 'K%';
rollback;

select * from emp where name like 'K%';

delete from emp
where name like 'K%';
rollback;

[����94] emp���̺� �ִ� ������ �߿� job_history�� �����ϴ� ������� ������ �ּ���.
select *
from emp
where id in (select employee_id
                from job_history); --�˻�

select * 
from emp e
where exists ( select 'x'
                from job_history
                where employee_id = e.id);
 1)                     
delete from emp
where id in ( select employee_id
                from job_history);
select * from emp;                

rollback;
2) exists�� ��ȣ(���ɻ�)
delete from emp e
where exists (select 'x'
                from job_history
                where employee_id = e.id);
select * 
from emp e
where exists ( select 'x'
                from job_history
                where employee_id = e.id);
rollback;                
                

�� �ڵ� commit �߻��� ��
- DDL(create, alter, drop, rename, truncate, comment)
- DCL(grant, revoke)
- sqlplus���� exit�� �����ؼ� �����ϸ� auto commit ������ �ִ�.
- sqlplus ���� �ٸ� ������ ������ �� connect(conn)

�� �ڵ� rollback �߻��� ��
- â�ݱ⸦ �ϸ� ���������� ����
- ��Ʈ��ũ�� ��ְ� �߻��ϴ� ���
- ��ǻ�Ͱ� ������������ ����

�ڡڡڡڡ����ǡڡڡڡڡ�
- DML�۾��� ������ �� �� ��������� transaction�� �����ϴ� ������ ����
- ��Ȯ�ϰ� commit, rollback�� �ؾ����� ��������� �� �����ϴ� ������ ����

select * from emp;
delete from emp; -- transaction ����
select * from emp;
create table dept
as select * from departments; -- transaction ���� ���������� auto commit ����ȴ�.
select * from dept;
select * from emp;
rollback; --delete ��Ҹ� �Ϸ��� ������ ������ auto commit ����Ǿ��� ������ ��Ҵ� �ǹ̰� ����.
select * from emp;

select * from dept;

insert into dept
select * from departments;
commit;
select * from dept;

create table emp_20
as select employee_id, last_name
from employees
where department_id = 20;

select * from emp_20;

insert into emp_20(employee_id, last_name) --transaction����
values(300, 'ȫ�浿');
select * from emp_20;

update emp_20
set last_name = '����ȣ'
where employee_id = 201;
select * from emp_20;

delete from emp_20 where employee_id = 202;

select * from emp_20;

rollback; --transaction���۽������� ���� rollback �ȴ�.

select * from emp_20;

-----

��savepoint
- dml�۾��ÿ� rollback�� �����ִ� ǥ����
- commit, rollback �� transaction�� ����ȸ� savepoint ��������.

insert into emp_20(employee_id, last_name) --transaction����
values(300, 'ȫ�浿');

select * from emp_20;

savepoint a;

update emp_20
set last_name = '����ȣ'
where employee_id = 201;

select * from emp_20;

savepoint b;

delete from emp_20 where employee_id = 202;

select * from emp_20;

rollback to b; --ǥ���� b ���Ͽ� �ִ� delete�� ��ҵȴ�. ���� �ִ� insert, update ����ִ�.

select * from emp_20;
commit;  -- insert,update ������ ����ȴ�.
select * from emp_20;

�ڴ������̺� insert (9i)
- source ���̺��� �����͸� �����ؼ� �������� target�� �����ϴ� SQL��
- ETL(Extraction(����), Transformation(����), Loading(����))
- source �ý��ۿ��� ������ �����ؼ� Data Warehouse �� �������� �۾�

1. ������ insert all

create table sal_history
as select employee_id, hire_date, salary from employees where 1 = 2;

select * from sal_history;

create table mgr_history
as select employee_id, manager_id, salary from employees where 1 = 2;

select * from mgr_history;

source table(employees) ---------> target table(sala_history, mgr_history)
                          ETL�۾�

��)
insert into sal_history(employee_id, hire_date, salary)
select employee_id, hire_date, salary
from employees;

select * from sal_history;

insert into mgr_history(employee_id, manager_id, salary)
select employee_id, manager_id, salary
from employees;

select * from mgr_history;

rollback;

select * from mgr_history;

insert all
into sal_history(employee_id, hire_date, salary) values(employee_id, hire_date, salary)
into mgr_history(employee_id, manager_id, salary) values(employee_id, manager_id, salary)
select employee_id, hire_date, manager_id, salary
from employees;

select * from sal_history;
select * from mgr_history;

rollback;

insert all
into sal_history(employee_id, hire_date, salary) values(id,day,sal)
into mgr_history(employee_id, manager_id, salary) values(id,mgr,sal)
select employee_id id, hire_date day, manager_id mgr, salary*1.1 sal
from employees;

select * from sal_history;
select * from mgr_history;

rollback;

2. ���� insert all
create table emp_history
as select employee_id, hire_date, salary from employees where 1 = 2;

create table emp_sal
as select employee_id, commission_pct, salary from employees where 1 = 2;

select * from emp_history;
select * from emp_sal;

insert all
when day < to_date('2005-01-01','yyyy-mm-dd') and sal >= 5000 then
    into emp_history(employee_id,hire_date, salary) values(id,day,sal)
when comm is not null then 
    into emp_sal(employee_id,commission_pct,salary) values(id,comm,sal)
select employee_id id, hire_date day, salary sal, commission_pct comm
from employees;

select * from emp_history;
select * from emp_sal;

select employee_id from emp_history
intersect
select employee_id from emp_sal;

select * 
from emp_history e
where exists (select 'x'
                from emp_sal
                where employee_id = e.employee_id);
                
3. ���� first insert
--������ �´� ���� ���� �־��ش�?

create table sal_low
as select employee_id, last_name, salary from employees where 1 = 2;

create table sal_mid
as select employee_id, last_name, salary from employees where 1 = 2;

create table sal_high
as select employee_id, last_name, salary from employees where 1 = 2;

select * from sal_low;
select * from sal_mid;
select * from sal_high;

insert first
when sal < 5000 then
    into sal_low(employee_id, last_name,salary) values(id,name,sal)
when sal between 5000 and 10000 then 
    into sal_mid(employee_id, last_name,salary) values(id,name,sal)
else    
    into sal_high(employee_id, last_name,salary) values(id,name,sal)
select employee_id id, last_name name, salary sal
from employees;

select * from sal_low;
select * from sal_mid;
select * from sal_high;

[����95] ����� �߿� �ٹ������� 15�� �̻� �̸鼭 �޿��� 10000�̻� �޿��� �޴� ������� 
emp_1���̺� ���, �̸�(last_name), �Ի���, �ٹ�����, �޿� ������ �Է��ϰ� 
�ٹ������� 15�� �̻� �̸鼭 �޿��� 10000�̸� �޿��� �޴� ������� 
emp_2���̺� ���, �̸�(last_name), �Ի���, �ٹ�����, �޿� ������ �Է��ϼ���.
create table emp_1(id number, name varchar2(30), day date, years number, sal number);
create table emp_2(id number, name varchar2(30), day date, years number, sal number);

/* �ٽ� �����غ��� ŵ!
insert first
when year >= 15 and salary >= 10000 then
    into emp_1(id,name,day,years,sal)
    values (id,name,day,year,sal)
when year >= 15 and salary < 10000 then
    into emp_2(id,name,day,years,sal)
    values (id,name,day,year,sal)
select employee_id id, last_name name, hire_date day, to_number(to_char(sysdate, 'yyyy'))-to_number(to_char(hire_date,'yyyy')) year,salary sal
from employees;
*/ 

insert first
when sal >= 10000 then
    into emp_1(id,name,day,years,sal) values(id,name,day,year,sal)
else
    into emp_2(id,name,day,years,sal) values(id,name,day,year,sal)
select employee_id id, last_name name, hire_date day,
        floor(months_between(sysdate,hire_date) / 12) year,salary sal
from employees
where months_between(sysdate,hire_date) / 12 >= 15;

select * from emp_1;
select * from emp_2;
rollback;

oltp(online transaction processing) : �¶��� ����ڵ��� �����ͺ��̽��� DML �۾��� �����ϴ� ����
olap(online analytical processing) : ������ �м��ϰ� �ǹ��ִ� ������ �����ϴ� ����

create table oltp_emp
as select employee_id, last_name, salary, department_id
from employees;

create table dw_emp
as select employee_id, last_name, salary, department_id
from employees
where department_id = 20;

select * from oltp_emp;
select * from dw_emp;

desc oltp_emp

-���� ���̺��� �÷��� �߰��ϴ� ���
alter table oltp_emp add flag char(1);

desc oltp_emp

select * from oltp_emp;

select * from oltp_emp where employee_id in (201,202);

update oltp_emp
set flag = 'd'
where employee_id = 202;

update oltp_emp
set salary = 20000
where employee_id = 202;

commit;

select * from oltp_emp where employee_id in(201,202);

[����96] oltp_emp�� �ִ� ����� �߿� dw_emp�� �����ϴ� ����� ������ ������ּ���
select *
from oltp_emp o
where exists (select 'x'
                from dw_emp
                where employee_id = o.employee_id);
                
[����97] dw_emp�� �ִ� ����� �߿� oltp_emp�� �����ϴ� ������� oltp_emp�� �޿��� �������� 
        10% �λ����ּ���.
/*update oltp_emp d
set salary = salary *1.1
where exists (select 'x'
                from dw_emp
                where employee_id = d.employee_id);*/
update dw_emp d
set salary = (select salary * 1.1
                from oltp_emp
                where employee_id = d.employee_id);
select * --Ȯ��
from oltp_emp o
where exists (select 'x'
                from dw_emp
                where employee_id = o.employee_id);
rollback;
     
[����98] dw_emp�� �ִ� ����� �߿� oltp_emp�� �����ϴ� ����� �߿� flag ���� 'd'�� ����鿡 
        ���ؼ� �������ּ���.
select * from oltp_emp;

delete from dw_emp d
where exists (select 'x'
                from oltp_emp
                where employee_id = d.employee_id
                and flag = 'd');

select * from oltp_emp where flag = 'd';
rollback;
[����99] oltp_emp���̺� �ִ� ������ �߿� dw_emp���̺� ���� �����͵��� dw_emp���̺� �Է����ּ��� (�� Ǭ ����)
select * 
from oltp_emp o
where not exists (select 'x'
                    from dw_emp
                    where employee_id = o.employee_id);
                    
insert into dw_emp(employee_id, last_name, salary, department_id)
select employee_id, last_name, salary, department_id
from oltp_emp o
where not exists (select 'x'
                    from dw_emp
                    where employee_id = o.employee_id);

select * from dw_emp;                    
rollback;

�� merge
insert, update, delete ���� �Ѳ����� ������ �� �ִ� SQL��

select * from dw_emp; -- target table(���� update, delete, insert)
select * from oltp_emp; -- source table

merge into dw_emp d -- target table, insert,update,delete����
using oltp_emp o -- source table, select ����
on (d.employee_id = o.employee_id) -- ��������(Ű ���� �����)
when matched then -- Ű���� ��ġ�� �Ǹ�
    update set
        d.salary = o.salary * 1.1
    delete where o.flag = 'd'
when not matched then    
    insert(d.employee_id, d.last_name, d.salary, d.department_id)
    values(o.employee_id, o.last_name, o.salary, o.department_id);
    
select * from dw_emp;
rollback;

[���� 100] emp_copy ���̺� �ִ� department_name���� departments���̺� �ִ� 
            department_name���� �̿��ؼ� �������ּ���.
create table emp_copy as select * from employees;
alter table emp_copy add department_name varchar(30);
desc emp_copy
select * from emp_copy;

1) update
update emp_copy c --�ΰ��� ���� ������Ʈ�� ���ԵǴ� 107�� ������Ʈ
set department_name = (select department_name
                        from departments
                        where department_id = c.department_id);

select * from emp_copy;    
rollback;

2) merge
merge into emp_copy c 
using departments d
on (c.department_id = d.department_id)
when matched then 
    update set
    c.department_name = d.department_name;

select * from emp_copy;    
