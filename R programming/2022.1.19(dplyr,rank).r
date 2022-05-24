
[문제132]부서별로 최고 급여자들의 정보를 출력해주세요.
library(plyr)
employees <- read.csv('c:/data/employees.csv',header = T)

a <- plyr::ddply(employees,'DEPARTMENT_ID',transform,max_s=max(SALARY))
a[a$SALARY == a$max_s,][,-12]

plyr::ddply(employees,'DEPARTMENT_ID',subset,SALARY==max(SALARY))

a <- aggregate(SALARY~DEPARTMENT_ID,employees,max)
merge(a,employees,by=c('DEPARTMENT_ID','SALARY'))

[문제133]부서별로 가장 처음으로 입사한 사원 정보를 출력해주세요.


employees$HIRE_DATE <- as.Date(employees$HIRE_DATE,format='%Y-%d-%m')
a <- ddply(employees,'DEPARTMENT_ID',transform,min_e= min(HIRE_DATE))
a[a$HIRE_DATE==a$min_e,][,-12]

plyr::ddply(employees,'DEPARTMENT_ID',subset,HIRE_DATE==min(HIRE_DATE))

a <- aggregate(HIRE_DATE~DEPARTMENT_ID,employees,min)
merge(a,employees,by=c('HIRE_DATE','DEPARTMENT_ID'))


[문제134]자신의 부서 평균 급여 보다 더 많이 받는 사원들의 EMPLOYEE_ID,DEPARTMENT_ID,SALARY를 출력해주세요.

ddply(employees,'DEPARTMENT_ID',subset,SALARY > mean(SALARY))[,c('EMPLOYEE_ID','DEPARTMENT_ID','SALARY')]

dept_avg <- aggregate(SALARY~DEPARTMENT_ID,employees,mean)
names(dept_avg)[2] <- 'AVG_SAL'
dept_avg
df <- merge(employees,dept_avg)
df[df$SALARY > df$AVG_SAL,c('EMPLOYEE_ID','DEPARTMENT_ID','SALARY','AVG_SAL')]

df <- ddply(employees, 'DEPARTMENT_ID', transform,AVG_SAL = mean(SALARY))
df[df$SALARY > df$AVG_SAL,c('EMPLOYEE_ID','DEPARTMENT_ID','SALARY','AVG_SAL')]



#---------------------------------------------------------------

기존의 필터링
employees[employees$DEPARTMENT_ID == 20,]
subset(employees,DEPARTMENT_ID == 20)

★ dplyr 패키지 함수 사용
install.packages("dplyr")
library(dplyr)

dplyr::filter() : 조건에 해당하는 것을 필터링하는 함수

filter(employees,DEPARTMENT_ID==20)

dplyr::select() : 특정한 컬럼을 선택하는 함수

select(employees,EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID)
select(employees,1,4,7) #1,4,7번 컬럼 추출
select(employees,1:7) # 1번부터 7번까지 컬럼 추출
select(employees,-1,-4,-7) # 특정(1,4,7)컬럼 제외 추출
select(employees,-LAST_NAME,-FIRST_NAME) # LAST_NAME,-FRIST_NAME을 제외하고 추출

x <- subset(employees,SALARY>=10000,select=c(LAST_NAME,SALARY))
order(x$SALARY,decreasing = T)
x[order(x$SALARY),]
x[order(x$SALARY,decreasing=T),]

library(doBy)
doBy::orderBy(~SALARY,x)#오름차순
doBy::orderBy(~-SALARY,x) #내림차순
doBy::orderBy(~-SALARY+LAST_NAME,x)# SALARY내림차순정렬, LAST_NAME 오름차순정렬

dplyr::arrange() : 정렬
arrange(x,SALARY) # 오름차순정령
arrange(x,desc(SALARY)) # 내림차순정령
arrange(x,desc(SALARY),LAST_NAME) # SALARY내림차순정렬, LAST_NAME 오름차순정렬

#sql
select last_name, job_id, salary
from employees
where salary >= 10000
order by salary;

filter(employees,SALARY >= 10000)
select(employees,LAST_NAME,JOB_ID,SALARY)
arrange(employees,SALARY)

%>%(파이프) : 여러문장을 조합해서 사용하는 방법 연산자.(dplyr에서만 사용)

employees%>%
  filter(DEPARTMENT_ID==20)

employees%>% #데이터프레임
  select(LAST_NAME,JOB_ID,SALARY)%>% #조건1
  filter(SALARY>=10000)%>% #조건2
  arrange(desc(SALARY),LAST_NAME) #대상컬럼이 위에 없으면 오류 , 조건 3
  

# 컬럼추가
employees$ann_sal <- employees$SALARY * 12
head(employees) 

#컬럼 삭제
employees$ann_sal <- NULL
head(employees)

● dplyr::mutate : 새로운 컬럼을 추가하는 함수,미리보기

mutate(employees,ann_sal=SALARY*12) #미리보기
head(employees) #나오지 않음

df <- mutate(employees,ann_sal=SALARY*12)
head(df)

employees%>%
  select(LAST_NAME,SALARY,COMMISSION_PCT)%>%
  mutate(ann_sal=SALARY*12)%>%
  arrange(desc(ann_sal))

[문제135] employees 데이터 프레임을 새로운 df 이름으로 복제하세요.
df 데이터 프레임에  새로운 comm 컬럼을 생성하는데 COMMISSION_PCT 값을 기반으로 값을 입력하시고
결측값은 기존 COMMISSION_PCT의 평균 값으로 입력해주세요.(단 mutate함수를 이용하세요)

df <- employees
head(df)

df>%%
  mutate(comm=ifelse(is.na(COMMISSION_PCT),mean(COMMISSION_PCT,na.rm=T),COMMISSION_PCT))
       
df$comm <- ifelse(is.na(df$COMMISSION_PCT),mean(df$COMMISSION_PCT,na.rm=T),df$COMMISSION_PCT)
df
[문제136]30번 부서 사원들이면서 급여는 5000이상인 사원들의 employee_id, salary, department_id를 출력하세요.
(dplyr 패키지에 있는 함수를 이용하세요.)

employees%>%
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>% #select가 먼저돌아감
  filter(DEPARTMENT_ID ==30 & SALARY >= 5000)

employees%>%
  filter(DEPARTMENT_ID ==30 & SALARY >= 5000)%>% #filter가 먼저돌아감
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)
  
employees%>%
  filter(DEPARTMENT_ID ==30 & SALARY >= 5000)%>%
  select(EMPLOYEE_ID,DEPARTMENT_ID)

select employee_id, department_id
from employees
where salary >= 5000;

[문제137]30번 또는 50번 부서 사원들이면서 급여는 5000이상인 사원들의 employee_id, salary, department_id를 출력하세요.
(dplyr 패키지에 있는 함수를 이용하세요.)

employees%>%
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>%
  filter((DEPARTMENT_ID==30 |DEPARTMENT_ID==50) & SALARY >= 5000)

employees%>%
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>%
  filter(DEPARTMENT_ID %in% c(30,50) & SALARY >= 5000)

[문제138] COMMISSON_PCT가 NA인 사원들 중에 급여는 10000이상인 사원들의 정보를 출력해주세요.
(dplyr 패키지에 있는 함수를 이용하세요.)

employees%>%
  filter(is.na(COMMISSION_PCT), SALARY >= 10000)

[문제139] 월요일에 입사한 사원들의 LAST_NAME, SALARY,HIRE_DATE를 출력하세요. 입사한 날짜를 기준으로 오름차순 정렬하세요.
(dplyr 패키지에 있는 함수를 이용하세요.)

employees%>%
  select(LAST_NAME,SALARY,HIRE_DATE)%>%
  filter(format(HIRE_DATE,'%A')=='월요일')%>%
  arrange(HIRE_DATE)

library(lubridate)

employees%>%
  select(LAST_NAME,SALARY,HIRE_DATE)%>%
  filter(wday(HIRE_DATE,week_start=1,label=T)=='월')%>%
  arrange(HIRE_DATE)

#전체 집계값
data.frame(sum_sal = sum(employees$SALARY),
           mean_sal = mean(employees$SALARY))
plyr::summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))
dplyr::summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))

select department_id, sum(salary)
from employees
group by deparment_id;

aggregate(SALARY~DEPARTMENT_ID,employees,sum)
plyr::ddply(employees,'DEPARTMENT_ID',summarise,sum_sal=sum(SALARY))

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY))

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal=sum(SALARY)) # summarise 함수 사용시에 패키지이름을 지정하지 않으면 우선순위는  plyr::summarise가 수행된다.

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  plyr::summarise(sum_sal=sum(SALARY))  #원하는 값을 출력하지 못하고 전체집계값만나옴 

#sql
select department_id,job_id,sum(salary) sum_sal, avg(salary) avg_sal
from employees
group by department_id,job_id;

employees%>%
  dplyr::group_by(DEPARTMENT_ID,JOB_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY),avg_sal=mean(SALARY))

employees%>%
  dplyr::summarise(sum_sal=sum(SALARY),sum_comm=sum(COMMISSION_PCT,na.rm=T),
                   mean_sal=mean(SALARY),mean_comm=mean(COMMISSION_PCT,na.rm=T))

employees%>%
  dplyr::summarise_at(c('SALARY','COMMISSION_PCT'),c(sum,mean),na.rm=T)

# 로드된 패키지 확인
search()

# 로드된 패키지 해지
detach(package:plyr,unload=TRUE)
detach(package:dplyr,unload=TRUE)
search()

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal=sum(SALARY))
#plyr이 로드되어 있지 않으면, dply::summarise수행된다.
install.packages('plyr')
library(plyr)
library(dplyr)

summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))
dplyr::summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))
#dply 메모리에 로드가 되어 있지 않아도 내 컴퓨터에 dplyr패키지를 설치해 놓았으면 dplyr::summarise() 수행할 수 있다.

library(plyr)
library(dplyr)
search()

employees%>%
  dplyr::summarise_if(is.numeric,c(sum,mean),na.rm=T)

employees%>%
  dplyr::summarise_if(is.integer,c(sum,mean),na.rm=T)
str(employees)

employees%>%
  dplyr::summarise_if(is.character,c(max,min,NROW))

employees%>%
  dplyr::summarise_if(is.integer,c(max,min,length))

max(employees$FIRST_NAME) # 알파벳 순 가장 마지막
min(employees$FIRST_NAME) # 알파벳 순 제일 첫번째


detach(package:plyr,unload=TRUE)
detach(package:dplyr,unload=TRUE)
install.packages(dplyr)
library(dplyr)
library(plyr)
search()

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal=sum(SALARY))
#순서적으로 패키지를 로드 시킬때 가장 마지막에 로드시킨 패키지가 우선적으로 적용된다.

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY)) #패키지 이름 지정해주기

#select문을 수행하고 있는 user가 insa유저입니다
select ...
from hr.emp, scott.emp, hr.dept, scott.dept, emp # insa유저에서 emp테이블을 찾는다.
where ...;


[문제140] 부서별 급여의 총액을 구한 후 10000이하 정보만 출력해주세요.
#sql
select department_id, sum(salary)
from employees
group by department_id
having sum(salary) <= 10000;

(1) tapply

x <-tapply(employees$SALARY,employees$DEPARTMENT_ID,sum)
x <- data.frame(x)
names(x) <- 'SUM_SAL'
x
rownames(x)
x$DEPARTMENT_ID <- rownames(x)
x
rownames(x) <- NULL
x <- x[,c(2,1)]
x[x$SUM_SAL <= 10000,]

a <- tapply(employees$SALARY,employees$DEPARTMENT_ID,sum)
a <- data.frame(a)
names(a) <- 'SUM_SAL'
a
rownames(a)
a$DEPARTMENT_ID <- rownames(a)
a
rownames(a) <- NULL
a <- a[,c(2,1)]
a[a$SUM_SAL <= 10000,]

(2) aggregate
a <-aggregate(SALARY~DEPARTMENT_ID,employees,sum)
a[a$SALARY <= 10000,]

(3) plyr::ddply

x <- plyr::ddply(employees,'DEPARTMENT_ID',summarise,SUM_SAL=sum(SALARY))
na.omit(x[x$SUM_SAL <= 10000,])

(4) dplyr
employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(SUM_SAL=sum(SALARY))%>%
  dplyr::filter(SUM_SAL <= 10000)

employees%>%
  dplyr::select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>%
  dplyr::filter(!DEPARTMENT_ID %in% c(10,70))%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(SUM_SAL=sum(SALARY))%>%
  dplyr::filter(SUM_SAL <= 10000)

select department_id, sum(salary)
from employees
where department_id not in (10,70)
group by DEPARTMENT_ID
having sum(salary) <= 10000;

[문제141]부서별, 요일별 입사 인원수를 출력하세요.

(1) tapply
tapply(employees$EMPLOYEE_ID,
       list(employees$DEPARTMENT_ID,lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)),length,default=0)


(2) aggregate
1.
aggregate(EMPLOYEE_ID~DEPARTMENT_ID+format(HIRE_DATE,'%A'),employees,NROW)
2.
aggregate(EMPLOYEE_ID~DEPARTMENT_ID+lubridate::wday(employees$HIRE_DATE,week_start=1,label=T),employees,length)

(3) plyr::ddply
df1 <- format(employees$HIRE_DATE,'%A')
df <- employees
df$yoil <- df1 
plyr::ddply(df,c('DEPARTMENT_ID','yoil'),summarise,cnt=NROW(EMPLOYEE_ID))

#-------강사님 답
plyr::ddply(employees,c('DEPARTMENT_ID','lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)'),summarise,cnt=length(EMPLOYEE_ID))


(4) dplyr
options(tibble.print_max=Inf) #tibble의 행을 제한하지 않고 모두 출력하게 하는 옵션
options(tibble.print_max=10)

employees%>%
  dplyr::group_by(DEPARTMENT_ID,lubridate::wday(employees$HIRE_DATE,week_start=1,label=T))%>%
  dplyr::summarise(cnt=length(EMPLOYEE_ID))
#이따가 이걸 다시 교차로 보여지는 tapply처럼 보이게 해보기

#---------------------------------
★ rank

x <- c(85,80,90,70,60,80,NA)
x

sort(x)
sort(x,decreasing=F, na.last=NA) #오름차순 na값 미포함
sort(x,decreasing=T, na.last=NA) # 내림차순  na값 미포함
sort(x,decreasing=T, na.last=T) # 내림차순 na값 마지막에 포함
sort(x,decreasing=F, na.last=T) # 오름차순 na값 마지막에 포함
sort(x,decreasing=T, na.last=F) # 내림차순 na값 맨 처음에 포함
sort(x,decreasing=F, na.last=F) # 오름차순 na값 맨 처음에 포함

order(x) # 인덱스로 순서
x[order(x)] # 오름차순
x[order(x,decreasing=F,na.last = T)] # 기본값
x[order(x,decreasing=T,na.last = T)] # 내림차순

#오름차순 순위
x <- c(85,80,90,70,60,80,NA)
rank(x)
data.frame(x,rank(x))
data.frame(x,rank(x,na.last = T))
data.frame(x,rank(x,na.last = F))

data.frame(점수 = x,
           순위 = rank(x))

data.frame(점수 = x,
           순위 = rank(x,na.last = T,ties.method = 'average')) # 기본값, 같은 점수일 경우 평균을 구해서 순위를 나타냄

data.frame(점수 = x,
             순위 = rank(x,na.last = T,ties.method = 'first'))  # 같은 점수면 앞쪽에 있는 것이 우선 

data.frame(점수 = x,
             순위 = rank(x,na.last = T,ties.method = 'last')) # 같은 점수면 더 늦게 들어온 값(뒤쪽에 있는 것이) 우선

data.frame(점수 = x,
             순위 = rank(x,na.last = T,ties.method = 'random')) # 같은 점수면 랜덤하게 순위를 매겨줌줌

data.frame(점수 = x,
             순위 = rank(x,na.last = T,ties.method = 'max')) # 같은 점수면 동차의 최대값으로 통일

data.frame(점수 = x,
             순위 = rank(x,na.last = T,ties.method = 'min')) # 같은 점수면 동차의 최소값

data.frame(점수 = x,
             순위 = rank(x,na.last = 'keep',ties.method = 'min')) # na값은 일단 na로

data.frame(점수 = na.omit(x),
             순위 = rank(x,na.last = NA,ties.method = 'min')) # 행의 수 때문에 na는 제거하고 구하기

data.frame(점수 = x,
             순위_1 = rank(x,na.last = T,ties.method = 'min'),
             순위_2 = dplyr::min_rank(x), #dplyr패키지의 min_rank도 비슷하게 쓰임
             순위_3 = dplyr::dense_rank(x)) # dplyr::dense_rank(x) 연이은 순위 오름차순


# 내림차순 순위
data.frame(점수 = x,
             순위_1 = rank(-x,na.last = T,ties.method = 'min'), # '-'표시
             순위_2 = dplyr::min_rank(desc(x)),
             순위_3 = dplyr::dense_rank(desc(x))) # dplyr::dense_rank(desc(x)) 연이은 순위 내림차순


[문제142] 급여를 많이 받는 순으로 순위를 구한다음에 1등 에서 5위 까지 출력해주세요.
연이은 순위를 이용하세요.
1.
employees%>%
  dplyr::filter(dplyr::dense_rank(desc(employees$SALARY)) <=5)

employees%>%
  dplyr::mutate(rank=dplyr::dense_rank(desc(SALARY)))%>%
  dplyr::filter(rank<=5)

employees%>%
  dplyr::mutate(rank=dplyr::min_rank(desc(SALARY)))%>%
  dplyr::filter(rank<=5)

2.
employees$rank <- dplyr::dense_rank(desc(employees$SALARY))
employees[employees$rank <= 5,]
employees$rank <- NULL
head(employees)


[문제143]  ann_sal 새로운 컬럼을 생성하세요. 값은 commission_pct NA 면 salary * 12,
아니면 (salary * 12) + (salary * 12 * commission_pct) 입력한 후 ann_sal컬럼의 값에 내림차순 기준으로
10위까지 출력해주세요

employees$ann_sal <- ifelse(is.na(employees$COMMISSION_PCT),employees$SALARY*12,
       (employees$SALARY*12)+(employees$SALARY*12*employees$COMMISSION_PCT))

head(employees)

employees$rank <- dplyr::dense_rank(desc(employees$ann_sal))
employees[employees$rank <= 10,]


employees$min_rank <- dplyr::min_rank(desc(employees$ann_sal))
employees[employees$rank <= 10,]

#dense_rank랑 min_rank는 전혀다른 함수

employees$ann_sal <- NULL
employees$dense_rank <- NULL
employees$min_rank <- NULL

employees%>%
  dplyr::mutate(ann_sal = ifelse(is.na(COMMISSION_PCT),SALARY*12,
                                 (SALARY*12)+(SALARY*12*COMMISSION_PCT)),
                dense_rank=dplyr::dense_rank(desc(ann_sal)),
                min_rank=dplyr::min_rank(desc(ann_sal)))%>%
  dplyr::filter(dense_rank<=10)
