--single function
--sysdate와 nvl많이씀
--SQL(Structed Query Language)
--PL/SQL(Procedure Language/SQL) PL = SQL을 절차지향 언어로 포장하는것 

--펑션은 파라미터로 레코드고 리턴값도 레코드다
--파라미터로 들어온 레코드 개수가 딱하나인 그런 펑션들을 싱글펑션이라고 한다.

desc dual
select * from dual; --데이터값 조회 레코드가 리턴된것; 싱글펑션은 레코드가 하나 필드가 하나

select lower('SQL Course') --lower가 소문자로 바꾼다는뜻
from dual;     --SQL최소문법 select from

select upper('SQL Course')  --upper은 대문자로 바꾼다는뜻
from dual;

select initcap('SQL Course') --initcap 각글자의 첫글자를 대문자로 바꾼다
from dual;

select last_name
from employees
where last_name = 'higgins'; --데이터 안의 값은 대소문자 구분이 되므로 소문자,대문자는 서로 다른값

select last_name
from employees
where last_name = 'Higgins'; --데이터 안의 값은 대소문자 구분이 되므로 소문자,대문자는 서로 다른값

select last_name
from employees
where lower(last_name) = 'higgins'; --lower가 라스트네임의 필드값을 파라미터로 받은것이다.
-- 싱글펑션은 레코드를 하나만 받을수 있기때문에 employees에 있는 107개의 레코드를 받아 107번 실행한것이다.

select concat('Hello', 'World')
from dual; --글자 두개를 붙여서 조회

select substr('HelloWorld', 2, 5)
from dual; --SQL은 index가 1부터 시작. index 2번부터 5글자를 뜯어낸것이다. ellow
select substr('Hello', -1, 1)
from dual; -- -1뒤에서부터 1은 length


select length('Hello')
from dual; --글자의 길이를 조회한다.

select instr('Hello', 'l')
from dual; -- 처음으로 발견된 입력값의 인덱스를 발견하고 끝낸다. l을 3의 인덱스에서 발견하고 끝냄.

select instr('Hello', 'w')
from dual; -- w가 없어서 0으로 출력

select lpad(salary, 5, '*') --5자리로 제한하고 랜덤값이 왼쪽을 채운다 
from employees;

select rpad(salary, 5, '*') --5자리로 제한하고 랜덤값이 오른쪽을 채운다 
from employees;

select replace('JACK and JUE', 'J', 'BL') --글자를 바꾼다.
from dual;

select trim('H' from 'Hello') -- 머리꼬리만 신경쓰며 글자를 뜯어낸다. 가운데있는 글자는 못뜯어냄.
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라
select rpad(trim(' ' from ' Hello '), 6, '*')
from dual;

select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;  -- 이렇게쓰면 머리, 꼬리부분 스페이스 날릴수있다.

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG'; --substr 인덱스 하나만 두면 그인덱스부터 마지막까지 뜯어냄

-- 과제] 위 문장을 where절을 like로 refactoring하라
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 구하라
-- 이름은 첫글자는 대문자, 나머지는 소문자로 출력하라.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or 
        last_name like 'A%' or
        last_name like 'M%';

select round(45.926, 2) -- 소수점 2번째 자리 이후에서 반올림
from dual;

select trunc(45.926, 2) --소수점 2번째 자리 이후에서 내림
from dual;

select mod(1600, 300) -- 나머지구하기
from dual;

select round(45.923, 0), round(45.923)
from dual; -- (x, y) y값이 0이라면 x만써도됨

select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;

--과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라
select last_name, salary, 
        round (salary * 1.155) "New Salary" , 
        round (salary * 1.155 - salary) "Increase" 
from employees;
-------------------------------------------------------

select sysdate -- function의 호출문으로 현재시각을 리턴해준다.
from dual; --표시형식에서 시분초 빼버려서 날짜만 출력

select sysdate + 1 
from dual; -- +1일

select sysdate - 1
from dual; -- -1일

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
from dual; -- 앞의 입력한 날짜와 뒤에 입력한날짜의 차이를 출력

select add_months('2022/07/14', 1)
from dual; -- 앞의 입력한날짜의 1개월뒤의 날짜를 출력

select next_day('2022/07/14', 5)
from dual; --1일 2월 3화 4수 5목 6금 7토 입력한 날짜이후 다음으로 오는 요일 출력

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

select last_day('2022/07/14')
from dual;  -- 입력한 날의 마지막 날 출력

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라
    --월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 20 * 12;

-- 과제] 사원들의 이름, 월급 그래프를 조회하라
-- 그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;



