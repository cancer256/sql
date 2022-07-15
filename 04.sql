--datatype conversion
--타입의 변환은 문자 > 숫자, 문자 > 날짜, 날짜 > 문자, 숫자 > 문자 4가지 형식만 있다.
select hire_date
from employees
where hire_date = '2003/06/17'; -- 문자가 날짜로 변환

select salary
from employees
where salary = '7000'; --문자가 숫자로 변환

select hire_date || '' --날짜가 문자로 변환(붙이기로 인해)
from employees;

select salary || '' --숫자가 문자로 변환(붙이기로 인해)
from employees;
--------------------------------------

select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd') 
from dual; -- 날짜를 'fm(form의 model)'안의 문자 형식으로 바꾼다

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual; --날짜 년월 요일 검색

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual; -- ''안에 값 소문자로 쓰면 소문자로 나온다.

select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- 과제] 위 테이블을 월요일부터 오름차순 정렬하라.
select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date - 1, 'd') d
from employees
order by d;

select to_char(sysdate, 'hh24:mi:ss am')
from dual; -- 현재 시분초 조회

select to_char(sysdate, 'DD "of" Month')
from dual; -- ""큰따옴표 안의 것들 사이 출력가능

select to_char(hire_date, 'fmDD Month YY') --fill mode 꽉꽉 압축해서 출력
from employees;

--과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD로 표시한다
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date, 
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;



----------------------------------------------

select to_char(salary) --문자로 변환
from employees;

select to_char(salary, '$99,999.99'),
        to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst'; --99,999.99는 임의의숫자라는뜻 소수점뒤는 수가 없어도 .00으로 표시
-- 0을쓰면 앞에 빈자리도 0이 남아있다.

select '|' || to_char(12.12, '9999.999') || '|',
        '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
        '|' || to_char(12.12, 'fm0000.000') || '|'
from dual; --fill mode로 공백을 없애버림

select to_char(1237, 'L9999')
from dual;  -- L(local)을쓰면 원단위 표현가능

-- 과제] <이름> earns <$월급> monthly but wants <$,월급x3>. 로 조회하라.
select last_name || ' earns ' || to_char(salary, 'fm$99,999')
    || ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') 
    || '.'
from employees;

-----------------------------------------

select last_name, hire_date --날짜로 변환
from employees
where hire_date = to_date('sep 21, 2005', 'Mon dd, yyyy'); -- to_date 쓰고 먼저쓴 양식에 맞춰 뒤에 적어줘야함.

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'fxMon  dd yy'); --Format eXtract(정확하게 확인하는것)
---------------------------------------------

select to_number('1237') --숫자로 변환
from dual;

select to_number('1,237.12')
from dual; --error ,가 들어가있어 에러

select to_number('1,237.12', '9,999.99')
from dual; -- 뒤에 , '9,999.99'라는 임의의 수가 들어간다고 해줘야 참
------------------------------------------------

-- null★★

select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees; --null값은 모두 0으로 만든다. 하나의 칼럼이므로 검사값과 기본값의 타입이 같아야한다.
--세로횡인 칼럼은 하나의 유형으로 묶여있다.

-- 과제] 사원들이 이름, 직업, 연봉을 조회하라.
select last_name, job_id, 
    salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

--과제] 사원들의 이름, 커미션을 조회하라
--  커미션이 없으면, no commission을 출력한다.
select last_name, nvl(to_char(commission_pct), 'No Commission') commission
    from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees; --null값이 아니면 SAL+COMM값을 받고 null이면 SAL값을 받는다
--'SAL+COMM', 'SAL' 이 2개의값을 통일시켜야한다.

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name, 
nullif(length(first_name), length(last_name))
from employees; --nullif 두개 파라미터 값이 같으면 null을 리턴
-- null을 리턴하거나 첫번째 파라미터인 퍼스트네임을 리턴한다.

select to_char(null), to_number(null), to_date(null)
from dual; --이 세개에 null값이 들어가면 리턴값도 null이다.

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
    from employees; --처음으로 null이 아닌 값을 리턴한다.
-- 커미션이 널값이면 매니져아이디를 리턴하고 커미션이 값이 있으면 커미션을 리턴한다.
-- 둘다 null이면 마지막인 None를 리턴

-------------------------------------

select last_name, salary,
    decode(trunc(salary / 2000),
    0, 0.00,
    1, 0.09,
    2, 0.20,
    3, 0.30,
    4, 0.40,
    5, 0.42,
    6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;  --(trunc(salary / 2000)이 기존값 0이 비교값 0.00이 리턴값

select decode(salary, 'a', 1)
from employees; --기본값은 널이기 때문에 일치하는것이없어 모두 널이 출력

select decode(salary, 'a', 1, 0)
from employees; --기본값이 0이기 때문에 일치하는것이 없어 모두 0이 출력
--'a'는 셀러리와 맞추기 위해 문자를 숫자로 변경했던걸 알수있음

select decode(job_id, 1, 1)
from employees; --error job_id와 1의 타입이 달라 에러

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; -- 하이어 데이트를 숫자로 바꾸려다가 실패해서 에러

-- 과제] 사원들의 직업, 직업별 등급을 조회하라
--      IT_PROG     A
--      AD_PERS     B
--      ST_MAN      C
--      ST_CLERK    D                  
select job_id, decode(job_id,
    'IT_PROG',    'A',
    'AD_PRES',    'B',
    'ST_MAN',     'C',
    'ST_CLEKR',   'D') grade -- 문자에는 ''붙여야한다.
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees; --케이스로 시작해서 엔드까지가 하나의 칼럼

select case job_id when '1' then 1
                    when '2' then 2
                    else 0 
        end grade
from employees;  --기준값과 비교값 타입도 동일해야하고 then 이후의 리턴값도 타입이 동일해야함

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees;

select case job_id when '1' then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees; --기준값과 비교값의 타입이달라 에러

select case job_id when 1 then '1'
                    when 2 then '2'
                    else 0 
        end grade
from employees; --error 

select case job_id when 1 then 1
                    when 2 then '2'
                    else 0 
        end grade
from employees; --error

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees; --case 조건문 가능

-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라
select last_name, hire_date, to_char(hire_date , 'fmday') day   
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4 
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end; 
-- 과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 후에 입사한 사원들에겐 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.
select last_name, hire_date, 
    case when hire_date <= '2005/12/31' then '100만원 상품권'
        else '10만원 상품권' end reward    
from employees;

