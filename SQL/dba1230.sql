show user

- 데이터베이스에 생성된 유저 정보
SELECT * FROM dba_users;

- 시스템권한을 어떤 유저한테 부여 했는지 확인
SELECT * FROM dba_sys_privs WHERE grantee ='HR';

- 객체권한을 어떤 유저한테 부여 했는지 확인
SELECT * FROM dba_tab_privs WHERE grantee = 'HR';

- 데이터베이스에 생성된 롤에 대한 정보 확인
SELECT * FROM dba_roles;

- 유저한테 부여한 롤에 대한 정보 확인
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
- 정렬작업 수행할 때 메모리에 수행 다 못하면 디스크로 내려 가야한다.


오라클 데이터베이스에 데이터를 저장하는 구조

    논리적         물리적
  database         os
  tablespace   --<-data file -- 업무별로 분리가 되어 있다.
  segment(table,index)
   extent
   block           os block
block : 오라클의 최소 INPUT/OUTPUT 단위, 2K, 4K, 8K(기본값), 16K

책 = table(segment)
장 = extent
페이지 = block
문장(단어) = row


SELECT * FROM dba_data_files;

유저생성
CREATE user james
identified by james
default tablespace users -- 테이블 생성시 사용할 수 있는 테이블 스페이스
temporary tablespace temp --정렬작업시 메모리에서 다 할 수 없으면 데이터를 임시로 저장하는 공간
quota 10m on users; -- tablespace를 사용할 수 있는 권한

SELECT * FROM dba_users WHERE username = 'JAMES'; --대소문자 구분해야하는 점
SELECT * FROM dba_ts_quotas;

권한부여
DCL(Data Control Language)
- grant : 권한 부여
- revoke : 권한 회수

- create session 권한을 유저한테 부여 하는 방법
grant create session to james; --james에게 권한 부여
--grant 시스템 권한 to 유저이름;

select * from dba_sys_privs where grantee = 'JAMES';

-- 시스템권한을 유저로부터 회수하는 방법
revoke create session from james;
-- revoke 시스템권한 from 유저이름;

select * from dba_sys_privs where grantee = 'JAMES';

유저 삭제
drop user insa;

select * from dba_users where username = 'JAMES';

[문제92] 새로운 유저를 생성해주세요.
유저이름 : insa
비밀번호 : oracle
DEFAULT TABLESPACE : users
TEMPORARY TABLESPACE : temp
users TABLESPACE 사용량 : 1M

CREATE USER insa
IDENTIFIED BY oracle
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 1m ON users;

SELECT * FROM dba_users WHERE username = 'INSA'; --확인

[문제93] insa 유저에서 create session 권한을 부여 해주세요
GRANT CREATE SESSION TO insa;

SELECT * FROM dba_sys_privs WHERE grantee = 'INSA'; --확인


유저 정보 수정
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

SELECT * FROM dba_ts_quotas; -- max_blocks -1이 무한으로 사용할 수 있는 권한, quota값이 0이면 그 테이블스페이스는 사용불가

- create table 시스템 권한을 유저한테 부여
grant create table to insa;
select * from dba_sys_privs where grantee = 'INSA';

- create table 시스템 권한을 유저한테 회수
revoke create table from insa;

