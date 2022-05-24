[문제30] JOB_ID 열의 값을 기반으로 모든 사원의 등급을 표시하는 query를 작성합니다.
<화면출력>
JOB_ID	 	GRADE
---------	-------	
AD_PRES 	A
ST_MAN 		B
IT_PROG 	C
SA_REP 		D
ST_CLERK 	E
            Z
...

1) DECODE
decode(기준값, 
        비교값1,참값1,
        비교삾2,참값2,
        기준값) --마지막에 기준값 안 적으면 null이 출력
        
SELECT job_id,
        DECODE(job_id,'AD_PRES','A',
                'ST_MAN','B',
                'IT_PROG','c',
                'SA_REP', 'D',
                'ST_CLERK','E',
                'Z') GRADE
FROM employees;

2) CASE
case 기준값
    when 비교값1 then 참값1
    when 비교값2 then 참값2
    else
end

SELECT job_id,
        case
            when job_id = 'AD_PRES' then
                'A'
            when job_id = 'ST_MAN' then    
                'B'
            when job_id = 'IT_PROG' then
                'c'
            when job_id = 'SA_REP' then
                'D'
            when job_id = 'ST_CLERK' then
                'E'
            else 'Z'
        end GRADE
FROM employees;
2) CASE2
SELECT job_id,
        case job_id
            when 'AD_PRES' then 'A'
            when 'ST_MAN' then  'B'
            when 'IT_PROG' then 'c'
            when 'SA_REP' then 'D'
            when 'ST_CLERK' then 'E'
            else 'Z'
        end GRADE
FROM employees;

SELECT job_id,
        case 
            when job_id in('AD_PRES', 'AC_MGR') then 'A' --다른 비교연산자가 사용되면 기준값을 when절에 다 표현해줘야 함
            when job_id = 'ST_MAN' then  'B'
            when job_id = 'IT_PROG' then 'c'
            when job_id = 'SA_REP' then 'D'
            when job_id = 'ST_CLERK' then 'E'
            else 'Z'
        end GRADE
FROM employees;

SELECT employee_id,
        nvl2(commission_pct, (salary*12)+(salary*12*commission_pct), salary*12) ann_sal
FROM employees;     
/* --nvl2함수 
if commission_pct is not null then
    (salary*12)+(salary*12*commission_pct)
else
    salary*12
end if;    
*/
decode, case 표현식에서 null check 방법
※decode 함수에서는 null keyword를 이용해서 null check해야 한다.
SELECT employee_id, 
        decode(commission_pct,
                null, salary*12, --null키워드 사용, is null 사용x
                (salary*12)+(salary*12*commission_pct)) ann_sal
FROM employees;

※case 표현식에서 is null 연산자를 이용해서 null check 해야 한다.
SELECT employee_id,
    case
        when commission_pct is null then --null키워드 사용 x, is null or is not null연산자 사용해야함
            salary * 12
        else 
            (salary*12)+(salary*12*commission_pct)
    end ann_sal
FROM employees;    

SELECT * FROM nls_session_parameters;

select 
    to_char(to_date('95-10-27','yy-mm-dd'), 'yyyy-mm-dd') YY,
    to_char(to_date('95-10-27','rr-mm-dd'), 'yyyy-mm-dd') RR
FROM dual;

95-10-27
YY : 현재년도의 세기를 반영 : 2095-10-27
RR : 2000년도 표기법을 자동화로 변경해준다.

                    지정된(데이터입력)연도(년도)
                    0~49                    50~99
현재연도(년도)        
0~49            반환 날짜는 현재 세기를 반영     반환날짜는 이전세기를 반영
50~99           반환 날짜는 이후 세기를 반영     반환날짜는 현재세기를 반영

현재년도    데이터 입력날짜       YY     RR
1994        92-10-27        1995    1995
1994        17-10-27        1917    2017
2001        17-10-27        2017    2017
2048        52-10-27        2052    1952
2051        47-10-27        2047    2147
YYYY-MM-DD

★단일행 함수
-행당 하나의 결과를 반환하는 함수
-문자함수, 숫자함수, 날짜함수, 형변환함수, NULL관련함수, 조건제어 관련함서

★그룹함수
-여러행당(행짐합) 하나의 결과를 반환하는 함수
-sum, avg, median, variance, stddev, max, min, count
-그룹함수에 입력하는 값이 숫자형만 입력해야하는 그룹함수 : sum, avg, median, variance, stddev
-그룹함수에 입력하는 값이 모든 타입이 가능하는 그룹함수 : count, max, min
-그룹함수는 null을 포함하지 않는다. 단 count(*)만 null을 포함
count : 행의 수를 구하는 함수
SELECT count(*)
FROM employees;

SELECT count(*) -- null포함한 행의 수를 구한다.
FROM employees
WHERE department_id = 50;

SELECT count(commission_pct), count(employee_id) --null제외한 행수를 구한다.
FROM employees
WHERE department_id = 50;

SELECT distinct department_id
FROM employees;

SELECT count(distinct department_id) --null을 제외한 건수
FROM employees;

sum : 합
SELECT sum(salary)
FROM employees;

SELECT sum(salary)
FROM employees
WHERE department_id = 50;

avg : 평균
SELECT avg(salary)
from employees;

SELECT avg(commission_pct) --null은 제외한 평균
FROM employees;
예)
1,null,2 --> (1+2)/2 --3명이지만 null은 빼고 2명만 계산함
만약에 전체 3으로 수행하려면?
--(1+2)/3 --> nvl함수로 null값을 0으로 대체하기

SELECT avg(nvl(commission_pct,0))
from employees;

median : 중앙값
-관측수(n) 홀수면 : (n+1)/2
-관측수(n) 짝수면 : 평균(n/2, (n+1)/2)

SELECT avg(salary), median(salary)
FROM employees;

자료의 중심 위치를 나타내는 대표값 : 평균(이상치데이터 때문에 문제스), 중앙값
자료의 퍼진 정도를 나타내는 값 : 분산, 표준편차, 범위, 사분위수

variance : 분산,  편차제곱의 합의 평균
SELECT variance(salary)
FROM employees;

stddev : 표준편차
SELECT stddev(salary)
FROM employees;

SELECT max(salary), min(salary), max(salary)-min(salary)
FROM employees;

SELECT max(hire_date), min(hire_date), max(last_name), min(last_name) --가장 최근에 입사한 날짜, 가장 오래된 입사한 날짜, 끝 이름, 첫 이름
FROM employees;

부서별로(소그룹) 급여 총액을 구해야 한다.
SELECT distinct department_id
FROM employees;

SELECT sum(salary)
FROM employees
WHERE department_id = 10; 

SELECT sum(salary)
FROM employees
WHERE department_id = 20; 

SELECT sum(salary)
FROM employees
WHERE department_id = 30;
...

group by 절을 이용해서 테이블의 행을 작은 그룹으로 나눌 수 있다.

SELECT department_id, sum(salary)
FROM employees
group by department_id;

그룹함수를 사용하실 때 주의 할 점
-null값 포함하지 않습니다.
-select절에 그룹함수에 포함되지 않는 개별컬럼은 하나도 빠짐없이 group by절에 명시해야 한다.
-group by 절에는 열별칭, 위치표기법 사용할 수 없다.
SELECT department_id ,job_id, sum(salary) --sum(salary)는 그룹함수, 나머지가 개별컬럼
FROM employees
group by department_id, job_id;

SELECT department_id dep_id,job_id, sum(salary) 
FROM employees
group by dep_id, job_id; --group by절에서 컬럼의 별칭 사용 오류!

SELECT department_id dep_id,job_id, sum(salary) 
FROM employees
group by 1, job_id; --group by절에서 컬럼의 위치표기법 사용하면 오류

SELECT department_id, sum(salary)
FROM employees
WHERE sum(salary) >= 10000 --where절은 행을 제한하는 절이기 때문에 그룹함수의 결과를 제한하면 오류(그룹함수보다 먼저 돌아감)
GROUP BY department_id; 

having절 : 그룹함수의 결과를 제한하는 절

SELECT department_id, sum(salary)
FROM employees
GROUP BY department_id
having sum(salary) >= 10000 ;

SELECT department_id, sum(salary)
FROM employees
GROUP BY department_id
having avg(salary) >= 10000 ;

SELECT department_id, job_id, sum(salary)
FROM employees
group by department_id, job_id
having avg(salary) > 5000;

SELECT department_id, job_id, sum(salary)
FROM employees
group by department_id, job_id
having count(*) > 5;


--보통 절들의 순서는 이렇게 / 실행되는 순서는 FROM - WHERE -GROUP - HAVING - 그룹함수적용 - 정렬
SELECT department_id, sum(salary)
FROM employees
WHERE last_name like '%i%' 
group by department_id
having sum(salary) >= 20000
order by 1;


SELECT department_id, max(avg(salary)) --그룹함수를 두 번 중첩할 때 개별 컬럼이 있으면 오류 발생
FROM employees
GROUP BY department_id;

SELECT max(avg(salary)) --그룹함수를 두 번 중첩할 때 개별 컬럼이 있으면 오류 발생
FROM employees
GROUP BY department_id; 
-- 부서 id를 볼 수 있는 해결방법은 sub query 이용
--내일이나 모레 해결방법 알려주신다고 했음 (혼자 찾아보기)


[문제31] 2008년도에 입사한 사원들의 job_id별 인원수를 구하고 인원수가 많은 순으로 출력하세요.

SELECT department_id,job_id, count(job_id)
FROM employees
WHERE hire_date between to_date('2008/01/01', 'yyyy/mm/dd') and to_date('2008/12/31 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
GROUP BY department_id,job_id
ORDER BY 3 desc;

------------강사님 답---------------
SELECT job_id, count(*) cnt
FROM employees
WHERE hire_date>=to_date('2008-01-01','yyyy-mm-dd')
and hire_date < to_date('2009-01-01', 'yyyy-mm-dd')
group by job_id
order by cnt desc;

[문제32] 년도별 입사한 인원수를 출력해주세요.
SELECT to_char(hire_date,'yyyy'), count(*)
FROM employees
group by to_char(hire_date,'yyyy')
order by 1;

[문제33] 월별 입사한 인원수 출력해주세요. 
SELECT  to_number(to_char(hire_date, 'mm')) month, count(employee_id)
FROM employees
group by to_number(to_char(hire_date, 'mm'))
order by 1;

[문제34] 아래 화면과 같이 출력해주세요.

     TOTAL     2001년     2002년     2003년
---------- ---------- ---------- ----------
       107          1          7          6

/* 해결책
count(if 입사한 년도 = '2001' then

end if)
*/
/* 
count(if 입사한 년도 = '2001' then
        count('x') -- 수행할 수 없다. 단일행함수에 그룹함수를 적용할 수 없다.
end if)
*/

SELECT  count(*) total,
        count(decode(to_char(hire_date,'yyyy'), '2001', 1)) "2001년", --이렇게 가로열로 2050년까지 뽑는다고 하면 비효율적이므로 서브쿼리를 사용해야함(다음주 수업까지 기다려야 한다고 함)
        count(decode(to_char(hire_date,'yyyy'), '2002', 1)) "2002년",
        count(decode(to_char(hire_date,'yyyy'), '2003', 1)) "2003년"
FROM employees;

SELECT  count(*) total,
        count(case to_char(hire_date, 'yyyy') when '2001' then 'x' end) "2001년", --count는 문자든 숫자든 가능
        count(case to_char(hire_date,'yyyy') when '2002' then 'x' end) "2002년",
        count(case to_char(hire_date,'yyyy') when '2003' then 'x' end) "2003년"
FROM employees;

SELECT  count(*) total,
        sum(case to_char(hire_date, 'yyyy') when '2001' then 1 end) "2001년", --sum은 문자가 안되고 숫자로 
        sum(case to_char(hire_date,'yyyy') when '2002' then 1 end) "2002년",
        sum(case to_char(hire_date,'yyyy') when '2003' then 1 end) "2003년"
FROM employees;


★JOIN (파이썬이나 R에서도 똑같음)
-두 개 이상의 테이블에서 내가 원하는 데이터를 가져오는 방법

1. catesian product
- 조인조건 생략된 경우
- 조인조건 잘못 만든 경우
-첫 번째 테이블 행의 수와 두 번째 테이블 행의 수가 곱해진다.
-107*21
SELECT employee_id, department_name --employee_id 107명, department_name 27개 
FROM employees, departments;

2.equi join, inner join, simple join, 등가조인
SELECT employee_id, department_name
FROM employees, departments
WHERE department_id = department_id; --ORA-00918: column ambiguously defined 오류

SELECT e.employee_id, d.department_name
FROM employees e, departments d --테이블의 별칭을 사용하는 습관을 갖자
WHERE e.department_id = d.department_id; --조인조건 술어

[문제35]사원들의 사원번호, 근무 도시를 출력해주세요
SELECT e.employee_id, l.city
FROM employees e, locations l, departments d
WHERE e.department_id = d.department_id
and d.location_id = l.location_id;

n개의 테이블을 조인하려면 조인조건술어는 몇개를 만들어야 하나요?
n-1개의 조인조건술어를 작성해야 한다.

[문제 36]사원들의 사원번호, 국가 이름을 출력해주세요
SELECT e.employee_id, c.country_id
FROM employees e, departments d, locations l, countries c
WHERE e.department_id = d.department_id --조인조건술어
    and d.location_id = l.location_id --조인조건술어
    and l.country_id = c.country_id; --조인조건술어
