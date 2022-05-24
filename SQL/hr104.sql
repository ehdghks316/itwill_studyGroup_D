select * from tab;

drop table emp purge;

create table emp
as select employee_id, last_name, salary
from employees;

> ���� ������ ���̺��� ���� select ������ �ٸ� �������� �ο�
grant select on hr.emp to ora;

select * from user_tab_privs;

create table dept
as select * from hr.departments;

grant select on hr.departments to ora;
select * from user_tab_privs;
grant insert on hr.emp to ora;

select * from hr.emp;
grant update on hr.emp to ora;
select * from hr.emp where employee_id = 300;
grant delete on hr.emp to ora;

revoke delete on hr.emp from ora;
revoke select, insert,update,delete on hr.emp from ora;
grant select, insert,update,delete on hr.emp to ora;

drop table emp purge;

create table emp(id number, nams varchar2(30), day date);
desc emp

select * from user_tables where table_name = 'EMP';
select * from user_tab_columns where table_name = 'EMP';

# �÷��� �߰��ϴ� ���
alter table emp add job_id varchar2(20);
desc emp -- Ȯ��
select * from user_tab_columns where table_name = 'EMP'; -- Ȯ��

# �÷��� Ÿ��, ũ�⸦ ����
desc emp
alter table emp modify job_id varchar2(30); --���� Ÿ���� ���̸� �ø��� ���� �����Ͱ� ����־ ���氡��(Ÿ���� �����Ͱ� �� ������ ���� �Ұ�, �ִ� �������� ���̺��� �۰Ե� ����Ұ�)
desc emp
alter table emp modify job_id char(20);
desc emp
alter table emp modify job_id number; -- ���� �����Ͱ� ����Ǿ��� ��쿡�� Ÿ�Լ����� ������ �߻��� �� �ִ�.
desc emp

# �÷����� 
alter table emp drop column job_id;
desc emp
�߿��� �÷��� drop�ϸ� ������ �� �� ����.(ddl), �ٷ� commit�� �����
- ���ð��� �ǵ����� �� �� �ִ� ū ������ ����
rollback�� insert,update,delete(dml)�� ����

�� ��������
- ���̺��� �����Ϳ� ���� ��Ģ�� �����.
- �����Ϳ� ���� ǰ���� ����Ű�� ���ؼ� �����.

1.primary key
- ���̺��� ��ǥŰ
- unique, null���� ����� �� ����.
- ���̺�� �ϳ� ����
- �ڵ����� unique index ����

- �������� ���� Ȯ��
select * from user_constraints where table_name = 'EMP'; --�÷��� ������ �� ����
select * from user_cons_columns where table_name = 'EMP';

- �ε��� ���� Ȯ��
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';
- ���� ������ �߰�
alter table emp add constraint emp_id_pk primary key(id);
�Ǵ�
alter table emp add primary key(id) -- ���������̸��� ������� ������ �ڵ����� sys_c�����̸����� �������ش�.

- ���������� ����
alter table emp drop constraint emp_id_pk;
�Ǵ�
alter table emp drop primary key;

desc emp

insert into emp(id,nams,day) values(1,'ȫ�浿',sysdate);
insert into emp(id,nams,day) values(1,'����ȣ',sysdate); --����
insert into emp(id,nams,day) values(null,'�����', sysdate); --����
select * from emp;
rollback;

alter table emp drop primary key; --�������� ����
select * from user_constraints where table_name = 'EMP';


insert into emp(id,nams,day) values(1,'ȫ�浿',sysdate);
insert into emp(id,nams,day) values(1,'����ȣ',sysdate); --����
insert into emp(id,nams,day) values(null,'�����', sysdate); --����
select * from emp;
rollback;

drop table dept purge;
create table dept(dept_id number, dept_name varchar2(30)); --dept���̺� ����
alter table dept add constraint dept_pk primary key(dept_id);
--���������� �������� �� ������ ���������� ���������̸��� ������ �̸����� �����ؾ� �Ѵ�.
select * from user_constraints where table_name = 'DEPT'; --�������� Ȯ��
insert into dept(dept_id, dept_name) values(10,'�ѹ���'); --dept���̺� �� ����
insert into dept(dept_id, dept_name) values(20,'�м���');
commit;
select * from dept;

select * from emp;
alter table emp add dept_id number; -- �÷��� �߰�
select * from emp;

insert into emp(id,nams,day,dept_id) values(1,'ȫ�浿',sysdate,10);
insert into emp(id,nams,day,dept_id) values(2,'����ȣ',sysdate,30);
select * from emp;
commit;

������� �μ� ����, �μ� ������ ������ּ���.
select e.id, e.nams, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id(+);

delete from emp;
select * from emp;
commit;

select * from emp; -- ������̺�
select * from dept; -- �μ����̺�

2. foreign key
- �ܷ�Ű, �������Ἲ ��������
- ������ ���̺��̳� �ٸ� ���̺��� primary key �Ǵ� unique key ���������� �����Ѵ�.
- ������ ǰ���� �����ϱ����ؼ�
- �ߺ��� ���, null�� ���
- ���ӵǴ� �� ������ �����Ѵ�.

alter table emp add constraint emp_dept_id_fk
foreign key(dept_id) references dept(dept_id);

select * from user_constraints where table_name in ( 'EMP','DEPT');
--CONSTRAINT_TYPE : R -FROREIGN KEY�ɷ��ִ�, P -primary key
select * from user_cons_columns where table_name in ( 'EMP','DEPT');

insert into emp(id,nams,day,dept_id) values(1,'ȫ�浿',sysdate,10);
insert into emp(id,nams,day,dept_id) values(2,'����ȣ',sysdate,30); --���� : primary key�ȿ� 30�̶�� ���� ���⶧����
-- dept���̺��� dept_id�� parent key , emp�� dept_id�� child
insert into emp(id,nams,day,dept_id) values(2,'����ȣ',sysdate,null);
select * from emp;
commit;
select * from emp;
select * from dept;
delete from dept where dept_id = 10; --���� : �����ϰ� �ִ� �����Ͱ� �ֱ� ������ ������ �� ����.
delete from dept where dept_id = 20; --��������, �����ϰ� �ִ� �����Ͱ� ���� ������ ������ �� �ִ�.
rollback;

select * from user_constraints where table_name in ( 'EMP','DEPT');
select * from user_cons_columns where table_name in ( 'EMP','DEPT');

alter table dept drop primary key; --���� : foreign key ���������� �����ϰ� �ֱ� ������ �����߻�
1) alter table emp drop constraint EMP_DEPT_ID_FK;
2) alter table dept drop primary key;

alter table dept drop primary key cascade; -cascade �ɼ��� ����ϸ� foreign key ���������� ���� �����ϰ� primary key ���������� �����Ѵ�.
select * from user_cons_columns where table_name in ( 'EMP','DEPT');


3. unique ��������
- ������ ���� üũ
- null ���
- �ڵ����� unique index �����ȴ�.

select * from user_constraints where table_name = 'DEPT';
select * from dept;

dept ���̺� �ִ� dept_name ������ ���� �Էµ� �� �ֵ��� unique ���������� �߰�����.
alter table dept add constraint dept_name_uk unique(dept_name);
select * from user_constraints where table_name = 'DEPT'; --unique�ε��� �ڵ� ����?
select * from user_cons_columns where table_name = 'DEPT';
select * from user_indexes where table_name = 'DEPT';
select * from user_ind_columns where table_name = 'DEPT';

select * from dept;
insert into dept(dept_id, dept_name) values(30,'�ѹ���'); -- ���� : unique �������ǿ� ���ݵǾ ���� �߻�
insert into dept(dept_id, dept_name) values(30,null);
select * from dept;

rollback;

update dept
set dept_name = '�ѹ���'
where dept_id = 20; -- unique �������ǿ� ���ݵǾ ���� �߻�

# unique key ����
alter table dept drop constraint dept_name_uk;

# unique key ����
alter table dept add constraint dept_name_uk unique(dept_name);
select * from user_constraints where table_name = 'DEPT';

# unique key ����
alter table dept drop unique(dept_name);
select * from user_constraints where table_name = 'DEPT';

4. check ��������
- ���ǿ� ���� true�� ��� insert, update �� �� �ֵ��� ����� ��������
- null ����Ѵ�. �ߺ��Ǵ� �� ����Ѵ�.

select * from emp;

alter table emp add sal number; -- sal�÷� �߰�

select * from emp;

alter table emp add constraint emp_sal_ck check(sal >= 1000);

select * from user_constraints where table_name = 'EMP';

insert into emp(id,nams,day,dept_id,sal)
values(3,'Ŀ��',sysdate,20,500); --check�������Ƕ����� ���ǿ� ��� false �̱⶧���� ���� �߻�

update emp
set sal = 600 
where id = 1; --check�������Ƕ����� ���ǿ� ��� false �̱⶧���� ���� �߻�

insert into emp(id,nams,day,dept_id,sal) values(3,'Ŀ��',sysdate,20,5000);
select * from emp;
rollback;

# check �������� ����
alter table emp drop constraint emp_sal_ck;

# check �������� ����
alter table emp add constraint emp_sal_ck check (sal>=1000 and sal<=5000);
alter table emp add constraint emp_sal_ck check (sal between 1000 and 5000);
select * from user_constraints where table_name = 'EMP';

insert into emp(id,nams,day,dept_id,sal) values(3,'Ŀ��',sysdate,20,6000); -- check ���������� ���� ������ �����߻�
select * from emp;
rollback;

5. not null ��������
- null ���� ����� �� ���� ��������

select * from user_constraints where table_name = 'DEPT'; --�������� Ȯ��

select * from dept;
alter table dept add constraint dept_name_uk unique(dept_name);  --unique �������� �ɱ�
insert into dept(dept_id, dept_name) values(30,null);
rollback;
select * from dept;

- not null ���������� modify�� �̿��ؼ� �߰��ؾ� �Ѵ�.
--alter table dept add constraint dept_name_nn not null(dept_name); -- �����߻�

alter table dept modify dept_name constraint dept_name_notnull not null;
select * from user_constraints where table_name = 'DEPT'; --�������� Ÿ���� C�� �����µ� NOT NULL���� CHECK���� Ȯ���ϴ� ���� SEARCH_CONDITION����
select * from user_cons_columns where table_name = 'DEPT';

insert into dept(dept_id, dept_name) values(30,'�ѹ���'); -- unique �������ǿ� ���ݵǾ ���� �߻�
insert into dept(dept_id, dept_name) values(30,null); -- not null �������ǿ� ���ݵǾ ���� �߻�
rollback;

select * from user_constraints where table_name = 'DEPT';
select * from user_cons_columns where table_name = 'DEPT';

NOT NULL �������� ����
alter table dept drop constraint dept_name_notnull;
�Ǵ�
alter table dept modify dept_name null;
desc dept

drop table emp purge;
alter table dept add constraint dept_dept_id_pk primary key(dept_id);

create table emp(
    id number constraint emp_id_pk primary key, -- ������ ���� 
    name varchar2(30) constraint emp_name_nn not null, -- not null ���������� ������ ���Ǹ� �����Ѵ�.
    sal number,
    dept_id number constraint emp_dept_id_fk references dept(dept_id), -- foreign key ���������� ������ ������ �� ����!
    constraint emp_name_uk unique(name), --���̺� ���� ����(�������� Ÿ�Եڿ� �÷� �� ����)
    constraint emp_sal_ck check(sal between 1000 and 5000));
    
select * from user_constraints where table_name in('EMP','DEPT');  

drop table emp purge;

create table emp(
    id number constraint emp_id_pk primary key, -- ������ ���� 
    name varchar2(30) constraint emp_name_nn not null, -- not null ���������� ������ ���Ǹ� �����Ѵ�.
    sal number,
    dept_id number, 
    constraint emp_name_uk unique(name), --���̺� ���� ����(�������� Ÿ�Եڿ� �÷� �� ����)
    constraint emp_sal_ck check(sal between 1000 and 5000),
    constraint emp_dept_id_fk foreign key(dept_id) references dept(dept_id)); -- ���̺� ������ foreign key ���������� ���� �� �� ����!
    
select * from user_constraints where table_name in('EMP','DEPT');  

select * from emp;

�� ���̺� �̸� ����
1) ���1
drop table emp_copy purge;
rename emp to emp_copy;
select * from emp_copy;
select * from user_constraints where table_name = 'EMP_COPY'; --�̸��� �����ص� ���������� �� �ٲ�
select * from user_indexes where table_name = 'EMP_COPY'; --�̸��� �����ص� �ε����� �� �ٲ�
desc emp_copy

2) ���2
alter table emp_copy rename to copy_emp;
select * from user_constraints where table_name = 'COPY_EMP';
select * from user_indexes where table_name = 'COPY_EMP';

�� �÷� �̸� ����
desc copy_emp
alter table copy_emp rename column id to emp_id;
select * from user_constraints where table_name = 'COPY_EMP';
select * from user_cons_columns where table_name = 'COPY_EMP';
select * from user_indexes where table_name = 'COPY_EMP';
select * from user_ind_columns where table_name = 'COPY_EMP';
desc copy_emp

�� �������� �̸� ����
select * from user_constraints where table_name = 'COPY_EMP';
select * from user_cons_columns where table_name = 'COPY_EMP';

alter table copy_emp rename constraint emp_id_pk to copy_emp_id_pk;
select * from user_constraints where table_name = 'COPY_EMP'; 
select * from user_cons_columns where table_name = 'COPY_EMP';

select * from user_indexes where table_name = 'COPY_EMP'; --�ε��� �̸��� ���� �̸� �״�� ������ ����, ������ ����

�� �ε��� �̸� ����
select * from user_indexes where table_name = 'COPY_EMP';

alter index emp_id_pk rename to copy_emp_idx;

select * from user_indexes where table_name = 'COPY_EMP';
select * from user_ind_columns where table_name = 'COPY_EMP';