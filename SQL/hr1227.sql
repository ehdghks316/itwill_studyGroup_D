[����66] Executive �μ��̸��� �Ҽӵ� ��� ����� ���� department_id, last_name, job_id  ����ϼ���.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name ='Executive');

select e.department_id, last_name, job_id
from employees e, departments d
where e.department_id = d.department_id
and d.department_name = 'Executive';

select e.department_id, last_name, job_id
from employees e join departments d
on e.department_id = d.department_id
and d.department_name = 'Executive';

[����67] ��ü ��� �޿����� ���� �޿��� �ް� last_name�� 'z'�� ���Ե� ����� 
���� �μ����� �ٹ��ϴ� ��� ����� employee_id, last_name, salary ����ϼ���

SELECT employee_id, last_name, salary
FROM employees
WHERE department_id in (select department_id 
                        from employees 
                        where last_name like '%z%') --instr(last_name, 'z',1,1) > 0�� ��ü����
and salary > (select avg(salary)
                from employees);
                
SELECT employee_id, last_name, salary
FROM employees o
where exists (select 'x'
                from employees
                where department_id =o.department_id 
                and last_name like '%z%')
and salary > (select avg(salary)
                from employees);
                
�ڽ��� �μ� ��ձ޿� ���� �� ���� �޿��� �޴� ���?
SELECT *
FROM employees
WHERE salary > �ڽ��� �μ� ��ձ޿�;

SELECT *
FROM employees o
WHERE salary > (SELECT avg(salary)
                FROM employees
                WHERE department_id = o.department_id);
��������?
�ĺ��� ���� ������ ������ �ٽ� �Է��� �� �� ����� �ٽ� ����ؾ� �Ѵٴ� ������(i.o, cpu�� �� ����ϴ� ����)

�ذ�å?
�μ��� ��� �޿��� �ִ� ���̺� ������ �����ٵ�

dept_avg���̺��� �ִ� ����
select department_id, avg(salary) avg_sal
from employees
group by department_id;

select e.*
from employees e, dept_avg d
where e.department_id = d.department_id
and e.salary > d.avg_sal;
                
                
[����68] ������� ���� ���� �μ��̸�, ����, �ο����� ������ּ���.
1)�μ��̸�, ���� ����
select d.department_name, l.city 
from departments d, locations l, employees e
where e.department_id = d.department_id
and d.location_id = l.location_id

2)�μ��̸����� �ο��� ���ϱ�        
select d.department_name, l.city , count(*)
from departments d, locations l, employees e
where e.department_id = d.department_id
and d.location_id = l.location_id
group by d.department_name, l.city;

3)���� ���� �ο��� �ִ� �μ��̸�, ����, �ο��� ���
select d.department_name, l.city , count(*)
from departments d, locations l, employees e
where e.department_id = d.department_id
and d.location_id = l.location_id
group by d.department_name, l.city
having count(*) = (select max(count(*))
                    from employees
                    group by department_id);

>INLINE VIEW �������� Ǯ��(���� �ڵ�� ��ȿ������ ������ �ֱ⿡ �� ȿ�������� �ٲ� �ڵ�)
1)�� ���� �����ͷ� �����
select department_id, count(*) cnt
from employees
group by department_id
having count(*) = (select max(count(*))
                    from employees
                    group by department_id);
2)���� �����͸� �������̺��
select d.department_name, l.city, e.cnt
from (select department_id, count(*) cnt
        from employees
        group by department_id
        having count(*) = (select max(count(*))
                            from employees
                            group by department_id)) e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

[����69] �Ի簡 ���� ���� ���Ͽ� �Ի��� ������� employee_id, last_name, ���� ������ּ���.
1)
SELECT employee_id, last_name, to_char(hire_date, 'dy')
FROM employees;

2)
SELECT to_char(hire_date,'dy'), count(*)
FROM employees
GROUP BY to_char(hire_date,'dy') 
HAVING count(*) = (SELECT max(count(*))
                    FROM employees
                    GROUP BY to_char(hire_date, 'dy'));
                    
3)
SELECT employee_id, last_name, to_char(hire_date, 'dy')
FROM employees e, (SELECT to_char(hire_date,'dy') day2, count(*)
                    FROM employees
                    GROUP BY to_char(hire_date,'dy') 
                    HAVING count(*) = (SELECT max(count(*))
                                        FROM employees
                                        GROUP BY to_char(hire_date, 'dy'))) d
WHERE to_char(e.hire_date, 'dy') =d.day2;       

����� ��
desc employees
select employee_id, last_name, to_char(hire_date, 'day')
from employees
where to_char(hire_date, 'day') in (select to_char(hire_date, 'day')
                                    from employees
                                    group by to_char(hire_date, 'day')
                                    having count(*) = (select max(count(*))
                                                        from employees
                                                        group by to_char(hire_date, 'day')));
                                                        --ū ���̺��� �� ���̳� �ݺ��ϰ� ������ ��ȿ�����̴�? �����غ���
                                                        --���Ϻ��� ������ ��ó�� �������� ���ĵ� ���� �ƴϴ� ���߿��� ������ ������� �� ���� ������Ѵ�.

                                      [����70] �μ����� �ο����� ����ּ���.
       10         20         30         40         50         60         70         80         90        100        110 �μ��� ���� ���
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------------
         1          2          6          1         45          5          1         34          3          6          2                1                                                        
1)����
SELECT department_id, count(*)
FROM employees
group by department_id;

2)����
SELECT 
    count(decode(department_id, 10,1)) "10",
    count(decode(department_id, 20,1)) "20",
    count(decode(department_id, 30,1)) "30",
    count(decode(department_id, 40,1)) "40",
    count(decode(department_id, 50,1)) "50",
    count(decode(department_id, 60,1)) "60",
    count(decode(department_id, 70,1)) "70",
    count(decode(department_id, 80,1)) "80",
    count(decode(department_id, 90,1)) "90",
    count(decode(department_id, 100,1)) "100",
    count(decode(department_id, 110,1)) "110",
    count(decode(department_id, null,1)) "�μ��� ���� ���"
FROM employees;

107 row decode 12�� �ݺ��Ѵ�.
decode �Լ��� �� �� ����ǳ���? 107 * 12 = �̷��� ���� ���ư��� ����
decode �Լ��� 12�� �ݺ� ������ �� �ֵ��� ������ �غ�����.
select 
    decode(department_id, 10,cn) "10",
    decode(department_id, 20,cn) "20",
    decode(department_id, 30,cn) "30",
    decode(department_id, 40,cn) "40",
    decode(department_id, 50,cn) "50",
    decode(department_id, 60,cn) "60",
    decode(department_id, 70,cn) "70",
    decode(department_id, 80,cn) "80",
    decode(department_id, 90,cn) "90",
    decode(department_id, 100,cn) "100",
    decode(department_id, 110,cn) "110",
    decode(department_id, null,cn) "�μ��� ���� ���"
from (select department_id, count(*) cn
        from employees
        group by department_id);

��pivot �Լ�
- ��(����) �����͸� ��(����)�� �����ϴ� �Լ�
select *
from (select department_id
        from employees)
pivot(count(*) for department_id in (10 "10�� �μ�",20,30,40,50,60,70,80,90,100,110,null as "�μ��� ���� ���"));        
       
select *
from (select department_id, salary
        from employees)
pivot(sum(salary) for department_id in(10 "10�� �μ�",20,30,40,50,60,70,80,90,100,110,null as "�μ��� ���� ���"));        
    
[����71] �⵵�� �Ի� �ο����� ������ּ���.
    2001       2002       2003       2004       2005       2006       2007       2008
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
         1          7          6         10         29         24         19         11
select to_char(hire_date, 'yyyy'), count(*) --���η� ���
from employees
group by to_char(hire_date,'yyyy');

SELECT * 
FROM (SELECT to_char(hire_date,'yyyy') year
        FROM employees)
pivot (count(*) for year in ('2001','2002','2003','2004','2005','2006','2007','2008'));        

[���� 72] ���Ϻ� �Ի� �ο����� ���� �������� ������ּ���.
select *
from (select to_char(hire_date,'day') day
        from employees)
pivot (count(*) for day in ('������' "������", 'ȭ����' "ȭ����", '������' "������", '�����' "�����", '�ݿ���' "�ݿ���", '�����' "�����", '�Ͽ���' "�Ͽ���"));
[���� 73] ���Ϻ� �޿��� �Ѿ��� ���� �������� ������ּ���.
select *
from (select to_char(hire_date, 'day') day, salary
        from employees)
pivot (sum(salary) for day in ('������' "������", 'ȭ����' "ȭ����", '������' "������", '�����' "�����", '�ݿ���' "�ݿ���", '�����' "�����", '�Ͽ���' "�Ͽ���"));       
��unpivot �Լ�
- ��(����)�� ��(����)���� �����ϴ� �Լ�

select ���� , to_char(�޿��Ѿ�, '999,999') �޿��Ѿ�
from (select *
        from (select to_char(hire_date, 'day') day, salary
                from employees)
        pivot (sum(salary) for day in ('������' "������", 'ȭ����' "ȭ����", '������' "������", '�����' "�����", '�ݿ���' "�ݿ���", '�����' "�����", '�Ͽ���' "�Ͽ���")))       
unpivot(�޿��Ѿ� for ���� in (������, ȭ����, ������, �����, �ݿ���, �����, �Ͽ���));