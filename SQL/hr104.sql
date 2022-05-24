select * from tab;

drop table emp purge;

create table emp
as select employee_id, last_name, salary
from employees;

> 내가 소유한 테이블의 대한 select 권한을 다른 유저한테 부여
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

# 컬럼을 추가하는 방법
alter table emp add job_id varchar2(20);
desc emp -- 확인
select * from user_tab_columns where table_name = 'EMP'; -- 확인

# 컬럼의 타입, 크기를 수정
desc emp
alter table emp modify job_id varchar2(30); --같은 타입의 길이를 늘리는 것은 데이터가 들어있어도 변경가능(타입은 데이터가 들어가 있으면 변경 불가, 있는 데이터의 길이보다 작게도 변경불가)
desc emp
alter table emp modify job_id char(20);
desc emp
alter table emp modify job_id number; -- 기존 데이터가 저장되었을 경우에는 타입수정시 문제가 발생할 수 있다.
desc emp

# 컬럼삭제 
alter table emp drop column job_id;
desc emp
중요한 컬럼을 drop하면 복구를 할 수 없다.(ddl), 바로 commit이 수행됨
- 디비시간을 되돌려야 할 수 있는 큰 문제가 있음
rollback은 insert,update,delete(dml)만 가능

★ 제약조건
- 테이블의 데이터에 대한 규칙을 만든다.
- 데이터에 대한 품질을 향상시키기 위해서 만든다.

1.primary key
- 테이블의 대표키
- unique, null값은 허용할 수 없다.
- 테이블당 하나 생성
- 자동으로 unique index 생성

- 제약조건 정보 확인
select * from user_constraints where table_name = 'EMP'; --컬럼의 정보는 안 나옴
select * from user_cons_columns where table_name = 'EMP';

- 인덱스 정보 확인
select * from user_indexes where table_name = 'EMP';
select * from user_ind_columns where table_name = 'EMP';
- 제약 조건을 추가
alter table emp add constraint emp_id_pk primary key(id);
또는
alter table emp add primary key(id) -- 제약조건이름을 명시하지 않으면 자동으로 sys_c숫자이름으로 생성해준다.

- 제약조건을 삭제
alter table emp drop constraint emp_id_pk;
또는
alter table emp drop primary key;

desc emp

insert into emp(id,nams,day) values(1,'홍길동',sysdate);
insert into emp(id,nams,day) values(1,'박찬호',sysdate); --오류
insert into emp(id,nams,day) values(null,'손흥민', sysdate); --오류
select * from emp;
rollback;

alter table emp drop primary key; --제약조건 삭제
select * from user_constraints where table_name = 'EMP';


insert into emp(id,nams,day) values(1,'홍길동',sysdate);
insert into emp(id,nams,day) values(1,'박찬호',sysdate); --오류
insert into emp(id,nams,day) values(null,'손흥민', sysdate); --오류
select * from emp;
rollback;

drop table dept purge;
create table dept(dept_id number, dept_name varchar2(30)); --dept테이블 생성
alter table dept add constraint dept_pk primary key(dept_id);
--제약조건을 생성해줄 때 동일한 유저내에서 제약조건이름은 고유한 이름으로 생성해야 한다.
select * from user_constraints where table_name = 'DEPT'; --제약조건 확인
insert into dept(dept_id, dept_name) values(10,'총무부'); --dept테이블에 행 삽입
insert into dept(dept_id, dept_name) values(20,'분석팀');
commit;
select * from dept;

select * from emp;
alter table emp add dept_id number; -- 컬럼을 추가
select * from emp;

insert into emp(id,nams,day,dept_id) values(1,'홍길동',sysdate,10);
insert into emp(id,nams,day,dept_id) values(2,'박찬호',sysdate,30);
select * from emp;
commit;

사원들의 부서 정보, 부서 정보를 출력해주세요.
select e.id, e.nams, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id(+);

delete from emp;
select * from emp;
commit;

select * from emp; -- 사원테이블
select * from dept; -- 부서테이블

2. foreign key
- 외래키, 참조무결성 제약조건
- 동일한 테이블이나 다른 테이블의 primary key 또는 unique key 제약조건을 참조한다.
- 데이터 품질을 좋게하기위해서
- 중복값 허용, null값 허용
- 종속되는 행 삭제를 불허한다.

alter table emp add constraint emp_dept_id_fk
foreign key(dept_id) references dept(dept_id);

select * from user_constraints where table_name in ( 'EMP','DEPT');
--CONSTRAINT_TYPE : R -FROREIGN KEY걸려있다, P -primary key
select * from user_cons_columns where table_name in ( 'EMP','DEPT');

insert into emp(id,nams,day,dept_id) values(1,'홍길동',sysdate,10);
insert into emp(id,nams,day,dept_id) values(2,'박찬호',sysdate,30); --오류 : primary key안에 30이라는 값이 없기때문에
-- dept테이블의 dept_id는 parent key , emp의 dept_id는 child
insert into emp(id,nams,day,dept_id) values(2,'박찬호',sysdate,null);
select * from emp;
commit;
select * from emp;
select * from dept;
delete from dept where dept_id = 10; --오류 : 참조하고 있는 데이터가 있기 때문에 삭제할 수 없다.
delete from dept where dept_id = 20; --삭제가능, 참조하고 있는 데이터가 없기 때문에 삭제할 수 있다.
rollback;

select * from user_constraints where table_name in ( 'EMP','DEPT');
select * from user_cons_columns where table_name in ( 'EMP','DEPT');

alter table dept drop primary key; --오류 : foreign key 제약조건이 참조하고 있기 때문에 오류발생
1) alter table emp drop constraint EMP_DEPT_ID_FK;
2) alter table dept drop primary key;

alter table dept drop primary key cascade; -cascade 옵션을 사용하면 foreign key 제약조건을 먼저 삭제하고 primary key 제약조건을 삭제한다.
select * from user_cons_columns where table_name in ( 'EMP','DEPT');


3. unique 제약조건
- 유일한 값만 체크
- null 허용
- 자동으로 unique index 생성된다.

select * from user_constraints where table_name = 'DEPT';
select * from dept;

dept 테이블에 있는 dept_name 유일한 값만 입력될 수 있도록 unique 제약조건을 추가하자.
alter table dept add constraint dept_name_uk unique(dept_name);
select * from user_constraints where table_name = 'DEPT'; --unique인덱스 자동 생성?
select * from user_cons_columns where table_name = 'DEPT';
select * from user_indexes where table_name = 'DEPT';
select * from user_ind_columns where table_name = 'DEPT';

select * from dept;
insert into dept(dept_id, dept_name) values(30,'총무부'); -- 오류 : unique 제약조건에 위반되어서 오류 발생
insert into dept(dept_id, dept_name) values(30,null);
select * from dept;

rollback;

update dept
set dept_name = '총무부'
where dept_id = 20; -- unique 제약조건에 위반되어서 오류 발생

# unique key 삭제
alter table dept drop constraint dept_name_uk;

# unique key 생성
alter table dept add constraint dept_name_uk unique(dept_name);
select * from user_constraints where table_name = 'DEPT';

# unique key 삭제
alter table dept drop unique(dept_name);
select * from user_constraints where table_name = 'DEPT';

4. check 제약조건
- 조건에 값이 true인 경우 insert, update 할 수 있도록 만드는 제약조건
- null 허용한다. 중복되는 값 허용한다.

select * from emp;

alter table emp add sal number; -- sal컬럼 추가

select * from emp;

alter table emp add constraint emp_sal_ck check(sal >= 1000);

select * from user_constraints where table_name = 'EMP';

insert into emp(id,nams,day,dept_id,sal)
values(3,'커리',sysdate,20,500); --check제약조건때문에 조건에 결과 false 이기때문에 오류 발생

update emp
set sal = 600 
where id = 1; --check제약조건때문에 조건에 결과 false 이기때문에 오류 발생

insert into emp(id,nams,day,dept_id,sal) values(3,'커리',sysdate,20,5000);
select * from emp;
rollback;

# check 제약조건 삭제
alter table emp drop constraint emp_sal_ck;

# check 제약조건 생성
alter table emp add constraint emp_sal_ck check (sal>=1000 and sal<=5000);
alter table emp add constraint emp_sal_ck check (sal between 1000 and 5000);
select * from user_constraints where table_name = 'EMP';

insert into emp(id,nams,day,dept_id,sal) values(3,'커리',sysdate,20,6000); -- check 제약조건의 위반 때문에 오류발생
select * from emp;
rollback;

5. not null 제약조건
- null 값을 허용할 수 없는 제약조건

select * from user_constraints where table_name = 'DEPT'; --제약조건 확인

select * from dept;
alter table dept add constraint dept_name_uk unique(dept_name);  --unique 제약조건 걸기
insert into dept(dept_id, dept_name) values(30,null);
rollback;
select * from dept;

- not null 제약조건은 modify를 이용해서 추가해야 한다.
--alter table dept add constraint dept_name_nn not null(dept_name); -- 오류발생

alter table dept modify dept_name constraint dept_name_notnull not null;
select * from user_constraints where table_name = 'DEPT'; --제약조건 타입은 C로 나오는데 NOT NULL인지 CHECK인지 확인하는 것은 SEARCH_CONDITION에서
select * from user_cons_columns where table_name = 'DEPT';

insert into dept(dept_id, dept_name) values(30,'총무부'); -- unique 제약조건에 위반되어서 오류 발생
insert into dept(dept_id, dept_name) values(30,null); -- not null 제약조건에 위반되어서 오류 발생
rollback;

select * from user_constraints where table_name = 'DEPT';
select * from user_cons_columns where table_name = 'DEPT';

NOT NULL 제약조건 삭제
alter table dept drop constraint dept_name_notnull;
또는
alter table dept modify dept_name null;
desc dept

drop table emp purge;
alter table dept add constraint dept_dept_id_pk primary key(dept_id);

create table emp(
    id number constraint emp_id_pk primary key, -- 열레벨 정의 
    name varchar2(30) constraint emp_name_nn not null, -- not null 제약조건은 열레벨 정의만 가능한다.
    sal number,
    dept_id number constraint emp_dept_id_fk references dept(dept_id), -- foreign key 제약조건을 열레벨 정의할 때 주의!
    constraint emp_name_uk unique(name), --테이블 레벨 정의(제약조건 타입뒤에 컬럼 꼭 정의)
    constraint emp_sal_ck check(sal between 1000 and 5000));
    
select * from user_constraints where table_name in('EMP','DEPT');  

drop table emp purge;

create table emp(
    id number constraint emp_id_pk primary key, -- 열레벨 정의 
    name varchar2(30) constraint emp_name_nn not null, -- not null 제약조건은 열레벨 정의만 가능한다.
    sal number,
    dept_id number, 
    constraint emp_name_uk unique(name), --테이블 레벨 정의(제약조건 타입뒤에 컬럼 꼭 정의)
    constraint emp_sal_ck check(sal between 1000 and 5000),
    constraint emp_dept_id_fk foreign key(dept_id) references dept(dept_id)); -- 테이블 레벨로 foreign key 제약조건을 정의 할 때 주의!
    
select * from user_constraints where table_name in('EMP','DEPT');  

select * from emp;

★ 테이블 이름 수정
1) 방법1
drop table emp_copy purge;
rename emp to emp_copy;
select * from emp_copy;
select * from user_constraints where table_name = 'EMP_COPY'; --이름을 수정해도 제약조건은 안 바뀜
select * from user_indexes where table_name = 'EMP_COPY'; --이름을 수정해도 인덱스는 안 바뀜
desc emp_copy

2) 방법2
alter table emp_copy rename to copy_emp;
select * from user_constraints where table_name = 'COPY_EMP';
select * from user_indexes where table_name = 'COPY_EMP';

★ 컬럼 이름 수정
desc copy_emp
alter table copy_emp rename column id to emp_id;
select * from user_constraints where table_name = 'COPY_EMP';
select * from user_cons_columns where table_name = 'COPY_EMP';
select * from user_indexes where table_name = 'COPY_EMP';
select * from user_ind_columns where table_name = 'COPY_EMP';
desc copy_emp

★ 제약조건 이름 수정
select * from user_constraints where table_name = 'COPY_EMP';
select * from user_cons_columns where table_name = 'COPY_EMP';

alter table copy_emp rename constraint emp_id_pk to copy_emp_id_pk;
select * from user_constraints where table_name = 'COPY_EMP'; 
select * from user_cons_columns where table_name = 'COPY_EMP';

select * from user_indexes where table_name = 'COPY_EMP'; --인덱스 이름은 옛날 이름 그대로 가지고 있음, 지장은 없음

★ 인덱스 이름 수정
select * from user_indexes where table_name = 'COPY_EMP';

alter index emp_id_pk rename to copy_emp_idx;

select * from user_indexes where table_name = 'COPY_EMP';
select * from user_ind_columns where table_name = 'COPY_EMP';