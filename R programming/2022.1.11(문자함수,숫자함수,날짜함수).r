employees <- read.csv("c:/data/employees.csv",header = T) # 파일 읽어오기기

str(employees)
length(employees)
NROW(employees)

★ 문자함수
1. nchar
- 문자수를 리턴하는 함수

nchar('R Dveloper') #공백문자까지 리턴
nchar('R Developer', type='chars')
nchar('R Developer', type='bytes')

nchar('빅데이터', type='chars') # 문자의 수
nchar('빅데이터', type='bytes') # 문자의 byte
nchar(names(df))
x <- c('R', 'Developer')
length(x) # 여기서는 벡터의 길이
nchar(x) # 방마다 문자의 길이를 추출
nchar(x)[1]
nchar((x)[1])
nchar(x)[2] # 모든 방을 다 세어놓고 두번째를 추출
nchar((x)[2]) # 처음부터 두번째 방의 값을 추출

2. strsplit
- 부분문자로 분리하는 함수

strsplit('R Developer', split=' ') # 공백문자를 기준으로 분리,  리스트형으로 출력
strsplit('R Developer', split=' ')[[1]][1] # 첫번째 방의 첫번째 값을 출력
strsplit('R Developer', split=' ')[[1]][2] # 첫번째 방의 두번째 값을 출력
strsplit('R,Developer', split=',') # 컴마를 기준으로 분리
strsplit('R Developer', split='') # 한글자 씩 분리
strsplit('R,Developer', split=character(0)) # 한글자 씩 분리2

as.vector(strsplit('R Developer', split=' ')) #벡터로 변하지 않는다

# unlist : list자료형을 vector자료형으로 변환하는 함수
unlist(strsplit('R Developer', split=' '))

x <- strsplit('R Developer', split=' ')

paste(x[[1]]) # 값이 합쳐지지않음
paste(x[[1]][1], x[[1]][2]) # 별도로 분리시키면 합쳐진다.
paste(x[[1]], collapse = ' ') # collapse옵션을 통해 합칠 수 있다.

y <- c('a','b','c')
paste(y[1],y[2],y[3]) 
paste0(y[1],y[2],y[3]) 
paste(y, collapse=' ')
paste(y, collapse=',')
strsplit(paste(y, collapse=','),split=',') # 합쳤다가 다시 분리

3. toupper
- 대문자로 변환하는 함수
toupper('r developer')

4. tolower
- 소문자로 변환하는 함수
tolower('R DEVELOPER')

5.substr
- 문자를 추출하는 함수
substr('R Developer',1,1) # substr(문자열,뽑아낼위치,처음부터해서 뽑아낼 글자 수)
substr('R Developer',1,5)
substr('R Developer',3,3) # 왜 D 하나만 나올까? R개발자가 그렇게 만들어놓은것, 음수로 뒤어서부터 뽑을 수 없음
substr('R Developer',2,4) 

6. sub
- 첫 번째 일치하는 문자만 바꾸는 함수
sub('R','Python','R Programmer R Developer') #처음으로 나오는 R을 Python으로 변경
# sub(찾을문자,바꿀문자,문자열)

6. gsub
- 일치하는 모든 문자를 바꾸는 함수
gsub('R','Python','R Programmer R Developer') # R을 모두 찾아서  Python으로 변경

[문제44] x변수의 값중에 제일 뒤에 두글자만 추출해주세요.
x <- 'developer'
substr(x,nchar(x)-1,nchar(x))
sub(x,nchar(x)-1) # 끝 점을 설정하지 않았기 때문에 오류발생
substring(x,nchar(x)-1)
substr(x,1,4)
substr(x,2,5)
substr(x,3,4)
substr(x,1:3,4:5) # 슬라이싱으로 수행되지 않고 시작점1,끝점4수행한 결과만 출력(수행x)
substring(x,1:3,4:5) # ??어떤식으로 출력이 되는거지?
substirng(x,3,5)

substring(x,1:nchar(x),3:nchar(x)) # 하나의 단어를 3글자씩 계단처럼 추출 n-gram

[문제45] last_name의 글자의 수가 10이상인 사원의 employee_id, last_name 출력하세요.

employees[nchar(employees$LAST_NAME) >= 10, c('EMPLOYEE_ID', 'LAST_NAME')]

[문제46] last_name, last_name의 첫번째 철자부터 세번째 철자까지 함께 출력하세요.

substr(employees$LAST_NAME,1,3)

[문제47] developer 글자를 첫글자 대문자, 뒷글자는 소문자로 변환하세요.
x <- 'developer'

paste0(toupper(substr(x,1,1)), tolower(substr(x,2,nchar(x))))
paste0(toupper(substr(x,1,1)),tolower(substring(x,2)))

library(tools)
tools::toTitleCase(x) # 첫글자 대문자 뒷글자 소문자로 변환하는 함수
#처음 사용할 때 무조건 tools:: 적기, 기본적으로 내장되어있지 않는 특정한 라이브러리를 사용할 때 무조건 tools::라고 표현
toTitleCase(x)

[문제48] last_name, salary값을 화면에 출력할때 0은 * 로 출력하세요.

gsub(0,'*',paste(employees$LAST_NAME,employees$SALARY))
paste(employees$LAST_NAME, gsub(0,'*',employees$SALARY))
paste(employees$LAST_NAME, gsub('0','*',as.character(employees$SALARY)))
data.frame(name = employees$LAST_NAME,
           sal = gsub('0','*',as.character(employees$SALARY)))

[문제49] last_name의 두번째 철자가 m 또는 b 인 사원들의 last_name, salary를 출력하세요.

employees[substr(employees$LAST_NAME,2,2) %in% c('m','b'), c('LAST_NAME','SALARY')]

[문제50] last_name의 제일 뒷글자만 대문자 앞글자들은 소문자로 출력하세요.
paste0(tolower(substr(employees$LAST_NAME,1,nchar(employees$LAST_NAME)-1)),
      toupper(substr(employees$LAST_NAME,nchar(employees$LAST_NAME),nchar(employees$LAST_NAME))))


★ 숫자함수
1. round 
- 숫자를 지정한 지릿수를 기준으로 반올림
 45.926
-10 123 <- 위치
round(45.926)
round(45.926,0) # 기본값
round(45.926,1)
round(45.926,2)
round(45.926,-1)
round(45.926,-2)
round(55.926,-2)

2. signif
- 앞에서부터 위치로 반올림
45.926
12 345 <- 위치
signif(45.926,4) # == round(45.926,2)
signif(45.926,3) # == round(45.926,1)
signif(45.926,2) # == round(45.926,0)
signif(45.926,1) # == round(45.926,-1)

3. ceiling(x)
- x보다 크거나 같은 정수, 올림
ceiling(45.0)
ceiling(45.01)
ceiling(45.0000000001) 

4. trunc
- 소수점은 절삭하는 함수
trunc(45.926)
trunc(45.926,1) # 자리수를 입력해도 의미가 없다, 무조건 절삭됨
trunc(45.926,2)

5. floor(x)
- x보다 작은 수중에 가장 큰 정수를 나타내는 함수, 내림
floor(45.926)
floor(45.0)
floor(-10.0)
floor(-10.0001)

6. 제곱근
sqrt(16)

7. 절대값
abs(-1)

8. factorial
factorial(3)
factorial(5)
★ 날짜함수
1. 현재날짜, 시간
Sys.Date()
Sys.time()
date()

2. as.Date()
- 문자형날짜를 날짜형으로 변환하는 함수
class('2022-01-11')
class(as.Date('2022-01-11'))  
class(as.Date('2022/01/11'))  
class(as.Date('20220111'))  
as.Date('2022-01-11')
as.Date('20220111',format='%Y%m%d')
as.Date('2022.01.11',format='%Y.%m.%d')
#sql
to_date('20220111','yyyymmdd')
class(as.Date('20220111'))

# format : 날짜모델요소
%Y : 년도 4자리(세기포함)
%y : 년도 2자리(세기불포함)
%m : 숫자달
%B : 문자달
%b : 문자달 약어
%d : 일
%A : 요일
%a : 요일의 약어
%u : 숫자요일 1~7, 월요일 1
%w : 숫자요일 0~6, 일요일 0
%H : 시
%M : 분
%S : 초
%z : timezone 시간
%Z : timezone 이름

as.Date('2022년 1월 11일', format='%Y년 %m월 %d일')
as.Date('2022년 1월 11일', format='%Y년 %B %d일')

as.Date('2022년 JANUARY 11일', format='%Y년 %B %d일') #na로 나옴
Sys.getlocale()
Sys.setlocale("LC_ALL","English") # 현재 설정을 영어로 바꾸기
Sys.getlocale()

as.Date('2022년 JANUARY 11일', format='%Y년 %B %d일')
as.Date('2022년 1월 11일', format='%Y년 %B %d일') #na
as.Date('2022년 1월 11일', format='%Y년 %m월 %d일') 

Sys.getlocale()
Sys.setlocale() # 기본설정값으로 적용
Sys.getlocale()
as.Date('2022년 1월 11일', format='%Y년 %B %d일')

3. format 함수
- 날짜를 문자형으로 변환하는 함수

Sys.Date()
format(Sys.Date(),'%Y%m%d')
mode(format(Sys.Date(),'%Y%m%d'))
format(Sys.Date(),'%B')

Sys.setlocale("LC_ALL","English") # 현재 설정을 영어로 바꾸기
Sys.getlocale()
format(Sys.Date(),'%B')
format(Sys.Date(),'%b')
format(Sys.Date(),'%A')

Sys.setlocale() # 기본설정값으로 적용
Sys.getlocale()
format(Sys.Date(),'%B')
format(Sys.Date(),'%b')
format(Sys.Date(),'%A')

format(Sys.Date(),'%u') # 1~7 월 1
format(Sys.Date(),'%w') # 0~6 일 0 

format(Sys.time(),'%H')
format(Sys.time(),'%M')
format(Sys.time(),'%S')

format(Sys.time(),'%z') # 타임존의 시
format(Sys.time(),'%Z') # 표준시

4. weekdays
- 요일을 출력하는 함수
format(Sys.Date(),'%A')
weekdays(Sys.Date())

5. 날짜 계산
Sys.Date() + 129
Sys.Date() - 30

as.Date('2022-01-11', format='%Y-%m-%d') + 129
as.Date('2022-01-11') + 129

as.Date('2021-12-16') - Sys.Date()

as.numeric(Sys.Date() - as.Date('2021-12-16'))

6. difftime 
- 두 날짜간의 일수를 리턴하는 함수
difftime(as.Date('2021-12-16'), Sys.Date())
as.integer(difftime(as.Date('2021-12-16'), Sys.Date()))
as.numeric(difftime(Sys.Date(),as.Date('2021-12-16')))

7. as.difftime() 
- 시간으로 형을 변환하는 함수, 시간의 차이를 나타내는 함수
as.difftime('18:30:00') - as.difftime('09:30:00')


employees <- read.csv("c:/data/employees.csv",header = T) # 파일 읽어오기기, sqldeveloper에서 다시 날짜형식을 yyyy-mm-dd로 바꿔서 csv파일로

str(employees)

[문제51]2002-06-07에 입사한 사원들의 last_name, hire_date를  출력하세요.

employees[as.Date(employees$HIRE_DATE, format = '%Y-%m-%d') == as.Date('2002-06-07'), c('LAST_NAME','HIRE_DATE')]
#-----------강사님
employees[employees$HIRE_DATE == as.Date('2002-06-07'),c('LAST_NAME','HIRE_DATE')]
mode(employees$HIRE_DATE)
employees$HIRE_DATE <- as.Date(employees$HIRE_DATE, format = '%Y-%m-%d')
mode(employees$HIRE_DATE)
str(employees)
employees[employees$HIRE_DATE == as.Date('2002-06-07'),c('LAST_NAME','HIRE_DATE')]
#employees[employees$HIRE_DATE == as.Date('20020607',format='%Y%m%d'),c('LAST_NAME','HIRE_DATE')]

[문제52]사원의 last_name, 근무일수를 출력하세요.
data.frame(last_name = employees$LAST_NAME,
           date =Sys.Date() - as.Date(employees$HIRE_DATE, format = '%Y-%m-%d'))
#---------강사님
data.frame(name = employees$LAST_NAME,
           working_days = as.integer(Sys.Date() - employees$HIRE_DATE))

[문제53]사원의 last_name, 입사한 요일을 출력하세요.
data.frame(last_name=employees$LAST_NAME,
           day=format(as.Date(employees$HIRE_DATE, format = '%Y-%m-%d'),'%A'))

#---------강사님
data.frame(name = employees$LAST_NAME,
           day_1 = weekdays(employees$HIRE_DATE),
           day_2 = format(employees$HIRE_DATE,'%A'))
           
[문제54]근무연수가 15년 이상인 사원들의 last_name, hire_date, 근무연수를 출력해주세요.
employees[as.numeric(format(Sys.Date(),'%y')) - as.numeric(format(as.Date(employees$HIRE_DATE,format='%Y-%m-%d'), '%y')) >= 15,c('LAST_NAME','HIRE_DATE')] # 틀림
#---------강사님
years <- as.integer(Sys.Date() - employees$HIRE_DATE)/365
x <- employees[years >= 15, c('LAST_NAME','HIRE_DATE')]
x$working_years <- as.integer(Sys.Date() - x$HIRE_DATE)/365
x
nrow(x)

★ lubricate
library(lubridate)
install.packages("lubridate") #관리자 권한으로 실행해서 설치
.libPaths()

lubridate::today()
today()

lubridate::now()
now()

# 날짜 -> 문자형으로 추출
format(Sys.Date(), '%Y')
class(format(Sys.Date(),'%Y'))


# 날짜 -> 수치형으로 추출 lubridate::year 년도를 수치형으로 추출하는 함수
lubridate::year(Sys.Date())
lubridate::year(Sys.time())
class(lubridate::year(Sys.Date()))
lubridate::year(today())
lubridate::year(now())

# 달 추출
format(Sys.Date(),'%m') # 문자달 추출
lubridate::month(Sys.Date()) # 숫자달 추출
lubridate::month(lubridate::today())
lubridate::month(lubridate::now()) 

# 일 추출
format(Sys.Date(), '%d') # 문자일 추출

lubridate::day(Sys.Date()) # 숫자일일 추출
lubridate::day(lubridate::today())
lubridate::day(lubridate::now()) 

# 요일 추출
format(Sys.Date(), '%A') # 문자 요일 추출
format(Sys.Date(), '%a') 
format(Sys.Date(), '%u') # 문자형 숫자 요일 1~7 월요일 1
format(Sys.Date(), '%w') # 문자형 숫자 요일 0~6 일요일 0
weekdays(Sys.Date())

lubridate::wday(Sys.Date(),week_start = 1) # 1~7월요일 기준, 숫자로 출력
lubridate::wday(Sys.Date(),week_start = 7) # 1~7일요일 기준, 숫자로 출력

lubridate::wday(Sys.Date(),week_start = 1, label = T) # label=T 문자요일 출력(factor형으로 출력)
lubridate::wday(Sys.Date(),week_start = 1, label = F) # label=F 기본값, 숫자요일

lubridate::wday(Sys.Date(),week_start = 7, label = T) # label=T 문자요일 출력(factor형으로 출력)
lubridate::wday(Sys.Date(),week_start = 7, label = F) # label=F 기본값, 숫자요일

as.vector(lubridate::wday(Sys.Date(),week_start = 7, label = T))

Sys.Date() + 3650

# lubridate::years 년의 수를 더하거나 뺄 때 사용
Sys.Date() + lubridate::years(10)

Sys.Date() - lubridate::years(10)
Sys.Date() + lubridate::years(-10)

lubridate::now() - lubridate::years(10)
lubridate::now() + lubridate::years(-10)

?months(lubridate 아님, base에 내장되어있음)
# months 달의 수를 더하거나 뺄 때 사용
Sys.Date() + base::months(5)
Sys.Date() + base::months(-5)

Sys.Date() + lubridate::years(10) + base::months(2)
#SQL : select sysdate + to_yminterval('10-02') from dual;

# lubridate::days() 일수를 더하거나 빼는 함수
Sys.Date() + 100
Sys.Date() + lubridate::days(100)
Sys.Date() + lubridate::days(-100)

# lubridate::hours() 시간을 더하거나 빼는 함수
Sys.time() + lubridate::hours(2)
Sys.time() + lubridate::hours(-100)

#lubridate::minutes() 분을 더하거나 빼는 함수
Sys.time() + lubridate::minutes(30)
Sys.time() + lubridate::minutes(-30)

#lubridate::seconds() 초를 더하거나 빼는 함수
Sys.time() + lubridate::seconds(3600)
Sys.time() + lubridate::seconds(-3600)

Sys.time() + lubridate::days(100) + lubridate::hours(10) + lubridate::minutes(30) + seconds(50)

#SQL : select localtimestamp + to_dsinterval('100 10:30:50') from dual;

Sys.time() + lubridate::hours(2) + lubridate::minutes(30) + lubridate::seconds(50)
Sys.time() + lubridate::hms('02:30:50')

x <- lubridate::now()
x
lubridate::year(x) <- 2000 #연도만 수정
lubridate::month(x) <- 2 # 달 수정
lubridate::day(x) <- 1 #  일 수정
lubridate::hour(x) <- 12 # 시간수정
lubridate::minute(x) <- 0 # 분수정
lubridate::second(x) <-0 # 초수정
x
Sys.Date() + 100
lubridate::now() + 100 # 수행이 안된다.
lubridate::now() + lubridate::days(100)
x+100
x+ days(100)
class(lubridate::now())
class(Sys.Date())
# 분기 lubridate::quarter
lubridate::quarter(lubridate::now())

lubridate::quarter(lubridate::now() + days(200)) #현재날짜에 200일 더하기
lubridate::quarter(Sys.Date()+200) #현재날짜에 200일 더하기

# 분기 base::quarters
base::quarters(Sys.Date()) # 분기
base::quarters(Sys.Date() + 200)

