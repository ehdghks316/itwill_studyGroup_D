★ matrix(행렬)
- 수, 문자를 직사각형 형태로 나타낸 자료형
- 백터처럼 한가지 유형의 타입만 저장한다.
- 행(가로)과 열(세로) 구성된다.

matrix(c(1:9))
matrix(c(1:9),nrow=3) # nrow : 행의수
matrix(c(1:9),ncol=3) # ncol : 열의수
matrix(c(1:10),nrow=2,ncol=5)
matrix(c(1:10),nrow=5,ncol=2)

x <- matrix(c(1:12), ncol=2,nrow=6)
x
str(x)
class(x)
mode(x)
typeof(x)
is.integer(x)
is.numeric(x)
is.list(x)
is.character(x)
is.matrix(x)

dim(x) # 행렬의 크기, 6 x 2, 행의수 x 열의수
NROW(x) # 행의수
nrow(x) # 행의수
ncol(x) # 열의수
length(x) # 형렬 안에 들어 있는 값의 수

dim(x)[1] # 행의수
dim(x)[2] # 열의수

z <- c(1:9)
length(z)
NROW(z)
nrow(z) # 벡터에서는 수행되지 않는다

matrix(c(1:9),ncol=3) # byrow=FALSE : 열기준으로 값을 채움, 기본값
matrix(c(1:9),ncol=3,byrow=FALSE)
matrix(c(1:9),ncol=3,byrow=TRUE) # byrow=TRUE : 행기준으로 값을 채움

x <- matrix(c(1,2,3,4),nrow=2,ncol=2,byrow=T,
       dimnames=list(c('row1','row2'),
                     c('col1','col2')))
x
class(dimnames(x))
dimnames(x)[1] # 행의 이름
dimnames(x)[[1]] # 페이지 이름 빼고 행의 이름만

dimnames(x)[2] # 열의 이름
dimnames(x)[[2]]

y <- matrix(c(1:9),ncol=3)
y
# 행렬의 이름 수정
dimnames(y) <- list(c('row1','row2','row3'),
                    c('col1','col2','col3'))
dimnames(y)
y
# 행이름 수정
rownames(y) <- c('r1','r2','r3')
dimnames(y)[[1]] <-c('row1','row2','row3')
rownames(y)[2] <- 'r2' # 행의 두번째 이름만 변경
'r2' %in% rownames(y)
rownames(y) %in% 'r2'
which(rownames(y) %in% 'r2')
rownames(y) == 'r2'
which(rownames(y) %in% 'r2')
rownames(y)[which(rownames(y) %in% 'r2')] <- 'row2'
y

# 열이름 수정
colnames(y) <- c('c1','c2','c3')
y
dimnames(y)[[2]] <- c('col1','col2','col3')
colnames(y)[2] <- 'c2'
colnames(y)[which(colnames(y) %in% 'c2')] <- 'col2'
y

cell <- c(1:9)
rname <- c('a','b','c')
cname <- c('c1','c2','c3')
x <- matrix(cell,nrow=3,byrow=T,dimnames=list(rname,cname))
x

# 전차행렬(transposed matrix), 행과 열의 위치를 바꾼 행렬
t(x)

x_t <- t(x)
x_t
rownames(x_t) <- rownames(x) # 행의 이름까지 열로 바뀌어 있어서 행의 이름은 다시 바꾸기
colnames(x_t) <- colnames(x) # 열의 이름까지 행으로 바뀌어 있어서 열의 이름은 다시 바꾸기
x_t

# 행렬의 인덱싱
x[1,1] #[행인덱스, 열인덱스]
x[1,2]
x[2,3]
x[2,] # [행인덱스,] 2행의 값들을 다 추출
x[,3] # [,열인덱스] 3열의 값들을 다 추출

x[-1,] # 첫번째 행을 제외시키고 추출 ( 특정한 행 제외)
x[,-2] # 두번째 열을 제외시키고 추출 ( 특정한 열 제외)
x[-1,-2] # 특정한 행, 열 제외

x[c(1,3),] # 특정한 행들 추출
x[,c(2,3)] # 특정한 열들 추출
x[c(1,3),2] # 특정한 행과 열 추출출

x['a',] # 행 이름으로 추출
x[,'c3'] # 열 이름으로 추출
x
which(x==10)
which(x==5) # 행렬 안에 값을 열기준으로 찾는다.
which(x==3)
which(x==6)

x <- matrix(c(1:4),ncol=2)
x
# 행렬의 연산
x+10
x-10
x*10
x/2
x%/%2
x%%2

y <- matrix(c(5:8),ncol=2)
y
# 행렬의 같은 위치에 있는 성분끼리 연산 작업을 수행한다.
x+y 
x-y
x*y
x/y
x%/%y
x%%y

# 행렬의 곱
x
y
x %*% y

 1 3 %*% 5 7   = (1*5 + 3*6, 1*7 + 3*8)
 2 4     6 8     (2*5 + 4*7, 2*7 + 4*8)
 
dim(x)
dim(y) 
2*2 2*2

# 정방행렬(square matrix) : 같은 수의 행과 열을 가지는 행렬
2*2, 3*3, 4*4...

# 항등행렬(identity matrix), 단위행렬(unit matrix)
- 대각성분이 모두 1이고 그 이외의 모든 성분이 0인 정방행렬
diag(4)
diag(3)
diag(2)

# 대각행렬(diagonal matrix) : 대각성분이 아닌 모든 성분이 0인 행렬

a <- c(1:3)
diag(a)
diag(2,nrow=3)
diag(7,nrow=5)

# 역행렬(invertible matrix)
solve(x)
x %*% solve(x) # 단위행렬

x <- c(1:4)
y <- c(5:8)
x
y
z <- cbind(x,y) # 열결합
class(z)
z
r <- rbind(x,y) # 행결합
class(r)
r
[문제16] x 변수에 행렬을 구성하세요. 값은 1부터 10까지 입력하시고 5행 2열으로 만들면서 값은 열을 기준으로 생성하세요.
x <- matrix(c(1:10),nrow=5, byrow=FALSE)
x

[문제17] x 변수에 열을 기준으로 11,12,13,14,15 값을 추가하세요.
x <- cbind(x,c(11:15)) 
x
[문제18] x 변수에 행을 기준으로 16,17,18 값을 추가하세요.
x <- rbind(x,c(16:18))

[문제19] x변수에 6행의 값을 20,21,22 로 수정하세요.
x[6,] <- c(20,21,22)
x

[문제20] x 변수에 6행을 제거해주세요.
x <- x[-6,]
x
x <- x[-6,]

x <- matrix(c(1:18),nrow=6, byrow=FALSE)
x[-6,]
x <- x[-6,]
x

dim(x)
x
dim(x) <- c(3,5) # 5행 3열 -> 3행5열 수정 #c(행,열)
x
dim(x) <- c(1,15)
x
dim(x) <- c(15,1)
x
dim(x) <- c(5,3)
x

★ array(배열)
- 같은 데이터 타입을 갖는 3차원 배열구조

x <- array(c(1:9),dim=c(2,3))
x
class(x)
str(x)
mode(x)
is.matrix(x) # matrix확인 방법
is.array(x) # array 확인 방법
dim(x)

y <- array(c(1:24),dim=c(2,3,4)) # dim=c(행,열,면면)
y
class(y)
mode(y)
str(y)
is.matrix(y)
is.array(y)

y[1,1,1] # [행,열,면]
y[,,1] # 특정한 면만 확인

dimnames(y) <- list(c('r1','r2'),c('c1','c2','c3'))
rownames(y)
colnames(y)
dimnames(y) <- NULL # 행과열의 이름을 다 지우겠다
y
dim(y) # array 모습 확인
dim(y) <- c(3,4,2) # 3행, 4열, 2면으로 바꾸기
y

[문제21] x 배열을 생성하세요. 1부터 12까지 값을 가지고있는 배열을 생성하세요. 행2,열2,면은 3개가 만들어지도록하세요.
x <- array(c(1:12),dim=c(2,2,3))
x

dim(x)

[문제22] x 배열 변수에 컬럼이름은 'a','b'로 설정하세요.
dimnames(x) <- list(NULL,c('a','b'))
x
colnames(x) <- c('a','b')
dimnames(x)[[1]]

[문제23] x 배열 변수에 행이름은 'row1','row2'로 설정하세요.
dimnames(x)[[1]] <- c('row1','row2')
rownames(x) <- c('row1','row2')
x
dimnames(x)[[3]] <- c('one','two','three') # 면 이름 수정
x[,,3]
x[,,'three']
x[1,1,]
x['row1','a',]

dimnames(x) <- NULL

[문제24] x 배열 변수에 면을 2로 수정하세요.
dim(x) <- c(2,3,2)
dim(x)
dim(x) <- c(1,6,2)
x

★ factor
- 범주형 데이터를 표현하는 자료형
- (좋음, 보통, 나쁨), (남자, 여자), 거주지역, 혈액형
- 종류 : 순위형, 순서형(ordinal), 명목형(nominal)
x <- factor("보통",levels=c("좋음","보통","나쁨")) #level에 있는 값들을 표현할 수 있음,없는값은 <na>출력
x
str(x)
class(x)
mode(x)
typeof(x)
y <- factor("보통",levels=c("좋음","보통","나쁨"),ordered=T) # 순위형 factor
y
str(y)
class(y)
mode(y)
typeof(y)

is.factor(x) #factor 형 체크
is.factor(y)
is.ordered(x) # 순위형 factor 체크크
is.ordered(y)

nlevels(x) # factor level 수 확인
nlevels(y)

levels(x) # factor level 값 확인
levels(y)

levels(y)[1]

"좋음" %in% levels(y)
levels(y) %in% "좋음"
levels(y)[which(levels(y) %in% "좋음")] <- "매우좋음" # levels(y)위치에서 좋음이 있는 자리는 매우좋음으로 변경
levels(y)
levels(y)[which(levels(y) %in% "보통")] <- "좋음"
y

levels(y) <- c('good','normal','bad') # factor level 값 수정정
y

levels(y)[2] <- '보통' # normal을 보통으로 변경(모든 normal값을 보통으로 변경)
y

문제25] 벡터에 있는 값 "좋음", "보통", "그냥", "나쁨", "좋음", "보통" 을 factor 변수로 구성하세요. 
변수이름은 x로 생성하시고 level은  나쁨, 보통, 좋음 순으로 지정하세요.
y <- c('좋음','보통','그냥','나쁨','좋음','보통')
y
x <- factor(y,levels=c('나쁨','보통','좋음'))
x[is.na(x)]
x[which(is.na(x))] <- '보통'
x

[문제26] x factor형 목록이름중에 좋음을 매우좋음으로 수정하세요.
levels(x) == '좋음'
levels(x)[which(levels(x) %in% "좋음")] <- "매우좋음"
levels(x)[which(levels(x) =="좋음")] <- "매우좋음"

is.factor(x)
is.ordered(x)
x <- as.ordered(x) #순위형으로 바꾸기
is.ordered(x)
x

매우 좋음, 보통, 나쁨

# factor levels 순서를 바꾸려면
1. factor형을 vector형으로 변환
y <- as.vector(x)
y
str(y)

2.vector 형을 factor형으로 변환
y <- factor(y,levels=c("매우좋음","보통","나쁨"),ordered=T)
y
is.ordered(y)

★ data frame
- 데이터베이스에 table과 유사하다.
- 행과 열로 구성되어 있다.
- 서로 다른 데이터 타입을 갖는 2차원 테이블(배열) 구조

df <- data.frame(name=c('scott','hraden','curry'), 
           sql=c(90,80,70),
           r=c(80,70,90))
df
str(df)
class(df)
mode(df)
typeof(df)

df$name # 특정한 컬럼 확인
df$sql

dim(df)
df[1,1]  
df[2,1]
df[1,1] <- 'james' # 값을 수정 
#sql 
 update df
 set name = james
 where name = 'scott'

df[1,] # 특정한 행추출
df[,1] # 특정한 열추출

df[c(1,3),]
df[,'name']
df[,c('name','r')] # sql > select name,r from df;

df[,'name'] # 열을 하나 출력할 때는 기본값으로 가로 방향 출력, 벡터로 출력
df[,'name',drop=F] # drop=F옵션 세로 방향 출력, 데이터프레임으로 출력


df[,'name'][2]
class(df[,'name'])
df[,'name',drop=F][2,]
class(df[,'name',drop=F])

names(df) # 열이름 출력
colnames(df) # 열이름 출력
colnames(df) <- c('NAME', 'SQL','R') # 열이름 수정
df

rownames(df)
rownames(df) <- c('사원1','사원2','사원3') # 행이름 수정
df

rownames(df) <- NULL # 행이름 삭제
df

'SQL' %in% names(df)
'SQL' %in% colnames(df)

names(df) %in% 'SQL'
colnames(df) %in% 'SQL'

names(df) %in% c('SQL','R')
colnames(df) %in% c('SQL','R')

c('SQL','PYTHON') %in% names(df)
names(df) %in% c('SQL','PYTHON')

df[,'SQL']
df[,c('SQL','R')]
df[,c('SQL','PYTHON')] # 오류
df[,names(df) %in% c('SQL','PYTHON','R')] # PYTHON이 없어도 TRUE값들만 출력, 특정한 열을 추출
df[,!names(df) %in% c('SQL','PYTHON','R')] # 특정한 열을 제외해서 추출

which(names(df) %in% c('SQL','PYTHON','R')) # SQL,PYTHON,R이 있는 위치를 찾아서 출력
which(!names(df) %in% c('SQL','PYTHON','R')) # SQL,PYTHON,R이 없는 위치를 찾아서 출력

which(names(df) == c('SQL','PYTHON','R')) # R하나밖에 안나옴 주의
which(!names(df) == c('SQL','PYTHON','R'))

which(names(df) == 'SQL') | which(names(df) == 'PYTHON') | which(names(df) == 'R') # 안나옴 

which(names(df) == 'SQL')
which(names(df) == 'PYTHON')
which(names(df) == 'R')

df$PYTHON <- c(90,70,60) # 새로운 컬럼을 추가
df

length(df) # 컬럼의 수
NROW(df) # 행의 수
nrow(df) # 행의 수
str(df)

df <- data.frame(x=1:100000)
df
head(df,n=10) # 앞부분의 행 추출
tail(df,n=10) # 뒷부분의 행 추출출

[문제27] 아래와 같은 모양의 변수를 생성하세요. 변수 이름은 df로 하세요.

<화면출력>
  
  name sql  plsql
1  king  96     75
2 smith  82     91
3  jane  78     86


df <- data.frame(name=c('king','smith','jane'),
                sql=c(96,82,78),
                plsql=c(75,91,86))
df

[문제28] df변수에 james, 90, 80 추가 해주세요.
<화면출력>
  
  
  name sql plsql
1  king  96    75
2 smith  82    91
3  jane  78    86
4 james  90    80

df[nrow(df)+1,] <- c('james',90,80)
df

[문제29] james에 대한 row 정보만 출력하세요.

<화면출력>
  
  name sql plsql  
4 james  90    80 

df[df$name == 'james',]
df[which(df$name %in% 'james'),]

[문제30] james 이름의 행을 삭제해주세요.
df <- df[-which(df$name %in% 'james'),] 
df <- df[!df$name =='james',]
df


# read.csv : csv파일을 데이터프레임으로 읽어들이는 함수
employees <- read.csv("c:/data/emp.csv",header = T) # /, \\ 둘다 가능
employees
str(employees)
names(employees)
colnames(employees)
head(employees)
tail(employees)

# SQL 
SELECT * FROM employees WHERE employee_id = 100;

# R
employees$EMPLOYEE_ID == 100
employees[employees$EMPLOYEE_ID == 100,] # 조건에 해당하는 행만 추출

# SQL 
SELECT last_name, salary FROM employees WHERE employee_id = 100;

# R
employees[employees$EMPLOYEE_ID == 100, c('LAST_NAME','SALARY')] # 조건에 해당하는 행만 추출
employees[which(employees$EMPLOYEE_ID == 100), c('LAST_NAME','SALARY')] # 조건에 해당하는 행만 추출

# 데이터프레임[행추출조건, 열추출]

[문제31] employees 변수에 있는 데이터 중에 급여가 3000 인 
사원들의 last_name, salary를 출력하세요. 
단 employees 변수에 컬럼정보를 확인하시고 수행하세요.
#R
employees[employees$SALARY == 3000,c('LAST_NAME','SALARY')]

#SQL
SELECT last_name, salary
FROM employees
WHERE salary = 3000;

[문제32] 급여가 2000 이상인 사원들의 last_name, salary를 출력하세요.
#R
employees[employees$SALARY >= 2000, c('LAST_NAME','SALARY')]

#SQL
SELECT last_name, salary
FROM employees
WHERE salary >= 2000;

[문제33] job이 ST_CLERK인 사원들의 이름과 월급과 직업을  출력하세요.
#R
employees[employees$JOB_ID =='ST_CLERK', c('LAST_NAME', 'SALARY','JOB_ID')]

#SQL
SELECT last_name, salary, job_id
FROM employees
WHERE job_id = 'ST_CLERK';

[문제34] job이 ST_CLERK이 아닌 사원들의 이름과 월급과 직업을  출력하세요.
#R
employees[employees$JOB_ID != 'ST_CLERK', c('LAST_NAME','SALARY','JOB_ID')]

#SQL
SELECT last_name,salary,job_id
FROM employees
WHERE job_id != 'ST_CLERK';

[문제35] job이 AD_ASST, MK_MAN 인 사원들의 employee_id,last_name,job_id를 출력하세요.
#R
employees[employees$JOB_ID == 'AD_ASST' |employees$JOB_ID == 'MK_MAN', c('EMPLOYEE_ID','LAST_NAME','JOB_ID')]
employees[employees$JOB_ID %in% c('AD_ASST','MK_MAN'),c('EMPLOYEE_ID','LAST_NAME','JOB_ID')]
#SQL
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id = 'AD_ASST'
OR job_id ='MK_MAN';
#job_id in ('AD_ASST','MK_MAN');

[문제36] 부서번호가 20번,30번 사원들 중에 급여가 10000이상인 
사원의 last_name, salary, department_id를 출력하세요.
#R
employees[(employees$DEPARTMENT_ID ==20 |employees$DEPARTMENT_ID ==30) & employees$SALARY >= 10000, c('LAST_NAME','SALARY','DEPARTMENT_ID')]

employees[employees$DEPARTMENT_ID %in% c(20,30) & employees$SALARY >= 10000, c('LAST_NAME','SALARY','DEPARTMENT_ID')] # &조건이 우선순위가 높아서  |에서 괄호로 묶음

#SQL
SELECT last_name, salary, department_id
FROM employees
WHERE department_id in (20,30)
AND salary >= 10000

text1 <- '2022-01-10'
text2 <- '오늘하루도 행복하게 살자'
text3 <- '내년에도 늘 행복하자'

#paste, paste0 : 변수에 값들을 하나로 묶는 함수
paste(text1,text2,text3)
paste(text1,text2,text3,sep=' ') # sep=' ' 값을 하나로 묶을 때 공백문자를 구분자로 입력해서 묶는다
paste(text1,text2,text3,sep=',')
paste(text1,text2,text3,sep='')
paste0(text1,text2,text3) # 공백문자를 없애고 묶음

[문제37] last_name과 job_id 값을 아래결과와 같이 출력되도록하세요. 

King의 직업은 AD_PRES입니다.
....
paste(employees$LAST_NAME,'의 직업은 ',employees$JOB_ID,'입니다.', sep='')
paste0(employees$LAST_NAME,'의 직업은 ',employees$JOB_ID,'입니다.', sep='')

[문제38] Grant 사원의 정보만 출력해주세요.

Grant의 직업은  SH_CLERK입니다.

paste0(employees[employees$LAST_NAME =='Grant','LAST_NAME'],'의 직업은 ',employees[employees$LAST_NAME =='Grant','JOB_ID'],'입니다.')
paste(employees[employees$LAST_NAME =='Grant','LAST_NAME'],'의 직업은 ',employees[employees$LAST_NAME =='Grant','JOB_ID'],'입니다.', sep='')

[문제39] commission_pct에  NA 인 사원들의 last_name, salary, commission_pct를 출력하세요.

employees[is.na(employees$COMMISSION_PCT) == T, c('LAST_NAME', 'SALARY', 'COMMISSION_PCT')]

[문제40] department_id에 NA 인 사원들의 last_name, salary, department_id를 출력하세요.

employees[is.na(employees$DEPARTMENT_ID) == T, c('LAST_NAME','SALARY','DEPARTMENT_ID')]

[문제41] commission_pct에  NA가 아닌 사원들의 last_name, salary, commission_pct를 출력하세요.

employees[is.na(employees$COMMISSION_PCT) == F, c('LAST_NAME','SALARY','COMMISSION_PCT')]
employees[!is.na(employees$COMMISSION_PCT),c('LAST_NAME','SALARY','COMMISSION_PCT')]

[문제42] 30번 부서 사원들이면서 급여는 3000이상인 사원들의 employee_id, salary, department_id를 출력하세요.

employees[employees$DEPARTMENT_ID == 30 & employees$SALARY >= 3000, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')]
#NA행이 나오는 이유 : 

# na.omit : NA가 있는 행을 삭제(데이터가 날아감, 필드값에 NA가 있으면 NA에 해당하는 그 데이터의 행 싹다 삭제) --주의해서 사용 
na.omit(employees[employees$DEPARTMENT_ID == 30 & employees$SALARY >= 3000, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')])

employees[employees$DEPARTMENT_ID %in% 30 & employees$SALARY >= 3000, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')]

[문제43] 20번부서 사원이면서 급여는 10000를 초과한 사원 또는 급여가 2500 미만의 사원들의 employee_id, salary, department_id를 출력하세요.

employees[employees$DEPARTMENT_ID ==20 & employees$SALARY > 10000 |employees$SALARY < 2500, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')]


NROW(employees)
NROW(na.omit(employees)) #na가 들어가 있는 행들 다 삭제하니 주의요망


