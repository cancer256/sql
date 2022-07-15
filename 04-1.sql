--datatype conversion
--타입의 변환은 문자 > 숫자, 문자 > 날짜, 날짜 > 문자, 숫자 > 문자 4가지 형식만 있다.

select hire_date
from employees
where hire_date = '2003/06/17';

select salary
from employees
where salary = '7000'; --문자가 숫자로 변환

select hire_date || ''
from employees; --날짜가 문자로 변환(붙이기로 인해)

select salary || '' 
from employees; -- 숫자가 문자로 변환(붙이기로 인해)
------------------------------------------

select to_char(hire_date)
from emolyees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual; -- 날짜를 'fm(form의 model)'안의 문자 형식으로 바꾼다.

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

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
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month YY')
from employees;

--과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD로 표시한다
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,  
    to_char(next_day(add_months(hire_date, 3), 2), 'YYYY.MM.DD') review_date
from employees;

---------------------------------------------------

select to_char(salary) --문자로 변환
from employees;

select to_char(salary, '$99,999.99'),
        to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst'; --99,999.99는 임의의숫자라는뜻 소수점뒤는 수가 없어도 .00으로 표시된다.
-- 0을쓰면 앞에 빈자리도 0이 남아있다.

select '|' || to_char(12.12, '9999.999') || '|',
        '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
        '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999')
from dual;

-- 과제] <이름> earns <$월급> monthly but wants <$,월급x3>. 로 조회하라.
select last_name || 'earns' || to_char(salary, 'fm$99,999') 
    || 'monthly but wants' || to_char(salary * 3, 'fm99,999') || '.'
from employees;
--------------------------------------------------------

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'fxMon dd yy');
-------------------------------------------

select to_number('1237')
from dual; -- 숫자로 변환

select to_number('1,237.12')
from dual; --error ,가 들어가 있어 에러

select to_number('1,237.12', '9,999.99')
from dual;  --위와달리 뒤에, '9,999.99'라는 임의의 수가 들어간다고 해줘야 참
-------------------------------------------------

-- null

select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;  --null값은 모두 0으로 만든다. 하나의 칼럼이므로 검사값과 기본값의 타입이 같아야한다.
--세로횡인 칼럼은 하나의 유형으로 묶여있다.

-- 과제] 사원들이 이름, 직업, 연봉을 조회하라.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 annu_sal
from employees
order by annu_sal desc;

--과제] 사원들의 이름, 커미션을 조회하라
--  커미션이 없으면, no commission을 출력한다
select last_name, nvl(to_char(commission_pct), 'no commission')
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name,
nullif(length(first_name), length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
----------------------------------------------

select last_name, salary,
    decode(trunc(salary / 2000),
    0, 0.00,
    1, 0.09,
    2, 0.20,
    3, 0.30,
    4, 0.40,
    5, 0.43,
    6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1)
from employees;

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; --error

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees;

-- 과제] 사원들의 직업, 직업별 등급을 조회하라
--      IT_PROG     A
--      AD_PERS     B
--      ST_MAN      C
--      ST_CLERK    D     
select job_id, decode(job_id,
    'IT_PROG',     'A',
    'AD_PRES',     'B',
    'ST_MAN',      'C',
    'ST_CLERK',     'D') grade
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select case job_id when '1' then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;
                    
select case job_id when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees;

select case job_id when 1 then 1
                    when 2 then '2'
                    else 0
        end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

--  과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라
select last_name, hire_date, to_char(hire_date, 'day'),
    case to_char(hire_date, 'fmday')
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end Day
from employees
order by Day;

-- 과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 후에 입사한 사원들에겐 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.
select last_name, hire_date, 
    case when hire_date <= '2005/12.31' then '100만원 상품권'
        when hire_date > '2005/12/31' then '10만원 상품권'
    end reward
from employees;