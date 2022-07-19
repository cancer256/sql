-- subquery
-- ���������� ���� �۵��Ͽ� �װ��� ���������� �޾� �۵�

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
                
-- ����] Kochhar ���� �����ϴ� ������� �̸�, ���� ��ȸ�϶�
select last_name, job_id
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');

select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
-- ����] Abel�� ���� �μ����� ���ϴ� ������� �̸� �Ի����� ��ȸ�϶�.
--      �̸������� �������� �����Ѵ�.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;

select last_name, salary
from employees
where salary = (select salary
                from employees
                where last_name = 'King'); -error ŷ�� �θ��̶� ���� �Ѹ��� ����������
                
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id =50);
                        
-- ����] ȸ�� ��� ���� �̻� ���� ������� ���, �̸�, ������ ��ȸ�϶�.
--      ���� �������� �����϶�
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by 3;
--------------------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); --error ���������� 2���̻��̾ ����
                
select employee_id, last_name
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id);
                    
-- ����] �̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ� ������� ���, �̸��� ��ȸ�϶�
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- ����] 1700�� ������ ��ġ�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);

select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees
                    group by department_id);

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';