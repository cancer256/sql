-- subquery
-- ���������� ���� �۵��Ͽ� �װ��� ���������� �޾� �۵�

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel'); --���������� �ƺ��� ������ �̾Ƴ���.
                
-- ����] Kochhar ���� �����ϴ� ������� �̸�, ���� ��ȸ�϶�
select last_name, job_id
from employees
where manager_id in (select employee_id
                        from employees
                        where last_name = 'Kochhar');
                
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary  --��Ʈ�� ������ ���� ���� �� ���� �޴»�� ���
                from employees
                where last_name = 'Ernst');


-- ����] IT�μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ���ض�
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name like 'IT');                 
                 
-- ����] Abel�� ���� �μ����� ���ϴ� ������� �̸� �Ի����� ��ȸ�϶�.
--      �̸������� �������� �����Ѵ�.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name != 'Abel'
order by 1;

select last_name, salary
from employees
where salary = (select salary
                from employees
                where last_name = 'King'); --error ŷ�� �θ��̶� ���� 
-- =�� ���� �񱳿����ڸ� ������ ���� �ϳ�������

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- ����] ȸ�� ��� ���� �̻� ���� ������� ���, �̸� ������ ��ȸ�϶�.
--      ���� �������� ����
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                    from employees)
order by 3 desc;
---------------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); --error ���������� 2���̻��̿���
                 
select employee_id, last_name
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id); --in, =any, all�� ���������� 2���̻��̾ ����


-- ����] �̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ� ������� ���, �̸��� ��ȸ�϶�
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%')
order by 1;


-- ����] 1700�� ������ ��ġ�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700)
order by 1;

select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees
                    group by department_id); 
-- any�� �ܵ����� �������ʰ� �����ڿ� �Բ����δ�.

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- ���������� ����� 9000,6000,4500 ��� 9õ���� �۰ų� 6õ���� �۰ų� 4500���� �۰ų�

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- all�� anyó�� �����ڿ� �پ����ϸ� ���������� ������� �ּҰ��� 4200���� �۾ƾ��Ѵ�

-- ����] 60�� �μ��� �Ϻ� ������� �޿��� ���� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where salary >any (select salary
                from employees
                where department_id = 60)
order by 1;

-- ����] ��� ���α׷��� �׸��� ȸ�� ��� ���޺��� ������ �� �޴� �������
--      �̸�, ����, ������ ��ȸ�϶�
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                from employees
                where job_id = 'IT_PROG') --like�� ���ϵ� ī��� �Բ� ���°�
order by 1;  

select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1); --���������� ���ϰ��� ������ ���������� ����
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT'); --���������� ���ϰ��� ������ ���������� ����
                
--null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);
                        
select last_name
from employees
where employee_id not in (select manager_id
                           from employees);
                           
-- ����] �� ������ all �����ڷ� refactoring �϶�
select last_name
from employees
where employee_id <>all (select manager_id
                            from employees); --�ѳ��̶� null�̸� ���ϰ��� ��� null
---------------------------------------

select count(*)
from departments;

select count(*)
from departments d
where exists (select * --exists �����ϴ�
                from employees e
                where e.department_id = d.department_id); --������� �ִ� �μ����� �̾Ƴ���
                
select count(*)
from departments d
where not exists (select * --exists �����ϴ�
                from employees e
                where e.department_id = d.department_id); --������� ���� �μ����� �̾Ƴ���.
                
-- ����] ������ �ٲ����� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�
select *
from job_history;

select employee_id, last_name, job_id
from employees e
where exists ( select *
                from job_history k
                where e.employee_id = k.employee_id);