[문제88] pivot을 이용해서 아래 화면과 같이 출력해주세요.

년도       SA_REP               SH_CLERK             ST_CLERK             행의합
---------- -------------------- -------------------- -------------------- ------------------------------------------
2003                     ￦0원                ￦0원            ￦7,100원            ￦7,100원
2004                ￦39,500원            ￦8,200원            ￦3,300원           ￦51,000원
2005                ￦74,800원           ￦15,400원           ￦18,100원          ￦108,300원
2006                ￦59,100원           ￦21,900원           ￦15,900원           ￦96,900원
2007                ￦38,200원           ￦13,400원            ￦6,900원           ￦58,500원
2008                ￦38,900원            ￦5,400원            ￦4,400원           ￦48,700원
열의합              ￦250,500원           ￦64,300원           ￦55,700원           ￦370,500원

select nvl(년도,'열의합') 년도,
        to_char(nvl(SA_REP,0),'L999,999')||'원' SA_REP,
        to_char(nvl(SH_CLERK,0),'L999,999')||'원' SH_CLERK,
        to_char(nvl(ST_CLERK,0),'L999,999')||'원' ST_CLERK,
        to_char(행의합,'L999,999')||'원' 행의합
from (select 년도, nvl(job_id,'x') job_id, sum_sal
        from (select to_char(hire_date,'yyyy') 년도, job_id, sum(salary) sum_sal
                from employees
                where job_id in ('SA_REP','SH_CLERK','ST_CLERK')
                group by cube(to_char(hire_date,'yyyy'), job_id)))
pivot(max(sum_sal) for job_id in ('SA_REP' "SA_REP", 'SH_CLERK' "SH_CLERK",'ST_CLERK' "ST_CLERK", 'x' "행의합"))
order by 1;

-------------------

★계층검색(hierarchical query) --분석할 때 많이 쓰임

SELECT employee_id, last_name, manager_id
FROM employees;

                               100
                 101
         108           200 203 204 205
109 110 111 112 113                206


SELECT employee_id, last_name, manager_id
FROM employees
START WITH employee_id = 101  --시작점, 시작해야 할 조건을 생성
CONNECT BY PRIOR employee_id = manager_id; --연결고리 조건

>하향식 (top-down방식, 위에서 아래로)
SELECT employee_id, last_name, manager_id
FROM employees
START WITH employee_id = 108  --시작점, 시작해야 할 조건을 생성
CONNECT BY PRIOR employee_id = manager_id; --연결고리 조건
              -------------------------->
>상향식 (bottom-up방식, 밑에서 위로)
SELECT employee_id, last_name, manager_id
FROM employees
START WITH employee_id = 100  --시작점, 시작해야 할 조건을 생성
CONNECT BY employee_id =  PRIOR manager_id; --연결고리 조건
            <----------------------------

SELECT LEVEL, employee_id, last_name, manager_id --LEVEL 계층검색에서 사용되는 형태
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
WHERE employee_id != 101 --101번 사원만 제외
START WITH employee_id = 100 
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name; -- 계층 검색된 내용을 정렬할 때는 siblings 옵션을 설정해야 하고 위치표기법은 사용할 수 없다.

SELECT LEVEL, lpad(' ',2*level-2,' ') || last_name, employee_id, manager_id
FROM employees
START WITH employee_id = 100 
CONNECT BY PRIOR employee_id = manager_id
--ORDER SIBLINGS BY last_name
AND employee_id != 101;

[문제 89] select 문을 이용해서 1~100 출력해주세요.
SELECT level
FROM dual
connect by level <=100;

[문제 90] select문을 이용해서 2단을 출력해주세요.
2단
---
2 * 1 = 2
2 * 2 = 4
...
2 * 9 = 18

SELECT '2 * '|| level || ' = ' || 2 * level "2단"
FROM dual
CONNECT BY level <= 9;


[문제 91] 구구단출력
SELECT 2 || ' * '|| level || ' = ' || 2 * level "2단",
        3 || ' * '|| level || ' = ' || 3 * level "3단",
        4 || ' * '|| level || ' = ' || 4 * level "4단",
        5 || ' * '|| level || ' = ' || 5 * level "5단",
        6 || ' * '|| level || ' = ' || 6 * level "6단",
        7 || ' * '|| level || ' = ' || 7 * level "7단",
        8 || ' * '|| level || ' = ' || 8 * level "8단",
        9 || ' * '|| level || ' = ' || 9 * level "9단"
FROM dual
CONNECT BY level <=9;

SELECT dan || '*' || num || ' = ' || dan*num 구구단
FROM (SELECT level + 1 dan
        FROM dual
        CONNECT BY level <= 8),
     (SELECT level num
        FROM dual
        CONNECT BY level <= 9); --카티션곱을 발생시켜서 작업하는 방식
        
DQL(Data Query Language)
SELECT : 데이터베이스에 있는 데이터를 조회하는 SQL문

DDL(Data Definition Language)
- create
- alter
- drop
- rename
- truncate
- comment

■ 유저관리
권한(privilege)
- 특정한 SQL문을 수행할 수 있는 권리
- 시스템권한 : 데이터베이스에 영향을 줄 수 있는 권한
- 객체권한 : 객체를 사용할 수 있는 권한
- ROLE(롤) : 유저에게 부여할 수 있는 권한을 모아 놓은 객체, 유지관리에 대한 편리성

- 내가 받은 시스템권한을 확인
SELECT * FROM user_sys_privs; --내가 받은 시스템권한을 확인
--create session 가장 중요한 권한

- 내가 받은 또는 내가 부여한 객체권한을 확인
SELECT * FROM user_tab_privs;

- 내가 받은 롤을 확인
SELECT * FROM session_roles;

- 내가 받은 롤안에 시스템 권한을 확인
SELECT * FROM role_sys_privs;

- 내가 받은 롤안에 객체권한을 확인
SELECT * FROM role_tab_privs;

- 내 것 보기
SELECT * FROM user_users;


■ table 생성(object, segment)
- 데이터를 저장하는 객체
- 행과 열로 구성되어 있다.

※테이블을 생성하려면 두가지를 체크해야한다.
1. 테이블을 생성할 수 있는 권한
    create table 시스템권한
select * from session_privs;
2. 테이블을 저장할 수 있는 테이블스페이스 권한
select * from user_ts_quotas; --hr(일반유저)입장에서 확인
select * from dba_ts_quotas; -- sys입장에서 확인

# 테이블이름, 컬럼이름, 유저이름, 다른객체이름, 제약조건이름
- 문자로 시작(숫자로 시작x)
- 문자의 길이는 1~30
- 문자, 숫자, 특수문자(_,#,$) 가능하다.
- 대소문자구분하지 않습니다.
- 동일한 유저가 소유한 객체이름은 중복되면 안된다. --hr.emp, insa.emp
- 예약어는 사용할 수 없다.(select, distinct, ...)

# 컬럼의 타입
desc employees
- number(p,s) : 가변길이 숫자 타입, p : 전체자리수, s : 소수점자리수, number(5,2) --전체 5자리중에 소수점은 2자리를 사용하겠다
- varchar2(4000) :  가변길이 문자 타입 --쓰는 만큼만 , 최대 4000까지 사용가능
- char(2000) : 고정길이 문자 타입 --고정적
- date : 날짜타입
- clob : 가변길이 문자 타입, 4gbyte(기가바이트)
- blob : 가변길이 이진 데이터 타입, 4gbyte(기가바이트)
- bfile : 외부파일에 저장된 이진 데이터타입, 4gbyte --이미지 같은 것은 주로 bfile을 사용, 실제 가지고 있는 것은 os

★테이블 생성

create table hr.emp(
        id number(4),
        name varchar2(30),
        day date default sysdate);
        
hr.emp 테이블은 어느 테이블스페이스에 저장이 되나요??
테이블을 생성하실때 테이블스페이스를 지정하지 않으면 유저 생성시에 설정한
default tablespace에 저장된다.

select * from user_users;

select * from user_tables where table_name = 'EMP';

- 테이블 삭제
drop table hr.emp purge;
        

create table hr.emp(
        id number(4),
        name varchar2(30),
        day date default sysdate)
tablespace users;

select * from user_tables where table_name = 'EMP';

desc emp 

DML(Data Manipulation Language)
- insert(입력)
- update(수정)
- delete(삭제)
- merge(insert, update, delete)

TCL(Transaction Control Language)
- commit(DML 영구히 저장하겠다)
- rollback(DML 영구히 취소하겠다)
- savepoint(rollback 기능을 도와주는 표시자)

Transaction(트랜잭션) : 논리적으로 DML을 하나로 묶어서 처리하는 작업단위

★insert문
테이블에 새로운 행을 입력하는 sql문
desc emp --insert 하기 전에 테이블의 구조를 확인한 후에 insert문을 생성하자'
insert into 소유자.테이블(컬럼,컬럼,...) --내소유자면 안 써도되고 남의 소유면 써야함
values(데이터,데이터,..);

--select * from nls_session_parameters;
insert into hr.emp(id, name,day)
values(1,'홍길동', to_date('2021-12-16', 'yyyy-mm-dd')); --행 삽입
select * from hr.emp; --확인(미리보기) ->영구히 저장은 x ->sqlplus에서 안보임
commit; --영구히 저장

insert into hr.emp(id,name,day) -- transaction 시작
values(2,'박찬호', sysdate);
select * from hr.emp; --미리보기

insert into hr.emp(id,name,day)
values(3,'윤건',to_date('2021-11-20', 'yyyy-mm-dd'));
select * from hr.emp; --미리보기

commit; --transaction 종료

select * from hr.emp;

insert into hr.emp(id,name,day) -- transaction 시작
values(4,'나얼',to_date('2020-1-10', 'yyyy-mm-dd'));

select * from emp;
rollback; --영구히 취소, transaction 종료
select * from emp;

desc emp

insert into hr.emp(id,name,day)
values(4,'나얼', to_date('2021-01-01', 'yyyy-mm-dd'));

--day컬럼에 default 값이 구성되어 있으면 default값이 입력된다.
-- insert를 수행하는 시점에 default값으로 구성된 sysdate값이 입력된다.
insert into hr.emp(id,name)
values(5,'이문세');

insert into hr.emp(id,name,day)
values(6,'손흥민',default);

select * from emp;

commit;

# null값을 입력하는 밥법
insert into hr.emp(id,name,day)
values(7,'하든',null); --day 컬럼에 default값이 설정되어있더라도 null이 우선순위가 높다. 강사님이 좋아하는 nba농구선수
select * from emp; --미리보기

insert into hr.emp(id,name,day)
values(8,null,null);
select * from emp;--미리보기 

commit; --커밋하기 전에 미리보기로 먼저 확인 완료하고 완벽히 되면 커밋하도록
rollback; --이미 transaction을 commit을 수행했기때문에 rollback을 수행해도 의미가 없다.
select * from hr.emp;

★ update
- 특정한 필드값을 수정하는 SQL문

update 소유자.테이블
set 수정할 필드가 있는 컬럼 = 새로운 값
where 조건;

update hr.emp -- transaction 시작
set day = to_date('2002-01-01', 'yyyy-mm-dd');

select * from hr.emp; -- 미리보기

rollback; --영구히 취소, transaction 종료
select * from hr.emp;

update hr.emp
set day = to_date('2001-01-01','yyyy-mm-dd')
where id =1;

select * from hr.emp; --미리보기
commit;

-- 여러컬럼의 필드값을 수정
update hr.emp
set name = '커리', day = default
where id = 8;

select * from hr.emp where id = 8;

commit;

- null값으로 수정(행에 있는 필드 값들)
update hr.emp
set day = null
where id =2;
select * from hr.emp;
commit;
★ delete문
- 행을 삭제하는 SQL문
delete from 소유자.테이블;
delete from 소유자.테이블 where 삭제해야할 행의 조건;

delete from hr.emp; --전체행 다 삭제됨
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