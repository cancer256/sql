-- group function

select avg(salary), max(salary), min(salary), sum(salary)
from employees; --avg ��� max�ִ밪 min�ּҰ� sum��ģ��
--�̱������ �Ķ���� ������ 1. �׷������ �Ķ���� ������ n
-- �̱���ǰ��� �������� ���ϰ��� �ϳ���� ���̴�.

select min(hire_date), max(hire_date)
from employees; -- �̶��� min�� ��������� max�� �����ֱ�

-- ����] �ְ� ���ް� �ּҿ����� ���̸� ���ض�
select max(salary) - min(salary)
from employees;
-----------------------------------------
select count(*)
from employees; -- ������ �ľ��Ѵ�. *�� ���Į���� ���Ѵ�.

-- ����] 70�� �μ����� ������� ��ȸ�϶�
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;-- �׷��Լ����� �Ķ���� ����� ���̸� �����Ѵ�.
-- �Ŵ������̵��� king�� ���̱� ������ ���ܵ� 106���
--�ΰ��� �ټ��� ������ count(*)�ϴ��� count(�����̸Ӹ� Ű)�ϸ� ��.

select avg(commission_pct)
from employees;

-- ����] ������ ��� Ŀ�̼����� ���϶�
select avg(nvl(commission_pct, 0))
from employees;
-------------------------------------------------

select avg(salary)
from employees;

select avg(distinct salary)
from employees; -- distinct�� �ߺ��� �����Ѵ�.

select avg(all salary)
from employees; --all ��� �Լ� �տ��� all�� ����ó�� �Ǿ������� ����̶�� ��

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�
select count(distinct department_id)
from employees;

-- ����] �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;
------------------------------------------

select department_id, count(employee_id)
from employees
group by department_id --�μ���ȣ�� �����ֵ鵵 ���´�.
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id 
order by department_id; -- �׷���̿��ִ� ����� ����Ʈ�� ������ �� �ִ�.
-- job_id�� ���̺��� ������ �Ҽ��ִ� �༮�� �ƴϴ�. �̱������ ���̺����� �Ҽ��ִµ� ����̵�� �ƴϴ�.
-- count(employee_id)�� ī������ ���ϰ��� ����Ʈ�� ���Ŵ�.
--����Ʈ���� Į���� ���̺��ϴ� �̱���ǰ� �׷������ �� �� �ִ�.

-- ����] ������ ������� ��ȸ�϶�
select job_id, count(employee_id)
from employees
group by job_id
order by job_id;
------------------------------------

select department_id, max(salary)
from employees
group by department_id
having department_id > 50; -- having �׷��� ��󳽴�

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000; --������ 10000�Ѵ� �ֵ��� ���ڴ�.

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- having������ ���� ����

select department_id, max(salary)
from employees
where department_id > 50
group by department_id; --having �������� ����� ���� 
--�غ��� �׷��� ����� ���� �׷��� ���  ������ ���ڵ带 ���� ��󳻰� �׷��� �����

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; --error 
--���ǹ��� �׷������ ������ �غ��� ����.