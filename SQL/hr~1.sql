SELECT employee_id "Emp#" , last_name || first_name
FROM employees;

SELECT last_name || q'(, )' || job_id "Employee and Title"
FROM employees;

SELECT department_name || q'( Department's Manager Id:)'|| manager_id "Department and Manager"
FROM departments;

SELECT *
FROM employees
WHERE 기준컬럼 비교연산자 비교값;

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
WHERE salary BETWEEN 2500 AND 3500; --사이값을 구할 때는 BETWEEN 값1 AND 값2 연산자 표현식을 사용하는 것이 좋다(편리성, 기호를 사용하나 BETWEEN을 사용하나 프로그램상 차이는 없다.)

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

SELECT employee_id, length(last_name) || ' ' || lengthb(last_name) 길이
FROM employees;

SELECT length('kimdonghwan'), lengthb('김동환')
FROM dual;