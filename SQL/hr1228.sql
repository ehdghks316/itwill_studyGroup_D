[����74] �⵵,�б⺰ �޿��� �Ѿ��� ���ϼ���.

�⵵          1�б�      2�б�      3�б�      4�б�
-------- ---------- ---------- ---------- ----------
2001          17000
2002                     36808      21008      11000
2003                     35000       8000       3500
2004          40700      14300      17000      14000
2005          86900      16800      60800      33400
2006          69400      20400      14200      17100
2007          36600      20200       2500      35600
2008          46900      12300

1)����
select *
from (select to_char(hire_date, 'q') season, salary
        from employees)
pivot (sum(salary) for season in (1 "1�б�",2 "2�б�",3 "3�б�",4 "4�б�"));

2)����
select to_char(hire_date, 'yyyy'), to_char(hire_date, 'q'), sum(salary)
from employees
group by to_char(hire_date, 'yyyy'), to_char(hire_date, 'q');

3-1)����
select to_char(hire_date, 'yyyy') "�⵵",
        nvl(sum(decode(to_char(hire_date, 'q'),1,salary)),0) "1�б�",
        nvl(sum(decode(to_char(hire_date, 'q'),2,salary)),0) "2�б�",
        nvl(sum(decode(to_char(hire_date, 'q'),3,salary)),0) "3�б�",
        nvl(sum(decode(to_char(hire_date, 'q'),4,salary)),0) "4�б�"
from employees        
group by to_char(hire_date, 'yyyy')
order by 1;

3-2)����(pivot)
select *
from (select to_char(hire_date, 'yyyy') "�⵵", to_char(hire_date, 'q') quarter, salary
        from employees)
pivot (sum(salary) for quarter in (1 "1�б�",2 "2�б�",3 "3�б�",4 "4�б�"))
order by 1;

select �⵵, nvl("1�б�", 0) "1�б�", nvl("2�б�", 0) "2�б�", nvl("3�б�", 0) "3�б�", nvl("4�б�", 0) "4�б�"
from (select to_char(hire_date, 'yyyy') "�⵵", to_char(hire_date, 'q') quarter, salary
        from employees)
pivot (sum(salary) for quarter in (1 "1�б�",2 "2�б�",3 "3�б�",4 "4�б�"))
order by 1;


-----------------
>unpivot ���θ� �ٽ� ���η� ǥ��
select *
from (select �⵵, nvl("1�б�", 0) "1�б�", nvl("2�б�", 0) "2�б�", nvl("3�б�", 0) "3�б�", nvl("4�б�", 0) "4�б�"
        from (select to_char(hire_date, 'yyyy') "�⵵", to_char(hire_date, 'q') quarter, salary
                from employees)
        pivot (sum(salary) for quarter in (1 "1�б�",2 "2�б�",3 "3�б�",4 "4�б�"))
        order by 1)
unpivot(�޿��Ѿ� for �б� in ("1�б�", "2�б�", "3�б�", "4�б�"));        

>include nulls(unpivot���� ������ null������ �����ִ� ���)
select *
from (select *
        from (select to_char(hire_date, 'yyyy') "�⵵", to_char(hire_date, 'q') quarter, salary
                from employees)
        pivot (sum(salary) for quarter in (1 "1�б�",2 "2�б�",3 "3�б�",4 "4�б�"))
        order by 1)
unpivot include nulls(�޿��Ѿ� for �б� in ("1�б�", "2�б�", "3�б�", "4�б�"));        

SELECT �⵵, nvl("1�б�",0), nvl("2�б�",0), nvl("3�б�",0), nvl("4�б�",0)
FROM (SELECT to_char(hire_date,'yyyy') �⵵, to_char(hire_date,'q') �б�, salary
        FROM employees)
PIVOT (SUM(salary) FOR �б� IN (1 "1�б�",2 "2�б�",3 "3�б�",4 "4�б�"));        
  


[����75] ��(��)�� �⵵�� �޿� �Ѿ��� �Ʒ� ���ó�� ������ּ���.

��          2001��   2002��   2003��   2004��
--------  --------  -------  -------  -------
01
02

...
12

1) decode�Լ�
select to_char(hire_date, 'mm') ��,
        nvl(sum(decode(to_char(hire_date, 'yyyy'),'2001', salary)),0) "2001��",
        nvl(sum(decode(to_char(hire_date, 'yyyy'),'2002', salary)),0) "2002��",
        nvl(sum(decode(to_char(hire_date, 'yyyy'),'2003', salary)),0) "2003��",
        nvl(sum(decode(to_char(hire_date, 'yyyy'),'2004', salary)),0) "2004��"
from employees
group by to_char(hire_date, 'mm');

2) pivot
select ��, nvl("2001��", 0) "2001��", nvl("2002��", 0) "2002��", nvl("2003��", 0) "2003��", nvl("2004��", 0) "2004��"
from (select to_char(hire_date, 'mm') ��, to_char(hire_date, 'yyyy') year, salary
        from employees)
pivot (sum(salary) for year in ('2001' "2001��", '2002' "2002��", '2003' "2003��", '2004' "2004��"))
order by 1;

select *
from (select *
        from (select to_char(hire_date, 'mm') ��, to_char(hire_date, 'yyyy') year, salary
                from employees)
        pivot (sum(salary) for year in (2001 "2001��",2002 "2002��",2003 "2003��",2004 "2004��"))
        order by 1)
unpivot (�޿��Ѿ� for �⵵ in ("2001��","2002��","2003��","2004��"));

3) unpivot
select *
from (select *
        from (select to_char(hire_date, 'mm') ��, to_char(hire_date, 'yyyy') year, salary
                from employees)
        pivot (sum(salary) for year in ('2001' "2001��", '2002' "2002��", '2003' "2003��", '2004' "2004��"))
        order by 1)
unpivot include nulls(�޿��Ѿ� for �⵵ in ("2001��", "2002��", "2003��", "2004��"));    

select �⵵, ��, �޿��Ѿ�
from (select *
        from (select to_number(to_char(hire_date, 'mm')) ��, to_char(hire_date, 'yyyy') year, salary
                from employees)
        pivot (sum(salary) for year in ('2001' "2001��", '2002' "2002��", '2003' "2003��", '2004' "2004��"))
        order by 1)
unpivot include nulls(�޿��Ѿ� for �⵵ in ("2001��", "2002��", "2003��", "2004��")); 


---------------------------------------
�ڴ��߿� ��������

-- �ֺ�
select *
from employees
where(manager_id, department_id) in (select manager_id, department_id
                                        from employees
                                        where first_name = 'John');
-- ��ֺ�
select *
from employees
where manager_id in (select manager_id
                        from employees
                        where first_name = 'John')
and department_id in (select department_id
                        from employees
                        where first_name = 'John');                        


[����76] commission_pct null�� �ƴ� ������� department_id, salary ��ġ�ϴ� ������� ������ ������ּ���.

1)�ֺ�
select *
from employees
where (department_id, salary) in (select department_id, salary
                                    from employees
                                    where commission_pct is not null);
2)��ֺ�
select *
from employees
where department_id in (select department_id
                        from employees
                        where commission_pct is not null)
and salary in (select salary
                        from employees
                        where commission_pct is not null);                        
[����77] location_id�� 1700 ��ġ�� �ִ� ������� salary, commission_pct�� ��ġ�ϴ� ������� ������ ������ּ���.
1) �ֺ�

SELECT *
FROM employees
WHERE (salary, nvl(commission_pct,0)) in (SELECT e.salary, nvl(e.commission_pct,0)
                                        FROM employees e, departments d
                                        WHERE e.department_id=d.department_id
                                        AND d.location_id=1700);

2) ��ֺ�

SELECT *
FROM employees
WHERE salary in (SELECT e.salary
                    FROM employees e, departments d
                    WHERE e.department_id=d.department_id
                    AND d.location_id=1700)
AND nvl(commission_pct,0) in (SELECT  nvl(e.commission_pct,0)
                                FROM employees e, departments d
                                WHERE e.department_id=d.department_id
                                AND d.location_id=1700);

                    
select distinct department_id
from employees;

��scalar subquery
-�� �࿡�� ��Ȯ�� �ϳ��� ������ ��ȯ�ϴ� ����(�����÷�, ���ϰ��� �����ؾ��Ѵ�)
-������ �Է°��� ������ ���� Ƚ���� �ּ�ȭ �� �� �ִ� ������ �����Ѵ�.
-query execution cache ����� ����ȴ�.
-Ű���� ���� �����Ͱ� �ԷµǸ� null������ �����Ѵ�.(outer join ���ó�� ����� ��µȴ�.)

select employee_id, department_id, (select department_name --query execution cache(�޸�)
                                    from departments
                                    where department_id = e.department_id)
from employees e
order by 2;

select e.employee_id, e.department_id, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

[����78] �μ��̸��� �޿��� �Ѿ�, ����� ���ϼ���.

1) �Ϲ����� ���� --������ �� �ϰ� �׷���
select department_name, sum(salary), avg(salary)
from employees e, departments d
where e.department_id = d.department_id
group by department_name
order by 1;

2) inline view �̿�( �𸣰���) --��Ҹ� �� ���� ����
select d.department_name, e.sum_sal, e.avg_sal
from (select department_id, sum(salary) sum_sal, avg(salary) avg_sal
        from employees
        group by department_id) e, departments d
where e.department_id = d.department_id(+)
order by 1;

3) scalar subquery �̿� (�𸣰ڳ�..) --������ �� �ϰ� ������ ��ó�� ������ ����, �� ���ϰ��� ��밡��
select department_name, (select sum(salary)
                            from employees
                            where department_id = d.department_id) sum_sal,
                        (select avg(salary)
                            from employees
                            where department_id = d.department_id) avg_sal    
from departments d;

select department_name, substr(sal,1,10) sum_sal, substr(sal,11) avg_sal --�ڸ����� �����س��ұ⿡ ���ϴ� �ڸ����� ����
from(select department_name, (select lpad(sum(salary),10) ||lpad(avg(salary),10) --�ڸ����� �����س���
                            from employees
                            where department_id = d.department_id) sal
        from departments d)
where sal is not null;        

select department_name, substr(sal,1,10) sum_sal, substr(sal,11) avg_sal
from (select department_name, (select lpad(sum(salary), 10) || lpad(avg(salary), 10)
                                from employees
                                where department_id = d.department_id) sal
        from departments d)
where sal is not null;        
        

[����79] ������� last_name, salary, grade_level�� ������ּ���.
1) ����
select e.last_name, e.salary, j.grade_level 
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal;

2) scalar subquery --ĳ�ñ���� ���ư��� ������ �ִ�.
select last_name, salary, (select grade_level
                            from job_grades
                            where e.salary between lowest_sal and highest_sal) grade_level
from employees e
order by 2;

[����80] ������� employee_id, last_name�� ����� �ϴµ� �� department_name�� �������� �������ּ���.
select e.employee_id, e.last_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by d.department_name;

SELECT employee_id, last_name
FROM employees e
ORDER BY (SELECT department_name
            FROM departments
            WHERE department_id = e.department_id) asc; --�ٸ� ���̺��� �������� ������ ��!!

- ORDER BY ���� SCALAR SUBQUERY�� ����� �� �ִ�.

select e.employee_id, e.last_name
from employees e
ORDER BY (SELECT department_name
            FROM departments
            WHERE department_id = e.department_id) asc;
