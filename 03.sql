--single function
--sysdate�� nvl���̾�
--SQL(Structed Query Language)
--PL/SQL(Procedure Language/SQL) PL = SQL�� �������� ���� �����ϴ°� 

--����� �Ķ���ͷ� ���ڵ�� ���ϰ��� ���ڵ��
--�Ķ���ͷ� ���� ���ڵ� ������ ���ϳ��� �׷� ��ǵ��� �̱�����̶�� �Ѵ�.

desc dual
select * from dual; --�����Ͱ� ��ȸ ���ڵ尡 ���ϵȰ�; �̱������ ���ڵ尡 �ϳ� �ʵ尡 �ϳ�

select lower('SQL Course') --lower�� �ҹ��ڷ� �ٲ۴ٴ¶�
from dual;     --SQL�ּҹ��� select from

select upper('SQL Course')  --upper�� �빮�ڷ� �ٲ۴ٴ¶�
from dual;

select initcap('SQL Course') --initcap �������� ù���ڸ� �빮�ڷ� �ٲ۴�
from dual;

select last_name
from employees
where last_name = 'higgins'; --������ ���� ���� ��ҹ��� ������ �ǹǷ� �ҹ���,�빮�ڴ� ���� �ٸ���

select last_name
from employees
where last_name = 'Higgins'; --������ ���� ���� ��ҹ��� ������ �ǹǷ� �ҹ���,�빮�ڴ� ���� �ٸ���

select last_name
from employees
where lower(last_name) = 'higgins'; --lower�� ��Ʈ������ �ʵ尪�� �Ķ���ͷ� �������̴�.
-- �̱������ ���ڵ带 �ϳ��� ������ �ֱ⶧���� employees�� �ִ� 107���� ���ڵ带 �޾� 107�� �����Ѱ��̴�.

select concat('Hello', 'World')
from dual; --���� �ΰ��� �ٿ��� ��ȸ

select substr('HelloWorld', 2, 5)
from dual; --SQL�� index�� 1���� ����. index 2������ 5���ڸ� �����̴�. ellow
select substr('Hello', -1, 1)
from dual; -- -1�ڿ������� 1�� length


select length('Hello')
from dual; --������ ���̸� ��ȸ�Ѵ�.

select instr('Hello', 'l')
from dual; -- ó������ �߰ߵ� �Է°��� �ε����� �߰��ϰ� ������. l�� 3�� �ε������� �߰��ϰ� ����.

select instr('Hello', 'w')
from dual; -- w�� ��� 0���� ���

select lpad(salary, 5, '*') --5�ڸ��� �����ϰ� �������� ������ ä��� 
from employees;

select rpad(salary, 5, '*') --5�ڸ��� �����ϰ� �������� �������� ä��� 
from employees;

select replace('JACK and JUE', 'J', 'BL') --���ڸ� �ٲ۴�.
from dual;

select trim('H' from 'Hello') -- �Ӹ������� �Ű澲�� ���ڸ� ����. ����ִ� ���ڴ� ����.
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--����] �� query���� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ�϶�
select rpad(trim(' ' from ' Hello '), 6, '*')
from dual;

select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;  -- �̷��Ծ��� �Ӹ�, �����κ� �����̽� �������ִ�.

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG'; --substr �ε��� �ϳ��� �θ� ���ε������� ���������� ��

-- ����] �� ������ where���� like�� refactoring�϶�
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ���϶�
-- �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����϶�.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or 
        last_name like 'A%' or
        last_name like 'M%';

select round(45.926, 2) -- �Ҽ��� 2��° �ڸ� ���Ŀ��� �ݿø�
from dual;

select trunc(45.926, 2) --�Ҽ��� 2��° �ڸ� ���Ŀ��� ����
from dual;

select mod(1600, 300) -- ���������ϱ�
from dual;

select round(45.923, 0), round(45.923)
from dual; -- (x, y) y���� 0�̶�� x���ᵵ��

select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;

--����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�
select last_name, salary, 
        round (salary * 1.155) "New Salary" , 
        round (salary * 1.155 - salary) "Increase" 
from employees;
-------------------------------------------------------

select sysdate -- function�� ȣ�⹮���� ����ð��� �������ش�.
from dual; --ǥ�����Ŀ��� �ú��� �������� ��¥�� ���

select sysdate + 1 
from dual; -- +1��

select sysdate - 1
from dual; -- -1��

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- ����]90�� �μ� ������� �̸�, �ټ� ������ ��ȸ�϶�
select last_name, trunc ((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual; -- ���� �Է��� ��¥�� �ڿ� �Է��ѳ�¥�� ���̸� ���

select add_months('2022/07/14', 1)
from dual; -- ���� �Է��ѳ�¥�� 1�������� ��¥�� ���

select next_day('2022/07/14', 5)
from dual; --1�� 2�� 3ȭ 4�� 5�� 6�� 7�� �Է��� ��¥���� �������� ���� ���� ���

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

select last_day('2022/07/14')
from dual;  -- �Է��� ���� ������ �� ���

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�
    --������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 20 * 12;

-- ����] ������� �̸�, ���� �׷����� ��ȸ�϶�
-- �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;



