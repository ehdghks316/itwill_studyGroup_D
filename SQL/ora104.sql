select * from hr.emp;
select * from user_tab_privs; -- ���� ���� ��ü���Ѱ� ���� �ο��� ��ü������ Ȯ��
select * from hr.dept;

desc hr.emp

insert into hr.emp(employee_id, last_name, salary)
values(300,'oracle',1000); -- transaction ����

select * from hr.emp; -- �̸�����

commit; -- transaction ����

update hr.emp
set salary = 2000
where employee_id =300;

select * from hr.emp where employee_id = 300;

commit;

delete from hr.emp where employee_id = 300;
select * from hr.emp where employee_id = 300; -- �̸�����
rollback;
select * from hr.emp where employee_id = 300;

delete from hr.emp;
select * from user_tab_privs;


