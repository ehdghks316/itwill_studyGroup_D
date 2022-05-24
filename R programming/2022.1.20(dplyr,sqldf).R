
[문제144] 부서별 급여를 기준으로 내림차순 순위를 구하세요.(연이은순위)
library(dplyr)
employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(rank=dplyr::dense_rank(desc(SALARY)), SALARY=SALARY)

library(plyr)
plyr::ddply(employees,'DEPARTMENT_ID',transform,dplyr::dense_rank(desc(SALARY)))


#-----------------강사님 답
df <- plyr::ddply(employees[,c('EMPLOYEE_ID','LAST_NAME','SALARY','DEPARTMENT_ID')],'DEPARTMENT_ID',transform,
            순위=dplyr::dense_rank(desc(SALARY)),
            순위2=dplyr::min_rank(desc(SALARY)))
library(doBy)
doBy::orderBy(~DEPARTMENT_ID+순위,df)

options(tibble.print_max=Inf)
employees%>%
  dplyr::select(EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID)%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::mutate(순위=dplyr::dense_rank(desc(SALARY)),
                순위2=dplyr::min_rank(desc(SALARY)))%>%
  dplyr::arrange(DEPARTMENT_ID,순위)

#sql
select employee_id,last_name, salary, department_id,
       rank() over(partition by department_id order by salary desc) 순위2,
       dense_rank() over(partition by department_id order by salary desc)순위
from employees
order by 4,6;
  
[문제145] JOB_ID별 급여를 많이 받는 사원 1등만 추출해 주세요.
employees%>%
  dplyr::group_by(JOB_ID)%>%
  dplyr::filter(SALARY ==max(SALARY))

ddply(employees,'JOB_ID',subset,SALARY==max(SALARY))

aggregate(SALARY~JOB_ID,employees,max)

#----------------강사님답
plyr::ddply(employees[,c('EMPLOYEE_ID','LAST_NAME','SALARY','JOB_ID')],'JOB_ID',
                  subset,SALARY==max(SALARY))

plyr::ddply(employees[,c('EMPLOYEE_ID','LAST_NAME','SALARY','JOB_ID')],'JOB_ID',
            subset,dplyr::dense_rank(desc(SALARY))==1)

df <- plyr::ddply(employees[,c('EMPLOYEE_ID','LAST_NAME','SALARY','JOB_ID')],'JOB_ID',transform,
            순위=dplyr::dense_rank(desc(SALARY)))
df[df$순위==1,]

employees%>%
  dplyr::select(EMPLOYEE_ID,LAST_NAME,SALARY,JOB_ID)%>%
  dplyr::group_by(JOB_ID)%>%
  dplyr::filter(dplyr::dense_rank(desc(SALARY))==1)

employees%>%
  dplyr::select(EMPLOYEE_ID,LAST_NAME,SALARY,JOB_ID)%>%
  dplyr::group_by(JOB_ID)%>%
  dplyr::mutate(순위=dplyr::dense_rank(desc(SALARY)))%>%
  dplyr::filter(순위==1)

#---------------------------------------------------------

employees%>%
  dplyr::summarise(n()) #데이터프레임에 있는 행의 개수

employees%>%
  dplyr::filter(DEPARTMENT_ID==50)%>%
  dplyr::summarise(n()) #50번부서인 사원의 수

employees%>%
  dplyr::count() # 데이터프레임의 행의 수

employees%>%
  dplyr::filter(DEPARTMENT_ID==50)%>%
  dplyr::count() 

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(n())# 부서아이디별로 개수

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::count() # 부서아이디별로 개수

employees%>%
  dplyr::count(DEPARTMENT_ID)# 부서아이디별로 개수

employees%>%
  dplyr::count(DEPARTMENT_ID,JOB_ID) #DEPARTMENT_ID, JOB_ID별로 개수

employees%>%
  dplyr::count(DEPARTMENT_ID,JOB_ID, sort = T) #DEPARTMENT_ID, JOB_ID별로 개수, 정렬까지(내림차순)

employees%>%
  dplyr::add_count(DEPARTMENT_ID) #행단위로 DEPARTMENT_ID별로 개수 출력

employees%>%
  dplyr::group_by(DEPARTMENT_ID,JOB_ID)%>%
  dplyr::summarise(n())

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(부서인원수 = n(),
                   부서내JOB_ID수 = n_distinct(JOB_ID)) # 한 부서에 몇명의 인원과 job_id가 몇개인지

departments <- read.csv('c:/data/departments.csv',header = T)
emp <- employees[,c('EMPLOYEE_ID','LAST_NAME','DEPARTMENT_ID')]
dept <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]

# 등가조인, equi join, inner join, simple join
merge(emp,dept,by='DEPARTMENT_ID') #1. emp,dept데이터프레임을 DEPARTMENT_ID로 조인하기
dplyr::inner_join(emp,dept,by='DEPARTMENT_ID') #2. emp,dept데이터프레임을 DEPARTMENT_ID로 조인하기

#left outer join
merge(emp,dept,by='DEPARTMENT_ID',all.x = T)  #left outer join, 키값에 일치하지 않는 x축에 있는 데이터 다 출력
dplyr::left_join(emp,dept,by='DEPARTMENT_ID') #left outer join, 키값에 일치하지 않는 x축에 있는 데이터 다 출력

#right outer join
merge(emp,dept,by='DEPARTMENT_ID',all.y = T)  #right outer join, 키값에 일치하지 않는 y축에 있는 데이터 다 출력
dplyr::right_join(emp,dept,by='DEPARTMENT_ID') #right outer join, 키값에 일치하지 않는 y축에 있는 데이터 다 출력

#full outer join
merge(emp,dept,by='DEPARTMENT_ID',all = T)  #full outer join, 키값에 일치하지 않는 x,y축에 있는 데이터 다 출력
dplyr::full_join(emp,dept,by='DEPARTMENT_ID') #full outer join, 키값에 일치하지 않는 x,y축에 있는 데이터 다 출력

소속 사원이 있는 부서 정보를 출력해주세요.
#sql
(1) in
select * 
from departments
where department_id in (select department_id
                        from employees)
#문제점 where department_id in (null,10,20,20,20,30,30......) 
#where department_id =null
# or department_id = 10
# ... 107개를 다 비교함, distinct를 사용하면 내부적으로 sort(oracle server에서)를 하기 때문에 그것도 문제임

select * 
  from departments
where department_id in (select distinct department_id # 현장에서 사용하실 때 주의 !! 내부적으로 정렬작업이 발생, 데이터가 적으면 괜찮 벗 많으면 하루종일 걸림
                        from employees)

(2)inner join으로 해결하겠다 하는 순간 현장에서 문제가 발생한다.
1쪽 집합으로 만들기 위해서 중복을 제거하는 작업을 수행하는 순간 정렬을 수행해야 하는 문제점 발생
select d.*
  from (select distinct department_id
        from employees) e, departments d
where e.department_id = d.department_id    

(3) exists를 사용하면 semi기법이 들어간다.
select *
from departments d
where exists (select 'x'
              from employees
              where department_id = d.department_id)
#semi join 기법 - department_id가 d.department_id와 맞으면 더이상 찾지 않고 다음 것으로 간다(oracle에서는 위에 in으로 사용해도 exists로 변경해서 수행함)

#R
(1)in(sql에서 in연산자를 r로 표현)
departments[departments$DEPARTMENT_ID %in% employees$DEPARTMENT_ID,]
departments[departments$DEPARTMENT_ID %in% unique(employees$DEPARTMENT_ID),]

(2) inner join
dplyr::inner_join(departments,employees,by='DEPARTMENT_ID')

employees$DEPARTMENT_ID를 1쪽 집합처럼 나들어서 수행하려면
unique(employees$DEPARTMENT_ID)를 수행해서 하면 된다. 하지만 문제점은 유일한 값을 만들기 위해서 내부적으로 정렬 작업을 수행해야한다는 문제점.

dplyr::inner_join(departments,
                  data.frame(DEPARTMENT_ID = unique(employees$DEPARTMENT_ID)),by='DEPARTMENT_ID')
이런 문제점을 개선해서 성능이 좋아지도록 하는 방법이 semi join 기법이다.

(3)semi join (sql에서 exists연산자)
departments%>%
  dplyr::semi_join(employees,by='DEPARTMENT_ID')


소속사원이 없는 부서 정보를 출력해주세요.
# sql
(1) anti join
select *
from departments d
where not exists (select 'x'
              from employees
              where department_id = d.department_id) #내부적으로 anti join 기번이 수행된다.
                    10                          10
                    20                          20
                    20                          30
                    30                          ..
                    30
                    30          

#R
(1) anti join
departments%>%
  dplyr::anti_join(employees,by='DEPARTMENT_ID')

employees$DEPARTMENT_ID   departments$DEPARTMENT_ID
10                          10
20                          20
20                          30
30                          ..
30
30

⊙관리자 사원들의 정보를 출력하세요.
str(employees)
●sql
(1) in
select * 
  from employees e
where employee_id in (select manager_id
                      from employees
                      where manager_id = e.employee_id);
(2) exists
select * 
from employees e
where exists(select *
             from employees
             where manager_id = e.employee_id);

#R
(1) in
employees[employees$EMPLOYEE_ID %in% employees$MANAGER_ID,]

(2) semi_join
employees%>%
  dplyr::semi_join(employees,by=c('EMPLOYEE_ID'='MANAGER_ID'))


⊙관리자가 아닌 사원들의 정보를 출력하세요.
str(employees)
●sql
(1) in
select * 
  from employees e
where employee_id not in (select manager_id
                      from employees
                      where manager_id is not null); #not in은 null값이 있으면 수행이 안됨 
(2) exists
select * 
  from employees e
where not exists(select *
                 from employees
                 where manager_id = e.employee_id);

#R
(1) in
employees[!employees$EMPLOYEE_ID %in% employees$MANAGER_ID,]

(2) semi_join
employees%>%
  dplyr::anti_join(employees,by=c('EMPLOYEE_ID'='MANAGER_ID'))


#----------------------------------------------
★ sqldf
- sql을 이용해서 데이터를 처리

install.packages("sqldf")
library(sqldf)

employees[,c('EMPLOYEE_ID','LAST_NAME')]
sqldf("select * from employees")
sqldf("select employee_id, last_name from employees")
sqldf("SELECT EMPLOYEE_ID, LAST_nAME, FROM employees") # 테이블명만큼은 데이터프레임 이름과 동일하게 대소문자 구분한다.
sqldf("select distinct department_id from employees")
unique(employees$DEPARTMENT_ID)

sqldf("
select * 
  from employees e
where employee_id not in (select manager_id
                      from employees
                      where manager_id is not null)")

sqldf("select * 
  from employees e
where not exists(select *
                   from employees
                 where manager_id = e.employee_id)")

sqldf("select employee_id, last_name, salary*12
      from employees
      order by salary * 12")

sqldf("select employee_id, last_name, salary*12 ann_sal
      from employees
      order by salary * 12")

sqldf("select employee_id, last_name, salary*12 ann_sal
      from employees
      order by ann_sal desc")

sqldf("select employee_id, last_name, salary*12 ann_sal
      from employees
      order by 3 desc")

sqldf("select last_name,upper(last_name), lower(last_Name)
      from employees")

sqldf("select last_name,upper(last_name), lower(last_Name),
              upper(substr(last_name,1,1)) || lower(substr(last_name,2)) as 'inicap'
      from employees") #별칭넣을 때 안에 큰따옴표면 별칭은 작은 따옴표, 작은따옴표면 큰따옴표로 표현

sqldf("select last_name, length(last_Name),
      substr(last_name,1,2), leftstr(last_name,2), substr(last_name,-2,2),rightstr(last_name,2),
      reverse(last_name)
      from employees") # 왼쪽의 두글자만 뽑기, 오른쪽 2글자 뽑기, reverse 반대로 뽑기

sqldf("select 1+2") # 테이블이 없는 표현식을 만들 때 from 절 없이 표현(mysql) 

sqldf("select round(45.926), round(45.926,0), round(45.926,1),round(45.926,2),
round(45.926,-1), round(45.926,-3)") # 반올림함수에서 -(sql에서 10의 자리, 100의 자리..)는 의미가 없다

sqldf("select ceil(45.926),floor(45.926)")

sqldf("select * from employees where department_id = 10")
sqldf("select * from employees where department_id is null")
sqldf("select * from employees where department_id is not null")

sqldf("select * from employees where department_id = 10 or department_id = 20")
sqldf("select * from employees where department_id in (10,20)")

sqldf('select *
      from employees
      where salary >= 10000 and salary <= 20000')

sqldf('select *
      from employees
      where salary between 10000 and  20000')

sqldf('select *
      from employees
      where salary not between 10000 and  20000')

sqldf("select *
      from employees
      where last_name like 'K%'")

sqldf("select *
      from employees
      where last_name not like 'K%'")

sqldf("select *
      from employees
      where last_name like '_i%'")


sqldf("select e.last_name,d.department_name
      from employees e, departments d
      where e.department_id = d.department_id")

sqldf("select e.last_name,d.department_name
      from employees e join departments d
      on e.department_id = d.department_id")

sqldf("select e.last_name,d.department_name
      from employees e, departments d
      using(department_id)")

sqldf("select e.last_name,d.department_name
      from employees e natural join departments d")
# =
sqldf("select e.last_name,d.department_name
      from employees e join departments d
      on e.department_id = d.department_id
      and e.manager_id = d.manager_id")

sqldf("select e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id")

sqldf("select e.last_name,d.department_name
      from employees e right outer join departments d
      on e.department_id = d.department_id") # right outer join기능은 없다. 테이블의 위치만 바꾸면 되기 때문인듯하다

sqldf("select e.last_name,d.department_name
      from employees e full outer join departments d
      on e.department_id = d.department_id") # full outer join 기능도 없다. 

sqldf("select e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      union
      select e.last_name,d.department_name
      from departments d left outer join employees e
      on e.department_id = d.department_id") # 동명이인은 안나오는 문제

sqldf("select e.employee_id, e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      union
      select e.employee_id, e.last_name,d.department_name
      from departments d left outer join employees e
      on e.department_id = d.department_id") # 동명이인이 있을 수 있으니 이렇게 사용

sqldf("select e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      union all
      select e.last_name,d.department_name
      from departments d left outer join employees e
      on e.department_id = d.department_id")

union  -> union all not exists

rm(list=ls())
ls()
employees <- read.csv('c:/data/employees.csv',header = T)
departments <- read.csv('c:/data/departments.csv',header = T)

sqldf("select e.employee_id, e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      union all
      select NULL,NULL, department_name
      from departments d
      where not exists (select 'x'
                        from employees
                        where department_id = d.department_id)")

sqldf("select e.employee_id,e.last_name,d.department_Name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      union all
      select NULL,NULL,department_name
      from departments d
      where not exists (select 'x'
                        from employees
                        where department_id = d.department_id)")

sqldf("select department_name
      from departments d
      where not exists (select 'x'
                        from employees
                        where department_id = d.department_id)")


# intersect 교집합 연산자
sqldf("select e.employee_id,e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      intersect
      select e.employee_id,e.last_name,d.department_name
      from departments d left outer join employees e
      on e.department_id = d.department_id")

# except 차집합 연산자
sqldf("select e.employee_id,e.last_name,d.department_name
      from employees e left outer join departments d
      on e.department_id = d.department_id
      except
      select e.employee_id,e.last_name,d.department_name
      from departments d left outer join employees e
      on e.department_id = d.department_id") 

sqldf("select sum(salary), avg(salary),min(salary),max(salary), variance(salary) 분산 ,stdev(salary) 표준편차
       from employees")

sqldf("select department_id, sum(salary)
      from employees
      group by department_id
      having sum(salary) >= 10000
      order by 2 desc")

자신의 부서 평균 급여보다 더 많이 받는 사원들의 정보를 출력해주세요.
sqldf("select e2.*
      from (select department_id, avg(salary) avg_sal
            from employees
            group by department_id) e1, employees e2
      where e1.department_id = e2.department_id
      and e2.salary > e1.avg_sal")

sqldf("select last_name, salary,
              case
                when salary < 5000 then 'low'
                when salary < 10000 then 'medium'
                when salary < 20000 then 'good'
                else 'excellent'
              end qualified_salary
      from employees")

nvl2(commission_pct,(salary*12)+(salary*12*commission_pcy),salary * 12)

sqldf("select last_name, salary , commission_pct,
        case
          when commission_pct is null then salary * 12
          else
            (salary * 12) + (salary * 12 * commission_pct)
        end ann_sal
      from employees")

sqldf("select last_name, salary, rank() over(order by salary desc)
      from employees")

sqldf("select last_name, salary, dense_rank() over(order by salary desc)
      from employees")

[문제146]fruits_sales.csv file 읽어 들인 후 과일 이름별 판매량, 판매합계를 구하세요.(sqldf를 이용하세요)
sales <- read.csv('c:/data/fruits_sales.csv',header = T)
sales
sqldf("select name, sum(qty),sum(price)
      from sales
      group by name")

[문제147]fruits_sales.csv file 읽어 들인 후 년도별로 판매량 중에 가장 많은 판매를 한 년도를 출력해주세요.(sqldf를 이용하세요)
모르겠다.

x <- plyr::ddply(sales,'year',summarise,qty=sum(qty))
x[x$qty == max(x$qty),'year']

sales%>%
  dplyr::group_by(year)%>%
  dplyr::summarise(sum_qty=sum(qty))%>%
  dplyr::filter(sum_qty == max(sum_qty))%>%
  dplyr::select(year)

sqldf("select year
      from sales
      group by year
      having sum(qty) = (select max(sumqty)
                        from(select sum(qty) sumqty
                              from sales
                              group by year))")

# sql에서는 되는데 r에서는 안되는 풀이
sqldf("select year, sum(qty) qt
             from sales
             group by year
             having sum(qty) = (select max(sum(qty))
                                from sales
                                group by year)")
sqldf("select max(sum(qty)) # sql에서는 가능한데 r에서는 불가능한듯하다. sqldeveloper에서는 실행 됨
      from sales
      group by year")


[문제148]부서별 급여를 기준으로 내림차순 순위를 구하세요.(연이은 순위).(sqldf를 이용하세요)
sqldf("select last_name, department_id, salary, dense_rank() over(partition by department_id order by salary desc) 순위
      from employees
      order by 3,4")

[문제149]부서별 최소 급여자들의 정보를 출력해주세요. (sqldf를 이용하세요)
sqldf("select *
        from employees e2
      where (department_id, salary) in (select department_id, min(salary) over(partition by department_id) 
      from employees)")

sqldf("select *
      from (select employee_id, last_name, salary, department_id,
                  min(salary) over(partition by department_id) min_sal,
                  case when salary = min(salary) over(partition by department_id) then 1 end case_min
            from employees)
      where case_min = 1")

sqldf("select *
      from (select *,
              dense_rank() over(partition by department_id order by salary) 순위
            from employees)
      where 순위 = 1")
sqldf("select *
      from (select employee_id, last_name, salary, department_id,
            dense_rank() over(partition by department_id order by salary) rank_s
            from employees) e
      where e.rank_s = 1")
[문제150]JOB_ID별 급여를 많이 받는 사원 1등만 추출해 주세요.(sqldf를 이용하세요)
sqldf("select * 
      from employees
      where (employee_id,salary) in (select employee_id, max(salary) over(partition by job_id)
                              from employees)")

sqldf("select *
      from (select last_name, salary, job_id,
              dense_rank() over(partition by department_id order by salary desc) 순위
            from employees)
      where 순위 = 1")

[문제151]동일한 날짜에 입사한 사원들의 정보를 출력해주세요.(sqldf를 이용하세요)

# 본인을 제외하고 나머지 hire_date랑 같은 사원들의 정보 출력

sqldf("select *
      from employees e
      where exists(select 'x'
                  from employees
                  where hire_date = e.hire_date
                  and employee_id != e.employee_id)
      order by 6")

#R로 풀어보기(머리 좀 써보자)

employees[,c('EMPLOYEE_ID','HIRE_DATE')][1,][1]
employees[,c('EMPLOYEE_ID','HIRE_DATE')][1,][2]
employees[employees$EMPLOYEE_ID != as.integer(employees[,c('EMPLOYEE_ID','HIRE_DATE')][104,][1]) &
employees$HIRE_DATE == as.character(employees[,c('EMPLOYEE_ID','HIRE_DATE')][104,][2]),]

employees$EMPLOYEE_ID == 203

df <- data.frame()
for(i in 1 : nrow(employees)){
  new <- employees[employees$EMPLOYEE_ID != as.integer(employees[,c('EMPLOYEE_ID','HIRE_DATE')][i,][1]) &
              employees$HIRE_DATE == as.character(employees[,c('EMPLOYEE_ID','HIRE_DATE')][i,][2]),]
  df <- rbind(df,new) # 숙제 중복성 없이 df 데이터프레임에 데이터를 입력하세요. 
}
unique(df)

