-where

select employee_id, last_name, department_id
from employees
where department_id = 90; -- department���� 90�� ���̺� ����.

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';    --���ǹ� where

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

--query = request answer = response

select last_name, salary
from employees
where salary <= 3000; --������ 3000���� ��ȸ

select last_name, job_id
from employees
where job_id != 'IT_PROG'; --��������ڰ� �ƴѻ��

-- ����] 176�� ����� ���, �̸�, �μ���ȣ�� ��ȸ�϶�.
select employee_id, last_name, department_id
from employees
where employee_id = 176;
-- ����] $12,000�޷� �̻� ���� ������� �̸�, ������ ��ȸ�϶�
select last_name, salary
from employees
where salary >= 12000;

---------------------------------------------
select last_name, salary
from employees
where salary between 2500 and 3500; --2500�̻� 3500���� between x and y x �̻� y ����

select last_name
from employees
where last_name between 'King' and 'Smith';

-- ����] 'king' ����� first name, last name, ����, ������ ��ȸ�϶�
select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; -- ''�ȿ� ���� �����ʹ� ��ҹ��� �����ؾ���. sql�� �������

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
----------------------------------------------------------

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); --100��,101��,102�� �Ŵ����� �� ��ȸ. in ��ġ�ϴ� ���� ��ȸ

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or --�Ŵ��� ���̵� 100�̰ų� 101�̰ų� 201�� �� ��ȸ
    manager_id = 101 or
    manager_id = 201;

select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');
-------------------------------------------------

select first_name
from employees
where first_name like 'S%'; -- �տ� s�� ��

select first_name
from employees
where first_name like '%r';

--����] first_name�� s�� ���Ե� ������� ��ȸ�϶�.
select last_name
from employees
where last_name like '%s%';

--����] 2005�⿡ �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select last_name, hire_date
from employees
where hire_date like '2005%'; --hire_date�� ���ڷ� ���߱⶧���� 2005%�� ���߸�ȴ� like�񱳰��� �����̴�.

select last_name
from employees
where last_name like 'K___'; --___�� K���� ������ 3���ڰ� �ִ� �׸� ��ȸ

--����] �̸��� �ι�° ���ڰ� o�� ����� �̸��� ��ȸ�϶�
select last_name
from employees
where last_name like '_o%'; --���� ����ٷ� ���� o ���� ���ϵ�ī�带 ����.

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; --Ư�����ڸ� Ż���Ų�� escape ���� �����ϸ� �װ� escape���ڰ� �ȴ�.

select last_name, job_id
from employees
where job_id like 'IT[_%' escape '['; 

--����] ������ _R�� ���Ե� ������� �̸� ������ ��ȸ�϶�.
select last_name, job_id
from employees
where job_id like '%/_R%' escape '/';
----------------------------------------------------------------

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null; --manager_id = null;�����ڰ� ���Ե� ��ɹ��̶� ������. ������ null�̸� ���ϰ��� null�̴�

select last_name, manager_id
from employees
where manager_id is null; --is null�� ������. ���� null�̸� true;
-----------------------------------------------------------------

select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%'; --and�� like������ true������.

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%'; --���߿� �ϳ��� true�̸� ��.
------------------------------------------------

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); --�������� ���Ѵ�. �� ('IT_PROG', 'SA_REP')�� �ƴѰ��� ���Ѵ�.

select last_name, salary
from employees
where salary not between 10000 and 15000; -- 10000�� 15000���̰� �ƴѰ͵� ��ȸ.

select last_name, job_id
from employees
where job_id not like '%IT%'; --���α׷��� 5������ 102���� ������.

select last_name, job_id
from employees
where commission_pct is not null; -- Ŀ�̼��� null�� �ƴѾֵ鸸 ��ȸ.

select last_name, salary
from employees
where manger_id is null and salary >= 20000;

-- ����] ������ 20000$�̻� �޴� ���� ��, ������� �̸�, ������ ��ȸ�϶�.
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--����] ������ $5000 �̻� $12000 �����̰�,
--        20���̳� 50�� �μ��� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and
department_id in(20, 50);

--����] �̸��� a�� e�� ���Ե� ������� �̸��� ��ȸ�϶�
select last_name
from employees
where last_name like '%a%' and 
    last_name like '%e%';
    
--����] ������ �����̴�. �׸���,
--      ������ $2500,  $3500�� �ƴ� ������� �̸�, ����, ������ ���϶�
select last_name, job_id, salary
from employees
where job_id like 'SA%' and salary not in(2500, 3500); 
-------------------------------------------

select last_name, department_id
from employees
order by department_id desc; -- order by�� �������� ������ /Į���� ���� desc���̸� ������������

select last_name, department_id
from employees
order by 2 desc; -- 2��° Į���� ������ �������� �����Ѵ�.

select last_name, department_id dept_id
from employees
order by dept_id desc; -- �������Ἥ�� ���� �����ϴ�.

select last_name
from employees
where department_id = 100
order by hire_date; -- �� ���̺� hire_date�� ��� ���İ����ϴ�(���ڵ�� �ֱ⶧����)

select last_name, department_id, salary
from employees
where department_id >80
order by department_id asc, salary desc; -- ���̵�� �������� ������ ������������ ����

