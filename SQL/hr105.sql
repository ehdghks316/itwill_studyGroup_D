�� sequence
- �ڵ��Ϸù�ȣ�� �����ϴ� ��ü
- sequence ��ü�� �����Ϸ��� create sequence �ý��۱����� �ʿ�

select * from session_privs;

-- SEQUENCE ��ü ����

create sequence id_seq;
select * from user_sequences where sequence_name = 'ID_SEQ';

create table seq_test(id number, name varchar2(30), day timestamp); --seq_test���̺� ����
insert into seq_test(id,name,day) values(id_seq.nextval,'ȫ�浿', localtimestamp); --nextval : �����÷�
select * from seq_test;
insert into seq_test(id,name,day) values(id_seq.nextval,'����ȣ', localtimestamp); --nextval : �����÷�
select * from seq_test;
select id_seq.currval from dual;

- sequence�̸�.nextval : �����÷�, �����밡���� ��ȣ�� �������ش�.
- sequence�̸�.currval : �������� ��ȣ�� �������ش�.

select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';
select * from seq_test;
rollback;
select * from seq_test;

insert into seq_test(id,name,day) values(id_seq.nextval,'ȫ�浿', localtimestamp); --nextval : �����÷�
select * from seq_test;
insert into seq_test(id,name,day) values(id_seq.nextval,'����ȣ', localtimestamp); --nextval : �����÷�
select * from seq_test;
select id_seq.currval from dual;
commit;
select * from user_sequences where sequence_name = 'ID_SEQ';

- SEQUENCE ����
drop sequence id_seq;
select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';

create sequence id_seq
start with 1
maxvalue 3
increment by 1
nocycle -- cycle �ϸ� ��� 123123�ݺ�
nocache -- �Ź� nextval�� ������ �����ϰڴ�, cache 20
;

select * from user_sequences where sequence_name = 'ID_SEQ'; --last_number : ��������ȣ

insert into seq_test(id,name,day) values(id_seq.nextval,'����', localtimestamp); 
select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';
insert into seq_test(id,name,day) values(id_seq.nextval,'����', localtimestamp); 
select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';

insert into seq_test(id,name,day) values(id_seq.nextval,'Ŀ��', localtimestamp); 
select * from seq_test; --��ȣ�� ��ġ�Ե�(Ű���� �浹)
select * from user_sequences where sequence_name = 'ID_SEQ';
insert into seq_test(id,name,day) values(id_seq.nextval,'�����', localtimestamp); 
select * from seq_test; --nextval������ ����

- sequence ����
alter sequence id_seq
maxvalue 100;

select * from user_sequences where sequence_name = 'ID_SEQ';
insert into seq_test(id,name,day) values(id_seq.nextval,'�����', localtimestamp); 
select * from seq_test;
rollback;

> sequence ����, start with �� �����ϰ� �ٸ� �ɼǵ��� ������ �� �ִ�.
alter sequence id_seq
increment by 2
maxvalue 100
cache 20; 
select * from user_sequences where sequence_name = 'ID_SEQ';

drop table seq_test;
drop sequence id_seq;

�� SYNONYM(���Ǿ�) 
- �� ��ü �̸��� ª�� �̸����� ����ϴ� ��ü
- CREATE SYNONYM �ý��۱��� �ʿ��ϴ�.
- ��� �������� ����� �� �ִ� synonym�� �����Ϸ��� create public synonym �ý��۱����� �־�� �Ѵ�.(dba(sys)���� ������ �޾ƾ���)
select * from session_privs;

create table emp_copy_2022 as select * from employees;
select * from emp_copy_2022;

> synonym ����
create synonym ec2 for emp_copy_2022; -- ��ȥ�ڸ� ����� �� �ִ� synonym
select * from user_synonyms where table_name = 'EMP_COPY_2022'; 
select * from ec2;
select * from emp_copy_2022;

> synonym ����
drop synonym ec2;
select * from user_synonyms where table_name = 'EMP_COPY_2022'; 

select * from user_tab_privs;
grant select on hr.employees to ora; --hr�Ƚᵵ ��
--select on hr.employees�ϴ� �����鿡�� �� synonym�� ���� �ϰ� �ʹ�?
grant select on hr.departments to ora;
select * from user_tab_privs;

select * from session_privs;

> public synonym ����
create public synonym emp for hr.employees;
create public synonym dept for hr.departments;
select * from user_synonyms; -- ���� ����PUBLIC SYNONYM ���� Ȯ�� �Ұ�, 
select * from all_synonyms where table_owner = 'HR'; -- ���� ����PUBLIC SYNONYM ���� Ȯ��

> select ������ ȸ��
revoke select on hr.employees from ora;
revoke select on hr.departments from ora;

> select ������ �ο�
grant select on hr.employees to ora;
grant select on hr.departments to ora;

> public synonym ����
drop public synonym emp; -- drop�� �����ϸ� ���� �߻�(drop public synonym �ý��۱����� ���� ������)
select * from session_privs;
drop public synonym emp;
drop public synonym dept;
select * from all_synonyms where table_owner = 'HR'; -- ���� ����PUBLIC SYNONYM ���� Ȯ��

select *
from hr.employees
where employee_id = 100;

optimizer : SQL���� �����ϱ� ���� �����ȹ�� �����.

�� Data access method
å = ���̺�
������(page) = block(4k,(8k),16k,32k)
���� = ��(row)
Ư���� �ܾ�(����Ŭ) ã�ƾ� �Ѵ�.?

> full table scan (Ư���� ���̺� Ư���� �ܾ ã�� �� ù��° block�������� ������block���� access�ϴ� ���)
- ���̺� ù ��° ����� ������ ����� access�ϴ� ���
> rowid scan : ���� ������ �ּҸ� ������ ã�� ���, ������ access����߿� ���� ���� ���(��)���ּ�)
    1) BY USER ROWID SCAN
        select * from employees where rowid = 'AAAEAbAAEAAAADNAAA';
    2) BY INDEX ROWID SCAN
        select * from employees where employee_id = 100;
select rowid, employee_id
from employees;

select * from employees where rowid = 'AAAEAbAAEAAAADNAAA';
�����ȣ 100�� ����� ���ּҸ� rowid('AAAEAbAAEAAAADNAAA')�� ��� ������ٷ�?

rowid : ������ row �ּ�
AAAEAb(6�ڸ�) : data object id
select * from user_objects; --DATA_OBJECT_ID�� NULL�� ��������� �ʿ���� ���̺�

AAE(3�ڸ�) : file id
select * from dba_data_file; --����(dba���� ����) 

AAAADN(6�ڸ�) : block id
select * from user_segments where segment_name = 'EMPLOYEES';
select * from user_extents where segment_name = 'EMPLOYEES';

AAA(3�ڸ�) : row slot id(ã����� row�� �ִ� ��ġ)

select * from employees where rowid = 'AAAEAbAAEAAAADNAAA';
�����ȣ 100�� ����� ���ּ�(rowid('AAAEAbAAEAAAADNAAA'))�� ��� ������ٷ�?

�� INDEX
- by index rowid scan ����� ����ؼ� �˻��ӵ��� ���̱� ���ؼ� ���Ǵ� ��ü
- �ε����� �̿��ؼ� ���� �˻��ϸ� i/o(�Է�/���)�� ���� �� �ִ�.
- �ε����� ���̺���� ���������� �����ȴ�.
- �ε����� ����Ŭ�� �ڵ����� ���������Ѵ�.
- primary key, unique ���������� �����ϸ� unique index�� �ڵ����� �����ȴ�.
- �������� �����Ѵ�.
select * from user_indexes where table_name = 'EMPLOYEES';
select * from user_ind_columns where table_name = 'EMPLOYEES';
select * from employees;
--( ��)å�� ������������ ���ȣ�� �������� nonunique, �ϳ��� unique)

drop table emp purge;

create table emp as select * from employees; 
desc emp -- �÷� , Ÿ��, ��, not null�� ������
select * from user_constraints where table_name = 'EMP'; --�������� 
select * from user_cons_columns where table_name = 'EMP'; -- �������� �÷�
select * from user_indexes where table_name = 'EMP'; --index�� �������� ����
select * from user_ind_columns where table_name = 'EMP';--index�� �������� ����

select * from emp where employee_id = 100; --f10��Ű ������ optionsȮ�� -> full table scan�߻�
select rowid, employee_id from emp;
select * from emp where rowid = 'AAAFCSAAEAAAAHjAAA'; -- by user rowid scan

- primary key ���������� �߰�
alter table emp add constraint emp_id_pk primary key(employee_id);
select * from user_constraints where table_name = 'EMP';
select * from user_cons_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

select * from emp where employee_id = 100; --(f10) by index rowid scan

select employee_id, rowid
from emp
order by 1;
emp_id_pk �ε������� �Ʒ��� ���� �������� �ԷµǾ� �ִ�.
EMPLOYEE_ID     ROWID
100	AAAFCFAAEAAAAI7AAA
101	AAAFCFAAEAAAAI7AAB
102	AAAFCFAAEAAAAI7AAC
103	AAAFCFAAEAAAAI7AAD
104	AAAFCFAAEAAAAI7AAE
105	AAAFCFAAEAAAAI7AAF
.......

select * from emp where employee_id = 100; -- by index rowid scan (emp_id_pk�� by index rowid�� ������ emp���̺��� ��ĵ)
1) 100���� �ش��ϴ� rowid�� emp_id_pk �ε����� ���� ã��
2) ã�� rowid������ emp ���̺� access�ϰ� ����

select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

select * from emp where last_name = 'King'; --full table scan

- nonunique index ����
create index emp_last_name_idx on emp(last_name);
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

select * from emp where last_name = 'King'; -- by index rowid scan

select last_name, rowid
from emp 
order by 1;
select * from emp where last_name = 'King'; -- by index rowid scan
1) 'King'�� �ش��ϴ� rowid�� emp_last_name_idx�� ���� ã�´�
2) ã�� rowid������ emp ���̺� ã�� ����.
    select * from emp where rowid = 'AAAFCFAAEAAAAI7AAA';
3) �ٽ� 'King'�� �ش��ϴ� rowid�� emp_last_name_idx�� ���� ã�´�
4) ã�� rowid������ emp ���̺� ã�� ����.
    select * from emp where rowid = 'AAAFCFAAEAAAAI7AA4';
5) �ٽ� 'King'�� �ش��ϴ� rowid�� emp_last_name_idx�� ���� ã�´�. ������ ����!
6) ��� ������ �������� ����
emp_last_name_idx
....
Khoo	AAAFCFAAEAAAAI7AAP
King	AAAFCFAAEAAAAI7AAA
King	AAAFCFAAEAAAAI7AA4
Kochhar	AAAFCFAAEAAAAI7AAB
Kumar	AAAFCFAAEAAAAI7ABJ
Ladwig	AAAFCFAAEAAAAI7AAl
....

> primary key �������� ����
select * from user_constraints where table_name = 'EMP';
select * from user_cons_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

alter table emp drop primary key;

- nonunique index ����
create index emp_id_idx on emp(employee_id); -- employee_id�� �ε��� ����
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from emp where employee_id = 100; -- index range scan
1) 100���� �ش��ϴ� rowid�� emp_id_idx �ε����� ���� ã��
2) ã�� rowid������ emp ���̺� access
3) �ٽ� 100���� �ش��ϴ� rowid�� emp_id_idx �ε����� ���� ã�ƺ��� ������ ����

- index ����
drop index emp_id_idx;
select * from user_indexes where table_name = 'EMP';

- unique index ����
- unique index �����ϰ� �Ǹ� employee_id �÷��� ���� �ߺ��Ǵ� ���� �Էµ� �� ����.
    �� unique ���������� ���� �� ó�� ȿ���� �ش�.
    
create unique index emp_id_idx on emp(employee_id); --�ߺ��Ǵ� ���� ������ �ȵ�
select * from user_constraints where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from emp where employee_id = 100; -- (f10) by index rowid, unique scan

create table test(id number, name varchar2(30));
create unique index test_id_idx on test(id);
select * from user_constraints where table_name = 'TEST'; --���������� ������ ����
select * from user_indexes where table_name = 'TEST';
insert into test(id,name) values(1,user); --user�Լ��� ���� insert�� �����ϴ� ����Ŭ ����
select * from test;
insert into test(id,name) values(1,user); -- id�÷��� unique index �����Ǿ� �ֱ⶧���� �ߺ��Ǵ� ���� ������ ���� �߻�
rollback;

drop table test purge; -- test���̺� ����
select * from user_indexes where table_name = 'TEST'; --���̺��� �����ϸ� �� ���̺�� ������ �ε����� �ڵ����� ������

select * from user_ind_columns where table_name = 'EMPLOYEES'; -- EMP_NAME_IX�� �ε����� 2��? -> �����ε���

---------------
select * 
from emp 
where last_name = 'King' --�ε��� ����
and first_name = 'Steven'; -- �ε��� ����

1) 'King'�� �ش��ϴ� rowid�� emp_last_name_idx�� ���� ã�´�
2) ã�� rowid������ emp ���̺� ã�� ����.
    select * from emp where rowid = 'AAAFCSAAEAAAAHjAAA' and first_name = 'Steven';
3)  ������ first_name = 'Steven' üũ�ϱ� ���ؼ� emp���̺� ã�ư��� ������
    ��� ���տ� �� �����͸� �����ϰ� ������ �ٽ� ���� �ܰ踦 �����ؾ� �Ѵ�.
4) �ٽ� 'King'�� �ش��ϴ� rowid�� emp_last_name_idx�� ���� ã�´�
5) ã�� rowid������ emp ���̺� ã�� ����.
    select * from emp where rowid = 'AAAFCSAAEAAAAHjAA4' and first_name = 'Steven';
6) ������ first_name = 'Steven' üũ�ϱ� ���ؼ� emp���̺� ã�ư��� ������
    ��� ���տ� �� �����͸� �����ϰ� ������ �ٽ� ���� �ܰ踦 �����ؾ� �Ѵ�.
7) �ٽ� 'King'�� �ش��ϴ� rowid�� emp_last_name_idx�� ���� ã�´�. ������ ����!
8) ��� ������ �������� ����
emp_last_name_idx
....
Khoo	AAAFCFAAEAAAAI7AAP
King	AAAFCFAAEAAAAI7AAA
King	AAAFCFAAEAAAAI7AA4
Kochhar	AAAFCFAAEAAAAI7AAB
Kumar	AAAFCFAAEAAAAI7ABJ
Ladwig	AAAFCFAAEAAAAI7AAl
....

select * from user_ind_columns where table_name = 'EMP';
drop index emp_last_name_idx;
> �����ε���
create index emp_last_first_name_idx on emp(last_name, first_name);
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select last_name, first_name, rowid
from emp
order by 1,2;
emp_last_first_name_idx
....
Khoo	Alexander	AAAFCFAAEAAAAI7AAP
King	Janette	    AAAFCFAAEAAAAI7AA4
King	Steven	    AAAFCFAAEAAAAI7AAA
Kochhar	Neena	    AAAFCFAAEAAAAI7AAB
....

select * 
from emp 
where last_name = 'King' --�ε��� ����
and first_name = 'Steven'; -- �ε��� ���� (last_name, first_name) �����ε���

1) last_name = 'King'�� first_name = 'Steven' ���� ���� �����ϴ� 
    rowid�� emp_last_first_name_idx�� ���� ã�´�
2) ã�� rowid������ emp ���̺� ã�� ����. 
    ������ ��������� ����� ���ؼ� ���� ���̺� ã�ư���. --(�޸𸮿� ���� �� 3)���� �޸𸮿� ����� ��������� �������� ����)
    select * from emp where rowid = 'AAAFCSAAEAAAAHjAAA'; 
3) �ٽ� last_name = 'King'�� first_name = 'Steven' ���� ���� �����ϴ� 
    rowid�� emp_last_first_name_idx�� ���� ã�ƺ��� ������ ������ �� ��������� �������� ����

---------------
�� COMMENT --���̺� �����ϸ� ������ �ּ��ޱ�(�������� ����̺� �����, �ּ��� ���� �̷� ������ ���̺��̱��� �� ������ �ڼ���)
���̺�� �÷��� �ּ�(����) �����.

drop table emp purge;
create table emp as select * from employees;

- ���̺� �ּ� ����
comment on table emp is '������� ���̺�';

- �÷� �ּ� ����
comment on column emp.employee_id is '���';
comment on column emp.department_id is '�μ��ڵ�';
- ���̺� �ּ� ���� Ȯ��
select * from user_tab_comments where table_name = 'EMP';

- �÷� �ּ� ���� Ȯ��
select * from user_col_comments where table_name = 'EMP';

- ���̺� �ּ� ����
comment on table emp is ''; -- ���ڿ��� �����

- �÷� �ּ� ����
comment on column emp.employee_id is ''; -- ���ڿ��� �����

select * from emp;

delete from emp;

rollback;

select * from user_segments where segment_name = 'EMP'; --BYTES : �� ���̺��� �뷮

delete from emp;
select * from emp;
rollback;
select * from emp;

���࿡ Ư���� ���̺��� �����͸� �� ������ ���̶�� ���Ϸ� undo ������ ������ �ϰڽ��ϱ�

�� truncate (���忡�� ����Ҷ� �����ϰ� �� �����ϰ� �� �����ϸ鼭 ���)
���̺��� ���� �� �����ϴ� ������ DELETE ���� ��������� 
�������� TRUNCATE���� ��������� �ʱ���·� �����. 
truncate���� rollback�� �� �� ����.
truncate�ϴ� ��� ���� undo������ �Է����� �ʽ��ϴ�. ��? rollback�� �� ������ ���⶧����
������ 
Ư���� ���� �����Ϸ��� delete���� �̿��ؾ� �Ѵ�.
�ٽ� ���̺� ��ü ���� �����Ϸ��� delete��, truncate�� �� �� ����� �� �ִ�.
������ �������� undo �߻��ϴ���(delete), ���ϴ���(truncate)
�� ���� �ϼž� �� ���� truncate�� rollback�� �ȵȴ�. truncate������ ������ ���� ������
truncate table emp;
select * from emp;

----------
�� �м��Լ�
sum(salary) over() : ����

select sum(salary)
from employees;

select employee_id, department_id, salary, 691416, salary - 691416
from employees;

select employee_id, department_id, salary, sum(salary) over(), salary -sum(salary) over()
from employees;

select employee_id, department_id, salary, round(avg(salary) over()), round(salary -avg(salary) over())
from employees;

select employee_id, department_id, salary, max(salary) over(), salary - max(salary) over()
from employees;

select employee_id, department_id, salary, min(salary) over(), salary - min(salary) over()
from employees;

> ������
select employee_id, department_id, salary, sum(salary) over(order by employee_id) ������ -- employee_id������ �������� ���ϱ�
from employees;

select e2.employee_id, e2.department_id, e2.salary, e1.sumsal
from (select department_id, sum(salary) sumsal
        from employees
        group by department_id
        order by 1) e1, employees e2
where e1.department_id = e2.department_id
order by 2;

select employee_id, department_id, salary, sum(salary) over(partition by department_id) �μ������� -- partition by  �׷������ؼ� ������ ������
from employees;

select employee_id, department_id, salary, sum(salary) over(partition by department_id order by employee_id) �μ������� -- partition by  �׷������ؼ� ������ ������
from employees;

select employee_id, department_id, count(*) over(partition by department_id) �μ����ο���
from employees;

select employee_id, department_id, salary,
        count(*) over(partition by department_id) �μ����ο���,
        max(salary) over(partition by department_id) �μ����ְ�޿�,
        min(salary) over(partition by department_id) �μ��������޿�
from employees;


select employee_id, department_id, salary, sum(salary) over(order by employee_id) ������ 
from employees;

TOP-N
�ְ� �޿��� �߿� 10������ ���

1) �޿��� �������� �������� ����
select employee_id, salary
from employees
order by salary desc;

2) ������ ����� ������ 10������ ������ �ؾ� �Ѵ�.

- rownum : fetch��ȣ�� �����ϴ� �����÷�
select rownum, employee_id
from employees;


select rownum, employee_id, salary --order by���� where�� �켱������ ���Ƽ� ������� Ʋ���� ���´�
from employees
where rownum <= 10 -- �����ϰ� 10�� �̾�
order by salary desc; -- �����ϰ� 10�� �̾Ƴ� ����� ������ ����

������ : �츮 ȸ�翡 �Ȱ��� �޿��ڰ� ���ٶ�� �ϸ� �Ʒ��� ���� query���� �����ص� �ǰ�����
������ �޿��� �޴� ����� �ִٰ� �ϸ� ���� �Ʒ��� ���� query�� �̿��ؼ� top-n�м��ϸ� ū�� ����.
select *
from(select employee_id, salary
        from employees
        order by salary desc) e
where rownum <= 10;        

- rank() : ������ ���ϴ� �Լ�, ������ ������ ���� ��� ���� ������ ���� ���� �� �ִ�.
- dense_rank() : ������ ���ϴ� �Լ�, ������ ������ �ִ��� ������ ������ ���ϴ� �Լ�
select rank() over(order by salary desc) "rank",
    dense_rank() over(order by salary desc) "dense_rank",
    employee_id, salary
from employees;

select * 
from (select dense_rank() over(partition by department_id order by salary desc) dense_rank ,employee_id, salary
        from employees)
where dense_rank <= 10;        

select rank() over(partition by department_id order by salary desc) "�μ��� rank",
    dense_rank() over(partition by department_id order by salary desc) "�μ��� dense_rank",
    department_id, employee_id, salary
from employees;
