select * from user_tab_privs;
select * from hr.employees;

select e.*, d.*
from hr.employees e, hr.departments d --소유자의 테이블을 사용할 때 너무 길지 않느냐
where e.department_id = d.department_id;

select * from all_synonyms where table_owner = 'HR'; --synonym이 아직 남아있더라도 권한이 없으면 사용불가
select * from emp;
select * from dept;

select e.*, d.*
from emp e, dept d
where e.department_id = d.department_id;

