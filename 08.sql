-- set
select employee_id, job_id
from employees
union -- �ΰ��� ����, �ߺ��Ȱ�(������ ������ ���翡�� �����ִ»��) ���ŵ�
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
union all --�ΰ��� ��� ����
select employee_id, job_id
from job_history;

-- ����] ���� ������ ���� �����ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
select employee_id, last_name, job_id
from employees e
where job_id in (select job_id
                from job_history k
                where e.employee_id = k.employee_id);
                
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, job_id
from employees
intersect -- �������� ���Ѵ�
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
minus -- ����
select employee_id, job_id
from job_history;

select location_id, department_name
from departments
union
select location_id, state_province
from locations; --�ָ�� �μ����� ���׹��� �����ִ�.

-- ����] �� ������, service �������� ���Ķ�.
--      union ����Ѵ�.
select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;
-- ����] �� ������ ���Ķ�.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0
from job_history
order by salary;