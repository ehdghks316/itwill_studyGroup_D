[문제51] 담당 관리자보다 먼저 입사한 사원의 이름과 입사일 및 해당 관리자의 이름과 입사일 출력해주세요.

SELECT * FROM employees;

SELECT w.last_name, w.hire_date, m.last_name,m.hire_date
FROM employees w join employees m
on w.manager_id = m.employee_id
where w.hire_date < m.hire_date;

select w.employee_id, w.hire_date, w.manager_id,m.employee_id, m.hire_date
FROM employees w, employees m
where w.manager_id = m.employee_id
and w.hire_date < m.hire_date;
--using절이랑 natural join은 불가능  ->

[문제 52] 110번 사원의 급여보다 더 많은 급여를 받는 사원?
--풀이순서--
SELECT *
FROM employees
WHERE salary > 110번 사원 급여;

SELECT salary
FROM employees
WHERE employee_id = 110;

SELECT *
FROM employees
WHERE salary > 8200;

--위 3개의 select문을 한 번에 수행할 수 없을까? 서 브 쿼 리!(sub query)
SELECT *
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE employee_id = 110);
                
subquery(서브쿼리)
-SQL문 안에 SELECT문을 서브쿼리라고 한다.
-SELECT문의 서브쿼리는 꼭 () 묶어야 한다.
-WHERE 절에서는 비교연산자 오른쪽 입력해야 한다.

중첩서브쿼리(nested subquery)
1.inner query(subquery) 먼저수행
2.inner query 수행한 값을 가지고 main query(outer query)를 수행한다.

main query, outer query
----------------------
SELECT *
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE employee_id = 110);
                -----------------------
                subquery, inner query

SELECT *
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'King'); --서브쿼리의 값이 여러개일 경우 단일비교연산자를 사용하면 오류 발생
                
단일행 서브쿼리 
- 서브쿼리의 결과가 단일값이 나오는 서브쿼리
- 단일행 비교연산자 : =, >, >=, <, <=, <>, !=, ^=
여러행 서브쿼리
-서브쿼리의 결과가 여러개의 값이 나오는 서브쿼리
-여러행 비교연산자 : in, any, all

[문제53] 110번 사원의 job_id와 동일한 사원들 중에 110번 사원의 급여보다 더 많이 받는 사원들의 정보를 추출하세요.
SELECT *
FROM employees 
WHERE job_id = all(select job_id
                    FROM employees
                    WHERE employee_id = 110)
and salary > (select salary
                from employees
                where employee_id = 110);
[문제54] 최고 급여를 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM employees
WHERE salary = all(SELECT max(salary)
                    FROM employees);

having절에 subquery 사용
having절에 비교연산자 오른쪽에 ()묶어서 사용한다.
having : 그룹함수에 대한 결과를 제한                    

SELECT department_id, sum(salary)
FROM employees
GROUP BY department_id
having sum(salary) > 10000;

SELECT department_id, sum(salary)
FROM employees
GROUP BY department_id
having min(salary) > 7000;


SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
having min(salary) > 40번 부서의 최소급여;

SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
having min(salary) > (SELECT min(salary) 
                        FROM employees
                        WHERE department_id =40);

[문제 55] 최소 평균값을 가지고 있는 부서번호, 평균을 출력해주세요.(모르겠다)
SELECT department_id, min(avg(salary)) --그룹함수 두 번 중첩해서 사용하면 개별컬럼 사용불가
FROM employees
GROUP BY department_id;

SELECT department_id,avg(salary)
FROM employees
GROUP BY department_id
having avg(salary) = (SELECT min(avg(salary))
                        FROM employees
                        GROUP BY department_id);

SELECT *
FROM employees
WHERE salary in (SELECT min(salary)
                FROM employees
                group by department_id);
                
--where 기준값 in (비교값)
where 기준값 = 비교값
or 기준값 = 비교값
....

SELECT *
FROM employees
WHERE salary > ANY(SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
            
서브쿼리에 여러행값이 나오면 여러행 비교연산자를 사용해야 한다.
IN(=OR), >ANY, <ANY, =ANY, >ALL, <ALL

★any 속성은 or 논리연산자의 의미를 내포하고 있다.
SELECT *
FROM employees
WHERE salary > 1000
or salary > 2000
or salary > 3000;
↓↓
SELECT *
FROM employees
WHERE salary > ALL (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
'> any' 의미는 최소값 보다 큼 역할
SELECT *
FROM employees
WHERE salary > any (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
-- =
SELECT *
FROM employees
WHERE salary > (SELECT min(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');    
              
select *
from employees
where salary < any (1000, 2000, 3000);
any 속성은 or 논리연산자의 의미를 내포하고 있다.
SELECT *
FROM employees
WHERE salary < 1000
or salary < 2000
or salary < 3000;
'< any' 의미는 최대값 보다 작은 역할

SELECT *
FROM employees
WHERE salary < any (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
-- =
SELECT *
FROM employees
WHERE salary < (SELECT max(salary)
                FROM employees
                WHERE job_id = 'IT_PROG'); 
                
select *
from employees
where salary > all (1000, 2000, 3000);
★all속성은 and 논리연산자의 의미를 내포하고 있다.                

SELECT *
FROM employees
WHERE salary > 1000
and salary > 2000
and salary > 3000;
 
'> all' 의미는 최대값 보다 크다
SELECT *
FROM employees
WHERE salary > all (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
-- =
SELECT *
FROM employees
WHERE salary > (SELECT max(salary)
                FROM employees
                WHERE job_id = 'IT_PROG'); 
                    
select *
from employees
where salary < all (1000, 2000, 3000);
★all속성은 and 논리연산자의 의미를 내포하고 있다.                

SELECT *
FROM employees
WHERE salary < 1000
and salary < 2000
and salary < 3000;
 
'< all' 의미는 최소값 보다 작다
SELECT *
FROM employees
WHERE salary < all (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
-- =
SELECT *
FROM employees
WHERE salary < (SELECT min(salary)
                FROM employees
                WHERE job_id = 'IT_PROG'); 
                                
------------------------오후수업
[문제56] 2006년도에 입사한 사원들의 job_id와 동일한 사원들의 job_id별 급여의 총액 중에 50000 이상인 값만 출력해주세요
--문제를 지우고 답을 가지고 역으로 문제를 만들어보기!!
SELECT job_id, sum(salary)
FROM employees
WHERE job_id in (SELECT job_id
                    FROM employees
                    WHERE hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
                    and hire_date < to_date('2007-01-01', 'yyyy-mm-dd'))
group by job_id
HAVING sum(salary) >= 50000;
                        
[문제57] location_id 가 1700인 모든 사원들의 last_name, department_id, job_id를 출력해주세요.
SELECT e.last_name, e.department_id, e.job_id
FROM employees e, departments d
where e.department_id = d.department_id
and d.location_id = 1700;

SELECT last_name, department_id, job_id
FROM employees 
where department_id in (select department_id
                        from departments
                        where location_id = 1700);
--서브쿼리랑 조인의 결과는 똑같은데 차이점은?       
--서브쿼리는 종속, 조인은 하나하나 따로 테이블을 볼 수 있다.
                        
[문제58] 60번 부서 사원들의 급여 보다 더 많은 급여를 받는 사원들의 정보를 출력해주세요.
select *
from employees
where salary > all (select salary
                    from employees
                    where department_id = 60);
select *
from employees
where salary > (select max(salary)
                    from employees
                    where department_id = 60);

[문제 59] 관리자 사원들의 정보를 출력해주세요.
SELECT m.*
FROM employees w join employees m
on w.manager_id = m.employee_id;

select *
from employees
where employee_id in (select manager_id
                        from employees);

select *
from employees
where employee_id = any (select distinct manager_id --중복을 제거하기 위해서 정렬 작업을 수행 해야하는 부담
                        from employees);

where employee_id = null
or employee_id =100
or employee_id = 123
....                                                
OR 진리표
TRUE OR TRUE = TRUE
TRUE OR FALSE = TRUE
FALSE OR TRUE = TRUE
FALSE OR FALSE =FALSE
TRUE OR NULL(T/F) = TRUE
FALSE OR NULL = NULL


[문제 60] 관리자가 아닌 사원들의 정보를 출력해주세요.
SELECT w.*
FROM employees w join employees m
on w.manager_id = m.employee_id
WHERE w.manager_id is not null;


where employee_id <> null
or employee_id <>100
or employee_id <> 123
....
AND 진리표
TRUE AND TRUE = TRUE
TRUE AND FALSE = FALSE
TRUE AND NULL = NULL
FALSE AND NULL = FALSE

select *
from employees
where employee_id not in (select manager_id
                        from employees
                        where manager_id is not null);
select *
from employees
where employee_id <> any (select manager_id
                        from employees); -- 전체사원
select *
from employees
where employee_id <> all (select manager_id
                        from employees 
                        where manager_id is not null); -- null값 때문에 is not null을 작성해야함
                        
                        
[문제 61] 자신의 부서 평균 급여보다 더 많이 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM employees
WHERE salary > (자신의 부서 평균 급여) ;

SELECT *
FROM employees
WHERE salary > (select avg(salary))
                from employees
                where department_id =  자신의 부서 코드);
                
select employee_id, salary, department_id
from employees;

select avg(salary)
from employees
where department_id = 변수;

select *
from employees o 
where salary > (select avg(salary)
                from employees
                where department_id = o.department_id);
★correlated subquery, 상호관련 서브쿼리
1. main query(outer query)를 먼저 수행
2. 첫 번째 행을 후보행으로 잡고 후보행 값을 서브쿼리에 전달
3. 후보행 값을 사용해서 서브쿼리 수행한다.
4. 서브쿼리 결과값을 사용해서 후보행과 비교한다.
5.다음 행을 후보행으로 잡고 2,3,4번을 반복 수행한다.

exists연산자
- 후보행 값이 서브쿼리에 존재하는지 여부를 찾는 연산자.
- 후보행 값이 서브쿼리에 존재하면 TRUE 우리가 찾는 데이터 검색종료
- 후보행 값이 서브쿼리에 존재하지 않으면 FALSE 우리가 찾는 데이터가 아니다.

SELECT *
FROM employees
WHERE employee_id in (select manager_id
                        from employees); -- null, 100, 101, 102~~~
where employee_id =null
or employee_id =100
or employee_id = 101
or employee_id = 102
or employee_id = 100 --in 연산자의 단점으로 중복되는 값들을 계속 비교해, distinct를 사용하면 더 비용이커지고 악성이 됨
....

select *
from employees o
where exists(select 'x' --exists연산자는 기준컬럼이 없음, 비교컬럼도(문법오류만 방지하고자 의미없는'x'를 넣음 숫자1 넣어도 상관없음)
                from employees
                where manager_id = o.employee_id);
                
[문제 62] 소속사원이 있는 부서정보를 출력해주세요.
1)in
SELECT *
FROM departments 
WHERE department_id in (SELECT department_id
                        FROM employees);
                        
2) exists
SELECT *
FROM departments d --SELECT * FROM departments d를 먼저 수행함
WHERE exists (SELECT 'x'
                FROM employees
                WHERE department_id = d.department_id);
                
SELECT * FROM departments;
                
not exists연산자
- 후보행 값이 서브쿼리에 존재하지 않는 데이터를 찾는 연산자
- 후보행 값이 서브쿼리에 존재하지 않으면 TRUE 우리가 찾는 데이터
- 후보행 값이 서브쿼리에 존재하면 FALSE 우리가 찾는 데이터가 아니다 검색 종료

SELECT *
FROM departments d --SELECT * FROM departments d를 먼저 수행함
WHERE not exists (SELECT 'x'
                FROM employees
                WHERE department_id = d.department_id);

SELECT *
FROM departments 
WHERE department_id not in (SELECT department_id 
                        FROM employees
                        where department_id is not null); 
                        
[문제 63] 관리자가 아닌 사원들의 정보를 출력해주세요.
1) NOT NULL
select *
from employees
where employee_id not in (select manager_id
                        from employees
                        where manager_id is not null);
                        
2) not exists 
SELECT *
FROM employees o
WHERE not exists (select 'x'
                    from employees
                    where manager_id = o.employee_id);