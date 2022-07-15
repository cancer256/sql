--datatype conversion
--Ÿ���� ��ȯ�� ���� > ����, ���� > ��¥, ��¥ > ����, ���� > ���� 4���� ���ĸ� �ִ�.
select hire_date
from employees
where hire_date = '2003/06/17'; -- ���ڰ� ��¥�� ��ȯ

select salary
from employees
where salary = '7000'; --���ڰ� ���ڷ� ��ȯ

select hire_date || '' --��¥�� ���ڷ� ��ȯ(���̱�� ����)
from employees;

select salary || '' --���ڰ� ���ڷ� ��ȯ(���̱�� ����)
from employees;
--------------------------------------

select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd') 
from dual; -- ��¥�� 'fm(form�� model)'���� ���� �������� �ٲ۴�

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual; --��¥ ��� ���� �˻�

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual; -- ''�ȿ� �� �ҹ��ڷ� ���� �ҹ��ڷ� ���´�.

select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- ����] �� ���̺��� �����Ϻ��� �������� �����϶�.
select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date - 1, 'd') d
from employees
order by d;

select to_char(sysdate, 'hh24:mi:ss am')
from dual; -- ���� �ú��� ��ȸ

select to_char(sysdate, 'DD "of" Month')
from dual; -- ""ū����ǥ ���� �͵� ���� ��°���

select to_char(hire_date, 'fmDD Month YY') --fill mode �˲� �����ؼ� ���
from employees;

--����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի����� 3���� �� ù��° �������̴�.
--      ��¥�� YYYY.MM.DD�� ǥ���Ѵ�
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date, 
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;



----------------------------------------------

select to_char(salary) --���ڷ� ��ȯ
from employees;

select to_char(salary, '$99,999.99'),
        to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst'; --99,999.99�� �����Ǽ��ڶ�¶� �Ҽ����ڴ� ���� ��� .00���� ǥ��
-- 0������ �տ� ���ڸ��� 0�� �����ִ�.

select '|' || to_char(12.12, '9999.999') || '|',
        '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
        '|' || to_char(12.12, 'fm0000.000') || '|'
from dual; --fill mode�� ������ ���ֹ���

select to_char(1237, 'L9999')
from dual;  -- L(local)������ ������ ǥ������

-- ����] <�̸�> earns <$����> monthly but wants <$,����x3>. �� ��ȸ�϶�.
select last_name || ' earns ' || to_char(salary, 'fm$99,999')
    || ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') 
    || '.'
from employees;

-----------------------------------------

select last_name, hire_date --��¥�� ��ȯ
from employees
where hire_date = to_date('sep 21, 2005', 'Mon dd, yyyy'); -- to_date ���� ������ ��Ŀ� ���� �ڿ� ���������.

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'fxMon  dd yy'); --Format eXtract(��Ȯ�ϰ� Ȯ���ϴ°�)
---------------------------------------------

select to_number('1237') --���ڷ� ��ȯ
from dual;

select to_number('1,237.12')
from dual; --error ,�� ���־� ����

select to_number('1,237.12', '9,999.99')
from dual; -- �ڿ� , '9,999.99'��� ������ ���� ���ٰ� ����� ��
------------------------------------------------

-- null�ڡ�

select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees; --null���� ��� 0���� �����. �ϳ��� Į���̹Ƿ� �˻簪�� �⺻���� Ÿ���� ���ƾ��Ѵ�.
--����Ⱦ�� Į���� �ϳ��� �������� �����ִ�.

-- ����] ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, 
    salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

--����] ������� �̸�, Ŀ�̼��� ��ȸ�϶�
--  Ŀ�̼��� ������, no commission�� ����Ѵ�.
select last_name, nvl(to_char(commission_pct), 'No Commission') commission
    from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees; --null���� �ƴϸ� SAL+COMM���� �ް� null�̸� SAL���� �޴´�
--'SAL+COMM', 'SAL' �� 2���ǰ��� ���Ͻ��Ѿ��Ѵ�.

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name, 
nullif(length(first_name), length(last_name))
from employees; --nullif �ΰ� �Ķ���� ���� ������ null�� ����
-- null�� �����ϰų� ù��° �Ķ������ �۽�Ʈ������ �����Ѵ�.

select to_char(null), to_number(null), to_date(null)
from dual; --�� ������ null���� ���� ���ϰ��� null�̴�.

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
    from employees; --ó������ null�� �ƴ� ���� �����Ѵ�.
-- Ŀ�̼��� �ΰ��̸� �Ŵ������̵� �����ϰ� Ŀ�̼��� ���� ������ Ŀ�̼��� �����Ѵ�.
-- �Ѵ� null�̸� �������� None�� ����

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
where department_id = 80;  --(trunc(salary / 2000)�� ������ 0�� �񱳰� 0.00�� ���ϰ�

select decode(salary, 'a', 1)
from employees; --�⺻���� ���̱� ������ ��ġ�ϴ°��̾��� ��� ���� ���

select decode(salary, 'a', 1, 0)
from employees; --�⺻���� 0�̱� ������ ��ġ�ϴ°��� ���� ��� 0�� ���
--'a'�� �������� ���߱� ���� ���ڸ� ���ڷ� �����ߴ��� �˼�����

select decode(job_id, 1, 1)
from employees; --error job_id�� 1�� Ÿ���� �޶� ����

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; -- ���̾� ����Ʈ�� ���ڷ� �ٲٷ��ٰ� �����ؼ� ����

-- ����] ������� ����, ������ ����� ��ȸ�϶�
--      IT_PROG     A
--      AD_PERS     B
--      ST_MAN      C
--      ST_CLERK    D                  
select job_id, decode(job_id,
    'IT_PROG',    'A',
    'AD_PRES',    'B',
    'ST_MAN',     'C',
    'ST_CLEKR',   'D') grade -- ���ڿ��� ''�ٿ����Ѵ�.
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees; --���̽��� �����ؼ� ��������� �ϳ��� Į��

select case job_id when '1' then 1
                    when '2' then 2
                    else 0 
        end grade
from employees;  --���ذ��� �񱳰� Ÿ�Ե� �����ؾ��ϰ� then ������ ���ϰ��� Ÿ���� �����ؾ���

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees;

select case job_id when '1' then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees; --���ذ��� �񱳰��� Ÿ���̴޶� ����

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
from employees; --case ���ǹ� ����

-- ����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�
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
-- ����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�Ǳݾ��� ��ȸ�϶�.
select last_name, hire_date, 
    case when hire_date <= '2005/12/31' then '100���� ��ǰ��'
        else '10���� ��ǰ��' end reward    
from employees;

