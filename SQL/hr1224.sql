[����51] ��� �����ں��� ���� �Ի��� ����� �̸��� �Ի��� �� �ش� �������� �̸��� �Ի��� ������ּ���.

SELECT * FROM employees;

SELECT w.last_name, w.hire_date, m.last_name,m.hire_date
FROM employees w join employees m
on w.manager_id = m.employee_id
where w.hire_date < m.hire_date;

select w.employee_id, w.hire_date, w.manager_id,m.employee_id, m.hire_date
FROM employees w, employees m
where w.manager_id = m.employee_id
and w.hire_date < m.hire_date;
--using���̶� natural join�� �Ұ���  ->

[���� 52] 110�� ����� �޿����� �� ���� �޿��� �޴� ���?
--Ǯ�̼���--
SELECT *
FROM employees
WHERE salary > 110�� ��� �޿�;

SELECT salary
FROM employees
WHERE employee_id = 110;

SELECT *
FROM employees
WHERE salary > 8200;

--�� 3���� select���� �� ���� ������ �� ������? �� �� �� ��!(sub query)
SELECT *
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE employee_id = 110);
                
subquery(��������)
-SQL�� �ȿ� SELECT���� ����������� �Ѵ�.
-SELECT���� ���������� �� () ����� �Ѵ�.
-WHERE �������� �񱳿����� ������ �Է��ؾ� �Ѵ�.

��ø��������(nested subquery)
1.inner query(subquery) ��������
2.inner query ������ ���� ������ main query(outer query)�� �����Ѵ�.

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
                WHERE last_name = 'King'); --���������� ���� �������� ��� ���Ϻ񱳿����ڸ� ����ϸ� ���� �߻�
                
������ �������� 
- ���������� ����� ���ϰ��� ������ ��������
- ������ �񱳿����� : =, >, >=, <, <=, <>, !=, ^=
������ ��������
-���������� ����� �������� ���� ������ ��������
-������ �񱳿����� : in, any, all

[����53] 110�� ����� job_id�� ������ ����� �߿� 110�� ����� �޿����� �� ���� �޴� ������� ������ �����ϼ���.
SELECT *
FROM employees 
WHERE job_id = all(select job_id
                    FROM employees
                    WHERE employee_id = 110)
and salary > (select salary
                from employees
                where employee_id = 110);
[����54] �ְ� �޿��� �޴� ������� ������ ������ּ���.
SELECT *
FROM employees
WHERE salary = all(SELECT max(salary)
                    FROM employees);

having���� subquery ���
having���� �񱳿����� �����ʿ� ()��� ����Ѵ�.
having : �׷��Լ��� ���� ����� ����                    

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
having min(salary) > 40�� �μ��� �ּұ޿�;

SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
having min(salary) > (SELECT min(salary) 
                        FROM employees
                        WHERE department_id =40);

[���� 55] �ּ� ��հ��� ������ �ִ� �μ���ȣ, ����� ������ּ���.(�𸣰ڴ�)
SELECT department_id, min(avg(salary)) --�׷��Լ� �� �� ��ø�ؼ� ����ϸ� �����÷� ���Ұ�
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
                
--where ���ذ� in (�񱳰�)
where ���ذ� = �񱳰�
or ���ذ� = �񱳰�
....

SELECT *
FROM employees
WHERE salary > ANY(SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
            
���������� �����ప�� ������ ������ �񱳿����ڸ� ����ؾ� �Ѵ�.
IN(=OR), >ANY, <ANY, =ANY, >ALL, <ALL

��any �Ӽ��� or ���������� �ǹ̸� �����ϰ� �ִ�.
SELECT *
FROM employees
WHERE salary > 1000
or salary > 2000
or salary > 3000;
���
SELECT *
FROM employees
WHERE salary > ALL (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG');
'> any' �ǹ̴� �ּҰ� ���� ŭ ����
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
any �Ӽ��� or ���������� �ǹ̸� �����ϰ� �ִ�.
SELECT *
FROM employees
WHERE salary < 1000
or salary < 2000
or salary < 3000;
'< any' �ǹ̴� �ִ밪 ���� ���� ����

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
��all�Ӽ��� and ���������� �ǹ̸� �����ϰ� �ִ�.                

SELECT *
FROM employees
WHERE salary > 1000
and salary > 2000
and salary > 3000;
 
'> all' �ǹ̴� �ִ밪 ���� ũ��
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
��all�Ӽ��� and ���������� �ǹ̸� �����ϰ� �ִ�.                

SELECT *
FROM employees
WHERE salary < 1000
and salary < 2000
and salary < 3000;
 
'< all' �ǹ̴� �ּҰ� ���� �۴�
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
                                
------------------------���ļ���
[����56] 2006�⵵�� �Ի��� ������� job_id�� ������ ������� job_id�� �޿��� �Ѿ� �߿� 50000 �̻��� ���� ������ּ���
--������ ����� ���� ������ ������ ������ ������!!
SELECT job_id, sum(salary)
FROM employees
WHERE job_id in (SELECT job_id
                    FROM employees
                    WHERE hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
                    and hire_date < to_date('2007-01-01', 'yyyy-mm-dd'))
group by job_id
HAVING sum(salary) >= 50000;
                        
[����57] location_id �� 1700�� ��� ������� last_name, department_id, job_id�� ������ּ���.
SELECT e.last_name, e.department_id, e.job_id
FROM employees e, departments d
where e.department_id = d.department_id
and d.location_id = 1700;

SELECT last_name, department_id, job_id
FROM employees 
where department_id in (select department_id
                        from departments
                        where location_id = 1700);
--���������� ������ ����� �Ȱ����� ��������?       
--���������� ����, ������ �ϳ��ϳ� ���� ���̺��� �� �� �ִ�.
                        
[����58] 60�� �μ� ������� �޿� ���� �� ���� �޿��� �޴� ������� ������ ������ּ���.
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

[���� 59] ������ ������� ������ ������ּ���.
SELECT m.*
FROM employees w join employees m
on w.manager_id = m.employee_id;

select *
from employees
where employee_id in (select manager_id
                        from employees);

select *
from employees
where employee_id = any (select distinct manager_id --�ߺ��� �����ϱ� ���ؼ� ���� �۾��� ���� �ؾ��ϴ� �δ�
                        from employees);

where employee_id = null
or employee_id =100
or employee_id = 123
....                                                
OR ����ǥ
TRUE OR TRUE = TRUE
TRUE OR FALSE = TRUE
FALSE OR TRUE = TRUE
FALSE OR FALSE =FALSE
TRUE OR NULL(T/F) = TRUE
FALSE OR NULL = NULL


[���� 60] �����ڰ� �ƴ� ������� ������ ������ּ���.
SELECT w.*
FROM employees w join employees m
on w.manager_id = m.employee_id
WHERE w.manager_id is not null;


where employee_id <> null
or employee_id <>100
or employee_id <> 123
....
AND ����ǥ
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
                        from employees); -- ��ü���
select *
from employees
where employee_id <> all (select manager_id
                        from employees 
                        where manager_id is not null); -- null�� ������ is not null�� �ۼ��ؾ���
                        
                        
[���� 61] �ڽ��� �μ� ��� �޿����� �� ���� �޴� ������� ������ ������ּ���.
SELECT *
FROM employees
WHERE salary > (�ڽ��� �μ� ��� �޿�) ;

SELECT *
FROM employees
WHERE salary > (select avg(salary))
                from employees
                where department_id =  �ڽ��� �μ� �ڵ�);
                
select employee_id, salary, department_id
from employees;

select avg(salary)
from employees
where department_id = ����;

select *
from employees o 
where salary > (select avg(salary)
                from employees
                where department_id = o.department_id);
��correlated subquery, ��ȣ���� ��������
1. main query(outer query)�� ���� ����
2. ù ��° ���� �ĺ������� ��� �ĺ��� ���� ���������� ����
3. �ĺ��� ���� ����ؼ� �������� �����Ѵ�.
4. �������� ������� ����ؼ� �ĺ���� ���Ѵ�.
5.���� ���� �ĺ������� ��� 2,3,4���� �ݺ� �����Ѵ�.

exists������
- �ĺ��� ���� ���������� �����ϴ��� ���θ� ã�� ������.
- �ĺ��� ���� ���������� �����ϸ� TRUE �츮�� ã�� ������ �˻�����
- �ĺ��� ���� ���������� �������� ������ FALSE �츮�� ã�� �����Ͱ� �ƴϴ�.

SELECT *
FROM employees
WHERE employee_id in (select manager_id
                        from employees); -- null, 100, 101, 102~~~
where employee_id =null
or employee_id =100
or employee_id = 101
or employee_id = 102
or employee_id = 100 --in �������� �������� �ߺ��Ǵ� ������ ��� ����, distinct�� ����ϸ� �� �����Ŀ���� �Ǽ��� ��
....

select *
from employees o
where exists(select 'x' --exists�����ڴ� �����÷��� ����, ���÷���(���������� �����ϰ��� �ǹ̾���'x'�� ���� ����1 �־ �������)
                from employees
                where manager_id = o.employee_id);
                
[���� 62] �Ҽӻ���� �ִ� �μ������� ������ּ���.
1)in
SELECT *
FROM departments 
WHERE department_id in (SELECT department_id
                        FROM employees);
                        
2) exists
SELECT *
FROM departments d --SELECT * FROM departments d�� ���� ������
WHERE exists (SELECT 'x'
                FROM employees
                WHERE department_id = d.department_id);
                
SELECT * FROM departments;
                
not exists������
- �ĺ��� ���� ���������� �������� �ʴ� �����͸� ã�� ������
- �ĺ��� ���� ���������� �������� ������ TRUE �츮�� ã�� ������
- �ĺ��� ���� ���������� �����ϸ� FALSE �츮�� ã�� �����Ͱ� �ƴϴ� �˻� ����

SELECT *
FROM departments d --SELECT * FROM departments d�� ���� ������
WHERE not exists (SELECT 'x'
                FROM employees
                WHERE department_id = d.department_id);

SELECT *
FROM departments 
WHERE department_id not in (SELECT department_id 
                        FROM employees
                        where department_id is not null); 
                        
[���� 63] �����ڰ� �ƴ� ������� ������ ������ּ���.
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