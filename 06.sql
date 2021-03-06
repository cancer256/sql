-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
select department_id, department_name, location_id, city
from departments natural join locations; --레코드 결합 natural join
-- 양쪽 테이블의 레코드를 살펴보고 공통칼럼을 찾는다
-- 키는 테이블내에서 유일한값을 가진다
-- 외부 테이블에서 복사되서 왔기때문에 foreign이라고 부른다. ex)location_id는 디파트먼트로 복사되서옴
-- 테이블 설계도를 아는 사람만 해당코드를 이해할수 있기때문에 범용성이 좋지않아 잘 안쓴다.

select department_id, department_name, location_id, city
from departments natural join locations --natural join 공통칼럼 둘다 사용
where department_id in(20, 50); --where로 조인의 후보를 골라낼수있다.
--장점 개발하기편하다, 단점 공통칼럼을 확인할수 없다.

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

select department_id, department_name, location_id, city
from departments natural join locations; -- using과 natural join의 차이

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400; -- 1400번 동네에 있는 부서를 파악
-- from 에도 별명을 붙이고 그 별명을 셀렉절에 쓸수 있다.

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- using 칼럼(location_id)에 접두사를 붙여서 error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; -- using칼럼(location_id)에는 접두사를 붙이지 못한다
-- using에 쓴 칼럼을 using칼럼 이라고함

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where manager_id = 100; --error manager이 애매하다고 에러

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100; -- manager에 접두사 d를 붙이니 출력됨
-- using 칼럼이 아닌 공용칼럼에는 접두사를 붙여야 에러가 안남!

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where e.manager_id = 100; -- manager에 접두사 e를 붙이니 출력됨
-------------------------------------------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- =equi join

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제] 위 문장을, using으로 refactorimg 하라.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149; -- on 조건문이 n개가 있다고 생각하여 and로 묶는다.

-- 과제] Toronto에 위치한 부서에서 일하는 사원들의 
--      이름, 직업, 부서번호, 부서명을  조회해라
select e.last_name ,e.job_id, e.department_id, d.department_name, city
from employees e join departments d
on e.department_id = d.department_id    
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join 이퀄열산자 다른걸 쓰면 non-equi join이다.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-------------------------------------

--self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error 접두사를 안쓰면 에러
-- 셀프조인에는 접두사를 써야한다.

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; --error 셀렉절에 접두사를 안써서 에러

-- 과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저입사일을 조회하라.
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and m.hire_date > e.hire_date;      
---------------------------------------

--inner join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--      king 사장도 테이블에 포함한다.
select w.last_name, w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
-------------------------------------------------

--구코드
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- (+) 여백이 있을부분을 표시한다 
--왼쪽에 (+) 했으니 오른쪽에 여백이 있다.

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);--오른쪽에 (+) 했으니 왼쪽에 여백이 있다.