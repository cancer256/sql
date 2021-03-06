-- group function
-- 파라미터에 null이 들어오면 무시한다.

select avg(salary), max(salary), min(salary), sum(salary)
from employees; --avg 평균 max최대값 min최소값 sum합친값
--싱글펑션은 파라미터 개수가 1. 그룹펑션은 파라미터 개수가 n
-- 싱글펑션과의 공통점은 리턴값은 하나라는 점이다.

select min(hire_date), max(hire_date)
from employees; -- 이때의 min은 가장빠른날 max는 가장최근

-- 과제] 최고 월급과 최소월급의 차이를 구해라
select max(salary) - min(salary)
from employees;
-----------------------------------------
select count(*)
from employees; -- 개수를 파악한다. *은 모든칼럼을 뜻한다.

-- 과제] 70번 부서원이 몇명인지 조회하라
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;-- 그룹함수에서 파라미터 밸류가 널이면 무시한다.
-- 매니저아이디값중 king은 널이기 때문에 제외된 106출력
--널값도 다세고 싶으면 count(*)하던가 count(프라이머리 키)하면 됨.

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 구하라
select avg(nvl(commission_pct, 0))
from employees;
-------------------------------------------------

select avg(salary)
from employees;

select avg(distinct salary)
from employees; -- distinct는 중복을 제거한다.

select avg(all salary)
from employees; --all 모든 함수 앞에는 all이 숨김처리 되어있으며 모든이라는 뜻

-- 과제] 직원이 배치된 부서 개수를 조회하라
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;
------------------------------------------

select department_id, count(employee_id)
from employees
group by department_id --부서번호가 같은애들도 묶는다.
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id 
order by department_id; -- 그룹바이에있는 펑션이 셀렉트에 등장할 수 있다.
-- job_id는 레이블의 역할을 할수있는 녀석이 아니다. 싱글펑션은 레이블역할을 할수있는데 잡아이디는 아니다.
-- count(employee_id)는 카운터의 리턴값을 셀렉트에 쓴거다.
--셀렉트절에 칼럼은 레이블역하는 싱글펑션과 그룹펑션을 쓸 수 있다.

-- 과제] 직업별 사원수를 조회하라
select job_id, count(employee_id)
from employees
group by job_id
order by job_id;
------------------------------------

select department_id, max(salary)
from employees
group by department_id
having department_id > 50; -- having 그룹을 골라낸다

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000; --월급이 10000넘는 애들을 보겠다.

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- having에서는 별명 못씀

select department_id, max(salary)
from employees
where department_id > 50
group by department_id; --having 썼을때와 결과는 동일 
--해빙은 그룹을 만들고 나서 그룹을 골라냄  웨얼을 레코드를 먼저 골라내고 그룹을 만든다

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; --error 
--조건문에 그룹펑션이 있으면 해빙을 쓴다.

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

-- 과제] 매니저별 관리 직원들 중 최소월급을 조회하라.
--      최소월급이 $6,000초과여야 한다.
select manager_id, min(salary)
from employees
where manager_id is not null -- 나는 not like 'null'로 했음. 문제는없음  
group by manager_id
having min(salary) > 6000
order by 2 desc; --확인요망
-----------------------------------------------


select max(avg(salary))
from employees
group by department_id;

select sum(max(avg(salary)))
from employees
group by department_id; --error 3차 이상으로 들어가니 받아들일수 없다. 2개까지만 가능

select department_id, round(avg(salary))
from employees
group by department_id; --avg함수의 n개의 레코드가 들어갔고 그 하나하나에 대해서 round를 실행해서 리턴

select department_id, round(avg(salary))
from employees; --error 싱글하고 그룹을 같이사용할땐 group by가 필요함

select department_id, avg(round(salary))
from employees; -- error

-- 과제] 2001년, 2002년, 2003년도별 입사자 수를 찾는다.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
    from employees;
    
-- 과제] 직업별, 부서별 월급합을 조회하라.
--      부서는 20, 50, 80이다.
select job_id, sum(case when department_id like '20' then salary else null end) "20",
    sum(case when department_id like '50' then salary else null end) "50",
    sum(case when department_id like '80' then salary else null end) "80"
from employees
group by job_id;

select job_id, sum(decode(department_id, 20, salary)) "20",
        sum(decode(department_id, 50, salary)) "50",
        sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;