[문제117] locations테이블을 locations.csv 파일로 export한 후 loc 변수로 로드하세요.
Toronto 지역에 근무하는 사원들의 LAST_NAME,SALARY,DEPARTMENT_ID,DEPARTMENT_NAME,STREET_ADDRESS 정보를 출력하세요.
loc <- read.csv('c:/data/locations.csv',header = T) # locations.csv파일 불러와서 loc변수에 저장
employees <- read.csv('c:/data/employees.csv',header=T)
departments <- read.csv('c:/data/departments.csv',header = T)

a <- emp[,c('LAST_NAME','SALARY','DEPARTMENT_ID')] # emp데이터프레임에서 last_name,salary,department_id컬럼만 가져와서 a변수에 저장
loc1 <- loc[loc$CITY == 'Toronto',] # 미리 조건을 구하기, loc데이터프레임의 city컬럼에 Toronto와 같은 값을 가지는 데이터의 전체행을 loc1에 변수에 저장
b <- merge(merge(a,dep),loc1)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME','STREET_ADDRESS')]
# merge함수를 2중으로 사용하여 3개의 데이터프레임을 조인하고 출력할 컬럼들만 가져와서 b변수에 저장
b
loc <- read.csv('c:/data/locations.csv',header=T)# 익스포트 받을 때 한 필드에 공백문자나 컴마가 있으면 큰따옴표로 구분하기
str(loc)
loc
loc[loc$LOCATION_ID ==2500,'POSTAL_CODE'] # 익스포트 받을 때 한 필드에 공백문자나 컴마가 있으면 큰따옴표로 구분하기

employees <- read.csv('c:/data/employees.csv',header = T)
departments <- read.csv('c:/data/departments.csv',header = T)

merge(loc[loc$CITY == 'Toronto',],departments,by='LOCATION_ID') 
z <- merge(loc[loc$CITY == 'Toronto',],departments,by.x='LOCATION_ID',by.y='LOCATION_ID') #위의 줄이랑 같음
merge(z,employees,by='DEPARTMENT_ID')[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME','STREET_ADDRESS')]


[문제118] 아래 화면의 결과처럼 출력해주세요.
부서이름       부서별급여
Administration       4400
Marketing           19000
Accounting          20308
......
소속부서X            7000
사원총급여         696456


dept_sal <- aggregate(SALARY ~ DEPARTMENT_ID, employees, sum)
dept <- merge(dept_sal,departments)[,c('DEPARTMENT_NAME','SALARY')]

x <- c('소속부서x', employees[is.na(employees$DEPARTMENT_ID), 'SALARY'])
t_sal <- c('사원총급여',sum(dept$SALARY))

df <- data.frame(부서이름 = dept$DEPARTMENT_NAME,
               부서별급여 = dept$SALARY)
df1 <- rbind(df,x)
rbind(df1,t_sal)

#----------------강사님
x <- aggregate(SALARY ~ DEPARTMENT_ID, employees,sum)
y <- merge(x,departments)[,c('DEPARTMENT_NAME','SALARY')]
z <- data.frame(DEPARTMENT_NAME = '소속부서X',
           SALARY = sum(employees[is.na(employees$DEPARTMENT_ID),'SALARY']))
w <- data.frame(DEPARTMENT_NAME = '사원총급여',
                  SALARY = sum(employees$SALARY))
s <- rbind(y,z,w)
s
names(s) <- c("부서이름","부서별급여총액")
s

[문제119] 부서별 최소급여를 받고 있는 사원정보를 출력해주세요.

dept_min <- aggregate(SALARY~DEPARTMENT_ID,employees,min)
merge(dept_min,employees,by=c('DEPARTMENT_ID','SALARY'))


dept_min <- aggregate(SALARY~DEPARTMENT_ID,employees,min)
names(dept_min) <- c('dept_id','min_sal') 
merge(dept_min,employees,by.x=c('dept_id','min_sal'),by.y=c('DEPARTMENT_ID','SALARY'))#컬럼이름이 다를 때 

#sql
select *
  from ( select department_id, min(salary) minsal
         from employees
         group by department_id) e1, employees e2
where e1.department_id = e2.department_id
and e1.minsal = e2.salary;

select *
  from employees
where (department_id,salary) in (select department_id, min(salary) minsal
                                 from employees
                                 group by department_id);

#--------------------------------------------------------------------------

★ subset
- 조건에 만족하는 데이터를 선택하는 함수
employees[employees$DEPARTMENT_ID == 20,]
employees[which(employees$DEPARTMENT_ID == 20),]
subset(employees,DEPARTMENT_ID==20)

employees[which(employees$DEPARTMENT_ID == 20),c('LAST_NAME','SALARY')]
subset(employees,DEPARTMENT_ID==20,select = c('LAST_NAME','SALARY'))
subset(employees,DEPARTMENT_ID==20,select = c(LAST_NAME,SALARY))


[문제120] 30번 부서 사원이면서 급여는 3000이상 받는 사원들의 LAST_NAME, HIRE_DATE,SALARY,DEPARTMENT_ID를 출력해주세요.

employees[employees$DEPARTMENT_ID==30 & employees$SALARY >= 3000, c('LAST_NAME','HIRE_DATE','SALARY','DEPARTMENT_ID')]
subset(employees,DEPARTMENT_ID==30 & SALARY >= 3000, select=c(LAST_NAME,HIRE_DATE,SALARY,DEPARTMENT_ID))

[문제121] 입사한 날짜가 2002,2003년도에 입사한 사원들의 last_name, hire_date, salary, job_id, department_id 출력해주세요.

subset(employees,format(as.Date(employees$HIRE_DATE,format='%Y-%m-%d'),'%Y') %in% c('2002','2003'),select=c(LAST_NAME,HIRE_DATE,SALARY,JOB_ID,DEPARTMENT_ID))


subset(employees,format(as.Date(employees$HIRE_DATE,format='%Y-%m-%d'),'%Y')==2002 | format(as.Date(employees$HIRE_DATE),'%Y')==2003, select=c(LAST_NAME, HIRE_DATE,SALARY,JOB_ID,DEPARTMENT_ID))

employees$HIRE_DATE <- as.Date(employees$HIRE_DATE,format='%Y-%m-%d')
employees[format(employees$HIRE_DATE,'%Y') %in% c('2002','2003'),c('LAST_NAME','HIRE_DATE','SALARY','JOB_ID','DEPARTMENT_ID')]
subset(employees,employees[format(employees$HIRE_DATE,'%Y') %in% c('2002','2003')],select = c('LAST_NAME','HIRE_DATE','SALARY','JOB_ID','DEPARTMENT_ID'))

[문제122] 150번 사원의 급여보다 더 많은 급여를 받는 사원들의 last_name, salary를 출력하세요.
a <- subset(employees,EMPLOYEE_ID==150,select = c(LAST_NAME,SALARY))
subset(employees, SALARY> a$SALARY, select = c(LAST_NAME,SALARY))

a <- employees[employees$EMPLOYEE_ID==150,c('LAST_NAME','SALARY')]
employees[employees$SALARY > a$SALARY, c('LAST_NAME','SALARY')]

1. subset
s <- subset(employees,EMPLOYEE_ID==150,select=SALARY) #data.frame으로 뽑아짐
class(s)

subset(employees,SALARY > s, select=c(LAST_NAME,SALARY)) # 결과값의 오류발생
# subset에서 비교값은 단일값으로 설정해서 비교(데이터프레임 값으로 비교x)
subset(employees,SALARY > as.integer(s), select=c(LAST_NAME,SALARY))

2. 기존방식
s <- employees[employees$EMPLOYEE_ID==150,'SALARY'] #integer로 뽑아짐
class(s)
employees[employees$SALARY > s,c('LAST_NAME','SALARY')]


[문제123]부서이름별 총액,평균,최대를 출력해주세요. 소속부서가 없는 정보도 출력해주세요.
DEPARTMENT_NAME   SUM_SAL   AVG_SAL MAX_SAL
소속부서X            7000  7000.000    7000
Administration       4400  4400.000    4400
Marketing           19000  9500.000   13000
.......

sum_a <- aggregate(SALARY~ifelse(is.na(DEPARTMENT_ID),0,DEPARTMENT_ID),employees,sum)
names(sum_a) <- c('DEPARTMENT_ID','SALARY')
avg_a <- aggregate(SALARY~ifelse(is.na(DEPARTMENT_ID),0,DEPARTMENT_ID),employees,mean)
names(avg_a) <- c('DEPARTMENT_ID','SALARY')
max_a <- aggregate(SALARY~ifelse(is.na(DEPARTMENT_ID),0,DEPARTMENT_ID),employees,max)
names(max_a) <- c('DEPARTMENT_ID','SALARY')
a <- merge(merge(sum_a,avg_a,by='DEPARTMENT_ID'),max_a,by='DEPARTMENT_ID')
b <- merge(a,departments,by='DEPARTMENT_ID', all.x = T)[,c('DEPARTMENT_NAME','SALARY.x','SALARY.y','SALARY')]
b[is.na(b$DEPARTMENT_NAME),'DEPARTMENT_NAME'] <- '소속부서X'
names(b) <- c('DEPARTMENT_NAME','SUM_SAL','AVG_SAL','MAX_SAL')
b



DEPARTMENT_NAME   SUM_SAL   AVG_SAL MAX_SAL
소속부서X            7000  7000.000    7000
Administration       4400  4400.000    4400
Marketing           19000  9500.000   13000
.......

s <- aggregate(SALARY ~ DEPARTMENT_ID,employees,sum)
names(s) <- c('DEPARTMENT_ID','SUM_SAL')
a <- aggregate(SALARY ~ DEPARTMENT_ID,employees,mean)
names(a) <- c('DEPARTMENT_ID','AVG_SAL')
m <-aggregate(SALARY ~ DEPARTMENT_ID,employees,max)
names(m) <- c('DEPARTMENT_ID','MAX_SAL')
s1 <- merge(s,departments)[,c('DEPARTMENT_NAME','SUM_SAL')] 
s1
a1 <- merge(s1, a)[,c('DEPARTMENT_NAME','SUM_SAL','AVG_SAL')] #카티션곱이 되버림 
a1
m1 <- merge(a1,m)[,c('DEPARTMENT_NAME','SUM_SAL','AVG_SAL','MAX_SAL')]
m1
employees[is.na(employees$DEPARTMENT_ID),c('DEPARTMENT_ID','SALARY')]

data.frame(DEPARTMENT_NAME=departments$DEPARTMENT_NAME,
           SUM_SAL=)

cbind(s,a,m)
#------------------------ 강사님답

x1 <- aggregate(SALARY~ifelse(is.na(DEPARTMENT_ID),0,DEPARTMENT_ID),employees,sum)
x2 <- aggregate(SALARY~ifelse(is.na(DEPARTMENT_ID),0,DEPARTMENT_ID),employees,mean)
x3 <- aggregate(SALARY~ifelse(is.na(DEPARTMENT_ID),0,DEPARTMENT_ID),employees,max)
x1;x2;x3
names(x1) <- c('DEPARTMENT_ID','SUM_SAL')
names(x2) <- c('DEPARTMENT_ID','AVG_SAL')
names(x3) <- c('DEPARTMENT_ID','MAX_SAL')
x1;x2;x3

m <- merge(merge(x1,x2),x3) #0(department_id값이 na)는 안나옴
result <- merge(m,departments, all.x=T)[,c('DEPARTMENT_NAME','SUM_SAL','AVG_SAL','MAX_SAL')]
result[is.na(result$DEPARTMENT_NAME),'DEPARTMENT_NAME'] <- '소속부서x'
result
str(result)

#sql
select department_id, sum(salary), avg(salary),max(salary)
from employees
group by department_id;

★ddply
- 데이터프레임을 분할하고 함수를 적용한 뒤 데이터프레임으로 결과를 반환하는 함수

install.packages("plyr")
library(plyr)

?ddply
rm(list=ls())
ls()
employees <- read.csv('c:/data/employees.csv',header = T)
departments <- read.csv('c:/data/departments.csv',header = T)
#summarise : 기준컬럼의 데이터끼리(그룹) 모은 후 함수에 적용 sql문의 group by절과 동일하다.
x <- plyr::ddply(employees,'DEPARTMENT_ID',summarise,
                 SUM_SAL = sum(SALARY),
                 AVG_SAL = mean(SALARY),
                 MAX_SAL = max(SALARY))
x
result <- merge(x,departments,all.x = T)[,c('DEPARTMENT_NAME','SUM_SAL','AVG_SAL','MAX_SAL')]
result[is.na(result$DEPARTMENT_NAME),'DEPARTMENT_NAME'] <- '소속부서x'
result
x<- plyr::ddply(employees,'DEPARTMENT_ID',summarise, #ddply(데이터프레임, 기준컬럼, summarise,~)
      SUM_SAL = sum(SALARY),
      AVG_SAL = mean(SALARY),
      MAX_SAL = max(SALARY))

result <- merge(x,departments,all.x=T)[,c('DEPARTMENT_NAME','SUM_SAL','AVG_SAL','MAX_SAL')]
result


[문제124]sales.csv file 읽어 들인 후 과일 이름별 판매량(qty), 판매합계를 구하세요.(tapply를 이용하세요)
sales <- read.csv('c:/data/fruits_sales.csv',header = T)
sales

x <- tapply(sales$price,sales$name,sum)
y <- tapply(sales$qty,sales$name,sum)
rbind(x,y)
cbind(x,y)
names(x)
df <- data.frame(name=names(x),qty=x,price=y)
rownames(df) <- NULL
df
[문제125]과일 이름별 판매량, 판매합계를 구하세요.(aggregate를 이용하세요)

sum_sal <- aggregate(price~name,sales,sum)
cnt_sal <- aggregate(qty~name,sales,sum)
merge(sum_sal, cnt_sal)

[문제126]과일 이름별 판매량, 판매합계를 구하세요. (ddply함수를 이용하세요)
ddply(sales,'name',summarise,
      SUM_SAL = sum(price),
      CNT_SAL = sum(qty))

[문제127]년도별로 판매량 중에 가장 많은 판매를 한 년도를 출력해주세요.(tapply를 이용하세요)
x <- tapply(sales$qty,sales$year,max)
names(x[x==max()])
rownames(x)[x==max(x)]



x <- tapply(sales$qty,sales$year,sum)
names(x)
rownames(x)
names(x[x==max(x)])
rownames(x)[x==max(x)]

[문제128]년도별로 판매량 중에 가장 많은 판매를 한 년도를 출력해주세요.(aggregate를 이용하세요)
a <- aggregate(qty~year,sales,max)
a[a$qty ==max(a$qty),'year']

[문제129]년도별로 판매량 중에 가장 많은 판매를 한 년도를 출력해주세요.(ddply를 이용하세요)

a <- plyr::ddply(sales,'year',summarise,
            qty=sum(qty))
a[a$qty ==max(a$qty),'year']

[문제130] 년도별 과일 판매 비율을 출력해주세요.( 각 년도에서 과일판매 비율)
year qty
1 2014  24
2 2015  35
3 2016  39
4 2017  50
sales

#-0-------------------------강사님
1.
x <- aggregate(qty~year, sales,sum)
x
df <- merge(x,sales,by='year')
df$pct_qty <- df$qty.y/df$qty.x *100
df[,-2]


   
2.
x <- aggregate(qty~year, sales,sum)
x

sales[1,'qty'] / x[x$year == sales[1,'year'],'qty'] * 100
sales[2,'qty'] / x[x$year == sales[1,'year'],'qty'] * 100

z <- NULL
for(i in 1:nrow(sales)){
  z <- c(z,sales[i,'qty'] / x[x$year == sales[i,'year'],'qty'] * 100)
}

z
sales$ratio <- z
sales

#__________________________

x <- aggregate(qty~year, sales,sum)
x
df <- merge(x,sales,by='year')
df$pct_qty <- df$qty.y/df$qty.x *100
df[,-2]

#summarise : SQL GROUP BY절 그룹을 수행한 집계값
ddply(sales,'year',summarise,sum_qty=sum(qty))

#transform : 행별로 연산을 수행해서 행당 값을 출력하는 기능 # SQL 분석함수와 유사하다. sum(qty) over(partition by year)
ddply(sales,'year',transform,sum_qty=sum(qty))

ddply(sales,'year',transform,sum_qty=sum(qty), pct_qty=qty/sum(qty)*100)

ddply(sales,'year',transform,sum_qty=sum(qty),pct_qty=qty/sum_qty*100) # 오류발생

#mutate : transform기능과 유사하고 차이점은 연산결과를 재사용할 수 있다.
ddply(sales,'year',mutate,sum_qty=sum(qty),pct_qty=qty/sum_qty*100)


[문제131] 년도별로 가장많이 판매된 정보를 출력해주세요.
sales

df <- ddply(sales,'year',summarise,name=name,qty=qty,price=price,qty_max= qty==max(qty)) #summarise는 컬럼들을 다 적어줘야한다.
df[df$qty_max==TRUE,]

x <- aggregate(qty~year,sales,max)
df <-merge(x,sales,by='year')
df[df$qty.x==df$qty.y,]


df <- ddply(sales,'year',transform,qty_max=max(qty))
df[df$qty==df$qty_max,]

df <- ddply(sales,'year',mutate,qty_max=max(qty),qty_bool= qty==qty_max)
df[df$qty==df$qty_max,] #df[df$qty_bool == TRUE,]

# 컬럼들을 구성하지 않고 true에 해당하는 열만 보고 싶다.
ddply(sales,'year',transform,qty==max(qty)) # truefalse가 안나옴
ddply(sales,'year',summarise,qty==max(qty)) # truefalse만 나옴
ddply(sales,'year',transform,max_bool = qty==max(qty)) #전부 다 나옴
ddply(sales,'year',subset,qty==max(qty)) # 원하는 답이 나옴 
#subset : 그룹함수의 결과가 나올 조건을 수행하는 기능
