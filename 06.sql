-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
select department_id, department_name, location_id, city
from departments natural join locations; --���ڵ� ���� natural join
-- ���� ���̺��� ���ڵ带 ���캸�� ����Į���� ã�´�
-- Ű�� ���̺����� �����Ѱ��� ������
-- �ܺ� ���̺��� ����Ǽ� �Ա⶧���� foreign�̶�� �θ���. ex)location_id�� ����Ʈ��Ʈ�� ����Ǽ���
-- ���̺� ���赵�� �ƴ� ����� �ش��ڵ带 �����Ҽ� �ֱ⶧���� ���뼺�� �����ʾ� �� �Ⱦ���.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50); --where�� ������ �ĺ��� ��󳾼��ִ�.
--���� �����ϱ����ϴ�, ���� ����Į���� Ȯ���Ҽ� ����.

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select department_id, department_name, location_id, city
from departments natural join locations; -- using�� natural join�� ����

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400; -- 1400�� ���׿� �ִ� �μ��� �ľ�
-- from ���� ������ ���̰� �� ������ �������� ���� �ִ�.

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- using Į��(location_id)�� ���λ縦 �ٿ��� error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; -- usingĮ��(location_id)���� ���λ縦 ������ ���Ѵ�
-- using�� �� Į���� usingĮ�� �̶����

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where manager_id = 100; --error manager�� �ָ��ϴٰ� ����

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100; -- manager�� ���λ� d�� ���̴� ��µ�
-- using Į���� �ƴ� ����Į������ ���λ縦 �ٿ��� ������ �ȳ�!

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where e.manager_id = 100; -- manager�� ���λ� e�� ���̴� ��µ�
-------------------------------------------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- =equi join

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using���� refactorimg �϶�.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149; -- on ���ǹ��� n���� �ִٰ� �����Ͽ� and�� ���´�.

-- ����] Toronto�� ��ġ�� �μ����� ���ϴ� ������� 
--      �̸�, ����, �μ���ȣ, �μ�����  ��ȸ�ض�
select e.last_name ,e.job_id, e.department_id, d.department_name, city
from employees e join departments d
on e.department_id = d.department_id    
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join ���������� �ٸ��� ���� non-equi join�̴�.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-------------------------------------

--self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error ���λ縦 �Ⱦ��� ����
-- �������ο��� ���λ縦 ����Ѵ�.

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; --error �������� ���λ縦 �ȽἭ ����

-- ����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, ������ �̸��� ��ȸ�϶�.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- ����] Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�
select last_name, hire_date
from employees e join employees c
e.last_name = 'Davies';