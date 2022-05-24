show user

- �����ͺ��̽��� ������ ���� ����
SELECT * FROM dba_users;

- �ý��۱����� � �������� �ο� �ߴ��� Ȯ��
SELECT * FROM dba_sys_privs WHERE grantee ='HR';

- ��ü������ � �������� �ο� �ߴ��� Ȯ��
SELECT * FROM dba_tab_privs WHERE grantee = 'HR';

- �����ͺ��̽��� ������ �ѿ� ���� ���� Ȯ��
SELECT * FROM dba_roles;

- �������� �ο��� �ѿ� ���� ���� Ȯ��
SELECT * FROM dba_role_privs WHERE grantee = 'HR';

SELECT *
FROM dba_tables
WHERE table_name = 'EMPLOYEES'
AND owner = 'HR';

SELECT * FROM hr.departments;
SELECT * FROM dba_data_files;
SELECT * FROM dba_temp_files;
SELECT * 
FROM hr.employees
ORDER BY employee_id desc;
- �����۾� ������ �� �޸𸮿� ���� �� ���ϸ� ��ũ�� ���� �����Ѵ�.


����Ŭ �����ͺ��̽��� �����͸� �����ϴ� ����

    ����         ������
  database         os
  tablespace   --<-data file -- �������� �и��� �Ǿ� �ִ�.
  segment(table,index)
   extent
   block           os block
block : ����Ŭ�� �ּ� INPUT/OUTPUT ����, 2K, 4K, 8K(�⺻��), 16K

å = table(segment)
�� = extent
������ = block
����(�ܾ�) = row


SELECT * FROM dba_data_files;

��������
CREATE user james
identified by james
default tablespace users -- ���̺� ������ ����� �� �ִ� ���̺� �����̽�
temporary tablespace temp --�����۾��� �޸𸮿��� �� �� �� ������ �����͸� �ӽ÷� �����ϴ� ����
quota 10m on users; -- tablespace�� ����� �� �ִ� ����

SELECT * FROM dba_users WHERE username = 'JAMES'; --��ҹ��� �����ؾ��ϴ� ��
SELECT * FROM dba_ts_quotas;

���Ѻο�
DCL(Data Control Language)
- grant : ���� �ο�
- revoke : ���� ȸ��

- create session ������ �������� �ο� �ϴ� ���
grant create session to james; --james���� ���� �ο�
--grant �ý��� ���� to �����̸�;

select * from dba_sys_privs where grantee = 'JAMES';

-- �ý��۱����� �����κ��� ȸ���ϴ� ���
revoke create session from james;
-- revoke �ý��۱��� from �����̸�;

select * from dba_sys_privs where grantee = 'JAMES';

���� ����
drop user insa;

select * from dba_users where username = 'JAMES';

[����92] ���ο� ������ �������ּ���.
�����̸� : insa
��й�ȣ : oracle
DEFAULT TABLESPACE : users
TEMPORARY TABLESPACE : temp
users TABLESPACE ��뷮 : 1M

CREATE USER insa
IDENTIFIED BY oracle
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 1m ON users;

SELECT * FROM dba_users WHERE username = 'INSA'; --Ȯ��

[����93] insa �������� create session ������ �ο� ���ּ���
GRANT CREATE SESSION TO insa;

SELECT * FROM dba_sys_privs WHERE grantee = 'INSA'; --Ȯ��


���� ���� ����
ALTER USER insa
IDENTIFIED BY insa
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 1m ON users;

select * from dba_ts_quotas;

ALTER user insa
QUOTA 10m ON users;

ALTER user insa
QUOTA unlimited ON users;

ALTER user insa
QUOTA 0 ON users;

SELECT * FROM dba_ts_quotas; -- max_blocks -1�� �������� ����� �� �ִ� ����, quota���� 0�̸� �� ���̺����̽��� ���Ұ�

- create table �ý��� ������ �������� �ο�
grant create table to insa;
select * from dba_sys_privs where grantee = 'INSA';

- create table �ý��� ������ �������� ȸ��
revoke create table from insa;

