a <- c(1:5) #벡터
b <- c(6:10)

x <- c(a,b)
x
for(i in 100:105){
  x <- c(x,i)
}
x

new_matrix <- rbind(a,b)
class(new_matrix)

df <- data.frame(x = c(1:5),
           y = c(6:10),
           z = c(11:15))

data <- c(16:19)
data
df_new <- rbind(df,data) # data, df 행 길이가 다를 때 행길이만큼만 들어오고 나머지는 안 들어옴
df_new
df1 <- data.frame(x = c(11,12,13),
           y = c(15,14,16),
           z = c(18,17,19))

rbind(df,df1) # 데이터프레임을 행 합칠때는 열의 수와 열 이름이 동일해야한다.

new = c()
new <- c(new,1)
new

new = NULL
new <- c(new,1)
new

df <- data.frame()
df
new_df <- rbind(df,c(1:9))
new_df <- rbind(new_df,c(10:19))
new_df

df <- data.frame()
for(i in 1:9){
  temp <- NULL
  for(j in 2:9){
    temp <- c(temp,paste(j,'*',i,'=',j*i)) 
  }
  df <- rbind(df,temp) #행단위로 할 때는 rbind 사용가능
}
df
names(df)
n <- NULL
for(i in 2:9){
  n <- c(n,paste0(i,'단'))
}
names(df) <- n
df
df$'2단' #컬럼이름에서 숫자가 앞에 온다면 작은따옴표를 꼭 사용



matrix(NA, nrow=9,ncol=8)

df <- data.frame(matrix(NA, nrow=9,ncol=8)) # 뼈대를 만들어 놓음
df
for(i in 2:9){
    temp <- NULL
    for(j in 1:9){
      temp <- c(temp, paste(i, '*',j,'=',i*j))
    }
    df[,i-1] <- temp # cbind는 안됨, 열단위로는 안되고 rbind(행단위)만 됨, 열별로 할 때는 뼈대를 만들어 놓고 열별로 다시 넣어주는 작업을 해야함
}
df


[문제95] 아래 화면과 같이 출력해주세요.(salary값을 기준으로 1000당 '*' 1개씩 출력)
name   sal                     star
King 24000 ************************
  Kochhar 17000        *****************
  De Haan 17000        *****************
  Hunold  9000                *********
  Ernst  6000                   ******
  Austin  4800                     ****
  Pataballa  4800                     ****
  ......
①
num <- trunc(employees$SALARY/1000)
star <- NULL
for(i in num){
  v <- NULL
  for(i in 1:i){
    v <- paste0(v,'*')  
  }
  star <- c(star,v) 
}
star
#employees <- read.csv('c:/data/employees.csv',header = T)

df <- data.frame(name=employees$LAST_NAME,
           sal=employees$SALARY,
           star=star)

df[nchar(df$star) != num,] #별의 개수 확인


②데이터프레임을 먼저만들기(na값이 하나 있을 때)
df <- data.frame(name=employees$LAST_NAME,
                 sal=employees$SALARY,
                 star=NA) # 컬럼을 선언할 때 NULL은 X, NA만, NULL은 변수선언할 때
df[107,'sal'] <- NA #107번의 salary값을 na로 초기화
df
idx <- 1 # idx변수는 star컬럼에서 각 행의 위치를 갖는 변수
for(i in df$sal){ #df$sal에 있는 값들을 하나씩 반복해서 수행
  if(is.na(i)){ #i(df$sal)값이 na이면 next함수를 사용해서 다음 i값으로 넘어가는 로직
    next 
  }else{ # i값이 na가 아니면 수행할 로직
    v <- NULL # '*'이 들어갈 변수를 선언
    for(j in 1:trunc(i/1000)){ # salarty/1000만큼의 '*'의 개수를 v변수에 초기화 
    v <- paste0(v,'*')
  }
  df[idx,'star'] <- v # v변수의 값을 df(데이터프레임)의 star컬럼의 idx번째에 초기화
  idx <- idx + 1 # idx변수를 1씩 증가시키면서 star컬럼의 다음 행으로 넘어가는 작업을 위해서
  }
}
df

★ 함수(function)
- 반복되어 사용하는 기능을 정의하는 프로그램
- 기능의 프로그램

toupper('king')

함수이름 <- function(){
  함수내에서 수행해야할 코드
  return(반환값) # 선택
}

Sys.Date()
format(Sys.Date(),'%Y%m%d')

#format(Sys.Date(),'%Y%m%d')를 리턴하는 date1이라는 함수 만들기
date1 <- function(){
  return(format(Sys.Date(),'%Y%m%d'))
}
date1() #함수 호출

# 매개변수(parameter variable)
- 형식매개변수(formal parameter variable) : arg1, arg2, 입력변수 # 매개변수 이름은 편한 것으로 아무거나 가능
- 실제매개변수(actual parameter variable) : 'king'

x<- 'king'
toupper(x)
toupper('king')

hap <- function(arg1,arg2){
  res <- arg1 + arg2
  return(res)
}

hap(100,200) #100 -> arg1, 200 -> arg2

x <- 100
y <- 200
hap(x,y)

[문제96] hap함수에 숫자를 입력하게 되면 1부터 입력숫자까지 누적합을 구하는 함수를 구현해주세요

hap <- function(x){
  y <- 0
  for(i in 1:x){
    y <- y + i
  }
  return(y)
}
hap(3)

#-------------------------- 내가 원하는 값의 구구단 구하는 함수
gugudan <- function(a){
  for(i in 1:9){
    cat(a,'*',i,'=',a*i,'\n')
  }
}
#--------------------------

[문제97] odd함수에 숫자를 입력하게 되면 1부터 입력숫자까지 홀수의 함을 구하세요.

odd <- function(arg1){
  temp <- 0
  for(i in 1:arg1){
    if(i%%2==0){
      next
    }
    temp <- temp + i
  }
  return(temp)
}

odd <- function(arg1){
  y <- 0
  for(i in 1:arg1){
    if(i%%2==1){
      y <- y + i
    }
  }
  return(y)
}
odd(10)

[문제98] 약수를 리턴하는 divisor함수를 생성해주세요.
약수 : 어떤 수를 나누어 떨어지게 하는 자연수
예) 12의 약수 1,2,3,4,6,12

12 %% 1 ==0
12 %% 2 ==0
12 %% 3 ==0
12 %% 4 ==0
12 %% 5 ==0
12 %% 6 ==0
12 %% 7 ==0
12 %% 8 ==0
12 %% 9 ==0
12 %% 10 ==0
12 %% 11 ==0
12 %% 12 ==0

divisor <- function(arg1){
  temp <- NULL
  for(i in 1:arg1)
    if(arg1%%i==0){
      temp <- c(temp,i)  
    }
  return(temp)
}
divisor(10)

divisor <- function(arg1){
  temp <- NULL
  for(i in 1:(arg1/2)){
    if(arg1%%i==0){
      temp <- c(temp,i)  
    }
  }
  return(c(temp,arg1))
}
divisor(10)



f <- function(arg){
  for(i in arg){
    print(i)
  }
}

f(c(1,2,3,4,5))
f(1,2,3,4,5)
f(1:5)

sum(1,2,3,4,5)
sum(c(1,2,3,4,5))
sum(1:5)

# 가변인수 : (...)
f <- function(...){
  for(i in list(...)){
    print(i)
  }
}

f <- function(...){
  for(i in c(...)){
    print(i)
  }
}


f(c(1,2,3,4,5))
f(1,2,3,4,5)
f(1:5)

[문제99] 입력값으로 들어온 수에 대한 합을 구하는 hap함수를 생성하세요.
sum(1,2,3,4,5)
sum(c(1,2,3,4,5))
sum(1:5)

hap <- function(...){
  v_sum <- 0
  for(i in c(...)){
    v_sum <- v_sum + i
  }
  return(v_sum)
}
hap(c(1,2,3,4,5))
hap(1,2,3,4,5)
hap(1:10)


[문제100] 평균을 구하는 avg함수를 생성해주세요.
y <- c(1,2,3,NA,4,5,NA)
mean(y)
mean(y,na.rm=T)
avg(y)

avg <- function(...){
  temp <- 0
  num <- 0
  for(i in c(...)){
    if(is.na(i)){
      next
    }
    temp <- temp + i
    num <- num + 1
  }
  return(temp/num)
}

avg(y)

avg <- function(...){
  x <- na.omit(c(...))
  v_sum <- 0 
  v_cn <- 0 
  for(i in x) {
    v_sum <- v_sum +i
    v_cn <- v_cn +1
  }
  return(v_sum/v_cn)
}
avg(y)

[문제101] 짝수, 홀수를 출력하는 odd_even함수를 생성해주세요.
> odd_even(1:5)
[1] "홀수" "짝수" "홀수" "짝수" "홀수"

odd_even <- function(...){
  odd1 <- NULL
  for(i in c(...)){
    if(i%%2==0){
      odd1 <- c(odd1,'짝수')
    }else{
      odd1 <- c(odd1,'홀수')
    }
  }
  return(odd1)
}

> odd_even(c(1,2,3,4,5))
[1] "홀수" "짝수" "홀수" "짝수" "홀수"



odd_even <- function(...){
  v <- NULL
  for(i in c(...)){
    if(i%%2==0){
      v <- c(v,"짝수")
    }else{
      v <- c(v,"홀수")
    }
  }
  return(v)
}

odd_even <- function(...){
  ifelse(c(...)%%2==0,"짝수","홀수")
}

lst <-list(1,2,3,4,5)
odd_even(lst)
odd_even(lst[[1]])
odd_even(lst[[2]])
odd_even(unlist(lst))

lapply(lst,odd_even) #리스트로
sapply(lst,odd_even) #벡터로

lapply(lst,function(arg){ifelse(arg%%2==0, "짝수","홀수")})
sapply(lst,function(arg){ifelse(arg%%2==0, "짝수","홀수")})

ls()
rm(list=ls())
ls()

# 전역변수(global variable)
- R프로그램이 수행되는 동안에는 어디서든지 사용할 수 있는 변수, 메모리에서 지우기 전까지 어디서든 사용할 수 있는 변수
x <- 1
y <- 2
z <- 3

ls()

f <- function(){
  y <-20 # 지역변수(private variable, local variable) : 함수내에서만 사용되는 변수
  print(x)
  print(y)
  print(z)
}

f()
y
ls()
rm(list=ls())
ls()

f <- function(){
  x <<- 10  # '<<-'전역변수
  y <- 20  # '<-' 지역변수
  z = 30   # '=' 지역변수
  print(x)
  print(y)
  print(z)
}

ls()
f()
ls()
x
#---------------
ls()
rm(list=ls())
ls()
x <- 100
x
ls()
f <- function(){
  x <<- 1  # '<<-'전역변수
  y <- 20  # '<-' 지역변수
  z = 30   # '=' 지역변수
  print(x)
  print(y)
  print(z)
}

ls()
f()
ls()
x

ls()
rm(list=ls())
ls()
#----------------
f <- function(arg1,arg2){
  print(arg1)
  
  f1 <- function(arg3){
    arg3 <- arg1 + arg3 # arg3 <- 10 + 20
    print(arg3)
  }
  f1(arg2) #arg2(20) -> f1.arg3(20)
  print(arg1)
  print(arg2)
  #print(arg3)
}

f(10,20) # 10 -> arg1, 20 -> arg2

# private variable : 함수가 중첩된 함수 일 경우 메인 함수의 arg1, arg2 함수내에서 어디서든 사용할 수 있다.
# local variable : 함수가 중첩된 함수 일 경우 중첩함수에서 선언된 arg3변수는 중첩함수 내에서만 사용할 수 있다.

f <- function(arg1,arg2){
  x1 <- arg1 #x1변수는 private variable 즉 f함수내에서 어디서든지 사용할 수 있다.
  x2 <- arg2 #x1변수는 private variable 즉 f함수내에서 어디서든지 사용할 수 있다.
  
  f1 <- function(arg3){
    x3 <- x1+x2 + arg3 #x3변수는 local variable, 즉 x3변수는 f1함수 내에서만 사용해야 한다.
    print(x3)
  }
  f1(x2) #arg2(20) -> f1.arg3(20)
  print(x1)
  print(x2)
  print(x3) # 오류발생 : local variable는 자신의 함수 내에서만 사용해야 하기 때문에 오류 발생
}

f(10,20)

[문제102] avg함수 안에 hap함수를 중첩해서 avg함수를 생성해주세요.
avg <- function(...){
  
  hap <- function(...){
    
    return() #중첩함수를 호출한 메인함수 쪽으로 값을 리터해줘야 한다.
  }
  hap # 메인함수 안에서 정의한 중첩함수를 호출하는 위치(hap함수를 먼저 정의 해야함)
}


avg <- function(...){
  x <- na.omit(c(...)) # x(1,2,3,4,5) na.omit((1,2,3,NA,4,5,NA))
  hap <- function(...){
    y <- c(...) #y(1,2,3,4,5)
    v_sum <- 0
    for(i in y){
      v_sum <- v_sum + i
    }
    return(v_sum)
  }
  return(hap(x)/length(x)) #hap 함수에서 리턴(v_sum) 한 값이 이곳으로 온다.
}

avg(1,2,3,NA,4,5,NA)
