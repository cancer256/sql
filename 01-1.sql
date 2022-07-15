select * from departments;

select department_id, location_id -- ����Ʈ�� ��ȸ
from departure;

select location_id, department_id
from departments;

desc departments  -- desc +"" ""�� �Է��� ��ü ����Ȯ��

--����] employees������ Ȯ���϶�
desc employees;

select last_name, salary, salary + 300
from employees;
-- ����] ������� ����, ������ ��ȸ�϶�.
select salary, salary * 12
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

select last_name as name, commission_pct comm --as �� �������� ����, �ҹ��ڷ� �ᵵ�빮�ڷ� ����
from employees;
select last_name "Name", salary * 12 "Annual Salary"
from employees; -- ū����ǥ �ȿ� ������ ��ҹ��� �����̽� ���� ����
-- ����] ������� ���, �̸�, ����, �Ի���(STARTDATE)�� ��ȸ�϶�
select employee_id, last_name, hire_date "STARTDATE"
from employees;
-- ����] ������� ���(Emp #), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id
from employees; --||���̱� ���
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;
select last_name || null
from employees; --null�� ���ڷ� �޾Ƶ鿩 �״�� ǥ��
select last_name || commission_pct
from employees;
select last_name || salary
from employees;
select last_name || hire_date
from employees;
select last_name || (salary * 12)
from employees; -- ���̱� �����ڿ� ���� ��� ���ϰ��� �����̴�.
-- ����] ������� �̸�, ����(Emp and Title)�� ��ȸ�϶�.
select last_name || ', ' || job_id "Emp and Title"
from employees;