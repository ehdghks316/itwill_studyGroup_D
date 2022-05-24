���� :                  ���� :  

����1. �Ի��� ���� ����ϰ� ���� �Ի��� ���� 1������ 12�� ���� ������� ����Ͻÿ�.

Ǯ��)
select ��||'��' ��, �ο���
from (select to_char(hire_date,'mm') ��, count(*) �ο���
      from employees
      group by to_char(hire_date,'mm')
      order by 1);


����2. �ټӿ����� ���� �� 10������ ������� employee_id, last_name, hire_date�� ����ϼ���.(������ ������ ���ϼ���)

Ǯ��)
select *
from (Select employee_id, last_name, hire_date,dense_rank() over(order by hire_date) rank
      from employees)
where rank <= 10;


select *
from (select employee_id, last_name, hire_date, dense_rank() over(order by day desc) rank
      from (select employee_id, last_name, hire_date, sysdate - hire_date day
            from employees))
where rank <= 10;


����3. �Ʒ�ȭ��� ���� �޿��� ��������ǥ�� �����ϼ���.

���               ����
----------- ----------
2000~5000           49
5001~10000          43
10001~15000         12
15001~20000          2
20001~               1


Ǯ��)
select *
from (select 
        count(case when salary between 2000 and 5000 then 'x' end) "2000~5000",
        count(case when salary between 5001 and 10000 then 'x' end) "5001~10000",
        count(case when salary between 10001 and 15000 then 'x' end) "10001~15000",
        count(case when salary between 15001 and 20000 then 'x' end) "15001~20000",
        count(case when salary > 20001 then 'x' end) "20001~"
      from employees)
unpivot (���� for ��� in ("2000~5000", "5001~10000", "10001~15000", "15001~20000", "20001~"));


select *
from (select 
        sum(case when salary between 2000 and 5000 then 1 end) "2000~5000",
        sum(case when salary between 5001 and 10000 then 1 end) "5001~10000",
        sum(case when salary between 10001 and 15000 then 1 end) "10001~15000",
        sum(case when salary between 15001 and 20000 then 1 end) "15001~20000",
        sum(case when salary > 20001 then 1 end) "20001~"
      from employees)
unpivot (���� for ��� in ("2000~5000", "5001~10000", "10001~15000", "15001~20000", "20001~"));





����4.  15000 �̻� �޿��� �޴� ������ �̸�, �޿�, �޿������ ����ϼ���.

Ǯ��)
select e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where exists (select 'x' 
              from employees
              where manager_id = e.employee_id)
and e.salary >= 15000
and e.salary between j.lowest_sal and j.highest_sal;


����5. �⵵ �б⺰ �޿� �Ѿ��� ����ϼ���.

Ǯ��)
select �⵵, nvl("1�б�",0) "1�б�", nvl("2�б�",0) "2�б�",
            nvl("3�б�",0) "3�б�", nvl("4�б�",0) "4�б�"
from(select to_char(hire_date,'yyyy') �⵵, to_char(hire_date,'q') �б�, salary
     from employees)
pivot (sum(salary) for �б� in (1 "1�б�", 2 "2�б�", 3 "3�б�" ,4 "4�б�"))
order by 1;


select to_char(hire_date,'yyyy') �⵵,
        sum(decode(to_char(hire_date,'q'),'1',salary)) "1�б�",
        sum(decode(to_char(hire_date,'q'),'2',salary)) "2�б�",
        sum(decode(to_char(hire_date,'q'),'3',salary)) "3�б�",
        sum(decode(to_char(hire_date,'q'),'4',salary)) "4�б�"
from employees
group by to_char(hire_date,'yyyy');


����6. ���� �μ�����  last_name�� ���� ������� ã���ּ���.

Ǯ��)
select * 
from employees e
where exists (select 'x'
              from employees
              where department_id = e.department_id
              and last_name = e.last_name
              and employee_id <> e.employee_id);


����7 . ������� 3�� �̸��� �μ���ȣ,�μ��̸�,�ο����� ������ּ���.	

Ǯ��)
select  d.department_id, d.department_name, count(*)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id, d.department_name
having count(*) < 3
order by 1;
-- ������ �Ϸ��� �ʹ� ����

select d.department_id, d.department_name, e.cnt
from (select department_id, count(*) cnt
      from employees
      group by department_id
      having count(*) < 3) e, departments d
where e.department_id = d.department_id;
--�׷��� �̷��� inline view�̿�

����8 . ��� ���� ���� ���� �μ�����, ����, �ο����� ������ּ���.

select d.*, l.city, e.cnt
from (select department_id, cnt, case when cnt = max(cnt) over() then 1 end max_cnt
      from (select department_id, count(*) cnt
            from employees
            group by department_id)) e, departments d, locations l
where max_cnt = 1
and e.department_id = d.department_id
and d.location_id = l.location_id;
--������. ū ���̺��� �ι� �ݺ��ؼ� ��ȸ��.

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
--�м��Լ��� �̿��ؼ� ū ���̺� �ι� ��ȸ�ϴ� �� ���� . �ٵ� �� �ٸ� ��� with���� ���� ���� �ϳ� ���� ����


select *
from (select department_id, count(*) cnt
        from employees
        group by department_id) e1, (select max(cnt) max_cnt from e1) e2
where e1.cnt = e2.max_cnt;
--inline view�� �ٽ� ���̺�� ȣ���� �� ����. ����. 
-- �ذ���

�� with��
- �ι� �̻� �ݺ��Ǵ� select���� query block(�������̺�)�� ���� ����Ѵ�.
- ������ ����ų �� �ִ�.

with
dept_cnt as (select department_id, count(*) cnt
            from employees
            group by department_id)
select d.*, l.city, e.cnt
from dept_cnt e, departments d, locations l --�������̺� 
where cnt = (select max(cnt)
             from dept_cnt)
and e.department_id = d.department_id
and d.location_id = l.location_id;


with
�������̺�1 as (subquery),
�������̺�2 as (select ... from �������̺�1),
�������̺�3 as (subquery),
�������̺�4 as (select ... from �������̺�2)
...
select �������̺�...., �������̺�,,,
where ���ι�...
and ���� �����ϴ� ������...;



        
����9. ���Ϻ� �Ի��� �ο����� ������ּ���.

Ǯ��)
select *
from (select to_char(hire_date,'d') day
      from employees)
pivot(count(*) for day in (2 "��",3 "ȭ",4 "��",5 "��",6 "��",7 "��",1 "��"));


select *
from (select *
        from (select to_char(hire_date,'d') day
              from employees)
        pivot(count(*) for day in (2 "��",3 "ȭ",4 "��",5 "��",6 "��",7 "��",1 "��")))
unpivot(�ο��� for ���� in ("��","ȭ","��","��","��","��","��"));


����10.  �μ��� �ְ� �޿��ڵ��� ������ּ���

Ǯ��)
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
--���� �� ����� ū ���̺��� �ι� ��ȸ�Ѵٴ� ������ ����. �׷��� �Ʒ�ó�� �ϴ� �� ����.


select *
from (select employee_id, last_name, salary, department_id,
                max(salary) over(partition by department_id) �μ��ְ�,
                case when salary = max(salary) over(partition by department_id) then 1 end �μ��ְ�2
        from employees)
where �μ��ְ�2 = 1;



--���幮�� ���̺� �ι� �ݺ��ϱ� ������ ����ϸ� ������
with
dept_max as (select department_id, max(salary) maxsal
             from employees
             group by department_id)
select *
from employees
where (department_id, salary) in (select department_id, maxsal from dept_max);
