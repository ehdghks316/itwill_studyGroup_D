�ֹι�ȣ_1             �ֹι�ȣ_2
---------------     ------------------
210101-1234567	210101-1******
SELECT '210101-1234567' "�ֹι�ȣ_1", rpad(substr('210101-1234567',1,8),14,'*') "�ֹι�ȣ_2"
FROM dual;


[���� 21] ��ȭ��ȣ ��� 4�ڸ� �κ��� �Ʒ�ȭ��� ���� ������ּ���.

��ȭ��ȣ_1             ��ȭ��ȣ_2
---------------- ------------------
010-1000-1004         010-****-1004

SELECT '010-1000-1004' "��ȭ��ȣ_1", concat(rpad(substr('010-2714-0952',1,4),8,'*'),substr('010-2714-0952',-5,5)) "��ȭ��ȣ_2"
FROM dual;

[���� 22] �����ּҸ� �Ʒ�ȭ��� ���� ������ּ���.

EMAIL_1                EMAIL_2
------------------ -------------------
james@itwill.com    j****@itwill.com

SELECT 'james@itwill.com' "EMAIL_1", concat(rpad(substr('james@itwill.com',1,1),5,'*'), substr('james@itwill.com',instr('james@itwill.com','@',1,1)))
FROM dual;
������ȯ �Լ�
��to_char : ��¥���� ���ڷ� �� ��ȯ�ϴ� �Լ�, data -> char
SELECT * FROM nls_session_parameters;
SELECT sysdate,
        to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss.sssss'),
        to_char(sysdate, 'yyyymmdd hh24miss.sssss'),
        to_char(sysdate, 'yyyy"�⵵" year month mon mm'),
        to_char(sysdate, 'ddd dd d'),
        to_char(sysdate, 'day dy'),
        to_char(sysdate, 'ww iw w')
FROM dual;

SELECT sysdate,
        to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss.ssss'),
        to_char(sysdate, 'yyyy"�⵵" month dd"��" hh24"��":mi"��":ss"��"'),
        to_char(sysdate, 'year day dy d dd ddd mm mon month'),
        to_char(sysdate, 'ww iw w')
FROM dual;        

SELECT sysdate,
        to_char(sysdate,'q'),
        to_char(sysdate,'q"�б�"'), --���ͷ����ڷ� ���� �� ū����ǥ �ʼ� 
        to_char(sysdate,'q') || '�б�',
        concat( to_char(sysdate,'q'),'�б�'),
        to_char(sysdate,'dd ddth ddsp ddthsp')
FROM dual;    

SELECT sysdate,
        to_char(sysdate, 'q'),
        to_char(sysdate, 'q"�б�"'),
        to_char(sysdate, 'q') || '�б�',
        concat(to_char(sysdate, 'q'), '�б�'),
        to_char(sysdate, 'ddsp ddth ddthsp ddspth d')
FROM dual;        
[����23] ������� �����ȣ, �Ի��� ������ ����ϼ���. �� ������ �������� �������ּ���.

SELECT employee_id, hire_date, to_char(hire_date,'day')
FROM employees
ORDER BY to_char(hire_date-1,'d');

[����24] employees(���) ���̺���  �Ͽ��Ͽ� �Ի��� ����� ������ ��ȸ�ϼ���.

SELECT *
FROM employees
WHERE to_char(hire_date,'day') = '�Ͽ���';

[����25] ���� ��¥��  "2021�� 12�� 21�� ȭ����" ������ּ���.

SELECT to_char(sysdate, 'yyyy"��" mm"��" dd"��" day')
FROM dual;

[����26] ����� employees(���)���̺� �ִ� last_name,hire_date �� �ٹ� 6 ���� �� ù��° �����Ͽ� �ش��ϴ� �޿� ���� ��¥�� ǥ���մϴ�. 
             �� ���̺��� REVIEW �� �����մϴ�. 
            ��¥�� "������, the Second of 4, 2007"�� ������ �������� ��Ÿ������ �����մϴ�.
SELECT last_name, to_char(hire_date, 'yyyy/mm/dd day'), to_char(next_day(add_months(hire_date,6),'������'), 'day", the" ddspth "of" fmmm, yyyy') REVIEW
FROM employees;


to_char(��¥, '��¥�𵨿��') : ��¥ -> ����
to_char(����, '���ڸ𵨿��') : ���� -> ����
��ü�������α׷�
overloading
-�Լ��̸��� ������ �μ������� � �ڷ����� �������Ŀ� ���� ���α׷��� Ʋ���� �����ϴ� ���
-�Լ��̸��� ������ ���� �ٸ� �Լ����̴�.

SELECT employee_id, salary, 
       to_char(salary, '999,999.00'),--���� ���ڸ����ڸ��� 9�� ǥ��, 9�ڸ��� ���� ������ �ƹ����� ä���� �ʴ´�.
       to_char(salary, '000,999.00'), --0�ڸ��� ���ڰ� ������ 0���� ǥ��
       to_char(salary, '999'), -- ǥ���ؾ� �� �ڸ����� �� ������ #���� ��µ�
       to_char(salary, '$9999,999.00'),
       to_char(salary, 'l9999,999.00'), -- l(��) : ���� ������ �δ� ������ ��ȭ��ȣ�� ǥ��
       to_char(salary, 'l9999g999d00')
FROM employees;

SELECT employee_id, salary,
        to_char(salary, '999,999.00'),
        to_char(salary, '000,999.00'),
        to_char(salary, '999'),
        to_char(salary, 'l999,999.00'),
        to_char(salary, 'l999g999d00')
FROM employees;        

SELECT * FROM nls_session_parameters;
alter session set nls_territory =  france;
alter session set nls_language = french;

alter session set nls_territory =  china;
alter session set nls_language = 'simplified chinese';

alter session set nls_territory =  america;
alter session set nls_language = american;

alter session set nls_territory =  'united kingdom';
alter session set nls_language = english;

alter session set nls_territory =  korea;
alter session set nls_language = korean;

SELECT employee_id,
        to_char(hire_date,'yyyy month dd day year'),y
        to_char(salary, 'l999g999d00') -- õ������g �Ҽ����� d
FROM employees;

SELECT 
    to_char(-1000, '9999'),
    to_char(-1000, '9999pr'), --������ ��� <>�� ���´�.
    to_char(-1000, '9999mi'), --������ �ڿ� ǥ���Ѵ�.
    to_char(+1000, 's9999') -- ��ȣ�� ǥ���Ѵ�.
FROM dual;

SELECT
to_char(-1000, '9999pr'),
to_char(-1000, '9999mi'),
to_char(-1000, 's9999')
from dual;


select to_char(-1000, '9999')
FROM dual;
�Ͻ������� ����ȯ�� ���ش�.
SELECT '1' + 1
FROM dual;

to_number(���ڼ���, ���ڸ𵨿��(����)) : ���� -> ����
SELECT to_number('1', '9') + 1, 
        to_number('1') + 1 -- ���ڸ𵨿�� ��������
FROM dual;

SELECT sysdate + 1, sysdate + to_number('1')
FROM dual;

[����27] ¦���޿� �Ի��� ������� ������ ������ּ���.

SELECT *
from employees
WHERE mod(to_number(to_char(hire_date,'mm')),2) = 0;

[����28] 2006�⵵�� Ȧ���޿� �Ի��� ������� ������ ������ּ���.

SELECT * --���� Ǯ�� �� �ڵ� (�� ���� �ڵ�)
FROM employees
WHERE to_char(hire_date, 'yyyy') = '2006'
    AND mod(to_number(to_char(hire_date,'mm')),2) =1;
    --to_number�� ���������� �������� �ʴ��� �Ͻ������� ���� �ٲ� �����
    --������ ��������� ����Ѵ�.
    
SELECT * --�������� �ڵ�
from employees
WHERE mod(to_number(to_char(hire_date,'mm')),2) != 0
    and hire_date >= '2006/01/01'
    and hire_date <='2006/12/31'; -- = WHERE hire_date between '2006/01/01' and '2006/12/31';

/* �Ǽ����α׷�
SELECT * 
FROM employees
WHERE HIRE_DATE LIKE '06%'; 
--���������� to_char(hire_date) like '06%';�� ������ : ���⼭ �������� ���࿡ hire_date�� �ε����� �����Ǿ� �ִ� �÷��� ��� �ε��� ��ĵ�� �ƴ� ���̺� full scan�� ����ȴ�.
--like�����ڴ� ���� ������ ã�� ������
--hire_date�� �����÷��� �ƴϸ� �Ͻ������� ���� ��ȯ�ؼ� ����
--��ҹ��ڳ� ���̺�ȯ�Ǵ� ��(������Ÿ���� �ٲ�� ��)�� ��������!
--���̽��̳� R������ �������

SELECT *
FROM employees
WHERE to_char(hire_date, 'yyyy') = '2006'
-- ���� ������
*/
SELECT * FROM nls_session_parameters;
ALTER session set nls_territory = america;
alter session set nls_language = american;

SELECT * --������ ���� ��¥ ������ �ΰ�
from employees
WHERE hire_date >= '2006/01/01'--��������(���������� ���ư�to_date��)
    and hire_date <='2006/12/31';
    
SELECT *  --������ ���� ��¥ ������ �ΰ�
from employees
WHERE hire_date >= '01-JAN-06'
    and hire_date <='31-DEC-2006'; 

��to_date(���ڳ�¥, ��¥���˸𵨿��) : ���ڳ�¥ -> ��¥
SELECT *
from employees
WHERE hire_date >= to_date('2006/01/01', 'yyyy/mm/dd') --��������� ���� ������ ������ �̷��� �ϸ� ������ ������� ���ư�
    and hire_date <= to_date('2006/12/31 23:59:59', 'yyyy/mm/dd hh24:mi:ss');     --������ �� 2006/1��/1�� 00�ú��ʹ� ������ 2006/12��31�ϵ� 00�ñ����̹Ƿ� �̷��� ǥ��

SELECT *
from employees
WHERE hire_date >= to_date('2006/01/01', 'yyyy/mm/dd') --��������� ���� ������ ������ �̷��� �ϸ� ������ ������� ���ư�
    and hire_date < to_date('2007/01/01', 'yyyy/mm/dd');-- �̷� ������� ǥ���� �� �ִµ� ��� between and ������ ���Ұ�
    
    
��NULL���� �Լ�
��nvl 
- null���� ���������� �����ϴ� �Լ�
- nvl�Լ��� �ԷµǴ� �μ������� ������ Ÿ���� ��ġ�ؾ��Ѵ�.
if exp1 is null then
    return exp2
else
    return exp1
end if;    

desc employees
SELECT employee_id, salary, commission_pct,
        ((salary * 12) + (salary * 12 * commission_pct)) ann_sal,
        ((salary * 12) + (salary * 12 * nvl(commission_pct,0))) ann_sal2
FROM employees;  

SELECT employee_id, salary, commission_pct,
    ((salary * 12) + (salary*12 * commission_pct)) an,
    ((salary*12) + (salary*12*nvl(commission_pct,0))) an2
from employees;

SELECT nvl(commission_pct,'no comm') --���� ����ġ ������ ������ �� commission_pct�� ����, 'no comm'�� ����
FROM employees;

SELECT nvl(to_char(commission_pct),'no comm')  --�� �μ��� Ÿ���� ��ġ�ϸ� ��
FROM employees;

��nvl2(exp1,exp2,exp3)
-ù ��° exp1�� null �ƴϸ� exp2�� �����ϰ� ù ��° exp1�� null�̸� exp3�� �����Ѵ�.
-exp2,exp3�� ������Ÿ���� ��ġ�ؾ� �Ѵ�.
if exp1 is not null then
    exp2
else
    exp3
end if;    

SELECT employee_id,salary,commission_pct,
        nvl2(commission_pct,(salary*12) + (salary*12*commission_pct), salary*12) ann_sal
FROM employees;        
        
SELECT employee_id, salary, commission_pct,
    nvl2(commission_pct,(salary*12), salary*0) an
    from employees;
    
    
SELECT employee_id,salary,commission_pct,
        nvl2(commission_pct,to_char(salary*12), 'no comm') ann_sal
FROM employees;               

��coalesce(exp1,exp2,exp3,.....expn)
- ù ��° exp1�� null�̸� �� ��° exp2�� �����ϰ� �� ��° ǥ���ĵ� null�̸� exp3�� �����Ѵ�.
�� null�� �߻����� ���� �� ���� ǥ������ �����ϴ� ���

SELECT employee_id,
    coalesce((salary*12) + (salary*12*commission_pct), salary*12,0)
FROM employees;    

SELECT employee_id,
    coalesce(salary, (salary*commission_pct), salary*commission_pct,0)
    from employees;

��nullif(exp1,exp2)
-�� ǥ������ ���ؼ� ������ null�� �����ϰ� ���� ������ ù ��° ǥ������ �����Ѵ�.
if exp1 = exp2 then
    null
else
    exp1
end if;

SELECT employee_id, last_name, first_name,
        nullif(length(last_name), length(first_name)) nullif1,
        nullif(length(first_name), length(last_name)) nullif2
FROM employees;  

SELECT employee_id, last_name, first_name,
    nullif(length(last_name), length(first_name))
    from employees;

���������
it�� ����� �� �ֵ��� decode�Լ�, case ǥ������ �����Ѵ�.

SELECT employee_id, job_id, salary
FROM employees;

if job_id = 'IT_PROG' then
    salary * 1.1
else if job_id = 'SY_CLERK' then
    salary * 1.2
else if job_id = 'SA_REP' then
    salary *1.3
else
    salary
end if;

decode
if ���ذ� = �񱳰�1 then
    ����1
else  ���ذ� = �񱳰�2 then
   ����2
else if  ���ذ�= �񱳰�3 then
    ����3
else
    ���ذ�
end if;

��decode �Լ��� ���ذ��� �񱳰��� ����(=) �񱳿����ڸ� ����Ѵ�.
decode(���ذ�,
        �񱳰�1, ����1,
        �񱳰�2, ����2,
        �񱳰�3,����3,......
        ���ذ�)


if job_id = 'IT_PROG' then
    salary * 1.1
else if job_id = 'SY_CLERK' then
    salary * 1.2
else if job_id = 'SA_REP' then
    salary *1.3
else
    salary
end if;

SELECT employee_id, job_id,
    decode(job_id, 'IT_PROG', salary *1.1,
            'ST_CLERK', salary * 1.2,
            'SA_REP', salary * 1.3,
            salary) rewised_salary
from employees;            

��case ǥ���� : ���ذ��� �񱳰��� ���ؼ� ��� �񱳿����ڸ� ����� �� �ִ�.

case ���ذ� = �񱳰�
    when �񱳰�1 then ����1
    when �񱳰�2 then ����2
    when �񱳰�3 then ����3
    ...
    else ���ذ�
end    

case ���ذ� = �񱳰�
    when ���ذ� = �񱳰�1 then ����1
    when ���ذ� = �񱳰�2 then ����2
    when ���ذ� = �񱳰�3 then ����3
    ...
    else ���ذ�
end    
���ذ� �񱳿�����(=,>,>=, <=,<,!=,^=, in, between and, like) �񱳰�

case ���ذ� = �񱳰�
    when ���ذ� >= �񱳰�1 then ����1
    when ���ذ� <= �񱳰�2 then ����2
    when ���ذ� in(�񱳰�3,�񱳰�4) then ����3
    ...
    else ���ذ�
end    

SELECT employee_id, job_id,
    case job_id
        when 'IT_PROG' then 
            salary *1.1
        when 'ST_CLERK' then
            salary * 1.2
        when 'SA_REP' then
            salary * 1.3
        else salary    
    end rewised_salary
from employees;    

SELECT employee_id, job_id,
    case
        when job_id = 'IT_PROG' then 
            salary *1.1
        when job_id = 'ST_CLERK' then
            salary * 1.2
        when job_id = 'SA_REP' then 
            salary * 1.3
        else salary    
    end rewised_salary
from employees; 

[����29] ������� �޿��� �������� ������ּ���.
        ~4999      : low
    5000~9999    : medium
    10000~19999 : good
    20000~        : excellent
    
SELECT employee_id, salary,
    case
        when salary between 0 and 4999 then
            'low'
        when salary >= 5000 and salary < 10000 then
            'medium'
        when salary >=10000 and salary < 20000 then
            'good'
        else 'excellent'
    end rewised_salary    
FROM employees;
