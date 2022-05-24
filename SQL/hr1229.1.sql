[����81] �Ʒ� ȭ��� ���� ������ּ���.
�⵵     SA_REP               SH_CLERK             ST_CLERK
-------- -------------------- -------------------- --------------------
2001                   ��0��                ��0��                ��0��
2002                   ��0��                ��0��                ��0��
2003                   ��0��                ��0��            ��7,100��
2004              ��39,500��            ��8,200��            ��3,300��
2005              ��74,800��           ��15,400��           ��18,100��
2006              ��59,100��           ��21,900��           ��15,900��
2007              ��38,200��           ��13,400��            ��6,900��
2008              ��38,900��            ��5,400��            ��4,400��

1)decode

SELECT �⵵, 
        to_char(nvl(max(decode(job_id, 'SA_REP', sum_sal)),0),'l999,999') ||'��' "SA_REP",
        to_char(nvl(max(decode(job_id, 'SH_CLERK', sum_sal)),0),'l999,999') ||'��' "SH_CLERK",
        to_char(nvl(max(decode(job_id, 'ST_CLERK', sum_sal)),0),'l999,999') ||'��' "ST_CLERK"
FROM (SELECT to_char(hire_date, 'yyyy') �⵵, job_id, sum(salary) sum_sal
        FROM employees
        GROUP BY to_char(hire_date, 'yyyy'), job_id)
GROUP BY �⵵;        
2)pivot
SELECT �⵵,
        to_char(nvl("SA_REP", 0), 'l999,999') ||'��' "SA_REP",
        to_char(nvl("SH_CLERK", 0), 'l999,999') ||'��' "SH_CLERK",
        to_char(nvl("ST_CLERK", 0), 'l999,999') ||'��' "ST_CLERK"
FROM (SELECT to_char(hire_date, 'yyyy') �⵵, job_id, salary
        FROM employees)
PIVOT (sum(salary) for job_id in ('SA_REP' "SA_REP", 'SH_CLERK' "SH_CLERK", 'ST_CLERK' "ST_CLERK"));


---------------------------------
�����տ�����
-select���� �÷��� ������ ��ġ�ؾ� �Ѵ�.
- ù��°  select���� �÷��� �����Ǵ� �ι�° select�� �÷��� ������ Ÿ���� ��ġ�ؾ� �Ѵ�.
- union, intersect, minus �����ڴ� �ߺ��� �����Ѵ�.
- union, intersect, minus �����ڴ� �ߺ��� �����ϱ� ���ؼ� ������ ����ȴ�.
- ���տ����ڿ��� order by ���� ���� �������� ����ؾ� �Ѵ�.
- order by ������ ù ��° select���� �÷��̸�, ��Ī, ��ġ ǥ����� ����Ѵ�.
    ������ : �÷��� ��Ī�� ����ϸ� ������ ��Ī, ��ġǥ����� ����ؾ� �Ѵ�.
    
��������
-union : �ߺ�����
-union all : �ߺ�����

select employee_id, job_id, salary
from employees
union
select employee_id, job_id, null --0 --to_number('0')
from job_history; --job_id�� �ѹ��̶� ������ ������� �ִ� ���̺�

select employee_id, job_id, salary
from employees
union all
select employee_id, job_id, null 
from job_history;

select employee_id id, job_id, salary
from employees
union all
select employee_id, job_id, null --0 --to_number('0')
from job_history --job_id�� �ѹ��̶� ������ ������� �ִ� ���̺�
order by 1; --�÷��� ��Ī�� ���� �� �÷��̸��� ������� ���ϰ� ��Ī�� ��밡��, ��ġǥ����� �׳� ��밡��

�ڱ�����

select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
where employee_id =176;

select employee_id, job_id
from job_history
where employee_id =176;

��������
select employee_id
from employees
minus
select employee_id
from job_history;

[����82] job_id�� �ѹ��̶� �ٲ� ������� ������ ������ּ���.
1)���տ����� --�ý��ۿ��� �ڵ����� �����ؾ��ϴ� ���ɻ��� ������
SELECT *
FROM employees
WHERE employee_id in (SELECT employee_id
                        FROM employees
                        intersect
                        SELECT employee_id
                        FROM job_history);
                
2)exists 
SELECT *
FROM employees e
WHERE exists (SELECT 'x'
                FROM job_history
                WHERE employee_id = e.employee_id);

[���� 82] job_id�� �ٲ��� ���� ������� ������ ������ּ���.    
1) ���տ�����
SELECT *
FROM employees
WHERE employee_id in (SELECT employee_id
                        FROM employees
                        minus
                        SELECT employee_id
                        FROM job_history);
2)not exists ������ -- �� ȿ������ ���� 
SELECT *
FROM employees e
WHERE not exists (SELECT 'x'
                    FROM job_history
                    WHERE employee_id = e.employee_id);

[����84] �μ��� �������� ���� ������ ����Ʈ�� �ʿ��մϴ�. country_id, country_name ������ּ���.
1)����
SELECT country_id, country_name
FROM countries
MINUS
SELECT c.country_id, c.country_name
FROM departments d, locations l, countries c
WHERE d.location_id = l.location_id
and l.country_id = c.country_id;

2)not exists
select country_id, country_name
from countries c
where not exists(select 'x'
                    from departments d, locations l
                    where d.location_id = l.location_id
                    and l.country_id = c.country_id);
[����85] union ->union all + not exists
1)
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id(+)= d.department_id(+); --����ȵ� ���� �� �ƿ��������� �� �� ����
2)
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id= d.department_id(+)
union
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id(+)= d.department_id;

3)                  
��)                                        
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id= d.department_id(+)
union all
select null, null, department_name --�Ҽ� ����� ���� �μ������ϱ�
from departments d
where not exists ( select 'x'
                    from employees
                    where department_id = d.department_id);
--������ ���̺��� �ι��� �����ϴ� ������ ����

>ANSI�������� �ϸ� �̷��� ������ �� �� �ִµ� ANSI�� ������� �ʴ� ȸ��鵵 �ִ�.(���̺��� �ι������� ������ ���� �����帮�� ��)
select e.employee_id, e.last_name, d.department_name
from employees e full outer join departments d
on e.department_id= d.department_id;

[���� 86]
1)DEPARTMENT_ID, JOB_ID, MANAGER_ID �������� �Ѿ� �޿��� ���
SELECT sum(salary)
FROM employees
GROUP BY department_id, job_id, manager_id;
2) department_id, job_id �������� �Ѿױ޿��� ���
SELECT sum(salary)
FROM employees
GROUP BY department_id, job_id;
3) department_id �������� �Ѿױ޿��� ���
SELECT sum(salary)
FROM employees
GROUP BY department_id;
4) ��ü �Ѿ� �޿��� ���
SELECT sum(salary)
FROM employees;

1),2),3),4)�� �Ѳ����� ������ּ���.
SELECT department_id, job_id, manager_id, sum(salary)
FROM employees
GROUP BY department_id, job_id, manager_id
union all
SELECT department_id, job_id, null, sum(salary)
FROM employees
GROUP BY department_id, job_id
union all
SELECT department_id, null,null ,sum(salary)
FROM employees
GROUP BY department_id
union all
SELECT null, null, null, sum(salary)
FROM employees;

��rollup ������
-group by�� ������ �� ����Ʈ�� �����ʿ��� ���ʹ������� �̵��ϸ鼭 �׷�ȭ�� ����� ������

��)
select a,b,c,sum(sal)
from test
group by a,b,c;

sum(sal) = {a,b,c}

��)
select a,b,c,sum(sal)
from test
group by rollup(a,b,c);

sum(sal) = {a,b,c}
sum(sal) = {a,b}
sum(sal) = {a}
sum(sal) = {}

SELECT department_id, job_id, manager_id, sum(salary)
FROM employees
GROUP BY rollup(department_id, job_id, manager_id);

��cube ������
rollup�����ڸ� �����ϰ� (���հ�����)��� �׷�ȭ �� �� �ִ� ���� ����� ������.

select a,b,c,sum(sal)
from test
group by cube(a,b,c);

sum(sal) = {a,b,c}
sum(sal) = {a,b}
sum(sal) = {a,c}
sum(sal) = {b,c}
sum(sal) = {a}
sum(sal) = {b}
sum(sal) = {c}
sum(sal) = {}

SELECT department_id, job_id, manager_id, sum(salary)
FROM employees
GROUP BY cube(department_id, job_id, manager_id);


��grouping sets ������(9i)
���� ���ϴ� �׷��� ����� ������

select a,b,c,sum(sal)
from test
group by grouping sets((a,b), (a,c), ());

sum(sal) = {a,b}
sum(sal) = {a,c}
sum(sal) = {}


SELECT department_id, job_id, manager_id, sum(salary)
FROM employees
GROUP BY grouping sets((department_id, job_id),(department_id, manager_id),());

[����87] �⵵ �б⺰ �Ѿ��� ���ϼ���. ���� �հ� ���� �յ� ���ϼ���.

YEAR      1�б�      2�б�      3�б�      4�б�         ��
---- ---------- ---------- ---------- ---------- ----------
2001      17000                                       17000
2002                 36808      21008      11000      68816
2003                 35000       8000       3500      46500
2004      40700      14300      17000      14000      86000
2005      86900      16800      60800      33400     197900
2006      69400      20400      14200      17100     121100
2007      36600      20200       2500      35600      94900
2008      46900      12300                            59200
         297500     155808     123508     114600     691416
    

--Ǯ������ ��� Ǯ��� ���� ����ϱ�
select �⵵, �б�, sum(sal)
from test
group by cube(�⵵, �б�);
sum(sal) = {�⵵,�б�}

1)decode
SELECT year,
        max(decode(quarter,1,sum_sal)) "1�б�",
        max(decode(quarter,2,sum_sal)) "2�б�",
        max(decode(quarter,3,sum_sal)) "3�б�",
        max(decode(quarter,4,sum_sal)) "4�б�",
        max(decode(quarter,null,sum_sal)) "��"
FROM (SELECT to_char(hire_date, 'yyyy') year, to_char(hire_date,'q') quarter, sum(salary) sum_sal
        FROM employees
        GROUP BY cube(to_char(hire_date, 'yyyy'), to_char(hire_date,'q')))
GROUP BY year
ORDER BY 1;        


2)pivot
SELECT *
FROM (SELECT year, nvl(quarter,0) quarter, sum_sal
        FROM (SELECT to_char(hire_date, 'yyyy') year, to_char(hire_date, 'q') quarter, sum(salary) sum_sal
                FROM employees
                GROUP BY CUBE(to_char(hire_date, 'yyyy'), to_char(hire_date, 'q'))))
PIVOT (max(sum_sal) for quarter in (1,2,3,4,0 ����))
ORDER BY 1;

SELECT *
        FROM (SELECT to_char(hire_date, 'yyyy') year, to_char(hire_date, 'q') quarter, sum(salary) sum_sal
                FROM employees
                GROUP BY CUBE(to_char(hire_date, 'yyyy'), to_char(hire_date, 'q')))
PIVOT (max(sum_sal) for quarter in (1,2,3,4, null))
ORDER BY 1;
;