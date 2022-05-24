[문제72] 년도별 총액급여를 구하세요.(가로방향으로 출력)
1.일반
aggregate(SALARY ~ format(employees$HIRE_DATE,'%Y'),employees,sum) # 문자형
t(aggregate(SALARY ~ format(employees$HIRE_DATE,'%Y'),employees,sum)) #문자형

2.lubridate::year
lubridate::year(employees$HIRE_DATE) # 숫자형

tapply(employees$SALARY,lubridate::year(employees$HIRE_DATE),sum)

install.packages("doBy")
library(doBy)
library(lubridate)

[문제73] 요일별 총액급여를 구하세요.(가로방향으로 출력)
1.
x <- tapply(employees$SALARY,format(employees$HIRE_DATE,'%u'),sum)
names(x) <- c('월','화','수','목','금','토','일')
x
t(t(x)) # 세로방향으로 바꿀 수 있다.

2.
tapply(employees$SALARY,lubridate::wday(employees$HIRE_DATE,week_start=1, label=T),sum)

[문제74] 부서별,년도별 총액급여를 출력해주세요.
1. 세로형
x <- aggregate(SALARY ~ DEPARTMENT_ID+lubridate::year(employees$HIRE_DATE),employees,sum)
names(x)[2] <- 'YEAR'
x
doBy::orderBy(~DEPARTMENT_ID+YEAR,x)

2.가로형(가로세로형)
tapply(employees$SALARY,list(employees$DEPARTMENT_ID,lubridate::year(employees$HIRE_DATE)),sum,default = 0)

[문제75] 년도별(행), 분기별(열) 총액급여, 행의 합, 열의 합을 출력해주세요.

year_s <- lubridate::year(employees$HIRE_DATE)
quarter_s <- lubridate::quarter(employees$HIRE_DATE)
tapply(employees$SALARY,list(year_s,quarter_s),sum,default = 0)

x <- tapply(employees$SALARY,list(lubridate::year(employees$HIRE_DATE),lubridate::quarter(employees$HIRE_DATE)),sum,default = 0)
class(x)
x <- data.frame(x) #data.frame으로 형식 변경
names(x) <- c('1분기', '2분기',' 3분기', '4분기')
x
x$합 <- apply(x,1,sum) # 컬럼추가
x
x <- rbind(x,apply(x,2,sum)) #행추가
x
x <- rownames(x)[nrow(x)] <- '합' #9행의 이름을 '합'으로 변경
x

#----------------------------------------------------------------

★ 조건제어문
-조건의 흐름을 제어

1. if 문

if(조건){
  조건에 참일 때 수행
} 

if(조건){
  조건에 참일 때 수행
} else{
  조건에 거짓일 때 수행
}

if(TRUE){
  print('참')
}

if(FALSE){
  print('참')
} else{
  print('거짓')
}

x <- 100
y <- 200
if(x==y){
  print('x와 y가 같다')
} else{
  print('x와 y가 같지 않다')
}

x <- 100
y <- 200
if(x==y){
  print('x와 y가 같다')
} else{
  if(x>y){
    print('x가 y보다 크다')
  } else{
    print('y가 x보다 크다')
  }
   
}

x <- 100
y <- 200
if(x==y){
  print('x와 y가 같다')
} else if(x>y){
    print('x가 y보다 크다')
} else{
    print('y가 x보다 크다')
}


[문제76]변수에 2를 입력한후 그 변수에 값이 2의 배수면 "2의 배수" 출력	아니면 "2의 배수가 아니다" 출력해주세요.

x <- 2
if(x%%2==0){
  print('2의 배수')
} else{
  print('2의 배수가 아니다')
}

#-------------------------- 직접 변수 입력해(혼자공부)
if(as.numeric(readline('insert please : '))%%2==0){
  print('2의 배수')
} else{
  print('2의 배수가 아니다')
}
#---------------------------

2. ifelse 함수
ifelse(조건,참,거짓)
ifelse(조건,참,ifelse(조건,참,ifelse(조건,참,거짓)))

x <- 1
y <- 2
ifelse(x==y,'같다','다르다')
ifelse(x==y,'같다',ifelse(x>y,'x가 크다','y가 크다'))

x <- 2
ifelse(x%%2==0, '2의 배수','2의 배수가 아니다')

[문제77] x 변수에 1부터 100까지 입력한 후 짝수값은 자신의 값에 10을 곱한 값으로 수정하세요.

x <- c(1:100)
ifelse(x%%2==0,x*10,x)

x<- 1:100
x[x%%2==0] * 10

x <- 1:100
if(x[1]%%2==0){  #if문으로는 반복문을 사용하지 않으면 수행할 수 없다. 함수는 반복해서 사용되는데 if문은 인덱싱을해서 하나씩 수행이 된다.
  print(x[1] * 10)
}

[문제78]  x <- c(2,10,6,4,3,NA,7,9,1) x 변수에 NA가 있으면 0으로 설정하세요

x <- c(2,10,6,4,3,NA,7,9,1)
ifelse(is.na(x),0,x)
ifelse(!is.na(x),x,0)

x[is.na(x)] <- 0
x

[문제79] last_name, salary, commission_pct, commission_pct NA 면 salary * 12,
아니면 (salary * 12) + (salary * 12 * commission_pct)을 수행하세요.

g <- ifelse(is.na(employees$COMMISSION_PCT),
       employees$SALARY*12,
       (employees$SALARY*12)+(employees$SALARY*12*employees$COMMISSION_PCT))

x <- employees[,c('LAST_NAME','SALARY','COMMISSION_PCT')]
x$계산값 <-g
x

df <- data.frame(name = employees$LAST_NAME,
           sal = employees$SALARY,
           com = employees$COMMISSION_PCT,
           ann_sal = ifelse(is.na(employees$COMMISSION_PCT),
                            employees$SALARY*12,
                            (employees$SALARY*12)+(employees$SALARY*12*employees$COMMISSION_PCT))
)
df[order(df$ann_sal,decreasing = T),]
doBy::orderBy(~-ann_sal,df)

[문제80] last_name, salary, 급여가 10000  이상이면 A, 5000이상 10000보다 작으면 B,
나머지는 C가 입력되어 있는 새로운 컬럼을 생성하세요.  
컬럼이름은 name, sal, level 로 설정하세요.

y <- ifelse(employees$SALARY >= 10000, 'A',
       ifelse(employees$SALARY >=5000 & employees$SALARY < 10000,'B','C'))

x <- employees[,c('LAST_NAME','SALARY')]
x$new <- y
names(x) <- c('name','sal','level')
x

df <- data.frame(name = employees$LAST_NAME,
                 sal = employees$SALARY,
                 level = ifelse(employees$SALARY >= 10000, 'A',
                                ifelse(employees$SALARY >=5000 & employees$SALARY < 10000,'B','C')))
df
doBy::orderBy(~level+sal,df)

3.switch
- 변수값에 따라 조건에 맞는 실행문을 수행하는 함수

x <- 2
switch(x,'남은 기간 최선을 다하자', '행복하자', '건강하게 살자')
switch(1,'남은 기간 최선을 다하자', '행복하자', '건강하게 살자')
switch(3,'남은 기간 최선을 다하자', '행복하자', '건강하게 살자')

x<- '산'
switch(x,'산' = '한라산 가고 싶다',
       '바다' = '함덕해수욕장 가고 싶다.',
       paste0(x,'그냥 방콕하세요'))

x <- '바다'
if(x=='산'){
  print('한라산 가고 싶다.')
} else if(x=='바다'){
  print('함덕 해수욕장 가고 싶다.')
} else{
  print('집에서 밥이나 먹자')
}

ifelse(x=='산','한라산 가고 싶다',
       ifelse(x=='바다','함덕 해수욕장 가자','집에서 밥이나 먹자'))

★ 반복문
1. for 문

for(카운터변수 in 반복수행할 데이터 변수){
  반복수행할 문장
}

x <- 1:100
x
for(i in x){
  print(i)
}

for(i in 1:100){
  print("오늘 하루도 행복하자")
}

x <- c('바다','강','계곡','산')
x
for (i in x){
  print(i)
}

x <- c(-1,1,2,3)
for(i in x){
  if(i < 0){
    print('음수')
  } else{
    print('양수')
  }
}

ifelse(x<0,'음수','양수')

for(i in '오늘 하루도 행복하자'){
  print(i)
}

[문제81] 1부터 10까지 합을 for문을 이용해서 구하세요
hap <- 0
for(i in 1:10){
  hap <- hap + i
}
hap

[문제82] 1부터100까지 전체합, 짝수합, 홀수합을 출력해주세요.
sum_even <- 0
sum_odd <- 0
sum_total <- 0

1.if
for(i in 1:100){
  sum_total <- sum_total + i
  if(i%%2==0){
    sum_even <- sum_even + i
  } else{
    sum_odd <- sum_odd + i
  }
}
sum_total
sum_even
sum_odd

2.ifelse
for(i in 1:100){
  sum_total <- sum_total + i
  ifelse(i%%2==0,sum_even<- sum_even +i, sum_odd <- sum_odd+i)
}
sum_total
sum_even
sum_odd

[문제83] 1부터100까지 홀수만 x변수에 입력해주세요.단 for문을 이용하세요.
1.
x <- seq(1,100,2)
x
2.
x <- NULL
for(i in 1:100){
  if(i%%2 != 0){
    x[i] <- i
  }
}
x[!is.na(x)]

3.
x <- NULL
for(i in 1:100){
  if(i%%2 != 0){
    x <- c(x,i)
  }
}
x

4.
x <- NULL
for(i in 1:100){
  if(i%%2 != 0){
    x <- append(x,i)
  }
}
x

[문제84] 1부터 10까지 까지 출력하세요. 단 3,5는 제외하세요.
x <- 0
for(i in 1:10){
  if(i!=3 & i!=5){
    x[i] <-i
  }
}
x
x[!is.na(x)]

2.
for(i in 1:10){
  if(i == 3 | i == 5){
    NULL
  } else{
    print(i)
  }
}

3.
# next 함수 : 현재 수행중인 반복문을 중지하고 다음 반복문으로 넘어가는 함수 (NULL이나 NA가 아님)

for(i in 1:10){
  if(i == 3 | i == 5){
    next
  } else{
    print(i)
  }
}


# break 함수 : 반복문 종료

for(i in 1:10){
  if(i == 3 | i == 5){
    break
  } else{
    print(i)
  }
}

[문제85] 2단을 출력
x<-2
for(i in 1:9){
    print(paste('2 x',i,'=',x*i))
}

2.
2*1:9

3.
x <- 1:9
x*2
paste('2 *',1:9,'=',2*1:9)
print('2 * ',1,'=',2) # 콤마로 구분이 되어 있는 각각의 값들을 출력할 수 없다.
print(paste('2 *',1:9,'=',2*1:9)) # 콤마로 구분이 되어있는 부분을 paste를 이용해서 하나로 붙여서 출력
cat('2 * ',1,'=',2) # 콤마로 구분이 되어 있는 각각의 값들을 출력할 수 있다.

for(i in 1:9){
  cat('2 *',i,'=',2*i, '\n') # '\n'(개행문자) <- 다음줄로 넘어가는 역할할
}

cat(paste('2 *',1:9,'=',2*1:9,'\n'))

[문제86] 구구단(2~9)를 출력

1.
for(i in 2:9){
  for(j in 1:9){
    print(paste(i,'x',j,'=',i*j))
  }
  
}

for (i in 2:9){
  for(j in 1:9){
    cat(i,' * ',j,' = ',i*j,'\n')
  }
}

2. 
for (i in 2:9){
  for(j in 1:9){
    cat(i,' * ',j,' = ',i*j,'\t')
  }
  cat('\n')
} 

3.
for(i in 1:9){
  for(j in 2:9){
    cat(j, 'x', i, '=',j*i, '\t') #cat 함수 : print의 강화버전.cat() '\n'->엔터, '\t' -> tab
  }
  cat('\n')
}

[문제87] 구구단(2~9)을 화면과 같이 출력해주세요.

2 * 1 = 2 	3 * 1 = 3 	4 * 1 = 4 	5 * 1 = 5 	6 * 1 = 6 	7 * 1 = 7 	8 * 1 = 8 	9 * 1 = 9 	
2 * 2 = 4 	3 * 2 = 6 	4 * 2 = 8 	5 * 2 = 10 	6 * 2 = 12 	7 * 2 = 14 	8 * 2 = 16 	9 * 2 = 18 	
...

for(i in 1:9){
  for(j in 2:9){
    cat(j, '*',i,'=',j*i,'\t')
  }
  cat('\n')
}


2.while 문
- 조건이 TRUE인 동안 반복수행하고 조건이 FALSE면 반복문을 종료하는 반복문

while(조건){
  반복수행할 문장
}

for(i in 1:10){
  print(i)
}

i<- 1
while(i<=10){
  print(i)
 i<- i+1
}

[문제88] while문을 이용해서 2단을 출력해주세요.
i<-1
while(i<=9){
  cat('2 *',i,'=',2*i,'\n')
  i <- i+1
}
[문제89] while문을 이용해서 구구단을 출력해주세요.
1.가로로 구구단
i<-2
j <- 1
while(i<=9){
  while(j<=9){
    cat(i,'*',j,'=',i*j,'\t')
    j <- j+1
  }
  j <- 1
  i <- i+1
    cat('\n')
}

2.세로로 구구단
i<-1
j <- 2
while(i<=9){
  while(j<=9){
    cat(j,'*',i,'=',j*i,'\t')
    j <- j+1
  }
  j <- 2
  i <- i+1
  cat('\n')
}

#--------------강사님답
i<-2
while(i<=9){
  j <- 1
  while(j<=9){
    print(paste(i,'*',j,'=',i*j))
    j <- j + 1
  }
  i <- i + 1
}

i<-2
while(i<=9){
  j <- 1
  while(j<=9){
    cat(i,'*',j,'=',i*j,'\n')
    j <- j + 1
  }
  i <- i + 1
}

[문제90] while문을 이용해서 구구단(2~9)을 화면과 같이 출력해주세요.

2 * 1 = 2 	3 * 1 = 3 	4 * 1 = 4 	5 * 1 = 5 	6 * 1 = 6 	7 * 1 = 7 	8 * 1 = 8 	9 * 1 = 9 	
2 * 2 = 4 	3 * 2 = 6 	4 * 2 = 8 	5 * 2 = 10 	6 * 2 = 12 	7 * 2 = 14 	8 * 2 = 16 	9 * 2 = 18 	
...

i <- 1
while(i<=9){
  j <- 2
  while(j<=9){
    cat(j,'*',i,'=',j*i,'\t')
    j <- j + 1
  }
  i <- i + 1
  cat('\n')
}

3. repeat
- 조건이 없는 상태에서 반복

repeat{
  반복수행할 문장
  break
}

i <- 1
repeat{
  print(i)
  if(i==10){
    break
  }
  i <- i +1
}


[문제91] repeat문을 이용해서 2단을 출력해주세요.
i<-1
repeat{
  
  if(i==10){
    break
  }
  print(paste('2 *',i,'=',2*i))
  i <- i + 1
}

[문제92] repeat문을 이용해서 구구단(2~9)을 출력해주세요.
i <- 2
repeat{
  j <- 1
  repeat{
    cat(i,'*',j,'=',i*j,'\n')
    if(j==9){
      break
    }
    j <- j+1
  }
  if(i==9){
    break
  }
  i <- i+1

}

#----강사님
i<-2
repeat{
  if(i==10){
    break
  }
  j <-1
  repeat{
    if(j==10){
      break
    }
    cat(i,'*',j,'=',i*j,'\n')
    j <- j+1
  }
  i <- i+1
}
[문제93] repeat문을 이용해서 구구단(2~9)을 화면과 같이 출력해주세요.

2 * 1 = 2 	3 * 1 = 3 	4 * 1 = 4 	5 * 1 = 5 	6 * 1 = 6 	7 * 1 = 7 	8 * 1 = 8 	9 * 1 = 9 	
2 * 2 = 4 	3 * 2 = 6 	4 * 2 = 8 	5 * 2 = 10 	6 * 2 = 12 	7 * 2 = 14 	8 * 2 = 16 	9 * 2 = 18 	
...

i <- 1
repeat{
  j <- 2
  repeat{
    cat(j,'*',i,'=',j*i,'\t')
    if(j==9){
      break
    }
    j <- j+1
  }
  cat('\n')
  if(i==9){
    break
  }
  i <- i + 1
}

#--------강사님
i <- 1
repeat{
  if(i==10){
    break
  }
  j <-2
  repeat{
    if(j==10){
      break
    }
    cat(j,'*',i,'=',i*j,'\n')
    j <- j+1
  }
  cat('\n')
  i <- i+1
}

[문제94] 구구단을 DATAFRAME에 저장하기. 각각 단이 컬럼으로 구성 되도록 해주세요.

temp <- NULL
temp <- c(temp,paste('2 * ',1,'=',2*1))
temp <- c(temp,paste('2 * ',1,'=',2*2))
temp

m <- NULL
m <- cbind(m,temp)
m

temp <- NULL
temp <- c(temp,paste('3 * ',1,'=',3*1))
temp <- c(temp,paste('3 * ',1,'=',3*2))
temp

m <- cbind(m,temp)
m

m <- NULL
for(i in 2:9){
  temp <- NULL
  for(j in 1:9){
    temp <- c(temp,paste(i,'x',j,'=',i*j))
  }
  m <- cbind(m,temp)
}
class(m)
m
gugudan <- data.frame(m)
gugudan
n <- NULL
for(i in 2:9){
  n <- c(n,paste0(i,'단'))
}
n

names(gugudan)<- n
gugudan
