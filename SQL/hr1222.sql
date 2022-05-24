[����30] JOB_ID ���� ���� ������� ��� ����� ����� ǥ���ϴ� query�� �ۼ��մϴ�.
<ȭ�����>
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
decode(���ذ�, 
        �񱳰�1,����1,
        �񱳘�2,����2,
        ���ذ�) --�������� ���ذ� �� ������ null�� ���
        
SELECT job_id,
        DECODE(job_id,'AD_PRES','A',
                'ST_MAN','B',
                'IT_PROG','c',
                'SA_REP', 'D',
                'ST_CLERK','E',
                'Z') GRADE
FROM employees;

2) CASE
case ���ذ�
    when �񱳰�1 then ����1
    when �񱳰�2 then ����2
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
            when job_id in('AD_PRES', 'AC_MGR') then 'A' --�ٸ� �񱳿����ڰ� ���Ǹ� ���ذ��� when���� �� ǥ������� ��
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
/* --nvl2�Լ� 
if commission_pct is not null then
    (salary*12)+(salary*12*commission_pct)
else
    salary*12
end if;    
*/
decode, case ǥ���Ŀ��� null check ���
��decode �Լ������� null keyword�� �̿��ؼ� null check�ؾ� �Ѵ�.
SELECT employee_id, 
        decode(commission_pct,
                null, salary*12, --nullŰ���� ���, is null ���x
                (salary*12)+(salary*12*commission_pct)) ann_sal
FROM employees;

��case ǥ���Ŀ��� is null �����ڸ� �̿��ؼ� null check �ؾ� �Ѵ�.
SELECT employee_id,
    case
        when commission_pct is null then --nullŰ���� ��� x, is null or is not null������ ����ؾ���
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
YY : ����⵵�� ���⸦ �ݿ� : 2095-10-27
RR : 2000�⵵ ǥ����� �ڵ�ȭ�� �������ش�.

                    ������(�������Է�)����(�⵵)
                    0~49                    50~99
���翬��(�⵵)        
0~49            ��ȯ ��¥�� ���� ���⸦ �ݿ�     ��ȯ��¥�� �������⸦ �ݿ�
50~99           ��ȯ ��¥�� ���� ���⸦ �ݿ�     ��ȯ��¥�� ���缼�⸦ �ݿ�

����⵵    ������ �Է³�¥       YY     RR
1994        92-10-27        1995    1995
1994        17-10-27        1917    2017
2001        17-10-27        2017    2017
2048        52-10-27        2052    1952
2051        47-10-27        2047    2147
YYYY-MM-DD

�ڴ����� �Լ�
-��� �ϳ��� ����� ��ȯ�ϴ� �Լ�
-�����Լ�, �����Լ�, ��¥�Լ�, ����ȯ�Լ�, NULL�����Լ�, �������� �����Լ�

�ڱ׷��Լ�
-�������(������) �ϳ��� ����� ��ȯ�ϴ� �Լ�
-sum, avg, median, variance, stddev, max, min, count
-�׷��Լ��� �Է��ϴ� ���� �������� �Է��ؾ��ϴ� �׷��Լ� : sum, avg, median, variance, stddev
-�׷��Լ��� �Է��ϴ� ���� ��� Ÿ���� �����ϴ� �׷��Լ� : count, max, min
-�׷��Լ��� null�� �������� �ʴ´�. �� count(*)�� null�� ����
count : ���� ���� ���ϴ� �Լ�
SELECT count(*)
FROM employees;

SELECT count(*) -- null������ ���� ���� ���Ѵ�.
FROM employees
WHERE department_id = 50;

SELECT count(commission_pct), count(employee_id) --null������ ����� ���Ѵ�.
FROM employees
WHERE department_id = 50;

SELECT distinct department_id
FROM employees;

SELECT count(distinct department_id) --null�� ������ �Ǽ�
FROM employees;

sum : ��
SELECT sum(salary)
FROM employees;

SELECT sum(salary)
FROM employees
WHERE department_id = 50;

avg : ���
SELECT avg(salary)
from employees;

SELECT avg(commission_pct) --null�� ������ ���
FROM employees;
��)
1,null,2 --> (1+2)/2 --3�������� null�� ���� 2�� �����
���࿡ ��ü 3���� �����Ϸ���?
--(1+2)/3 --> nvl�Լ��� null���� 0���� ��ü�ϱ�

SELECT avg(nvl(commission_pct,0))
from employees;

median : �߾Ӱ�
-������(n) Ȧ���� : (n+1)/2
-������(n) ¦���� : ���(n/2, (n+1)/2)

SELECT avg(salary), median(salary)
FROM employees;

�ڷ��� �߽� ��ġ�� ��Ÿ���� ��ǥ�� : ���(�̻�ġ������ ������ ������), �߾Ӱ�
�ڷ��� ���� ������ ��Ÿ���� �� : �л�, ǥ������, ����, �������

variance : �л�,  ���������� ���� ���
SELECT variance(salary)
FROM employees;

stddev : ǥ������
SELECT stddev(salary)
FROM employees;

SELECT max(salary), min(salary), max(salary)-min(salary)
FROM employees;

SELECT max(hire_date), min(hire_date), max(last_name), min(last_name) --���� �ֱٿ� �Ի��� ��¥, ���� ������ �Ի��� ��¥, �� �̸�, ù �̸�
FROM employees;

�μ�����(�ұ׷�) �޿� �Ѿ��� ���ؾ� �Ѵ�.
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

group by ���� �̿��ؼ� ���̺��� ���� ���� �׷����� ���� �� �ִ�.

SELECT department_id, sum(salary)
FROM employees
group by department_id;

�׷��Լ��� ����Ͻ� �� ���� �� ��
-null�� �������� �ʽ��ϴ�.
-select���� �׷��Լ��� ���Ե��� �ʴ� �����÷��� �ϳ��� �������� group by���� ����ؾ� �Ѵ�.
-group by ������ ����Ī, ��ġǥ��� ����� �� ����.
SELECT department_id ,job_id, sum(salary) --sum(salary)�� �׷��Լ�, �������� �����÷�
FROM employees
group by department_id, job_id;

SELECT department_id dep_id,job_id, sum(salary) 
FROM employees
group by dep_id, job_id; --group by������ �÷��� ��Ī ��� ����!

SELECT department_id dep_id,job_id, sum(salary) 
FROM employees
group by 1, job_id; --group by������ �÷��� ��ġǥ��� ����ϸ� ����

SELECT department_id, sum(salary)
FROM employees
WHERE sum(salary) >= 10000 --where���� ���� �����ϴ� ���̱� ������ �׷��Լ��� ����� �����ϸ� ����(�׷��Լ����� ���� ���ư�)
GROUP BY department_id; 

having�� : �׷��Լ��� ����� �����ϴ� ��

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


--���� ������ ������ �̷��� / ����Ǵ� ������ FROM - WHERE -GROUP - HAVING - �׷��Լ����� - ����
SELECT department_id, sum(salary)
FROM employees
WHERE last_name like '%i%' 
group by department_id
having sum(salary) >= 20000
order by 1;


SELECT department_id, max(avg(salary)) --�׷��Լ��� �� �� ��ø�� �� ���� �÷��� ������ ���� �߻�
FROM employees
GROUP BY department_id;

SELECT max(avg(salary)) --�׷��Լ��� �� �� ��ø�� �� ���� �÷��� ������ ���� �߻�
FROM employees
GROUP BY department_id; 
-- �μ� id�� �� �� �ִ� �ذ����� sub query �̿�
--�����̳� �� �ذ��� �˷��ֽŴٰ� ���� (ȥ�� ã�ƺ���)


[����31] 2008�⵵�� �Ի��� ������� job_id�� �ο����� ���ϰ� �ο����� ���� ������ ����ϼ���.

SELECT department_id,job_id, count(job_id)
FROM employees
WHERE hire_date between to_date('2008/01/01', 'yyyy/mm/dd') and to_date('2008/12/31 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
GROUP BY department_id,job_id
ORDER BY 3 desc;

------------����� ��---------------
SELECT job_id, count(*) cnt
FROM employees
WHERE hire_date>=to_date('2008-01-01','yyyy-mm-dd')
and hire_date < to_date('2009-01-01', 'yyyy-mm-dd')
group by job_id
order by cnt desc;

[����32] �⵵�� �Ի��� �ο����� ������ּ���.
SELECT to_char(hire_date,'yyyy'), count(*)
FROM employees
group by to_char(hire_date,'yyyy')
order by 1;

[����33] ���� �Ի��� �ο��� ������ּ���. 
SELECT  to_number(to_char(hire_date, 'mm')) month, count(employee_id)
FROM employees
group by to_number(to_char(hire_date, 'mm'))
order by 1;

[����34] �Ʒ� ȭ��� ���� ������ּ���.

     TOTAL     2001��     2002��     2003��
---------- ---------- ---------- ----------
       107          1          7          6

/* �ذ�å
count(if �Ի��� �⵵ = '2001' then

end if)
*/
/* 
count(if �Ի��� �⵵ = '2001' then
        count('x') -- ������ �� ����. �������Լ��� �׷��Լ��� ������ �� ����.
end if)
*/

SELECT  count(*) total,
        count(decode(to_char(hire_date,'yyyy'), '2001', 1)) "2001��", --�̷��� ���ο��� 2050����� �̴´ٰ� �ϸ� ��ȿ�����̹Ƿ� ���������� ����ؾ���(������ �������� ��ٷ��� �Ѵٰ� ��)
        count(decode(to_char(hire_date,'yyyy'), '2002', 1)) "2002��",
        count(decode(to_char(hire_date,'yyyy'), '2003', 1)) "2003��"
FROM employees;

SELECT  count(*) total,
        count(case to_char(hire_date, 'yyyy') when '2001' then 'x' end) "2001��", --count�� ���ڵ� ���ڵ� ����
        count(case to_char(hire_date,'yyyy') when '2002' then 'x' end) "2002��",
        count(case to_char(hire_date,'yyyy') when '2003' then 'x' end) "2003��"
FROM employees;

SELECT  count(*) total,
        sum(case to_char(hire_date, 'yyyy') when '2001' then 1 end) "2001��", --sum�� ���ڰ� �ȵǰ� ���ڷ� 
        sum(case to_char(hire_date,'yyyy') when '2002' then 1 end) "2002��",
        sum(case to_char(hire_date,'yyyy') when '2003' then 1 end) "2003��"
FROM employees;


��JOIN (���̽��̳� R������ �Ȱ���)
-�� �� �̻��� ���̺��� ���� ���ϴ� �����͸� �������� ���

1. catesian product
- �������� ������ ���
- �������� �߸� ���� ���
-ù ��° ���̺� ���� ���� �� ��° ���̺� ���� ���� ��������.
-107*21
SELECT employee_id, department_name --employee_id 107��, department_name 27�� 
FROM employees, departments;

2.equi join, inner join, simple join, �����
SELECT employee_id, department_name
FROM employees, departments
WHERE department_id = department_id; --ORA-00918: column ambiguously defined ����

SELECT e.employee_id, d.department_name
FROM employees e, departments d --���̺��� ��Ī�� ����ϴ� ������ ����
WHERE e.department_id = d.department_id; --�������� ����

[����35]������� �����ȣ, �ٹ� ���ø� ������ּ���
SELECT e.employee_id, l.city
FROM employees e, locations l, departments d
WHERE e.department_id = d.department_id
and d.location_id = l.location_id;

n���� ���̺��� �����Ϸ��� �������Ǽ���� ��� ������ �ϳ���?
n-1���� �������Ǽ�� �ۼ��ؾ� �Ѵ�.

[���� 36]������� �����ȣ, ���� �̸��� ������ּ���
SELECT e.employee_id, c.country_id
FROM employees e, departments d, locations l, countries c
WHERE e.department_id = d.department_id --�������Ǽ���
    and d.location_id = l.location_id --�������Ǽ���
    and l.country_id = c.country_id; --�������Ǽ���
