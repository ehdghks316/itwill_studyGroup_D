SELECT employee_id "Emp#" , last_name || first_name
FROM employees;

SELECT last_name || q'(, )' || job_id "Employee and Title"
FROM employees;

SELECT department_name || q'( Department's Manager Id:)'|| manager_id "Department and Manager"
FROM departments;

SELECT *
FROM employees
WHERE �����÷� �񱳿����� �񱳰�;

SELECT *
FROM employees
WHERE employee_id <> 100;

SELECT *
FROM employees
WHERE employee_id = 100;


SELECT *
FROM employees
WHERE hire_date = '2003/06/17';

SELECT * FROM nls_session_parameters;

SELECT * 
FROM employees
WHERE salary > 10000;

SELECT *
FROM employees
WHERE employee_id = 100
OR employee_id =101
OR employee_id = 102;

SELECT *
FROM employees
WHERE employee_id IN(100,101,102);

SELECT *
FROM employees
WHERE job_id LIKE 'SA%'
AND salary >=10000;

SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500; --���̰��� ���� ���� BETWEEN ��1 AND ��2 ������ ǥ������ ����ϴ� ���� ����(����, ��ȣ�� ����ϳ� BETWEEN�� ����ϳ� ���α׷��� ���̴� ����.)

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

SELECT last_name, salary
FROM employees
WHERE salary NOT IN(3000,2500);
SELECT *
FROM employees
WHERE department_id IS NULL;

SELECT *
FROM employees
WHERE department_id IS NOT NULL;

SELECT *
FROM employees
WHERE job_id LIKE 'HR%';

SELECT *
FROM employees
WHERE job_id LIKE 'SA\_%' ESCAPE '\';

SELECT last_name
FROM employees
WHERE last_name LIKE '__a%' OR last_name LIKE '__e%';

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000
ORDER BY salary ;

SELECT *
FROM employees
WHERE initcap(last_name) = 'King';

SELECT employee_id, concat(last_name, first_name) as go
FROM employees;

SELECT employee_id, last_name || ' ' || first_name as "Real Name"
FROM employees;

SELECT employee_id, length(last_name) || ' ' || lengthb(last_name) ����
FROM employees;

SELECT length('kimdonghwan'), lengthb('�赿ȯ')
FROM dual;