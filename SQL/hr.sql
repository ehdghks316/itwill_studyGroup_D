select employee_id, salary
from employees;

select employee_id, salary, commission_pct
from employees;

select employee_id ||salary
from employees;

select employee_id, commission_pct
from employees;

select employee_id, salary, commission_pct,  nvl(commission_pct,1) --Ç¥Çö½Ä
from employees;

select nvl(commission_pct,1) good
from employees;

select distinct department_id
from employees;

