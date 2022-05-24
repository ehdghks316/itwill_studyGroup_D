show user
grant create public synonym to hr;
grant drop public synonym to hr;

revoke create public synonym from hr;
revoke drop public synonym from hr;

SELECT * from dba_data_files;
select * from user_segments where segment_name = 'EMPLOYEES';
select * from user_extents where segment_name = 'EMPLOYEES';

UNDO tablespace 하는 일?
dml 작업시 이전값을 저장하는 공간
왜 이전값을 저장해야하는가?
rollback 하기 위해서 이전값을 눈군가는 가지고 있어야 하니 않을까요?
그 누군가가 undo tablespace공간에 이전값을 기억하고 있다.
select salary from hr.employees where employee_id = 100;
24000 -> 2400 수정하겠다.

update hr.employees
set salary = 2400
where employee_id = 100;

select salary from hr.employees where employee_id = 100;
rollback; 
select salary from hr.employees where employee_id = 100;