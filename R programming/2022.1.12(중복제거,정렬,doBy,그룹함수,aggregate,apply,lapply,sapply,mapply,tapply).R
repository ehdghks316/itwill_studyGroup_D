[문제55] 아래화면과 같이 날짜, 시간 정보를 출력해주세요
"2022년 1월 12일 09시 36분 55초"
#일반
format(Sys.time(),'%Y년 %m월 %d일 %H시 %M분 %S초')

#lubridate
library(lubridate)
paste(lubridate::year(lubridate::now()), '년 ',
lubridate::month(lubridate::now()), '월 ',
lubridate::day(lubridate::now()), '일 ',
lubridate::hour(lubridate::now()), '시 ',
lubridate::minute(lubridate::now()), '분 ',
as.integer(lubridate::second(lubridate::now())), '초 ',sep='')

#lubridate2
format(lubridate::now(),'%Y년 %B %d일 %H시%M분%S초')


[문제56] 홀수달에 입사한 사원들중에 짝수일에 입사한 사원들의 정보를 출력해주세요.
# str(employees)
# employees$HIRE_DATE <- as.Date(employees$HIRE_DATE,format='%Y-%m-%d') #날짜가 CHAR형으로 되어있을 때 날짜형으로 변경
# 날짜사용할 때 연도 4자리로 FORMAT을 맞춰놓고 진행하는 것이 좋다

#일반
employees[as.integer(format(employees$HIRE_DATE,'%m'))%%2==1 & 
          as.integer(format(employees$HIRE_DATE,'%d'))%%2==0,]
#lubridate
employees[(lubridate::month(employees$HIRE_DATE)%%2)==1 &
(lubridate::day(employees$HIRE_DATE)%%2)==0, ]

[문제57] 2005년도에 짝수달에 입사한 사원들 중에 월요일에 입사한 정보를 출력해주세요.
#일반
employees[format(employees$HIRE_DATE,'%Y') == '2005' &
          as.integer(format(employees$HIRE_DATE,'%m'))%%2==0 &
          format(employees$HIRE_DATE,'%A')=='월요일',]

#lubridate
employees[lubridate::year(employees$HIRE_DATE) == 2005 &
          lubridate::month(employees$HIRE_DATE)%%2==0 &
          lubridate::wday(employees$HIRE_DATE,week_start = 1, label = T)=='월',]

[문제58] 1분기에 입사한 사원들중에 수요일에 입사한 사원들의 정보를 출력해주세요.
#일반
employees[base::quarters(employees$HIRE_DATE)=='Q1' &
          format(employees$HIRE_DATE,'%A')=='수요일',]

#lubridate
employees[lubridate::quarter(employees$HIRE_DATE) == 1 &
          lubridate::wday(employees$HIRE_DATE, week_start = 1, label = T) =='수',]

★ 중복제거
unique(employees$JOB_ID)
na.omit(unique(employees$DEPARTMENT_ID))
as.integer(na.omit(unique(employees$DEPARTMENT_ID)))

★ 정렬(sort)
x <- c(6,9,2,3,5,4,7,1,8)
sort(x) #기본값은 오름차순
sort(x,decreasing = F) # 오름차순
sort(x,decreasing = T) # 내림차순

x <- c(6,9,2,3,NA,5,4,7,NA,1,NA,8)
sort(x) # 오름차순, NA출력 안 한다.
sort(x,decreasing = F, na.last = NA) # 기본값, 오름차순, NA출력X
sort(x,decreasing = F, na.last = T) # 마지막에 NA 출력
sort(x,decreasing = F, na.last = F) # 앞에 NA 출력
sort(x,decreasing = T, na.last = T) # 마지막에 NA 출력, 내림차순
sort(x,decreasing = T, na.last = F) # 앞에 NA 출력, 내림차순

★ rev
- 역순 출력
x <- c(6,9,2,3,5,4,7,1,8,NA)
rev(x)
x[length(x):1]
rev(na.omit(x))

★order
- 정렬의 인덱스번호를 반환하는 함수
x <- c(60,90,20,30,50,40,70,10,80)
sort(x)
order(x)
x[order(x)]

sort(x,decreasing = T)
order(x,decreasing = T)

x <- c(60,90,20,30,50,40,NA,70,NA,10,80)
sort(x,decreasing = T)
x[order(x,decreasing = T)]
order(x,decreasing = T, na.last = T) #기본값
order(x,decreasing = T, na.last = F) 

[문제59] 사원들의 LAST_NAME, SALARY를 출력해주세요.
단  SALARY를 기준으로  내림차순으로 정렬해주세요.

employees[order(employees$SALARY,decreasing = T), c('LAST_NAME','SALARY')]
# 데이터프레임에서 정렬할 때는 order를 사용 sort는 x

★ doBy 
- 데이터프레임에서 정렬

install.packages("doBy")
library(doBy)

#sql
select last_name, salary
from employees
order by salary desc;

? orderBy
orderBy(~SALARY,employees[,c('LAST_NAME','SALARY')]) # ~포뮬러(formula)형식 
orderBy(~DEPARTMENT_ID,employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')])  # 오름차순
orderBy(~-DEPARTMENT_ID,employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')])  # 내림차순
orderBy(~-SALARY,employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')])  # 내림차순

#sql
select last_name, salary
from employees
order by department_id,salary;

orderBy(~DEPARTMENT_ID+SALARY,employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')])  # 여러개를 정렬할 때 '+'부호 사용


#sql
select last_name, salary
from employees
order by department_id,salary desc;

orderBy(~DEPARTMENT_ID-SALARY,employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')]) #department_id는 오름차순 salary는 내림차순으로 정렬


#sql
select last_name, salary
from employees
order by department_id desc,salary desc;

orderBy(~-DEPARTMENT_ID-SALARY,employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')]) #department_id는 내림차순 salary는 내림차순으로 정렬


[문제60] last_name, hire_date를  출력하는데 먼저 입사한 사원부터 출력하세요.
#1orderBy(doBy)
orderBy(~HIRE_DATE,employees[,c('LAST_NAME','HIRE_DATE')])
#2기본
employees[order(employees$HIRE_DATE,decreasing=F),c('LAST_NAME','HIRE_DATE')]

[문제61] 아래화면과 같이 사원들의 정보를 출력해주세요. 

사번              이름     입사일 입사요일
104       Ernst Bruce 2007-05-21       월
123    Vollman Shanta 2005-10-10       월
133      Mallin Jason 2004-06-14       월
137     Ladwig Renske 2003-07-14       월
...

y <- lubridate::wday(employees$HIRE_DATE,week_start=1,label=T) # 1~7 월 1~ 일7, 
is.factor(y)
is.ordered(y)
x <- data.frame(사번 = employees$EMPLOYEE_ID,
                이름 = paste(employees$FIRST_NAME,employees$LAST_NAME),
                입사일 = employees$HIRE_DATE,
                입사요일 = lubridate::wday(employees$HIRE_DATE,week_start=1,label=T))

x
orderBy(~입사요일, x)

df <- data.frame(사번 =employees$EMPLOYEE_ID,
           이름 = paste(employees$LAST_NAME, employees$FIRST_NAME),
           입사일 = employees$HIRE_DATE,
           입사요일 = format(employees$HIRE_DATE, '%a'), # format을 이용할 때는 따로 순서가 필요하다.
           입사요일1 = format(employees$HIRE_DATE, '%u'))
df
orderBy(~입사요일1,df)[,-5]

#sql
select employee_id, last_name ||first_name,hire_date,to_char(hire_date,'day')
from employees
order by to_char(hire_date-1,'d')


[문제62] 30번 부서 사원들의 last_name, salary를  출력하세요.
단 salary를 기준으로 내림차순정렬하세요.

na.omit(employees[order(employees$SALARY, decreasing = T) & employees$DEPARTMENT_ID == 30,c('LAST_NAME','SALARY')])

employees[employees$DEPARTMENT_ID ==30,c('LAST_NAME','SALARY')]
employees[employees$DEPARTMENT_ID %in% 30,c('LAST_NAME','SALARY')]
x <- na.omit(employees[employees$DEPARTMENT_ID ==30,c('LAST_NAME','SALARY')])
x[order(x$SALARY),]

orderBy(~-SALARY,x)

[문제63] job_id가  ST_CLERK 가 아닌 사원들의 last_name, salary, job_id를 출력하는데 급여가 높은 사원부터 출력되게하세요.

X <- employees[employees$JOB_ID != 'ST_CLERK',c('LAST_NAME','SALARY','JOB_ID')]
x[order(x$SALARY, decreasing = T),]
orderBy(~-SALARY,x)

[문제64] 사원 last_name, salary, commission_pct를 출력하는데 commission_pct를 기준으로 오름차순정렬하세요.

employees[order(employees$COMMISSION_PCT),c('LAST_NAME','SALARY','COMMISSION_PCT')]

orderBy(~COMMISSION_PCT, employees[,c('LAST_NAME','SALARY','COMMISSION_PCT')])

[문제65] commission_pct를 받고 있는 사원들의 last_name, salary, commission_pct를 출력하는데 commission_pct를 기준으로 오름차순정렬하세요.(na가 아닌)

x <- employees[!is.na(employees$COMMISSION_PCT),c('LAST_NAME','SALARY','COMMISSION_PCT')]
x[order(x$COMMISSION_PCT),]

orderBy(~COMMISSION_PCT,x)

★ 그룹함수
x <- c(70,80,90,100)
sum(x) #합
mean(x) #평균
var(x) #분산
sd(x) # 표준편차
max(x) # 최대값
min(x) # 최소값
length(x) # 갯수 , 데이터프레임에서는 컬럼의 수
NROW(x) #행의 수
nrow(x) #벡터에서는 수행 x 데이터프레임에서 행의 수

x <- c(70,80,90,100,NA)
sum(x)
mean(x)

sum(na.omit(x))
sum(x,na.rm=T) # na.rm=T NA제거, NA.RM=F 기본값
mean(na.omit(x))
mean(x,na.rm=T)
var(x,na.rm=T)
sd(x,na.rm=T)
max(x,na.rm=T)
min(x,na.rm=T)
length(x)
NROW(x)
length(na.omit(x))
NROW(na.omit(x))

SELECT count(*) FROM employees # null 포함한 행의 수
SELECT count(commission_pct) FROM employees; #  null 제외한 행의 수

[문제66] 직업이 ST_CLERK 인 사원들중에 최대급여를 출력하세요.

max(employees[employees$JOB_ID == 'ST_CLERK',c('SALARY')])
max(employees[employees$JOB_ID == 'ST_CLERK','SALARY'])

[문제67] 최소 급여를 받는 사원들의 정보를 출력해주세요.

employees[employees$SALARY ==min(employees$SALARY),]

#sql
SELECT depatment_id, sum(salary)
FROM employees
GROUP BY department_id;

★ aggregate
- 데이터를 분할하고 각 그룹으로 묶은 후 그룹함수를 적용하는 함수

aggregate(SALARY ~ DEPARTMENT_ID, employees,sum)
aggregate(SALARY ~ JOB_ID, employees, mean)

[문제68] JOB_ID별 인원수를 출력해주세요

aggregate(EMPLOYEE_ID ~ JOB_ID, employees,NROW) # length도 NROW 대체 가능

[문제69] DEPARTMENT_ID별 평균급여를 구한후 평균급여가 8000이상인 정보만 출력해주세요.

#SQL
SELECT department_id, avg(salary)
from employees
group by department_id
having avg(salary)>= 8000;

x <- aggregate(SALARY ~ DEPARTMENT_ID, employees, mean)
orderBy(~DEPARTMENT_ID, x[x$SALARY >= 8000,])

[문제70] 년도별 총액급여를 구하세요.
#SQL
select to_char(hire_date,'yyyy'), sum(salary)
from employees
group by to_char(hire_date, 'yyyy');

#R
aggregate(SALARY ~ lubridate::year(HIRE_DATE), employees, sum)
class(x)
names(x) <- c('년도','총액') # 컬럼 이름 바꾸기
x

x <- aggregate(SALARY ~ format(employees$HIRE_DATE,'%Y'),employees, sum)
class(x)
names(x) <- c('년도','총액') # 컬럼 이름 바꾸기
x

[문제71] 요일별 총액급여를 구하세요.
x<-aggregate(SALARY ~ lubridate::wday(HIRE_DATE,week_start = 1, label = T),employees,sum)

x <- aggregate(SALARY ~ format(employees$HIRE_DATE,'%A'),employees, sum)
class(x)
names(x) <- c('요일','총액') # 컬럼 이름 바꾸기
x

x <- aggregate(SALARY ~ format(employees$HIRE_DATE,'%a'),employees, sum)
class(x)
names(x) <- c('요일','총액') # 컬럼 이름 바꾸기
x
x <- aggregate(SALARY ~ format(employees$HIRE_DATE,'%u'),employees, sum)
class(x)
names(x) <- c('요일','총액') # 컬럼 이름 바꾸기
x

class(x$요일)
lubridate::wday(employees$HIRE_DATE, week_start = 1)
lubridate::wday(employees$HIRE_DATE, week_start = 1, label = T)

x$요일 <- factor(x$요일, levels=c(1,2,3,4,5,6,7),labels=c('월','화','수','목','금','토','일'))
x

df <- data.frame(id = 100:104,
           weight = c(60,90,74,95,65),
           size = c('small','large','medium','large','small'))
df
str(df) # size를 chr에서 factor로 바꾸고 싶다
df$size <- factor(df$size, levels=c('small','medium','large'))
df
str(df)

df$size <- factor(df$size, levels=c('small','medium','large'), labels=c('작다','중간','크다'))
df
str(df)

#----------------------------

★ apply
- 함수를 반복수행
- 행렬, 배열, 데이터프레임에 함수를 적용한 결과 벡터, 리스트, 배열 형태로 리턴하는 함수

m <- matrix(1:4, ncol=2)
m
sum(m[1,]) # 1행의 합
sum(m[2,]) # 2행의 합
sum(m[,1]) # 1열의 합
sum(m[,2]) # 2열의 합

apply(m,MARGIN = 1, sum) # MARGIN = 1 행 방향
apply(m,MARGIN = 2, sum) # MARGIN = 2 열 방향

df <- data.frame(name = c('king','smith','scott'),
           sql = c(90,NA,70),
           r = c(80,70,NA))
df
sum(df$sql,na.rm=T)
sum(df$r,na.rm=T)

apply(df[,c('sql','r')],MARGIN = 2, sum, na.rm=T) # 열의 합, na.rm=T NA제외
apply(df[,c('sql','r')],MARGIN = 1, sum, na.rm=T) # 행의 합
rowSums(df[,c('sql','r')])
rowSums(df[,c('sql','r')],na.rm=T) # 행의 합, na.rm=T NA제외
colSums(df[,c('sql','r')])
colSums(df[,c('sql','r')],na.rm=T) # 열열의 합, na.rm=T NA제외

★ lapply
- 벡터, 리스트, 데이터프레임에 함수를 적용하고 그 결과를 리스트로 반환하는 함수

x <- list(a=1:3,b=4:10,c=11:21)
x
length(x) # 방이 몇개인지
length(x$a) #방에 값이 몇개인지
length(x$b)
length(x$c)

lapply(x,length) #각 방들의 값의 개수

sum(x) #오류
sum(x$a) # x리스트의 a방에 값들을 모두 더한 값 출력
sum(x$b)
sum(x$c)

lapply(x,sum) #각각의 방들에 대한 합계를 구하기
lapply(x,mean) #각각의 방들에 대한 평균를 구하기
lapply(x,var) #각각의 방들에 대한 분산를 구하기
lapply(x,sd) #각각의 방들에 대한 표준편차를 구하기
lapply(x,max) #각각의 방들에 대한 최대값을 구하기
lapply(x,min) #각각의 방들에 대한 최소값을 구하기

df <- data.frame(name = c('king','smith','scott'),
                 sql = c(90,80,70),
                 r = c(80,70,60))
df

apply(df[,c(2,3)],MARGIN=2,sum) # 열의 합
apply(df[,c(2,3)],2,sum) # 열의 합
colSums(df[,c(2,3)]) # 열의 합
lapply(df[,c('sql','r')],sum) # 리스트 형식으로 출력
lapply(df[,c(2,3)],sum) # 리스트 형식으로 출력
df <- data.frame(name = c('king','smith','scott'),
                 sql = c(90,NA,70),
                 r = c(80,70,NA))
df

apply(df[,c(2,3)],MARGIN=2,sum,na.rm=T) # 열의 합
apply(df[,c(2,3)],2,sum,na.rm=T) # 열의 합
colSums(df[,c(2,3)]) # 열의 합
lapply(df[,c(2,3)],sum,na.rm=T) # 리스트 형식으로 열의 합 출력

★ sapply
- 벡터, 리스트, 데이터프레임에 함수를 적용하고 그 결과를 벡터로 반환하는 함수

x <- list(a=1:3,b=4:10,c=11:21)
x

lapply(x,length)
unlist(lapply(x,length))
sapply(x,length)

df <- data.frame(name = c('king','smith','scott'),
                 sql = c(90,80,70),
                 r = c(80,70,60))
df

apply(df[,c(2,3)],MARGIN=2,sum) # 열의 합
apply(df[,c(2,3)],2,sum) # 열의 합
colSums(df[,c(2,3)]) # 열의 합
lapply(df[,c(2,3)],sum) # 리스트 형식으로 출력
sapply(df[,c(2,3)],sum)

df <- data.frame(name = c('king','smith','scott'),
                 sql = c(90,NA,70),
                 r = c(80,70,NA))
df

apply(df[,c(2,3)],MARGIN=2,sum) # 열의 합
apply(df[,c(2,3)],MARGIN=2,sum,na.rm=T) # 열의 합
apply(df[,c(2,3)],2,sum,na.rm=T) # 열의 합
colSums(df[,c(2,3)],na.rm=T) # 열의 합
lapply(df[,c(2,3)],sum,na.rm=T) # 리스트 형식으로 열의 합 출력
sapply(df[,c(2,3)],sum,na.rm=T)

★ mapply
- 다수의 인수값을 입력하여 함수를 반복 수행해서 리스트 형으로 리턴하는 함수 

rep(1,5)
rep(2,4)
rep(3,3)
rep(4,2)
rep(5,1)

mapply(rep,1:5,5:1)

★ tapply
- 벡터, 데이터프레임에 저장된 데이터를 주어진 기준에 따라 그룹을 묶은 뒤 그룹함수를 적용하고
그 결과를 array(가로형식)형식으로 리턴하는 함수

aggregate(SALARY ~ DEPARTMENT_ID, employees, sum) # 세로형식
tapply(employees$SALARY, employees$DEPARTMENT_ID, sum) # 가로 형식
class(tapply(employees$SALARY, employees$DEPARTMENT_ID, sum)) # array형식(vector x)

aggregate(SALARY ~ DEPARTMENT_ID+JOB_ID, employees, sum) # 두개(DEPARTMENT_ID,JOB_ID) 이상 그룹핑할 때
orderBy(~DEPARTMENT_ID, aggregate(SALARY ~ DEPARTMENT_ID+JOB_ID, employees, sum))
tapply(employees$SALARY, list(employees$DEPARTMENT_ID,employees$JOB_ID), sum) #행은 DEPARTMENT_ID 열은 JOB_ID로 출력
tapply(employees$SALARY, list(employees$JOB_ID,employees$DEPARTMENT_ID), sum) # 반대
tapply(employees$SALARY, list(employees$JOB_ID,employees$DEPARTMENT_ID), sum, default=0) # default=0은 NA값을 다른 값으로 설정

