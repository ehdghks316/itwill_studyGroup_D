★ sequence
- 자동일련번호를 생성하는 객체
- sequence 객체를 생성하려면 create sequence 시스템권한이 필요

select * from session_privs;

-- SEQUENCE 객체 생성

create sequence id_seq;
select * from user_sequences where sequence_name = 'ID_SEQ';

create table seq_test(id number, name varchar2(30), day timestamp); --seq_test테이블 생성
insert into seq_test(id,name,day) values(id_seq.nextval,'홍길동', localtimestamp); --nextval : 가상컬럼
select * from seq_test;
insert into seq_test(id,name,day) values(id_seq.nextval,'박찬호', localtimestamp); --nextval : 가상컬럼
select * from seq_test;
select id_seq.currval from dual;

- sequence이름.nextval : 가상컬럼, 현재사용가능한 번호를 리턴해준다.
- sequence이름.currval : 현재사용한 번호를 리턴해준다.

select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';
select * from seq_test;
rollback;
select * from seq_test;

insert into seq_test(id,name,day) values(id_seq.nextval,'홍길동', localtimestamp); --nextval : 가상컬럼
select * from seq_test;
insert into seq_test(id,name,day) values(id_seq.nextval,'박찬호', localtimestamp); --nextval : 가상컬럼
select * from seq_test;
select id_seq.currval from dual;
commit;
select * from user_sequences where sequence_name = 'ID_SEQ';

- SEQUENCE 삭제
drop sequence id_seq;
select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';

create sequence id_seq
start with 1
maxvalue 3
increment by 1
nocycle -- cycle 하면 계속 123123반복
nocache -- 매번 nextval할 때마다 생성하겠다, cache 20
;

select * from user_sequences where sequence_name = 'ID_SEQ'; --last_number : 다음사용번호

insert into seq_test(id,name,day) values(id_seq.nextval,'나얼', localtimestamp); 
select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';
insert into seq_test(id,name,day) values(id_seq.nextval,'윤건', localtimestamp); 
select * from seq_test;
select * from user_sequences where sequence_name = 'ID_SEQ';

insert into seq_test(id,name,day) values(id_seq.nextval,'커리', localtimestamp); 
select * from seq_test; --번호가 겹치게됨(키값이 충돌)
select * from user_sequences where sequence_name = 'ID_SEQ';
insert into seq_test(id,name,day) values(id_seq.nextval,'손흥민', localtimestamp); 
select * from seq_test; --nextval꽉차서 오류

- sequence 수정
alter sequence id_seq
maxvalue 100;

select * from user_sequences where sequence_name = 'ID_SEQ';
insert into seq_test(id,name,day) values(id_seq.nextval,'손흥민', localtimestamp); 
select * from seq_test;
rollback;

> sequence 수정, start with 만 제외하고 다른 옵션들은 수정할 수 있다.
alter sequence id_seq
increment by 2
maxvalue 100
cache 20; 
select * from user_sequences where sequence_name = 'ID_SEQ';

drop table seq_test;
drop sequence id_seq;

★ SYNONYM(동의어) 
- 긴 객체 이름을 짧은 이름으로 사용하는 객체
- CREATE SYNONYM 시스템권한 필요하다.
- 모든 유저들이 사용할 수 있는 synonym을 생성하려면 create public synonym 시스템권한이 있어야 한다.(dba(sys)에게 권한을 받아야함)
select * from session_privs;

create table emp_copy_2022 as select * from employees;
select * from emp_copy_2022;

> synonym 생성
create synonym ec2 for emp_copy_2022; -- 나혼자만 사용할 수 있는 synonym
select * from user_synonyms where table_name = 'EMP_COPY_2022'; 
select * from ec2;
select * from emp_copy_2022;

> synonym 삭제
drop synonym ec2;
select * from user_synonyms where table_name = 'EMP_COPY_2022'; 

select * from user_tab_privs;
grant select on hr.employees to ora; --hr안써도 됨
--select on hr.employees하는 유저들에게 내 synonym을 쓰게 하고 싶다?
grant select on hr.departments to ora;
select * from user_tab_privs;

select * from session_privs;

> public synonym 생성
create public synonym emp for hr.employees;
create public synonym dept for hr.departments;
select * from user_synonyms; -- 내가 만든PUBLIC SYNONYM 정보 확인 불가, 
select * from all_synonyms where table_owner = 'HR'; -- 내가 만든PUBLIC SYNONYM 정보 확인

> select 권한을 회수
revoke select on hr.employees from ora;
revoke select on hr.departments from ora;

> select 권한을 부여
grant select on hr.employees to ora;
grant select on hr.departments to ora;

> public synonym 삭제
drop public synonym emp; -- drop을 수행하면 오류 발생(drop public synonym 시스템권한이 없기 때문에)
select * from session_privs;
drop public synonym emp;
drop public synonym dept;
select * from all_synonyms where table_owner = 'HR'; -- 내가 만든PUBLIC SYNONYM 정보 확인

select *
from hr.employees
where employee_id = 100;

optimizer : SQL문을 수행하기 위한 실행계획을 만든다.

★ Data access method
책 = 테이블
페이지(page) = block(4k,(8k),16k,32k)
문장 = 행(row)
특정한 단어(오라클) 찾아야 한다.?

> full table scan (특정한 테이블에 특정한 단어를 찾을 때 첫번째 block에서부터 마지막block까지 access하는 방식)
- 테이블 첫 번째 행부터 마지막 행까지 access하는 방식
> rowid scan : 행의 물리적 주소를 가지고 찾는 방식, 데이터 access방법중에 가장 빠른 방법(예)집주소)
    1) BY USER ROWID SCAN
        select * from employees where rowid = 'AAAEAbAAEAAAADNAAA';
    2) BY INDEX ROWID SCAN
        select * from employees where employee_id = 100;
select rowid, employee_id
from employees;

select * from employees where rowid = 'AAAEAbAAEAAAADNAAA';
사원번호 100번 사원의 행주소를 rowid('AAAEAbAAEAAAADNAAA')를 대신 기억해줄래?

rowid : 물리적 row 주소
AAAEAb(6자리) : data object id
select * from user_objects; --DATA_OBJECT_ID가 NULL은 저장공간이 필요없는 테이블

AAE(3자리) : file id
select * from dba_data_file; --오류(dba에서 수행) 

AAAADN(6자리) : block id
select * from user_segments where segment_name = 'EMPLOYEES';
select * from user_extents where segment_name = 'EMPLOYEES';

AAA(3자리) : row slot id(찾고싶은 row가 있는 위치)

select * from employees where rowid = 'AAAEAbAAEAAAADNAAA';
사원번호 100번 사원의 행주소(rowid('AAAEAbAAEAAAADNAAA'))를 대신 기억해줄래?

★ INDEX
- by index rowid scan 방식을 사용해서 검색속도를 높이기 위해서 사용되는 객체
- 인덱스를 이용해서 행을 검색하면 i/o(입력/출력)를 줄일 수 있다.
- 인덱스를 테이블과는 독립적으로 생성된다.
- 인덱스는 오라클이 자동으로 유지관리한다.
- primary key, unique 제약조건을 생성하면 unique index가 자동으로 생성된다.
- 수동으로 생성한다.
select * from user_indexes where table_name = 'EMPLOYEES';
select * from user_ind_columns where table_name = 'EMPLOYEES';
select * from employees;
--( 예)책의 색인페이지에 장번호가 여러개면 nonunique, 하나면 unique)

drop table emp purge;

create table emp as select * from employees; 
desc emp -- 컬럼 , 타입, 값, not null만 복제됨
select * from user_constraints where table_name = 'EMP'; --제약조건 
select * from user_cons_columns where table_name = 'EMP'; -- 제약조건 컬럼
select * from user_indexes where table_name = 'EMP'; --index는 복제되지 않음
select * from user_ind_columns where table_name = 'EMP';--index는 복제되지 않음

select * from emp where employee_id = 100; --f10번키 누르고 options확인 -> full table scan발생
select rowid, employee_id from emp;
select * from emp where rowid = 'AAAFCSAAEAAAAHjAAA'; -- by user rowid scan

- primary key 제약조건을 추가
alter table emp add constraint emp_id_pk primary key(employee_id);
select * from user_constraints where table_name = 'EMP';
select * from user_cons_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

select * from emp where employee_id = 100; --(f10) by index rowid scan

select employee_id, rowid
from emp
order by 1;
emp_id_pk 인덱스에는 아래와 같은 정보들이 입력되어 있다.
EMPLOYEE_ID     ROWID
100	AAAFCFAAEAAAAI7AAA
101	AAAFCFAAEAAAAI7AAB
102	AAAFCFAAEAAAAI7AAC
103	AAAFCFAAEAAAAI7AAD
104	AAAFCFAAEAAAAI7AAE
105	AAAFCFAAEAAAAI7AAF
.......

select * from emp where employee_id = 100; -- by index rowid scan (emp_id_pk를 by index rowid를 가지고 emp테이블을 스캔)
1) 100번에 해당하는 rowid를 emp_id_pk 인덱스에 가서 찾기
2) 찾은 rowid가지고 emp 테이블에 access하고 종료

select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

select * from emp where last_name = 'King'; --full table scan

- nonunique index 생성
create index emp_last_name_idx on emp(last_name);
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

select * from emp where last_name = 'King'; -- by index rowid scan

select last_name, rowid
from emp 
order by 1;
select * from emp where last_name = 'King'; -- by index rowid scan
1) 'King'에 해당하는 rowid를 emp_last_name_idx에 가서 찾는다
2) 찾은 rowid가지고 emp 테이블에 찾아 간다.
    select * from emp where rowid = 'AAAFCFAAEAAAAI7AAA';
3) 다시 'King'에 해당하는 rowid를 emp_last_name_idx에 가서 찾는다
4) 찾은 rowid가지고 emp 테이블에 찾아 간다.
    select * from emp where rowid = 'AAAFCFAAEAAAAI7AA4';
5) 다시 'King'에 해당하는 rowid를 emp_last_name_idx에 가서 찾는다. 없으면 종료!
6) 결과 집합을 유저한테 전달
emp_last_name_idx
....
Khoo	AAAFCFAAEAAAAI7AAP
King	AAAFCFAAEAAAAI7AAA
King	AAAFCFAAEAAAAI7AA4
Kochhar	AAAFCFAAEAAAAI7AAB
Kumar	AAAFCFAAEAAAAI7ABJ
Ladwig	AAAFCFAAEAAAAI7AAl
....

> primary key 제약조건 삭제
select * from user_constraints where table_name = 'EMP';
select * from user_cons_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';

alter table emp drop primary key;

- nonunique index 생성
create index emp_id_idx on emp(employee_id); -- employee_id의 인덱스 생성
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from emp where employee_id = 100; -- index range scan
1) 100번에 해당하는 rowid를 emp_id_idx 인덱스에 가서 찾기
2) 찾은 rowid가지고 emp 테이블에 access
3) 다시 100번에 해당하는 rowid를 emp_id_idx 인덱스에 가서 찾아보고 없으면 종료

- index 삭제
drop index emp_id_idx;
select * from user_indexes where table_name = 'EMP';

- unique index 생성
- unique index 생성하게 되면 employee_id 컬럼의 값은 중복되는 값은 입력될 수 없다.
    꼭 unique 제약조건을 만든 것 처럼 효과를 준다.
    
create unique index emp_id_idx on emp(employee_id); --중복되는 값이 있으면 안됨
select * from user_constraints where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
select * from emp where employee_id = 100; -- (f10) by index rowid, unique scan

create table test(id number, name varchar2(30));
create unique index test_id_idx on test(id);
select * from user_constraints where table_name = 'TEST'; --제약조건을 만들지 않음
select * from user_indexes where table_name = 'TEST';
insert into test(id,name) values(1,user); --user함수는 현재 insert를 수행하는 오라클 유저
select * from test;
insert into test(id,name) values(1,user); -- id컬럼의 unique index 생성되어 있기때문에 중복되는 값이 들어오면 오류 발생
rollback;

drop table test purge; -- test테이블 삭제
select * from user_indexes where table_name = 'TEST'; --테이블을 삭제하면 그 테이블과 연관된 인덱스도 자동으로 삭제됨

select * from user_ind_columns where table_name = 'EMPLOYEES'; -- EMP_NAME_IX는 인덱스가 2개? -> 조합인덱스

---------------
select * 
from emp 
where last_name = 'King' --인덱스 있음
and first_name = 'Steven'; -- 인덱스 없음

1) 'King'에 해당하는 rowid를 emp_last_name_idx에 가서 찾는다
2) 찾은 rowid가지고 emp 테이블에 찾아 간다.
    select * from emp where rowid = 'AAAFCSAAEAAAAHjAAA' and first_name = 'Steven';
3)  이유는 first_name = 'Steven' 체크하기 위해서 emp테이블에 찾아가서 있으면
    결과 집합에 그 데이터를 저장하고 없으면 다시 다음 단계를 진행해야 한다.
4) 다시 'King'에 해당하는 rowid를 emp_last_name_idx에 가서 찾는다
5) 찾은 rowid가지고 emp 테이블에 찾아 간다.
    select * from emp where rowid = 'AAAFCSAAEAAAAHjAA4' and first_name = 'Steven';
6) 이유는 first_name = 'Steven' 체크하기 위해서 emp테이블에 찾아가서 있으면
    결과 집합에 그 데이터를 저장하고 없으면 다시 다음 단계를 진행해야 한다.
7) 다시 'King'에 해당하는 rowid를 emp_last_name_idx에 가서 찾는다. 없으면 종료!
8) 결과 집합을 유저한테 전달
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
> 조합인덱스
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
where last_name = 'King' --인덱스 있음
and first_name = 'Steven'; -- 인덱스 있음 (last_name, first_name) 조합인덱스

1) last_name = 'King'과 first_name = 'Steven' 값이 같이 존재하는 
    rowid를 emp_last_first_name_idx에 가서 찾는다
2) 찾은 rowid가지고 emp 테이블에 찾아 간다. 
    이유는 결과집합을 만들기 위해서 실제 테이블에 찾아간다. --(메모리에 저장 후 3)에서 메모리에 저장된 결과집합을 유저한테 전달)
    select * from emp where rowid = 'AAAFCSAAEAAAAHjAAA'; 
3) 다시 last_name = 'King'과 first_name = 'Steven' 값이 같이 존재하는 
    rowid를 emp_last_first_name_idx에 가서 찾아보고 없으면 종료한 후 결과집합을 유저한테 전달

---------------
★ COMMENT --테이블 생성하면 무조건 주석달기(업무에서 어떤테이블에 어떤건지, 주석만 봐도 이런 성격의 테이블이구나 알 정도로 자세히)
테이블과 컬럼에 주석(설명) 만든다.

drop table emp purge;
create table emp as select * from employees;

- 테이블 주석 생성
comment on table emp is '사원정보 테이블';

- 컬럼 주석 생성
comment on column emp.employee_id is '사번';
comment on column emp.department_id is '부서코드';
- 테이블 주석 내용 확인
select * from user_tab_comments where table_name = 'EMP';

- 컬럼 주석 내용 확인
select * from user_col_comments where table_name = 'EMP';

- 테이블 주석 삭제
comment on table emp is ''; -- 빈문자열로 만들기

- 컬럼 주석 삭제
comment on column emp.employee_id is ''; -- 빈문자열로 만들기

select * from emp;

delete from emp;

rollback;

select * from user_segments where segment_name = 'EMP'; --BYTES : 이 테이블의 용량

delete from emp;
select * from emp;
rollback;
select * from emp;

만약에 특정한 테이블의 데이터를 다 삭제할 것이라면 뭐하러 undo 공간에 저장을 하겠습니까

★ truncate (현장에서 사용할때 주의하고 또 주의하고 또 주의하면서 사용)
테이블의 행을 다 삭제하는 행위는 DELETE 문과 비슷하지만 
차이점은 TRUNCATE문은 저장공간을 초기상태로 만든다. 
truncate문은 rollback을 할 수 없다.
truncate하는 대상 행은 undo공간에 입력하지 않습니다. 왜? rollback을 할 이유가 없기때문에
※주의 
특정한 행을 삭제하려면 delete문을 이용해야 한다.
다시 테이블 전체 행을 삭제하려면 delete문, truncate문 둘 다 사용할 수 있다.
하지만 차이점은 undo 발생하느냐(delete), 안하느냐(truncate)
또 주의 하셔야 할 점은 truncate는 rollback이 안된다. truncate했으면 영구히 행을 삭제함
truncate table emp;
select * from emp;

----------
★ 분석함수
sum(salary) over() : 총합

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

> 누적합
select employee_id, department_id, salary, sum(salary) over(order by employee_id) 누적합 -- employee_id순서로 누적합을 구하기
from employees;

select e2.employee_id, e2.department_id, e2.salary, e1.sumsal
from (select department_id, sum(salary) sumsal
        from employees
        group by department_id
        order by 1) e1, employees e2
where e1.department_id = e2.department_id
order by 2;

select employee_id, department_id, salary, sum(salary) over(partition by department_id) 부서별총합 -- partition by  그룹핑을해서 총합을 구하자
from employees;

select employee_id, department_id, salary, sum(salary) over(partition by department_id order by employee_id) 부서별총합 -- partition by  그룹핑을해서 총합을 구하자
from employees;

select employee_id, department_id, count(*) over(partition by department_id) 부서별인원수
from employees;

select employee_id, department_id, salary,
        count(*) over(partition by department_id) 부서별인원수,
        max(salary) over(partition by department_id) 부서별최고급여,
        min(salary) over(partition by department_id) 부서별최저급여
from employees;


select employee_id, department_id, salary, sum(salary) over(order by employee_id) 누적합 
from employees;

TOP-N
최고 급여자 중에 10위까지 출력

1) 급여를 기준으로 내림차순 정렬
select employee_id, salary
from employees
order by salary desc;

2) 정렬한 결과를 가지고 10위까지 제한을 해야 한다.

- rownum : fetch번호를 리턴하는 가상컬럼
select rownum, employee_id
from employees;


select rownum, employee_id, salary --order by보다 where가 우선순위가 높아서 결과값이 틀리게 나온다
from employees
where rownum <= 10 -- 랜덤하게 10개 뽑아
order by salary desc; -- 랜덤하게 10개 뽑아낸 결과를 가지고 정렬

※주의 : 우리 회사에 똑같은 급여자가 없다라고 하면 아래와 같은 query문을 수행해도 되겠지만
동일한 급여를 받는 사원이 있다고 하면 절대 아래와 같은 query를 이용해서 top-n분석하면 큰일 난다.
select *
from(select employee_id, salary
        from employees
        order by salary desc) e
where rownum <= 10;        

- rank() : 순위를 구하는 함수, 동일한 순위가 있을 경우 다음 순위는 갭이 생길 수 있다.
- dense_rank() : 순위를 구하는 함수, 동일한 순위가 있더라도 연이은 순위를 구하는 함수
select rank() over(order by salary desc) "rank",
    dense_rank() over(order by salary desc) "dense_rank",
    employee_id, salary
from employees;

select * 
from (select dense_rank() over(partition by department_id order by salary desc) dense_rank ,employee_id, salary
        from employees)
where dense_rank <= 10;        

select rank() over(partition by department_id order by salary desc) "부서별 rank",
    dense_rank() over(partition by department_id order by salary desc) "부서별 dense_rank",
    department_id, employee_id, salary
from employees;
