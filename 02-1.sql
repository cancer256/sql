select employee_id, last_name, department_id
from employees
where department_id = 90; --department값이 90인 테이블만 담긴다.

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; --조건문 where

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

--query = request / answer = response
select last_name, salary
from employees
where salary <= 3000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

--과제] 176번 사원의 사번, 이름 , 부서번호를 조회하라
select employee_id, last_name, department_id
from employees
where employee_id = 176;
--과제] $12,000달러 이상 버는 사원들의 이름, 월급을 조회하라
select last_name, salary
from employees
where salary >= 12000;
-------------------------------------

select last_name, salary
from employees
where salary between 2500 and 3500; --between x and y = x이상 y이하

select last_name
from employees
where last_name between 'King' and 'Smith';

-- 과제] 'King'사원의 first name, last name, 직업, 월급을 조회하라
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
------------------------------------------------------

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); --100, 101, 201 매니저인 값 조회. in 일치하는 값을 조회

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or --매니저 아이디가 100이거나 101이거나 201인 값 조회
    manager_id = 101 or
    manager_id = 201;

select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');
---------------------------------------------------

select first_name
from employees
where first_name like 'S%'; -- 앞에 s가 옴

select first_name
from employees
where first_name like '%r'; --뒤에 r이 옴

--과제] first_name에 s가 포함된 사원들을 조회하라.
select first_name
from employees
where first_name like '%s%';

--과제] 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%'; --hire_date도 문자로 변했기때문에 2005%만 맞추면된다 like비교값은 문자이다.

select last_name
from employees
where last_name like 'K___'; --___는 k다음 임의의 3글자가 있는 항목 조회

--과제] 이름의 두번째 글자가 o인 사원의 이름을 조회하라
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';

select last_name, job_id
from employees
where job_id like 'IT[_%' escape '[';

--과제] 직업에 _R이 포함된 사원들의 이름 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape'\';
----------------------------------------------------------------

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null; --manager_id = null;연산자가 포함된 명령문이라 수식임. 수식이 null이면 리턴값은 null이다

select last_name, manager_id
from employees
where manager_id is null; --is null 이 연산자. 값이 null이면 true;
-----------------------------------------------------------------

select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%'; --and는 양쪽이 true여야함

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); --여집합을 구한다. 즉('IT_PROG', 'SA_REP')가 아닌것을 구한다.

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id, commission_pct
from employees
where commission_pct is not null;

select last_name, salary
from employees
where manager_id is null and salary >= 20000;

-- 과제] 월급을 20000$이상 받는 사장 외, 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--과제] 월급이 $5000 이상 $12000 이하이고,
--        20번이나 50번 부서에 일하는 사원들의 이름, 월급, 부서번호를 조회하라
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and department_id in (20, 50); 

--과제] 이름에 a와 e가 포함된 사원들의 이름을 조회하라
select last_name
from employees
where last_name like '%a%' and
        last_name like '%e%';
        
--과제] 직업이 영업이다. 그리고,
--      월급이 $2500,  $3500가 아닌 사원들의 이름, 직업, 월급을 구하라
select last_name, job_id, salary
from employees
where job_id like 'SA%' and salary not in (2500, 3500);
