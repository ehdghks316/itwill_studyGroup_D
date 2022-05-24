select * from hr.emp;
select * from user_tab_privs; -- 내가 받은 객체권한과 내가 부여한 객체권한을 확인
select * from hr.dept;

desc hr.emp

insert into hr.emp(employee_id, last_name, salary)
values(300,'oracle',1000); -- transaction 시작

select * from hr.emp; -- 미리보기

commit; -- transaction 종료

update hr.emp
set salary = 2000
where employee_id =300;

select * from hr.emp where employee_id = 300;

commit;

delete from hr.emp where employee_id = 300;
select * from hr.emp where employee_id = 300; -- 미리보기
rollback;
select * from hr.emp where employee_id = 300;

delete from hr.emp;
select * from user_tab_privs;


