SELECT employee_id || ' ' || last_name || ' ' || first_name
FROM employees;

SELECT department_name || q'(Depatment's Manager ID:)' || manager_id "goodD"
FROM departments;

SELECT last_name || ', ' ||job_id "Employee and Title"
FROM employees;
