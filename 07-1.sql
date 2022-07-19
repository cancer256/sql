-- subquery
-- 서브쿼리가 먼저 작동하여 그값을 메인쿼리가 받아 작동

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
                
-- 과제] Kochhar 에게 보고하는 사원들의 이름, 직업 조회하라
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
                
-- 과제] Abel과 같은 부서에서 일하는 동료들의 이름 입사일을 조회하라.
--      이름순으로 오름차순 정렬한다.
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
                where last_name = 'King'); -error 킹이 두명이라서 에러 한명만 받을수있음
                
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
                        
-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
--      월급 오름차순 정렬하라
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
                group by department_id); --error 서브쿼리가 2개이상이어서 에러
                
select employee_id, last_name
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id);
                    
-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라
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
