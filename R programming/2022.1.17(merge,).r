#[문제103] 분산을 구하는 variance 함수를 생성하세요.



합((개별관측값 - 평균)^2)
------------------------
          n-1

순서
1)합
2)평균
3)편차


1. 함수 없이          
variance <- function(...){
  x <- na.omit(c(...)) #결측값 빼고 X변수에 매개변수 초기화
  y <- 0 # 평균을 구하기 위한 합을 저장하는 변수
  avg <- 0 # 평균을 구할 함수
  sum_a <- 0 # 합((개별관측값 - 평균)^2 값을 넣을 변수
  for(i in x){ # x값의 합
    y <- y + i
  }
  avg <- y/length(x) # x값의 평균
  
  for(i in x){ # 합((개별관측값 - 평균)^2)
    sum_a <- sum_a + (i - avg)^2
  }
  return(sum_a/(length(x)-1)) # 분산한 값을 리턴
  
}
variance(1:5)

2. 함수 사용
variance <- function(...){
  x <- na.omit(c(...))
  return(sum((x - mean(x))^2)/(length(x)-1))
  
}

1. 함수 없이(length 없이)          
variance <- function(...){
  x <- na.omit(c(...)) #결측값 빼고 X변수에 매개변수 초기화
  y <- 0 # 평균을 구하기 위한 합을 저장하는 변수
  v_cnt <- 0
  avg <- 0 # 평균을 구할 함수
  sum_a <- 0 # 합((개별관측값 - 평균)^2 값을 넣을 변수
  for(i in x){ # x값의 합
    y <- y + i
    v_cnt <- v_cnt + 1
  }
  avg <- y/v_cnt # x값의 평균
  
  for(i in x){ # 합((개별관측값 - 평균)^2)
    sum_a <- sum_a + (i - avg)^2
  }
  return(sum_a/(v_cnt-1)) # 분산한 값을 리턴
  
}
variance(1:5)
sqrt(variance(1:5)) #표준편차
var(c(1,2,3,4,5,NA),na.rm=T)
sd(c(1,2,3,4,5,NA),na.rm=T)

[문제104]사원 번호를 입력 값으로 받아서 사원의 LAST_NAME, SALARY를 출력하는 
find 함수를 생성하세요.
employees <- read.csv('c:/data/employees.csv',header = T)


find(100)
LAST_NAME SALARY
King  24000

find(300)
"사원이 존재하지 않습니다."
employees <- read.csv('c:/data/employees.csv',header = T)

find <- function(x){
  df <- employees[employees$EMPLOYEE_ID == x, c('LAST_NAME','SALARY')]
  if(nrow(df)==1){
    print(df)
  } else{
    print('사원이 존재하지 않습니다.')
  }
}
find(100)
find(300)

'employees' %in% ls()
rm(list=ls())
ls
'employees' %in% ls()

find <- function(arg){
  if(arg==100){
    #NULL #아무것도 안하겠다
    return() # 아무것도 안하겠다. 값이 없는 retrun()은 NULL을 리턴한다.
  }else{
    if(!'employees' %in% ls()){
      employees <- read.csv("c:/data/employees.csv",header = T)
    }
    df <- employees[employees$EMPLOYEE_ID == arg, c('LAST_NAME','SALARY')]
    if(nrow(df)==1){
      print(df)
    } else{
      print('사원이 존재하지 않습니다.')
    } 
  }
  
}
find(100)

find <- function(arg){
  if(arg==100){
    print('오늘 하루도 행복하자') # 수행됨
    stop('조회할 수 없다.') # 오류를 유발시키는 함수
    print('오늘 하루도 행복하자') # 수행되지 않는다. 의미없이 코드 작업한 것
  }else{
    if(!'employees' %in% ls()){
      employees <- read.csv("c:/data/employees.csv",header = T)
    }
    df <- employees[employees$EMPLOYEE_ID == arg, c('LAST_NAME','SALARY')]
    if(nrow(df)==1){
      print(df)
    } else{
      print('사원이 존재하지 않습니다.')
    } 
  }
  
}
find(100)
find(101)
find(300)

find <- function(arg){
  if(arg==100){
    warning('조회할 수 없다.') # warning은 프로그램은 수행하면서 마지막에 경고를 출력하는 기능
    print('오늘 하루도 행복하자') # 수행됨
    print('내일도 행복하자') # 수행됨
  }else{
    if(!'employees' %in% ls()){
      employees <- read.csv("c:/data/employees.csv",header = T)
    }
    df <- employees[employees$EMPLOYEE_ID == arg, c('LAST_NAME','SALARY')]
    if(nrow(df)==1){
      print(df)
    } else{
      print('사원이 존재하지 않습니다.')
    } 
  }
  
}
find(100)
find(101)
find(300)

x1 <- data.frame(id=c(100,200,300),sql=c(70,80,90))
x2 <- data.frame(id=c(100,200,300),r=c(85,90,60))
x1
x2
rbind(x1,x2) # 서로 다른 데이터프레임을 행으로 합치려면 컬럼이름이 동일해야한다.
cbind(x1,x2) # 서로 다른 데이터프레임을 열로 합치려면 행의 수가 동일해야한다.

★ merge(join)
두 데이터프레임의 공통된 값을 기준으로 병합(조인) 한다.

#sql에서 equi join, simple join, 등가조인
select x1.*, x2.*
from x1,x2
where x1.id = x2.id;

select x1.*, x2.*
from x1 join x2
on x1.id = x2.id;

select x1.*, x2.*
from x1 natural join x2;

merge(x1,x2) # sql의 natural조인과 똑같다. 서로 다른 데이터프레임의 동일한 컬럼을 기반으로 조인한다.
# 만약에 동일한 컬럼이름이 없을 경우 카티시안 곱이 발생한다.

select x1.*, x2.*
  from x1 join x2
using(id);

merge(x1,x2,by='id') # by='id' 동일한 컬럼이 여러개 있을 경우 특정한 컬럼을 기반으로 조인하는 방법


x1 <- data.frame(id=c(100,200,300),sql=c(70,80,90), p=c(1,2,3))
x2 <- data.frame(no=c(100,200,300,400,500),r=c(85,90,60,10,20), j=c(5,6,7,8,9))

select x1.*, x2.*
  from x1,x2
where x1.id = x2.no;

select x1.*, x2.*
  from x1 join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no') # x1 -> by.x, x2 -> by.y
merge(x2,x1,by.x='no',by.y='id') # x1자리랑 x2자리를 x축과 y축에 잘 맞춰야 실행됨

x1
x2

#sql left outer join
select x1.*, x2.*
  from x1,x2
where x1.id = x2.no(+);

select x1.*, x2.*
  from x1 left outer join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no', all.x=TRUE) 
# all.x=TRUE 키값이 일치하는 데이터 다 출력하고 일치하지 않는 x축 데이터를 출력(left outer join)

#sql right outer join
select x1.*, x2.*
  from x1,x2
where x1.id(+) = x2.no;

select x1.*, x2.*
  from x1 right outer join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no', all.y=TRUE) 
# all.x=TRUE 키값이 일치하는 데이터 다 출력하고 일치하지 않는 y축 데이터를 출력(right outer join)

#sql full outer join
select x1.*, x2.*
  from x1,x2
where x1.id(+) = x2.no;
union
select x1.*, x2.*
  from x1,x2
where x1.id = x2.no(+);

select x1.*, x2.*
  from x1 full outer join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no', all.y=TRUE, all.x=TRUE) 
# all.x=TRUE 키값이 일치하는 데이터 다 출력하고 일치하지 않는 x축, y축 데이터를 출력(full outer join)


[문제105]20번 부서에 소속되어 있는 사원들의
LAST_NAME,SALARY, JOB_ID, DEPARTMENT_NAME을 출력해주세요.
departments <- read.csv("c:/data/departments.csv",header = T)
str(departments)
str(employees)

x1 <- employees[employees$DEPARTMENT_ID==20,c('LAST_NAME','SALARY','JOB_ID','DEPARTMENT_ID')]
x2 <- departments[departments$DEPARTMENT_ID==20,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2)[,-1]

[문제106] 급여가 3000 이상이고 JOB_ID가 ST_CLERK인 사원들의 employee_id, salary, job_id, department_name을 출력해주세요

x <- employees[employees$SALARY >= 3000 & employees$JOB_ID %in% 'ST_CLERK', c('EMPLOYEE_ID','SALARY','JOB_ID','DEPARTMENT_ID')]
merge(x,departments)[,c('EMPLOYEE_ID','SALARY','JOB_ID','DEPARTMENT_NAME')]

[문제107] commission_pct에 NA인 사원들의
LAST_NAME, SALARY, DEPARTMENT_ID,DEPARTMENT_NAME을 출력해주세요.

x1 <- employees[is.na(employees$COMMISSION_PCT), c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2, by='DEPARTMENT_ID')

merge(x1,departments)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[문제108] commission_pct에 NA가 아닌 사원들의
LAST_NAME, SALARY, DEPARTMENT_ID,DEPARTMENT_NAME을 출력해주세요.

x1 <- employees[!is.na(employees$COMMISSION_PCT), c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2, by='DEPARTMENT_ID')

merge(x1,departments)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[문제109] commission_pct에 NA가 아닌 사원들의
LAST_NAME, SALARY, DEPARTMENT_ID,DEPARTMENT_NAME을 출력해주세요. 단 부서가 없는 사원도 출력해주세요.

x1 <- employees[!is.na(employees$COMMISSION_PCT), c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2, by='DEPARTMENT_ID', all.x=T)

merge(x1,departments,all.x=T)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[문제110] 사원의 last_name, 관리자 last_name을 출력해주세요.

x1 <- employees[,c('MANAGER_ID','LAST_NAME')]
x2 <- employees[,c('EMPLOYEE_ID','LAST_NAME')]
merge(x1,x2, by.x='MANAGER_ID',by.y = 'EMPLOYEE_ID')[,c('LAST_NAME.x','LAST_NAME.y')]

#sql
select w.last_name, m.last_name
from employees w, employees m
where w.manager_id = m.employee_id;


[문제111] 사원의 last_name, 관리자 last_name을 출력해주세요. 관리자가 없는 사원도 출력해주세요.

x1 <- employees[,c('MANAGER_ID','LAST_NAME')] #sql에서 inline view
x2 <- employees[,c('EMPLOYEE_ID','LAST_NAME')] #sql에서 inline view
df <- merge(x1,x2, by.x='MANAGER_ID',by.y = 'EMPLOYEE_ID', all.x = T)[,c('LAST_NAME.x','LAST_NAME.y')]
names(df) <- c('사원이름','관리자이름')
head(df)
#sql
select w.last_name, m.last_name
from employees w, employees m
where w.manager_id = m.employee_id(+);

select w.last_name, m.last_name
from employees w left outer join employees m
on w.manager_id = m.employee_id;

[문제112] 부서이름별 총액 급여를 출력하세요.

x1 <- employees[,c('SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_NAME','DEPARTMENT_ID')]
df <- merge(x1,x2)[,c('DEPARTMENT_NAME','SALARY')]
df
aggregate(SALARY ~ DEPARTMENT_NAME,df,sum)

x <- aggregate(SALARY~DEPARTMENT_ID,employees,sum)
merge(x,departments)[,c('DEPARTMENT_NAME','SALARY')]
t <- tapply(employees$SALARY,employees$DEPARTMENT_ID,sum)
t
class(t)
df <- data.frame(t)
df$dept_id <- rownames(df)
rownames(df) <- NULL
df
merge(df,departments,by.x='dept_id',by.y='DEPARTMENT_ID')[,c('DEPARTMENT_NAME','t')]

[문제113] 부서이름,직업별 급여의 총액을 구하세요.
x1 <- employees[,c('SALARY','DEPARTMENT_ID','JOB_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
df <- merge(x1,x2)[,c('DEPARTMENT_NAME','JOB_ID','SALARY')]
df
aggregate(SALARY ~ DEPARTMENT_NAME+JOB_ID,df,sum)

x <- aggregate(SALARY~DEPARTMENT_ID+JOB_ID,employees,sum)
merge(x,departments)[,c('DEPARTMENT_NAME','JOB_ID','SALARY')]


[문제114] 최고 급여를 받는 사원의 이름, 급여, 부서코드, 부서이름를 출력하세요.

x1 <- employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
df <- merge(x1,x2)
df
max(df$SALARY)
df[df$SALARY == max(df$SALARY),]

x <- employees[employees$SALARY == max(employees$SALARY),c('LAST_NAME','SALARY','DEPARTMENT_ID')]
merge(x,departments)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[문제115] 사원들의 급여 등급을 출력해주세요. last_name, salary, grade_level
job_grades <- read.csv("c:/data/job_grades.csv",header=T)

level <- NULL
for(i in employees$SALARY){
  level <- c(level,job_grades[i >= job_grades$LOWEST_SAL & i <= job_grades$HIGHEST_SAL,'GRADE_LEVEL'])
}
level
data.frame(name = employees$LAST_NAME,
           sal = employees$SALARY,
           level=level)

[문제 116] 사원들의 사번 , 부서 이름을 출력해주세요. (merge함수 이용하지 말고 for문을 생성해주세요.)

data.frame(사번 = employees$EMPLOYEE_ID,
             부서이름 = 변수)
#merge(join) = 반복문 수행되고 있다.

employees$DEPARTMENT_ID

dept_name <- NULL
for(i in employees$DEPARTMENT_ID){
  if(is.na(i)){
    dept_name <- c(dept_name,NA)
  }else{
  dept_name <- c(dept_name,departments[departments$DEPARTMENT_ID == i,'DEPARTMENT_NAME'])
  }
}
dept_name

data.frame(사번 = employees$EMPLOYEE_ID,
             부서이름 = dept_name)
employees[employees$EMPLOYEE_ID==178,]

