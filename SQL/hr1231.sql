★테이블 복제, ctas
-테이블구조, 행(데이터),제약조건중에 not null만 복제된다.

desc employees
drop table hr.emp purge;
-테이블 제거

create table hr.emp
as select * from hr.employees;
-emp테이블 생성,  emp테이블로 employees테이블을 복제
desc hr.emp_20 
select * from hr.employees;

create table emp_20
as select employee_id, upper(last_name) name, salary
from employees
where department_id =20;
-emp_20테이블을 생성, employees테이블에서 employee_id, last_name, salary를 복제, 조건은 department_id가 20인 것
select * from emp_20;

drop table emp purge; --emp 테이블 삭제
drop table emp_20 purge; --emp_20테이블 삭제

> 데이터는 제외하고 테이블의 구조만 복제
create table emp
as select * from employees where 1=2;
-emp테이블에 employees테이블을 복제하는데 조건을 보면 1=2 안 맞는 것을 알 수 있고 조건에 충족하는 데이터가 없기에 아무것도 복제가 되지않고 구조(뼈대,컬럼)만 복제된다
desc emp
select * from emp;

★insert subquery

select * from emp;

insert into emp --transaction 시작
select * from employees;
select * from emp;
commit; -- 영구히 저장, transaction 종류

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

※ETL(Extraction(추출), Transformation(변형), Loading(적재))


★ update subquery
select * from emp;

update emp -- transaction 시작
set name = null
where id = 100;
select * from emp where id = 100; --미리보기
commit; --영구히 저장, transaction 종료

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

- correlated subquery 이용한 update
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

★ delete subquery

select * from emp where name like 'K%';

delete from emp
where id in (select id from emp where name like 'K%');

select * from emp where name like 'K%';
rollback;

select * from emp where name like 'K%';

delete from emp
where name like 'K%';
rollback;

[문제94] emp테이블에 있는 데이터 중에 job_history에 존재하는 사원들을 삭제해 주세요.
select *
from emp
where id in (select employee_id
                from job_history); --검색

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
2) exists를 선호(성능상)
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
                

★ 자동 commit 발생할 때
- DDL(create, alter, drop, rename, truncate, comment)
- DCL(grant, revoke)
- sqlplus에서 exit를 수행해서 종료하면 auto commit 가지고 있다.
- sqlplus 에서 다른 유저로 접속할 때 connect(conn)

★ 자동 rollback 발생할 때
- 창닫기를 하면 비정상적인 종료
- 네트워크가 장애가 발생하는 경우
- 컴퓨터가 비정상적으로 종료

★★★★★주의★★★★★
- DML작업을 수행한 후 꼭 명시적으로 transaction을 종료하는 습관을 갖자
- 정확하게 commit, rollback을 해야할지 명시적으로 꼭 수행하는 습관을 갖자

select * from emp;
delete from emp; -- transaction 시작
select * from emp;
create table dept
as select * from departments; -- transaction 종료 내부적으로 auto commit 수행된다.
select * from dept;
select * from emp;
rollback; --delete 취소를 하려고 하지만 위에서 auto commit 수행되었기 때문에 취소는 의미가 없다.
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

insert into emp_20(employee_id, last_name) --transaction시작
values(300, '홍길동');
select * from emp_20;

update emp_20
set last_name = '박찬호'
where employee_id = 201;
select * from emp_20;

delete from emp_20 where employee_id = 202;

select * from emp_20;

rollback; --transaction시작시점까지 전부 rollback 된다.

select * from emp_20;

-----

★savepoint
- dml작업시에 rollback을 도와주는 표시자
- commit, rollback 즉 transaction이 종료된면 savepoint 없어진다.

insert into emp_20(employee_id, last_name) --transaction시작
values(300, '홍길동');

select * from emp_20;

savepoint a;

update emp_20
set last_name = '박찬호'
where employee_id = 201;

select * from emp_20;

savepoint b;

delete from emp_20 where employee_id = 202;

select * from emp_20;

rollback to b; --표시자 b 이하에 있는 delete만 취소된다. 위에 있는 insert, update 살아있다.

select * from emp_20;
commit;  -- insert,update 영구히 저장된다.
select * from emp_20;

★다중테이블 insert (9i)
- source 테이블에서 데이터를 추출해서 여러개의 target에 저장하는 SQL문
- ETL(Extraction(추출), Transformation(변형), Loading(적재))
- source 시스템에서 데이터 추출해서 Data Warehouse 로 가져오는 작업

1. 무조건 insert all

create table sal_history
as select employee_id, hire_date, salary from employees where 1 = 2;

select * from sal_history;

create table mgr_history
as select employee_id, manager_id, salary from employees where 1 = 2;

select * from mgr_history;

source table(employees) ---------> target table(sala_history, mgr_history)
                          ETL작업

예)
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

2. 조건 insert all
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
                
3. 조건 first insert
--구간에 맞는 값을 각각 넣어준다?

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

[문제95] 사원들 중에 근무연수가 15년 이상 이면서 급여는 10000이상 급여를 받는 사원들은 
emp_1테이블에 사번, 이름(last_name), 입사일, 근무연수, 급여 정보를 입력하고 
근무연수가 15년 이상 이면서 급여는 10000미만 급여를 받는 사원들은 
emp_2테이블에 사번, 이름(last_name), 입사일, 근무연수, 급여 정보를 입력하세요.
create table emp_1(id number, name varchar2(30), day date, years number, sal number);
create table emp_2(id number, name varchar2(30), day date, years number, sal number);

/* 다시 생각해보기 킵!
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

oltp(online transaction processing) : 온라인 사용자들이 데이터베이스에 DML 작업을 수행하는 업무
olap(online analytical processing) : 데이터 분석하고 의미있는 정보를 수행하는 업무

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

-기존 테이블의 컬럼을 추가하는 방법
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

[문제96] oltp_emp에 있는 사원들 중에 dw_emp에 존재하는 사원의 정보를 출력해주세요
select *
from oltp_emp o
where exists (select 'x'
                from dw_emp
                where employee_id = o.employee_id);
                
[문제97] dw_emp에 있는 사원들 중에 oltp_emp에 존재하는 사원들은 oltp_emp에 급여를 기준으로 
        10% 인상해주세요.
/*update oltp_emp d
set salary = salary *1.1
where exists (select 'x'
                from dw_emp
                where employee_id = d.employee_id);*/
update dw_emp d
set salary = (select salary * 1.1
                from oltp_emp
                where employee_id = d.employee_id);
select * --확인
from oltp_emp o
where exists (select 'x'
                from dw_emp
                where employee_id = o.employee_id);
rollback;
     
[문제98] dw_emp에 있는 사원들 중에 oltp_emp에 존재하는 사원들 중에 flag 값이 'd'인 사원들에 
        대해서 삭제해주세요.
select * from oltp_emp;

delete from dw_emp d
where exists (select 'x'
                from oltp_emp
                where employee_id = d.employee_id
                and flag = 'd');

select * from oltp_emp where flag = 'd';
rollback;
[문제99] oltp_emp테이블에 있는 데이터 중에 dw_emp테이블에 없는 데이터들을 dw_emp테이블에 입력해주세요 (못 푼 문제)
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

★ merge
insert, update, delete 문을 한꺼번에 수행할 수 있는 SQL문

select * from dw_emp; -- target table(실제 update, delete, insert)
select * from oltp_emp; -- source table

merge into dw_emp d -- target table, insert,update,delete권한
using oltp_emp o -- source table, select 권한
on (d.employee_id = o.employee_id) -- 조인조건(키 값의 연결고리)
when matched then -- 키값이 일치가 되면
    update set
        d.salary = o.salary * 1.1
    delete where o.flag = 'd'
when not matched then    
    insert(d.employee_id, d.last_name, d.salary, d.department_id)
    values(o.employee_id, o.last_name, o.salary, o.department_id);
    
select * from dw_emp;
rollback;

[문제 100] emp_copy 테이블에 있는 department_name값을 departments테이블에 있는 
            department_name값을 이용해서 수정해주세요.
create table emp_copy as select * from employees;
alter table emp_copy add department_name varchar(30);
desc emp_copy
select * from emp_copy;

1) update
update emp_copy c --널값도 같이 업데이트에 포함되니 107행 업데이트
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
