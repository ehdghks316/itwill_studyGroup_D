drop table job_grades purge; -- 테이블 drop(제거)하다 ->밑에 문장을 실수로 두번 수행했을 때 해결책

CREATE TABLE job_grades
( grade_level varchar2(3),
  lowest_sal  number,
  highest_sal number);

INSERT INTO job_grades VALUES ('A',1000,2999);
INSERT INTO job_grades VALUES ('B',3000,5999);
INSERT INTO job_grades VALUES ('C',6000,9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);
commit; 
SELECT e.employee_id, d.department_name
FROM employees e natural join departments d;

SELECT e.employee_id, d.department_name
FROM employees e join departments d
using(department_id)
where department_id =30;

SELECT e.employee_id, d.department_name
FROM employees e join departments d
using (e.department_id) --오류나옴, using 절에 사용된 기준컬럼은 어느 테이블이라고 지정하면 안된다.
where e.department_id =30; --오류나옴, using 절에 사용된 기준컬럼은 어느 테이블이라고 지정하면 안된다. 마찬가지

SELECT e.employee_id, d.department_name, l.city
FROM employees e join departments d
using (department_id)
join locations l
using (location_id)
where department_id = 30;

SELECT e.employee_id, d.department_name, l.city
FROM employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
WHERE e.department_id in (30,50);

[문제46] 사원들의 사번, 급여, 급여등급, 부서이름을 출력하세요.
         부서배치를 받지 않는 사원은 제외시켜주세요. 단 join on절을 이용해주세요

SELECT e.employee_id, e.salary, j.grade_level, d.department_name
FROM employees e join departments d
on e.department_id = d.department_id
join job_grades j
on e.salary between j.lowest_sal and j.highest_sal;

select w.last_name, m.last_name
from employees w join employees m
on w.manager_id = m.employee_id;

SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
where e.department_id(+)= d.department_id(+); --오류(양쪽 아우터조인 x)

1) 해결방법
SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
where e.department_id(+)= d.department_id
union --양쪽쿼리문을 하나로 합쳐 중복을 제거하는 합집합연산자
SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
where e.department_id= d.department_id(+);
 --성능상 좋지 않음 (테이블을 두 번 엑세스 해야되서 비효율적)
2) 해결방법 
-ansi 표준의 full outer join 이용하면 된다.

SELECT e.employee_id, e.salary, d.department_name
FROM employees e full outer join departments d
on e.department_id= d.department_id; -- 위의 식을 해결한 것이 full outer join

SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d; --cartesian product

SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
WHERE  e.department_id = 20
and d.department_id = 20;

SELECT e.employee_id, e.salary, d.department_name
FROM employees e cross join departments d; --cartesian product

문제47] 2006년도에 입사한 사원들의 부서이름별 급여의 총액, 평균을 출력해주세요.
1) 오라클 전용
SELECT d.department_name, sum(e.salary),avg(e.salary) 
FROM employees e, departments d
WHERE e.department_id = d.department_id
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by d.department_name;


2) ANSI 표준
SELECT d.department_name, sum(e.salary),avg(e.salary) 
FROM employees e join departments d
on e.department_id = d.department_id
where e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by d.department_name;


[문제48] 2006년도에 입사한 사원들의 도시이름별 급여의 총액, 평균을 출력해주세요.
1) 오라클 전용
SELECT l.city, sum(e.salary), avg(e.salary)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
and d.location_id = l.location_id
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

2) ANSI 표준
SELECT l.city, sum(e.salary), avg(e.salary)
FROM employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

SELECT l.city, sum(e.salary), avg(e.salary)
FROM employees e join departments d
using (department_id)
join locations l
using (location_id)
where e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

[문제49] 2007년도에 입사한 사원들의 도시이름별 급여의 총액, 평균을 출력해주세요.
단 부서 배치를 받지 않은 사원들의 정보도 출력해주세요.
1) 오라클 전용
SELECT l.city, sum(e.salary), avg(e.salary)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

2) ANSI 표준
SELECT l.city, sum(e.salary), avg(e.salary) 
FROM employees e left outer join departments d
on e.department_id = d.department_id
left outer join locations l
on d.location_id = l.location_id
WHERE e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

[문제50] 사원들의 last_name,salary,grade_level, department_name을 출력하는데 last_name에 a문자가 2개 이상 포함되어 있는 사원들을 출력하세요.
1) 오라클 전용
SELECT e.last_name, e.salary, j.grade_level, d.department_name
FROM employees e, departments d, job_grades j
WHERE e.department_id = d.department_id
and e.salary between j.lowest_sal and j.highest_sal
and e.last_name like '%a%a%';
--instr(e.last_name, 'a',1,2) >0; like대신

2) ANSI 표준 
SELECT e.last_name, e.salary, j.grade_level, d.department_name
FROM employees e join departments d 
on e.department_id = d.department_id
join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
where e.last_name like '%a%a%';
