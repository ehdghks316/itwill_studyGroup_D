주민번호_1             주민번호_2
---------------     ------------------
210101-1234567	210101-1******
SELECT '210101-1234567' "주민번호_1", rpad(substr('210101-1234567',1,8),14,'*') "주민번호_2"
FROM dual;


[문제 21] 전화번호 가운데 4자리 부분을 아래화면과 같이 출력해주세요.

전화번호_1             전화번호_2
---------------- ------------------
010-1000-1004         010-****-1004

SELECT '010-1000-1004' "전화번호_1", concat(rpad(substr('010-2714-0952',1,4),8,'*'),substr('010-2714-0952',-5,5)) "전화번호_2"
FROM dual;

[문제 22] 메일주소를 아래화면과 같이 출력해주세요.

EMAIL_1                EMAIL_2
------------------ -------------------
james@itwill.com    j****@itwill.com

SELECT 'james@itwill.com' "EMAIL_1", concat(rpad(substr('james@itwill.com',1,1),5,'*'), substr('james@itwill.com',instr('james@itwill.com','@',1,1)))
FROM dual;
★형변환 함수
★to_char : 날짜값을 문자로 형 변환하는 함수, data -> char
SELECT * FROM nls_session_parameters;
SELECT sysdate,
        to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss.sssss'),
        to_char(sysdate, 'yyyymmdd hh24miss.sssss'),
        to_char(sysdate, 'yyyy"년도" year month mon mm'),
        to_char(sysdate, 'ddd dd d'),
        to_char(sysdate, 'day dy'),
        to_char(sysdate, 'ww iw w')
FROM dual;

SELECT sysdate,
        to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss.ssss'),
        to_char(sysdate, 'yyyy"년도" month dd"일" hh24"시":mi"분":ss"초"'),
        to_char(sysdate, 'year day dy d dd ddd mm mon month'),
        to_char(sysdate, 'ww iw w')
FROM dual;        

SELECT sysdate,
        to_char(sysdate,'q'),
        to_char(sysdate,'q"분기"'), --리터럴문자로 넣을 때 큰따옴표 필수 
        to_char(sysdate,'q') || '분기',
        concat( to_char(sysdate,'q'),'분기'),
        to_char(sysdate,'dd ddth ddsp ddthsp')
FROM dual;    

SELECT sysdate,
        to_char(sysdate, 'q'),
        to_char(sysdate, 'q"분기"'),
        to_char(sysdate, 'q') || '분기',
        concat(to_char(sysdate, 'q'), '분기'),
        to_char(sysdate, 'ddsp ddth ddthsp ddspth d')
FROM dual;        
[문제23] 사원들의 사원번호, 입사한 요일을 출력하세요. 단 요일을 오름차순 정렬해주세요.

SELECT employee_id, hire_date, to_char(hire_date,'day')
FROM employees
ORDER BY to_char(hire_date-1,'d');

[문제24] employees(사원) 테이블에서  일요일에 입사한 사원의 정보를 조회하세요.

SELECT *
FROM employees
WHERE to_char(hire_date,'day') = '일요일';

[문제25] 오늘 날짜를  "2021년 12월 21일 화요일" 출력해주세요.

SELECT to_char(sysdate, 'yyyy"년" mm"월" dd"일" day')
FROM dual;

[문제26] 사원의 employees(사원)테이블에 있는 last_name,hire_date 및 근무 6 개월 후 첫번째 월요일에 해당하는 급여 협상 날짜를 표시합니다. 
             열 레이블을 REVIEW 로 지정합니다. 
            날짜는 "월요일, the Second of 4, 2007"과 유사한 형식으로 나타나도록 지정합니다.
SELECT last_name, to_char(hire_date, 'yyyy/mm/dd day'), to_char(next_day(add_months(hire_date,6),'월요일'), 'day", the" ddspth "of" fmmm, yyyy') REVIEW
FROM employees;


to_char(날짜, '날짜모델요소') : 날짜 -> 문자
to_char(숫자, '숫자모델요소') : 숫자 -> 문자
객체지향프로그램
overloading
-함수이름은 같지만 인수값으로 어떤 자료형이 들어오느냐에 따라 프로그램은 틀리게 수행하는 기능
-함수이름은 같지만 전혀 다른 함수들이다.

SELECT employee_id, salary, 
       to_char(salary, '999,999.00'),--숫자 한자리한자리를 9로 표현, 9자리의 값이 없으면 아무값도 채우지 않는다.
       to_char(salary, '000,999.00'), --0자리에 숫자가 없으면 0으로 표현
       to_char(salary, '999'), -- 표현해야 할 자리수가 안 맞으면 #으로 출력됨
       to_char(salary, '$9999,999.00'),
       to_char(salary, 'l9999,999.00'), -- l(엘) : 현재 세션을 맺는 지역의 통화부호를 표현
       to_char(salary, 'l9999g999d00')
FROM employees;

SELECT employee_id, salary,
        to_char(salary, '999,999.00'),
        to_char(salary, '000,999.00'),
        to_char(salary, '999'),
        to_char(salary, 'l999,999.00'),
        to_char(salary, 'l999g999d00')
FROM employees;        

SELECT * FROM nls_session_parameters;
alter session set nls_territory =  france;
alter session set nls_language = french;

alter session set nls_territory =  china;
alter session set nls_language = 'simplified chinese';

alter session set nls_territory =  america;
alter session set nls_language = american;

alter session set nls_territory =  'united kingdom';
alter session set nls_language = english;

alter session set nls_territory =  korea;
alter session set nls_language = korean;

SELECT employee_id,
        to_char(hire_date,'yyyy month dd day year'),y
        to_char(salary, 'l999g999d00') -- 천단위는g 소수점은 d
FROM employees;

SELECT 
    to_char(-1000, '9999'),
    to_char(-1000, '9999pr'), --음수일 경우 <>로 묶는다.
    to_char(-1000, '9999mi'), --음수를 뒤에 표현한다.
    to_char(+1000, 's9999') -- 부호를 표현한다.
FROM dual;

SELECT
to_char(-1000, '9999pr'),
to_char(-1000, '9999mi'),
to_char(-1000, 's9999')
from dual;


select to_char(-1000, '9999')
FROM dual;
암시적으로 형변환을 해준다.
SELECT '1' + 1
FROM dual;

to_number(문자숫자, 숫자모델요소(생략)) : 문자 -> 숫자
SELECT to_number('1', '9') + 1, 
        to_number('1') + 1 -- 숫자모델요소 생략가능
FROM dual;

SELECT sysdate + 1, sysdate + to_number('1')
FROM dual;

[문제27] 짝수달에 입사한 사원들의 정보를 출력해주세요.

SELECT *
from employees
WHERE mod(to_number(to_char(hire_date,'mm')),2) = 0;

[문제28] 2006년도에 홀수달에 입사한 사원들의 정보를 출력해주세요.

SELECT * --내가 풀이 한 코드 (안 좋은 코드)
FROM employees
WHERE to_char(hire_date, 'yyyy') = '2006'
    AND mod(to_number(to_char(hire_date,'mm')),2) =1;
    --to_number로 숫자형으로 변형하지 않더라도 암시적으로 형이 바뀌어서 수행됨
    --하지만 명시적으로 사용한다.
    
SELECT * --안정적인 코드
from employees
WHERE mod(to_number(to_char(hire_date,'mm')),2) != 0
    and hire_date >= '2006/01/01'
    and hire_date <='2006/12/31'; -- = WHERE hire_date between '2006/01/01' and '2006/12/31';

/* 악성프로그램
SELECT * 
FROM employees
WHERE HIRE_DATE LIKE '06%'; 
--내부적으로 to_char(hire_date) like '06%';를 수행함 : 여기서 문제점은 만약에 hire_date가 인덱스가 생성되어 있는 컬럼일 경우 인덱스 스캔이 아닌 테이블 full scan이 수행된다.
--like연산자는 문자 패턴을 찾는 연산자
--hire_date가 문자컬럼이 아니면 암시적으로 형을 변환해서 수행
--대소문자나 형이변환되는 것(데이터타입이 바뀌는 것)은 배제하자!
--파이썬이나 R에서는 상관없음

SELECT *
FROM employees
WHERE to_char(hire_date, 'yyyy') = '2006'
-- 같은 문제점
*/
SELECT * FROM nls_session_parameters;
ALTER session set nls_territory = america;
alter session set nls_language = american;

SELECT * --지역에 따라 날짜 형식은 민감
from employees
WHERE hire_date >= '2006/01/01'--문자형임(내부적으로 돌아감to_date가)
    and hire_date <='2006/12/31';
    
SELECT *  --지역에 따라 날짜 형식은 민감
from employees
WHERE hire_date >= '01-JAN-06'
    and hire_date <='31-DEC-2006'; 

★to_date(문자날짜, 날짜포맷모델요소) : 문자날짜 -> 날짜
SELECT *
from employees
WHERE hire_date >= to_date('2006/01/01', 'yyyy/mm/dd') --명시적으로 쓰는 습관을 가지자 이렇게 하면 지역에 상관없이 돌아감
    and hire_date <= to_date('2006/12/31 23:59:59', 'yyyy/mm/dd hh24:mi:ss');     --주의할 점 2006/1월/1일 00시부터는 맞지만 2006/12월31일도 00시까지이므로 이렇게 표현

SELECT *
from employees
WHERE hire_date >= to_date('2006/01/01', 'yyyy/mm/dd') --명시적으로 쓰는 습관을 가지자 이렇게 하면 지역에 상관없이 돌아감
    and hire_date < to_date('2007/01/01', 'yyyy/mm/dd');-- 이런 방식으로 표현할 수 있는데 대신 between and 연산자 사용불가
    
    
▶NULL관련 함수
★nvl 
- null값을 실제값으로 리턴하는 함수
- nvl함수는 입력되는 인수값들의 데이터 타입이 일치해야한다.
if exp1 is null then
    return exp2
else
    return exp1
end if;    

desc employees
SELECT employee_id, salary, commission_pct,
        ((salary * 12) + (salary * 12 * commission_pct)) ann_sal,
        ((salary * 12) + (salary * 12 * nvl(commission_pct,0))) ann_sal2
FROM employees;  

SELECT employee_id, salary, commission_pct,
    ((salary * 12) + (salary*12 * commission_pct)) an,
    ((salary*12) + (salary*12*nvl(commission_pct,0))) an2
from employees;

SELECT nvl(commission_pct,'no comm') --형의 불일치 때문에 오류가 남 commission_pct는 숫자, 'no comm'은 문자
FROM employees;

SELECT nvl(to_char(commission_pct),'no comm')  --두 인수의 타입이 일치하면 됨
FROM employees;

★nvl2(exp1,exp2,exp3)
-첫 번째 exp1이 null 아니면 exp2를 수행하고 첫 번째 exp1이 null이면 exp3를 수행한다.
-exp2,exp3의 데이터타입이 일치해야 한다.
if exp1 is not null then
    exp2
else
    exp3
end if;    

SELECT employee_id,salary,commission_pct,
        nvl2(commission_pct,(salary*12) + (salary*12*commission_pct), salary*12) ann_sal
FROM employees;        
        
SELECT employee_id, salary, commission_pct,
    nvl2(commission_pct,(salary*12), salary*0) an
    from employees;
    
    
SELECT employee_id,salary,commission_pct,
        nvl2(commission_pct,to_char(salary*12), 'no comm') ann_sal
FROM employees;               

★coalesce(exp1,exp2,exp3,.....expn)
- 첫 번째 exp1이 null이면 두 번째 exp2를 수행하고 두 번째 표현식도 null이면 exp3을 수행한다.
즉 null이 발생하지 않을 때 까지 표현식을 수행하는 기능

SELECT employee_id,
    coalesce((salary*12) + (salary*12*commission_pct), salary*12,0)
FROM employees;    

SELECT employee_id,
    coalesce(salary, (salary*commission_pct), salary*commission_pct,0)
    from employees;

★nullif(exp1,exp2)
-두 표현식을 비교해서 같으면 null을 리턴하고 같지 않으면 첫 번째 표현식을 리턴한다.
if exp1 = exp2 then
    null
else
    exp1
end if;

SELECT employee_id, last_name, first_name,
        nullif(length(last_name), length(first_name)) nullif1,
        nullif(length(first_name), length(last_name)) nullif2
FROM employees;  

SELECT employee_id, last_name, first_name,
    nullif(length(last_name), length(first_name))
    from employees;

▶조건제어문
it를 사용할 수 있도록 decode함수, case 표현식을 제공한다.

SELECT employee_id, job_id, salary
FROM employees;

if job_id = 'IT_PROG' then
    salary * 1.1
else if job_id = 'SY_CLERK' then
    salary * 1.2
else if job_id = 'SA_REP' then
    salary *1.3
else
    salary
end if;

decode
if 기준값 = 비교값1 then
    참값1
else  기준값 = 비교값2 then
   참값2
else if  기준값= 비교값3 then
    참값3
else
    기준값
end if;

★decode 함수는 기준값과 비교값을 같다(=) 비교연산자만 사용한다.
decode(기준값,
        비교값1, 참값1,
        비교값2, 참값2,
        비교값3,참값3,......
        기준값)


if job_id = 'IT_PROG' then
    salary * 1.1
else if job_id = 'SY_CLERK' then
    salary * 1.2
else if job_id = 'SA_REP' then
    salary *1.3
else
    salary
end if;

SELECT employee_id, job_id,
    decode(job_id, 'IT_PROG', salary *1.1,
            'ST_CLERK', salary * 1.2,
            'SA_REP', salary * 1.3,
            salary) rewised_salary
from employees;            

★case 표현식 : 기준값과 비교값의 대해서 모든 비교연산자를 사용할 수 있다.

case 기준값 = 비교값
    when 비교값1 then 참값1
    when 비교값2 then 참값2
    when 비교값3 then 참값3
    ...
    else 기준값
end    

case 기준값 = 비교값
    when 기준값 = 비교값1 then 참값1
    when 기준값 = 비교값2 then 참값2
    when 기준값 = 비교값3 then 참값3
    ...
    else 기준값
end    
기준값 비교연산자(=,>,>=, <=,<,!=,^=, in, between and, like) 비교값

case 기준값 = 비교값
    when 기준값 >= 비교값1 then 참값1
    when 기준값 <= 비교값2 then 참값2
    when 기준값 in(비교값3,비교값4) then 참값3
    ...
    else 기준값
end    

SELECT employee_id, job_id,
    case job_id
        when 'IT_PROG' then 
            salary *1.1
        when 'ST_CLERK' then
            salary * 1.2
        when 'SA_REP' then
            salary * 1.3
        else salary    
    end rewised_salary
from employees;    

SELECT employee_id, job_id,
    case
        when job_id = 'IT_PROG' then 
            salary *1.1
        when job_id = 'ST_CLERK' then
            salary * 1.2
        when job_id = 'SA_REP' then 
            salary * 1.3
        else salary    
    end rewised_salary
from employees; 

[문제29] 사원들의 급여를 기준으로 출력해주세요.
        ~4999      : low
    5000~9999    : medium
    10000~19999 : good
    20000~        : excellent
    
SELECT employee_id, salary,
    case
        when salary between 0 and 4999 then
            'low'
        when salary >= 5000 and salary < 10000 then
            'medium'
        when salary >=10000 and salary < 20000 then
            'good'
        else 'excellent'
    end rewised_salary    
FROM employees;
