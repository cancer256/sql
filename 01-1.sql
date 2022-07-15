select * from departments;

select department_id, location_id -- 셀렉트는 조회
from departure;

select location_id, department_id
from departments;

desc departments  -- desc +"" ""에 입력한 객체 구조확인

--과제] employees구조를 확인하라
desc employees;

select last_name, salary, salary + 300
from employees;
-- 과제] 사원들의 월급, 연봉을 조회하라.
select salary, salary * 12
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

select last_name as name, commission_pct comm --as 는 별명으로 설정, 소문자로 써도대문자로 박힘
from employees;
select last_name "Name", salary * 12 "Annual Salary"
from employees; -- 큰따옴표 안에 넣으면 대소문자 스페이스 구분 가능
-- 과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라
select employee_id, last_name, hire_date "STARTDATE"
from employees;
-- 과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)를 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id
from employees; --||붙이기 기능
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;
select last_name || null
from employees; --null을 문자로 받아들여 그대로 표시
select last_name || commission_pct
from employees;
select last_name || salary
from employees;
select last_name || hire_date
from employees;
select last_name || (salary * 12)
from employees; -- 붙이기 연산자와 사용시 모든 리턴값은 문자이다.
-- 과제] 사원들의 이름, 직업(Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;