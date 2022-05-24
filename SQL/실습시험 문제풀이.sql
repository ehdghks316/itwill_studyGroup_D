성명 :                  점수 :  

문제1. 입사한 월을 출력하고 월별 입사자 수를 1월부터 12월 까지 순서대로 출력하시오.

풀이)
select 월||'월' 월, 인원수
from (select to_char(hire_date,'mm') 월, count(*) 인원수
      from employees
      group by to_char(hire_date,'mm')
      order by 1);


문제2. 근속연수가 가장 긴 10위까지 사원들의 employee_id, last_name, hire_date를 출력하세요.(연이은 순위를 구하세요)

풀이)
select *
from (Select employee_id, last_name, hire_date,dense_rank() over(order by hire_date) rank
      from employees)
where rank <= 10;


select *
from (select employee_id, last_name, hire_date, dense_rank() over(order by day desc) rank
      from (select employee_id, last_name, hire_date, sysdate - hire_date day
            from employees))
where rank <= 10;


문제3. 아래화면과 같이 급여의 도수분포표를 생성하세요.

계급               도수
----------- ----------
2000~5000           49
5001~10000          43
10001~15000         12
15001~20000          2
20001~               1


풀이)
select *
from (select 
        count(case when salary between 2000 and 5000 then 'x' end) "2000~5000",
        count(case when salary between 5001 and 10000 then 'x' end) "5001~10000",
        count(case when salary between 10001 and 15000 then 'x' end) "10001~15000",
        count(case when salary between 15001 and 20000 then 'x' end) "15001~20000",
        count(case when salary > 20001 then 'x' end) "20001~"
      from employees)
unpivot (도수 for 계급 in ("2000~5000", "5001~10000", "10001~15000", "15001~20000", "20001~"));


select *
from (select 
        sum(case when salary between 2000 and 5000 then 1 end) "2000~5000",
        sum(case when salary between 5001 and 10000 then 1 end) "5001~10000",
        sum(case when salary between 10001 and 15000 then 1 end) "10001~15000",
        sum(case when salary between 15001 and 20000 then 1 end) "15001~20000",
        sum(case when salary > 20001 then 1 end) "20001~"
      from employees)
unpivot (도수 for 계급 in ("2000~5000", "5001~10000", "10001~15000", "15001~20000", "20001~"));





문제4.  15000 이상 급여를 받는 관리자 이름, 급여, 급여등급을 출력하세요.

풀이)
select e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where exists (select 'x' 
              from employees
              where manager_id = e.employee_id)
and e.salary >= 15000
and e.salary between j.lowest_sal and j.highest_sal;


문제5. 년도 분기별 급여 총액을 출력하세요.

풀이)
select 년도, nvl("1분기",0) "1분기", nvl("2분기",0) "2분기",
            nvl("3분기",0) "3분기", nvl("4분기",0) "4분기"
from(select to_char(hire_date,'yyyy') 년도, to_char(hire_date,'q') 분기, salary
     from employees)
pivot (sum(salary) for 분기 in (1 "1분기", 2 "2분기", 3 "3분기" ,4 "4분기"))
order by 1;


select to_char(hire_date,'yyyy') 년도,
        sum(decode(to_char(hire_date,'q'),'1',salary)) "1분기",
        sum(decode(to_char(hire_date,'q'),'2',salary)) "2분기",
        sum(decode(to_char(hire_date,'q'),'3',salary)) "3분기",
        sum(decode(to_char(hire_date,'q'),'4',salary)) "4분기"
from employees
group by to_char(hire_date,'yyyy');


문제6. 같은 부서에서  last_name이 같은 사원들을 찾아주세요.

풀이)
select * 
from employees e
where exists (select 'x'
              from employees
              where department_id = e.department_id
              and last_name = e.last_name
              and employee_id <> e.employee_id);


문제7 . 사원수가 3명 미만인 부서번호,부서이름,인원수를 출력해주세요.	

풀이)
select  d.department_id, d.department_name, count(*)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id, d.department_name
having count(*) < 3
order by 1;
-- 조인의 일량이 너무 많음

select d.department_id, d.department_name, e.cnt
from (select department_id, count(*) cnt
      from employees
      group by department_id
      having count(*) < 3) e, departments d
where e.department_id = d.department_id;
--그래서 이렇게 inline view이용

문제8 . 사원 수가 가장 많은 부서정보, 도시, 인원수를 출력해주세요.

select d.*, l.city, e.cnt
from (select department_id, cnt, case when cnt = max(cnt) over() then 1 end max_cnt
      from (select department_id, count(*) cnt
            from employees
            group by department_id)) e, departments d, locations l
where max_cnt = 1
and e.department_id = d.department_id
and d.location_id = l.location_id;
--문제점. 큰 테이블을 두번 반복해서 조회함.

select department_id, count(*) cnt
        from employees
        group by department_id
        having count(*) = (select max(count(*))
                            from employees
                            group by department_id);

select *
from (select department_id, cnt, max(cnt) over(), case when cnt = max(cnt) over() then 1 end max_cnt
      from (select department_id, count(*) cnt
            from employees
            group by department_id))
where max_cnt = 1;
--분석함수를 이용해서 큰 테이블 두번 조회하는 것 막기 . 근데 또 다른 방법 with문이 있음 둘중 하나 쓰면 좋음


select *
from (select department_id, count(*) cnt
        from employees
        group by department_id) e1, (select max(cnt) max_cnt from e1) e2
where e1.cnt = e2.max_cnt;
--inline view를 다시 테이블로 호출할 수 없다. 오류. 
-- 해결방법

■ with문
- 두번 이상 반복되는 select문을 query block(가상테이블)을 만들어서 사용한다.
- 성능을 향상시킬 수 있다.

with
dept_cnt as (select department_id, count(*) cnt
            from employees
            group by department_id)
select d.*, l.city, e.cnt
from dept_cnt e, departments d, locations l --가상테이블 
where cnt = (select max(cnt)
             from dept_cnt)
and e.department_id = d.department_id
and d.location_id = l.location_id;


with
가상테이블1 as (subquery),
가상테이블2 as (select ... from 가상테이블1),
가상테이블3 as (subquery),
가상테이블4 as (select ... from 가상테이블2)
...
select 가상테이블...., 실제테이블,,,
where 조인문...
and 행을 제한하는 조건절...;



        
문제9. 요일별 입사한 인원수를 출력해주세요.

풀이)
select *
from (select to_char(hire_date,'d') day
      from employees)
pivot(count(*) for day in (2 "월",3 "화",4 "수",5 "목",6 "금",7 "토",1 "일"));


select *
from (select *
        from (select to_char(hire_date,'d') day
              from employees)
        pivot(count(*) for day in (2 "월",3 "화",4 "수",5 "목",6 "금",7 "토",1 "일")))
unpivot(인원수 for 요일 in ("월","화","수","목","금","토","일"));


문제10.  부서별 최고 급여자들을 출력해주세요

풀이)
select e2.*
from (select department_id, max(salary) maxsal
        from employees
        group by department_id) e1, employees e2
where e1.department_id = e2.department_id
and e1.maxsal = e2.salary;


select *
from employees
where (department_id, salary) in (select department_id, max(salary) maxsal
                                    from employees
                                    group by department_id);
--위의 두 방법은 큰 테이블을 두번 조회한다는 문제가 있음. 그래서 아래처럼 하는 게 좋음.


select *
from (select employee_id, last_name, salary, department_id,
                max(salary) over(partition by department_id) 부서최고값,
                case when salary = max(salary) over(partition by department_id) then 1 end 부서최고값2
        from employees)
where 부서최고값2 = 1;



--위드문은 테이블 두번 반복하기 때문에 사용하면 안좋음
with
dept_max as (select department_id, max(salary) maxsal
             from employees
             group by department_id)
select *
from employees
where (department_id, salary) in (select department_id, maxsal from dept_max);
