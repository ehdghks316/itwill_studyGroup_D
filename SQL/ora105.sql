select * from user_tab_privs;
select * from hr.employees;

select e.*, d.*
from hr.employees e, hr.departments d --�������� ���̺��� ����� �� �ʹ� ���� �ʴ���
where e.department_id = d.department_id;

select * from all_synonyms where table_owner = 'HR'; --synonym�� ���� �����ִ��� ������ ������ ���Ұ�
select * from emp;
select * from dept;

select e.*, d.*
from emp e, dept d
where e.department_id = d.department_id;

