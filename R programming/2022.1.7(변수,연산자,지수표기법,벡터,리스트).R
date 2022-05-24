R
뉴질랜드 오클랜드대학 Ross ihaka, Robert Getleman 1995년 개발한 소프트웨어이고
데이터 분석을 위한 통계 그래픽스를 지원하는 무료 소프트웨어이다.

R을 사용해야하는 이유?
- 뮤료 소프트웨어
- R은 소스코드 형태로 Free software foundation GNU조건에 따라
자유소프트웨어로 사용할 수 있다.
- 다양한 플랫폼에서 사용할 수 있다.
- 데이터분석을 위해서 가장 많이 쓰는 통계 플랫폼
- 누구든지 유용한 패키지를 생성해서 공유할 수 있고 새로운 기능에 대한 전달이 빠르다
- 복잡한 데이터를 다양한 그래프로 제공해준다.
- 인터프리터언어(interpreter) - 바로 실행 후 결과를 확인하는 언어, 컴파일 없이 바로 결과를 확인 
- 통계분석, 머신러닝, 딥러닝 관련된 프로그램도 있다.
- stata, SAS, SPSS 통계분석 소프트웨어와 더불어 많이 사용되고 있다.

R 버전 확인
version

print("오늘 하루도 행복하자")

변수(VARIABLE)
- 데이터를 저장하는 메모리 공간
- 저장된 데이터를 변경할 수 있다.
- 변수이름은 알파벳, 숫자, 특수문자('_','.')를 사용한다.
- 변수이름은 첫 글자는 알파벳 또는 .(마침표)를 사용한다.
- 변수이름을 .(마침표) 시작할 때는 바로 뒤에 숫자를 입력할 수 없다.
- 대소문자를 구분한다.
- 예약어를 변수이름으로 사용하지 말자

헬프를 이용해서 모르는 것들을 확인 할 수 있다.
help(reserved)
?sum
sum(1:5)

예) 변수이름으로 가능
a, A, x2,.x, xy
예) 변수이름으로 불가능
1x, .2, x-y, x^y

# 변수에 값을 할당하는 연산자(<-, <<-, =, ->)

x <- 1 #변수에 값을 넣을 때 주로 <-를 사용
x
X #오류나옴 대소문자 구분

1 -> y
y

x <<- 10
x = 100

x_1 <- 10
x_2 <- 20

# 메모리에 생성된 변수 확인
ls()

# 메모리에 생성된 특정한 변수 삭제
rm(x_1)

# 메모리에 생성된 모든 변수 삭제
rm(list=ls())

# 숫자, R의 기본 숫자는 실수형으로 입력된다.
x <- 1
x
class(x) # 변수의 타입 확인, numeric 실수형
typeof(x) # 변수의 타입 확인, double 실수형

y <- 1.0
y
class(y)
typeof(y)

z <- 2L # 숫자 뒤에 L을 입력하면 정수형으로 생성된다.
z
class(z) # 데이터 타입확인 integer 정수형
typeof(z) # 데이터 타입확인 integer 정수형

is.numeric(x) # 실수형인지 체크하는 함수, 실수형이면 boolean 값으로 TRUE가 리턴된다.
is.numeric(z) # 정수형이 실수형에 포함되어 있어서 정수형 변수 이지만 TRUE가 리턴된다.

is.integer(x) # 정수형인지 체크하는 함수
is.integer(z)

# 문자열(character)
s1 <- '오늘 하루도 행복하자'
class(s1)
typeof(s1)

s2 <- "오늘 하루도 행복하자"
class(s1)
typeof(s1)

is.numeric(s1)
is.integer(s1)
is.character(s1) # 문자형인지 체크하는 함수
-------- 

# 변수의 타입과 값을 확인하는 함수
str(x)
str(z)
str(s1)

# boolean, logical 확인하기
str(TRUE)
str(FALSE)
is.logical(TRUE) # boolean, logical 자료형인지 확인하는 함수
is.logical(FALSE)
class(TRUE)
typeof(FALSE)

str(T)
str(F)
is.logical(T) # boolean, logical 자료형인지 확인하는 함수
is.logical(F)
class(T)
typeof(F)

T <- 100 # T는 예약어이기 때문에 사용안하기
str(T)
is.logical(T)
rm(T)

str(T)

x1 <- TRUE
x1
str(x1)
class(x1)
typeof(x1)

# 논리연산자
& : AND 의미
| : OR 의미

TRUE & TRUE
TRUE & FALSE
FALSE & FALSE


TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

T & T
T & F
F & F

T | T
T | F
F | F

10 == 10 & 1 == 1

x <- TRUE
y <- FALSE

str(x)
str(y)

# NA(Not Available) : 결측치(값)
- 데이터가 입력이 되지 않은 경우
- SQL에서 NULL값과 동일하다.

x <- 100 
y <- NA 
z <- x+y
z

is.na(x) # NA를 체크하는 함수
is.na(y)

# NULL : 변수에 초기화 되지 않을 때 사용, undefined

x1 <- 100
y1 <- NULL # 변수는 선언 값은 초기화 x
z <- NA # 결측값

is.na(y1)
is.na(z)
is.null(y1) # NULL 체크하는 함수
is.null(z)

# 산술연산자
1+2
2-1
2*3
10/2
10/3
10 %/% 3 # 몫
10 %% 3 # 나머지
10 ^ 2 # 거듭제곱
10**2 # 거듭제곱 #SQL : select 10 * 10, power(10,2) from dual;

# 비교연산자
==(같다), !=(같지않다), >(크다), >=(크거나같다), <(작다), <=(작거나같다)

1 == 1
1 == 2
1 != 2
1 > 2
1 >= 1
1 < 2
1 <= 1

# 지수표기법(exponetial notation), 과학표기법(scientific notation)
과학이나 공학에서 큰 숫자를 간단하게 표현하는 표기법
10000
100000 # le+05
1000000
1e+05
1*10^5
200000
2*10^5

100e3 == 100*10^3
1e-08 == 0.00000001
1*10^-8 == 0.00000001

?options
options(scipen = 999) # 지수표기법을 사용하지 않을 때 scipen값을 999로 설정하면 된다.
100000

options(scipen = 0) # 지수표기법으로 사용하는 방법(기본값)
100000

x <- 100000
x
x1 <- format(100000, scientific=FALSE) # 지수표기법으로 사용하고 싶지 않을 때 format을 사용하면 된다. 하지만 문자로 입력된다.
str(x1)
x1 + 100 # x1이 문자형으로 들어가서 오류 발생(주의)

as.integer(x1) + 100 # as.integer 형변환 함수 char -> int 형변환 


★ 자료형

1. 단일값만 저장하는 변수, scalar type

x <- 100
x 

2. vector(벡터) 
- 같은 데이터 타입을 갖는 1차원 배열구조
- c() : combine value
- 벡터는 중첩할 수 없다.
- 데이터 변환규칙(integer < double(numeric) < character)

x <- c(10,20,30,40,50)
x
class(x)
typeof(x)
str(x)
mode(x)

y <- c(10L,2,'삼') # 서로 다른 형을 벡터에 넣을 수는 업다. 다 캐릭터로 들어감
y
class(y)
typeof(y)
str(y)
mode(y)

z <- c(1,2,3,c(4,5)) # 중첩 불가
z

x <- c("국어" = 90, "영어" = 95, "수학" = 80) #c(컬럼=값, 컬럼=값.....)
x
names(x) # 컬럼 이름만 확인

y <- c("과목"=c(70,80,90)) # 자동 컬럼 생성
y

names(y) <- c("국어","영어","수학") # 컬럼이름 수정정
names(y)
names(y)[1] # 컬럼 이름 중에 첫번째만 보겠다(인덱싱)
names(y)[2] # 컬럼 이름 중에 두번째만 보겠다
names(y)[3] # 컬럼 이름 중에 세번째만 보겠다

names(y)[2] <- "과학" # 2번째 열의 이름을 과학으로 바꾸겠다
y
names(y)[3] <- NA # 3번째 열의 이름을 NA로 바꾸겠다 
y
names(y) <- NULL # 열 이름 삭제
y

# 백터의 길이
length(y) 
NROW(y)

#인덱싱 : 배열 방번호를 기준으로 찾는다.
#R의 방번호는 1부터 시작한다.

y[1]
y[2]
y[3]
y[length(y)] # 백터안의 제일 마지막 방을 보겠다
y[-1] # 1번 방 제외하고 보겠다
y[-2] # 2번 방 제외하고 보겠다.
y[c(1,3)] # 1,3번방만 보겠다. (백터를 이용해서 여러개의 방을 선택할 수 있다.)
y[c(-1,-3)] # 1,3번방을 제외하고 보겠다.

names(y) <- c("국어","영어","수학")
y

y["국어"] # 컬럼 이름을 이용해서 인덱싱
y[c("국어","수학")]

y[c(1,2)]

# 슬라이싱
y[1:3]
y[1:2]
y[2:3]
y[-1:-2] # 1번방부터 2번방까지 제외

# 연속되는 값을 표현하는 방법
x <-1:100
x
y <- c(1:10000)
y

# [ reached getOption("max.print") -- omitted 9000 entries ] --해결방법
options(max.print = 1000000) # 화면의 출력해야 할 수를 조절하는 방법
y
options(max.print = 1000) # 기본값
y

# sql : 자동 일련번호를 생성하는 객체? SEQUENCE
# seq(시작값, 종료값, 증가분)
seq(1,1000,1)
seq(1,1000,2)
s <- seq(0,100,2)
s
10:1
seq(10,1,-1)

x <- c(2,4,6,8,10,12)
x
length(x)
NROW(x)

# 벡터 변수 길이 만큼 시퀀스 값을 생성
seq(1,length(x),1)
1:length(x)
1:NROW(x)
seq_along(x)

# 반복되는 값을 생성하는 함수

1:5
rep(1:5, times=2) #times = n 시작과 종료까지를 n번 반복
rep(1:10, each=2) # each =n  각각의 숫자를 n번 반복
rep(1:10, times=2,each=2)

x <- 10:15
x
#백터의 값을 수정
x[2] <- 16
x[2] <- NA # 결측값으로 수정
x[2] <- NULL 
x <- NULL # 변수 초기화

x <- 10:15
# 벡터의 값을 추가
x[7] <- 16
x[9] <- 17
x[11] <- 18

# 벡터 제일 뒤에 새로운 값을 추가
x[length(x)+1] <-19
x
append(x,20,after=length(x)) # append(벡터변수, 새로운값, after = 인덱스번호)
append(x,21,after=1) # 미리보기, 실제 적용은 안됨
x <- append(x,21,after=1)  # 변수에 할당해줘야지 적용이 됨
x

# 벡터 연산
x <- 10:15
x[1] + 100
x[2] + 100
x[3] + 100
x + 100
x - 100
x * 100
x/2
x%/%2
x%%2
x^2

# 서로 다른 벡터 변수의 값을 비교
x <- c(1,2,3)
y <- c(1,2,3)
z <- c(1,2,4)

x[1] == y[1]
x[2] == y[2]
x[3] == y[3]

x == y # 벡터 변수안에 있는 인덱스(요소번호, 방번호)끼리 값을 비교
x == z

x == y
identical(x,y) # 각 인덱스가 있는 값을 비교해서 전부 일치하면 TRUE 아니면 FALSE

x == z
identical(x,z)

x <- c(1,2,3,4,4)
y <- c(1,2,3,4)

x == y # 벡터의 길이가 일치하지 않으면 경고메시지가 발생한다.
identical(x,y) # 백터의 길이가 일치하지 않으면 FALSE, 경고메시지는 발생하지 않는다.

x1 <- c(1,2,3)
x2 <- c(2,3,1)
x1 == x2
identical(x1,x2)

# 인덱스에 있는 값으로 비교하는게 아니고 집합개념으로 비교하고 싶을 때 
setequal(x1,x2) # 집합에 있는 값으로 비교하기때문에 값이 일치하면  TRUE, 아니면 FALSE를 출력한다.
setequal(x,y)

x <- c(1,2,3,4,4)
y <- c(1,2,3,4,5)
x == y
identical(x,y)
setequal(x,y)

# 집합연산
x <- c(1,2,3,4)
y <- c(1,4,6)

union(x,y) # 합집합
intersect(x,y) # 교집합
setdiff(x,y) # 차집합 ,x쪽에만 있는 것만 뽑겠다
setdiff(y,x) #차집합 y쪽에만 있는 것만 뽑겠다
z <- c(x,y) # SQL에서 배웠던 UNION ALL

x <- c(1,2,3,4)
x

#벡터 변수에 값이 있는지를 확인
1 %in% x
5 %in% x

x <- c(1,2,3,4,5,1,2,1)
1 %in% x # x벡터에 1이 있으면 TURE
x %in% 1 # 1이 x벡터 방마다 비교해서 일치하는 값들은 그 위치에 TRUE, 아닌 값들은 FALSE
x == 1
x[x==1]
x[x %in% 1]
x[x==2]
x[x %in% 2]

y <- c('a','b', NA, 'a','b','d', NA)
'a' %in% y
y %in% 'a'
y[y=='a'] # NA포함시켜서 찾는다
y[y%in%'a'] # NA를 제외시키고 찾는다
y[y=='a'|y=='b']
y[y%in%'a'|y%in%'b']

# 조건에 해당하는 인덱스 번호를 찾는 방법
which(y =='a')
y[which(y =='a')]
y[y=='a']
y[which(y=='a')|which(y=='b')] # 이렇게 사용하면 안된다. 그냥 y변수에 있는 값 다 출력
y[which(y == 'a' | y == 'b')]

# NA 찾는 방법
is.na(y)
y[is.na(y)]

# NA가 있는 인덱스 번호를 찾는 방법
which(is.na(y))
y[which(is.na(y))]

# NA(결측치(값))을 찾아서 동일한 값으로 수정

y <- c('a','b',NA,'a','b','d',NA)
which(is.na(y))
y[which(is.na(y))] <- 'c' # y[c(3,7)] <- 'c'
y

y <- c('a','b',NA,'a','b','d',NA)
is.na(y) # is null
!is.na(y) # is not null
y[!is.na(y)] #NA제외하고 출력

y[which(is.na(y))] # y[c(3,7)]
y[-which(is.na(y))] # y[c(-3,-7)]

# 정렬
x <- c(8,7,9,3,2,4,6,5,1)
sort(x)
sort(x,decreasing = FALSE) # 오름차순, 기본값
sort(x,decreasing = TRUE) # 내림차순

x <- 1:5 # 정수
y <- c(1:5) # 정수
z <- c(1,2,3,4,5) # 실수
s1 <- seq(1,5) # 정수
s2 <- seq(1,5,1) #실수
str(x)
str(z)
str(y)
str(s1)
str(s2)

x == z
identical(x,z) # 벡터 변수의 길이, 인덱스 값이, 데이터 타입 비교교
setequal(x,z) # 값으로 비교
identical(s1,s2)
setequal(s1,s2)

# as.integer() 실수형, 문자형 숫자 -> 정수형으로 변환하는 함수
identical(s1, as.integer(s2))

#as.numeric() 정수형, 문자숫자 -> 실수형으로 변환하는 함수
identical(as.numeric(s1),s2)

x <- c('1', '2')
str(x)          
as.integer(x) + 100
as.numeric(x) + 100

[문제1] x변수에 1,3,5,7,9 값을 입력, y 변수에 1,2,3,4,5 값을 입력하세요.
1)
x <- c(1,3,5,7,9)
y <- c(1,2,3,4,5)
2) 
x <- seq(1,9,2)
y <- seq(1,5)

[문제2] x 변수와 y 변수를 중복성 없이 하나로 합친후에 u 변수에 넣어 주세요.
u <- union(x,y)
u <- sort(u)
u

[문제3] x 변수와 y 변수의 값들중에 중복성만 추출해서 i 변수에 넣어주세요.
i <- intersect(x,y)
i

[문제4] x 변수의 값과 y 변수의 값중에 순수하게 x 변수에 들어 있는 값만 추출해서 m 변수에 넣어 주세요.
m <- setdiff(x,y)
m

[문제5] x 변수의 값과 y 변수의 값이 일치가 되면 TRUE 아니면 FALSE를 출력해주세요.
identical(x,y)
setequal(x,y)

[문제6] x 변수에 값들을 10을 곱한 결과를 x 변수에 적용하세요.
x <- x * 10
x

[문제7] x 변수에 있는 50을 5로 수정하세요.
x[which(x == 50)] <- 5
x[x%in%50] <- 5
x

[문제8]  x 변수에 있는 10 30  5 70 90을  원래의 값으로 1,3,5,7,9로 되돌려 주세요.
단 union, 정수 나누기, sort 만 사용하세요
sort(union(x[-3] %/% 10, x[3]))
x <- sort(union(x[-which(x==5)]%/%10,x[which(x==5)]))

[문제9] x변수에 11숫자를 제일 뒤에 입력하세요. 단 append와 length를 이용하세요.
x <- append(x,11,after=length(x))
x

[문제10] x 변수에 제일 뒤에 있는 값을 NA로 수정하세요. 단 length를 이용하세요.
x[length(x)] <- NA
x

3. list
- 서로 다른 데이터 타입을 같는 벡터를 저장하거나 다른 리스트를 저장할 수 있는 구조
- list(key=value,key=value)

x <- list(name='홍길동', age=20,addr='강남구',pn='010-1000-1004')
str(x)
class(x)
mode(x)
typeof(x)

x$name
x$age
typeof(x$name) # 리스트에 특정한 키의 타입을 확인
typeof(x$age)

# 인덱싱
x[1] # key, value값 리턴
x[2]
x[3]
x[4]

x$name
x[[1]] # value값만 출력, 대괄호 두번

x[-1] # 1번 인덱스의 키, 값은 제외외

# 슬라이싱
x[1:2]

# list 키, 값을 추가
x$sal <- 1000
x

# list 키, 값을 삭제
x$sal <- NULL
x

# list중첩을 사용할 수 있다.
y <- list(a = list(d=c(1,2,3)),
          b = list(d=c(1,2,3,4)))

y
y$a
y$a$d
y$b
y$b$d

# list 키 이름을 확인
names(y)
names(y)[1]
names(y)[2]

names(y)[1] <- 'A'
names(y)[2] <- 'B'
names(y$A) <- 'D'
names(y$B) <- 'E'

y$A$D
y$B$E

[문제11] lst 변수에 name = 'king' , height = 180, weight = 70 값을 입력해 주세요.
lst <- list(name='king', height=180, weight=70)
lst

[문제12] lst 변수에  blood = 'A' 추가하세요.
lst$blood <- 'A'
lst

[문제13] lst 변수에 name의 값을 'scott'로 수정하세요.
lst$name <- 'scott'
lst$name
lst

[문제14] lst변수에 2번인덱스 값만 출력해주세요.
lst[[2]]

[문제15] lst변수에 blood 이름을 blood type 이름으로 수정하세요.
names(lst)[4] <- 'blood type'
lst
'blood' %in% names(lst)
which(names(lst) %in% 'blood')

names(lst)[which(names(lst) %in% 'blood')] <- 'blood type'
lst$'blood type' # 공백문자는 작은 따옴표(큰따옴표)를 꼭 넣어야 한다.
lst$"blood type"

lst
is.list(lst) # list자료형인지 체크하는 함수
is.numeric(lst)
is.integer(lst)
is.character(lst)
is.logical(lst)
is.numeric(lst$height)
is.character(lst$name)
class(lst)
mode(lst)
typeof(lst)

as.character(lst) # lst를 character형으로 바꾸었을 때 벡터가 된다. lst -> vector(문자형)으로 자료형을 변환할 수 있다.
as.integer(lst) #list -> vector(수치형)으로 자료형을 변환할 때 숫자는 바꿀 수 있지만 문자는 NA로 변경된다.
as.numeric(lst)

lst_new <- unlist(lst) # list -> vector 형으로 변환하는 함수, 키는 컬럼으로 변환된다.

lst_new
is.list(lst_new)
is.character(lst_new)
names(lst_new)
class(lst_new)
mode(lst_new)
lst_new['name'] # 벡터

lst_new2 <- as.list(lst_new) # vector -> list 형변환
is.list(lst_new2)
names(lst_new2)
lst_new2$name
lst_new2
lst_new2$height <- as.numeric(lst_new2$height) #charactor -> numeric 형변환
lst_new2$height

str(lst_new2)
lst_new2$weight <- as.integer(lst_new2$weight) # charactor -> integer 형변환
str(lst_new2)
