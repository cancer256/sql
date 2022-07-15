--single function
--SQL(Structed Query Language)
--PL/SQL(Procedure Language/SQL) PL = SQL을 절차지향 언어로 포장하는것 

--펑션은 파라미터로 레코드고 리턴값도 레코드다
--파라미터로 들어온 레코드 개수가 딱하나인 그런 펑션들을 싱글펑션이라고 한다.

desc dual
select * from dual;

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';

select concat('Hello', 'World')
from dual;

select substr('HelloWorld' ,2 ,5)
from dual;
select substr('Hello', -4, 2)
from dual;

select length('Hello')
from dual;

select instr('Hello', '1')
from dual;

select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*')
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;

select trim ('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 위 문장을 where절을 like로 refactoring하라
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 구하라
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
        last_name like 'A%' or
        last_name like 'M%';
        
select round(45.926, 2) -- 소수점 2번째 자리 이후에서 반올림
from dual;

select trunc(45.926, 2)
from dual;

select mod(1600, 300)
from dual;
select round(45.923, 0), round(45.932)
from dual;

select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;

--과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라
select last_name, salary, round(salary * 1.155) "New Salary", round((salary * 1.155) - salary) "Increase"
from employees;
-----------------------------------------------------------------

select sysdate -- function의 호출문으로 현재시각을 리턴해준다.
from dual; --표시형식에서 시분초 빼버려서 날짜만 출력

select sysdate + 1
from dual;

select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 과제]90번 부서 사원들의 이름, 근속 연수를 조회하라
select last_name, trunc ((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/07/14', 1)
from dual;

select next_day('2022/07/14', 5)
from dual;

select last_day('2022/07/14')
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라
    --월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between (sysdate, hire_date) >= 20 * 12;

-- 과제] 사원들의 이름, 월급 그래프를 조회하라
-- 그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;