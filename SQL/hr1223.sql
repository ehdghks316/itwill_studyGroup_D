drop table job_grades purge; -- ���̺� drop(����)�ϴ� ->�ؿ� ������ �Ǽ��� �ι� �������� �� �ذ�å

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
using (e.department_id) --��������, using ���� ���� �����÷��� ��� ���̺��̶�� �����ϸ� �ȵȴ�.
where e.department_id =30; --��������, using ���� ���� �����÷��� ��� ���̺��̶�� �����ϸ� �ȵȴ�. ��������

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

[����46] ������� ���, �޿�, �޿����, �μ��̸��� ����ϼ���.
         �μ���ġ�� ���� �ʴ� ����� ���ܽ����ּ���. �� join on���� �̿����ּ���

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
where e.department_id(+)= d.department_id(+); --����(���� �ƿ������� x)

1) �ذ���
SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
where e.department_id(+)= d.department_id
union --������������ �ϳ��� ���� �ߺ��� �����ϴ� �����տ�����
SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
where e.department_id= d.department_id(+);
 --���ɻ� ���� ���� (���̺��� �� �� ������ �ؾߵǼ� ��ȿ����)
2) �ذ��� 
-ansi ǥ���� full outer join �̿��ϸ� �ȴ�.

SELECT e.employee_id, e.salary, d.department_name
FROM employees e full outer join departments d
on e.department_id= d.department_id; -- ���� ���� �ذ��� ���� full outer join

SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d; --cartesian product

SELECT e.employee_id, e.salary, d.department_name
FROM employees e , departments d
WHERE  e.department_id = 20
and d.department_id = 20;

SELECT e.employee_id, e.salary, d.department_name
FROM employees e cross join departments d; --cartesian product

����47] 2006�⵵�� �Ի��� ������� �μ��̸��� �޿��� �Ѿ�, ����� ������ּ���.
1) ����Ŭ ����
SELECT d.department_name, sum(e.salary),avg(e.salary) 
FROM employees e, departments d
WHERE e.department_id = d.department_id
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by d.department_name;


2) ANSI ǥ��
SELECT d.department_name, sum(e.salary),avg(e.salary) 
FROM employees e join departments d
on e.department_id = d.department_id
where e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by d.department_name;


[����48] 2006�⵵�� �Ի��� ������� �����̸��� �޿��� �Ѿ�, ����� ������ּ���.
1) ����Ŭ ����
SELECT l.city, sum(e.salary), avg(e.salary)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
and d.location_id = l.location_id
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

2) ANSI ǥ��
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

[����49] 2007�⵵�� �Ի��� ������� �����̸��� �޿��� �Ѿ�, ����� ������ּ���.
�� �μ� ��ġ�� ���� ���� ������� ������ ������ּ���.
1) ����Ŭ ����
SELECT l.city, sum(e.salary), avg(e.salary)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

2) ANSI ǥ��
SELECT l.city, sum(e.salary), avg(e.salary) 
FROM employees e left outer join departments d
on e.department_id = d.department_id
left outer join locations l
on d.location_id = l.location_id
WHERE e.hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
and e.hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
group by l.city;

[����50] ������� last_name,salary,grade_level, department_name�� ����ϴµ� last_name�� a���ڰ� 2�� �̻� ���ԵǾ� �ִ� ������� ����ϼ���.
1) ����Ŭ ����
SELECT e.last_name, e.salary, j.grade_level, d.department_name
FROM employees e, departments d, job_grades j
WHERE e.department_id = d.department_id
and e.salary between j.lowest_sal and j.highest_sal
and e.last_name like '%a%a%';
--instr(e.last_name, 'a',1,2) >0; like���

2) ANSI ǥ�� 
SELECT e.last_name, e.salary, j.grade_level, d.department_name
FROM employees e join departments d 
on e.department_id = d.department_id
join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
where e.last_name like '%a%a%';
