show user
grant create public synonym to hr;
grant drop public synonym to hr;

revoke create public synonym from hr;
revoke drop public synonym from hr;

SELECT * from dba_data_files;
select * from user_segments where segment_name = 'EMPLOYEES';
select * from user_extents where segment_name = 'EMPLOYEES';

UNDO tablespace �ϴ� ��?
dml �۾��� �������� �����ϴ� ����
�� �������� �����ؾ��ϴ°�?
rollback �ϱ� ���ؼ� �������� �������� ������ �־�� �ϴ� �������?
�� �������� undo tablespace������ �������� ����ϰ� �ִ�.
select salary from hr.employees where employee_id = 100;
24000 -> 2400 �����ϰڴ�.

update hr.employees
set salary = 2400
where employee_id = 100;

select salary from hr.employees where employee_id = 100;
rollback; 
select salary from hr.employees where employee_id = 100;