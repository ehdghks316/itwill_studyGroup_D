[문제166] 2015년~2021년까지 서울에서 '경기도','부산광역시','인천광역시',
'대구광역시','세종특별자치시' 으로 이동자수를 그래프로 시각화해주세요.

#-----------------------데이터작업
data <- read.csv('c:/data/전출지_전입지_시도_별_이동자수.csv',header=T)
data
#열에는 지역,행에는 년도 
data <- data[-1,-1]
names(data) <- c('전입지별','2015','2016','2017','2018','2019','2020','2021')
data
new <- data.frame(t(data))
names(new) <- new[1,]
new <- new[-1,]
str(new)
new[,1:16] <- lapply(new[,1:16],as.integer)
str(new)
new
#---------------------그래프그리기(x년도, 5개의 그래프 선 )
plot(new$경기도, axes=F, ylab="",xlab="",
     type='o', col='red', ylim=c(0,380000))
lines(new$부산광역시, type='o', col='blue')
lines(new$인천광역시, type='o', col='purple')
lines(new$대구광역시, type='o', col='green')
lines(new$세종특별자치시, type='o', col='black')
axis(1,at=1:7,label=rownames(new),las=2)
axis(2)
abline(h=seq(0,300000,50000),v=seq(1,10,1),lty=3,lwd=0.2)
legend("topright",legend = names(new)[c(8,1,3,2,7)],cex=0.5,lty = 2,lwd=1,
       col=c('red','blue','red','black','green'))



#--------------------------강사님
data <- read.csv('c:/data/전출지_전입지_시도_별_이동자수.csv',header=T)
data <- data[-1,-1]
names(data)[2:8] <- c(2015:2021)
data
data <- data.frame(t(data))
data
names(data) <- data[1,]
data <- data[-1,]
str(data)
data[,1:16] <- lapply(data[,1:16],as.integer)
str(data)
data
plot(data$경기도,xlab="",ylab="",ylim=c(0,400000),axes=F,col='violet',type='b')
lines(data$부산광역시, col='blue',type='b')
lines(data$인천광역시, col='red', type='b')
lines(data$대구광역시, col='black', type='b')
lines(data$세종특별자치시, col='green', type='b')
axis(1,at=1:7,label=rownames(data),las=2)
axis(2,at=seq(0,400000,by=50000),las=2)
abline(v=seq(1,10,1),lty=3,lwd=0.2)
legend('topleft',legend=c('경기도','부산광역시','인천광역시',
                          '대구광역시','세종특별자치시'),
        col=c('violet','blue','red','black','green'),cex=0.5,lty=1,lwd=0.5)

#------------------------------------------
install.packages('reshape2')
library(reshape2)
sales <- read.csv('c:/data/fruits_sales.csv',header=T)
sales

#reshape2::melt : 컬럼이 많은 형태(wide) 가로를 세로방향 긴(long)형태로 변경하는 함수
reshape2::melt(sales,id='year')
reshape2::melt(sales,id='name')

a<- reshape2::melt(sales,id=c('name'), measure=c('qty','price'))
# name컬럼을 기준으로 variable컬럼과 value컬럼을 생성하는데 variable컬럼에는 qty,price만 들어가며 value는 그에 맞는 값들이 들어간다.
dcast(a,name~variable,sum) # name을 기준으로 그룹하여 variable에 있는 값들의 합을 구한다. sum을 작성하지 않고 실행하면 빈도수를 구한다. 
#dcast(원본데이터, 행고정~unstack처리컬럼(컬럼분리),)


m <- reshape2::melt(sales,id=c('year','name'))
str(m) #data.frame형식, 새로운열이 2개 생김

m -> sales로 바꾸고 싶을 때 dcast함수 사용
# reshape2::dcast : long(세로)을 wide(가로)형태로 변경하는 함수

dcast(m,year+name~variable) # 원래 상태로 복귀
reshape2::dcast(m,year~variable,sum) #년도별 수량의합,price의 합
reshape2::dcast(m,name~variable,sum) #name별 수량의합,price의 합

library(dplyr)
sales%>%
  dplyr::group_by(year)%>%
  dplyr::summarise(qty=sum(qty),price=sum(price))
sales%>%
  dplyr::group_by(name)%>%
  dplyr::summarise(qty=sum(qty),price=sum(price))

#-----------------------------------------------------
data <- read.csv('c:/data/전출지_전입지_시도_별_이동자수.csv',header=T)
data <- data[-1,-1]
names(data)[2:8] <- c(2015:2021)
data

data <- dcast(melt(data,id='전입지별'),variable~전입지별) #데이터프레임으로 만드는 작업을 할 필요가 없음(t함수를 사용하면 data.frame을 수행해야함)
data
str(data)

data[,-1] <- lapply(data[,-1],as.integer) # rownames를 1열로 바꾸고 1열을 삭제해서  data[,1:길이]하는 방법도 있다.
str(data)
data
plot(data$경기도,xlab="",ylab="",ylim=c(0,400000),axes=F,col='violet',type='b')
lines(data$부산광역시, col='blue',type='b')
lines(data$인천광역시, col='red', type='b')
lines(data$대구광역시, col='black', type='b')
lines(data$세종특별자치시, col='green', type='b')
axis(1,at=1:7,label=data$variable,las=2)
axis(2,at=seq(0,400000,by=50000),las=2)
abline(v=seq(1,10,1),lty=3,lwd=0.2)
legend('topleft',legend=c('경기도','부산광역시','인천광역시',
                          '대구광역시','세종특별자치시'),
       col=c('violet','blue','red','black','green'),cex=0.5,lty=1,lwd=0.5)


[문제167] 조사된 데이터 값들이 있습니다. 도수분포표를 만드세요.
#도수: 개수라고 보면됨, 
#상대도수 : 전체에서 도수값 나누기
#누적도수 : 도수에 대한 누적값
90 88 78 65 80 94 69 72 83 64 95 68 87 69 82 91 63 70 81 67 

계급                도수    상대도수  누적도수
----------------- -------   --------  --------
  90점이상             4       4/20        4
80점이상~90점미만    6                   10
70점이상~80점미만    3                   13
60점이상~70점미만    7                   20

# scan을 이용해서 값들을 벡터에 넣을 수 있음()
#scan() 함수는 console에서 수행하세요.
> score <- scan()

score
ft <- data.frame(계급=c('90점 이상','80점이상~90점미만','70점이상~80점미만','60점이상~70점미만'),
             도수=c(0,0,0,0))

# 1.도수 값 구하기
for(i in score){ 
  if(i >= 90){
    ft[,2][1] <- ft[,2][1] + 1
  } else if(i >= 80 & i < 90){
    ft[,2][2] <- ft[,2][2] + 1
  } else if(i >= 70 & i < 80){
    ft[,2][3] <- ft[,2][3] + 1
  } else if(i >= 60 & i < 70){
    ft[,2][4] <- ft[,2][4] + 1
  }
}

# 2.상대도수 값 구하기(상대도수값을 벡터형으로 구한 뒤 열을 추가하는 방식)
a <- NULL
for(i in 1:4){
  a <- c(a,ft[,2][i]/sum(ft[,2]))
}
a
ft$상대도수 <- a
ft

# 3.누적도수 구하기
nu <- c(0,0,0,0)
a <- 0
for(i in 1:4){
  a <-  a + ft[,2][i]
  nu[i] <- a
}
nu
ft$누적도수 <- nu

#----------------------------------------강사님 답
score
ft <- data.frame(계급=c('90점 이상','80점이상~90점미만','70점이상~80점미만','60점이상~70점미만'),
                   도수=c(0,0,0,0))
#도수
for(i in score){
  if(i >= 90){
    ft[1,2] <- ft[1,2]+1
  }else if(i>=80){
    ft[2,2] <- ft[2,2]+1
  }else if(i>=70){
    ft[3,2] <- ft[3,2]+1
  }else if(i >=60){
    ft[4,2] <- ft[4,2]+1
  }
}

#상대도수
ft$도수 / sum(ft$도수)
ft$상대도수 <- prop.table(ft$도수)
ft

#누적도수
  #첫번째 행의 도수값을 그대로 누적도수에 입력
  #두번째 행의 도수값을 바로 앞에 있는 누적도수의 값으로 더하면 된다.
# 첫번째 행의 누적도수 : ft$누적도수[1] <-ft$도수[1]
# 두번째 행의 누적도수 : ft$누적도수[2] <- ft$누적도수[1] + ft$도수[2]
# 세번째 행의 누적도수 : ft$누적도수[3] <- ft$누적도수[2] + ft$도수[3]

ft$누적도수 <- NULL
for(i in 1:nrow(ft)){
  if(i==1){
    ft$누적도수[i] <- ft$도수[i]
  } else{
    ft$누적도수[i] <- ft$도수[i] + ft$누적도수[i-1]
  }
}
ft


[문제168] 조사된 데이터 값들이 있습니다. 도수분포표를 만드세요.
단 기존값(수치형)을 문자(범주형)로 수정한 후 도수를 구하세요.

(예) 90 ->"90점이상",95 -> "90점이상", 88 -> "80점이상~90점미만"

score

# score의 값들을 범주형으로 수정하기

for(i in 1:length(score)){
  if(score[i] >= 90){
    score[i] <- "90점이상" 
  }else if(score[i] >= 80){
    score[i] <- "80점이상~90점미만"
  }else if(score[i] >= 70){
    score[i] <- "70점이상~80점미만"
  }else if(score[i] >= 60){
    score[i] <- "60점이상~70점미만"
  }
}
score
table(score)
score_df <- data.frame(table(score))

#------------------------다른 방법
categorical <- function(x){
  ifelse(x>=90,"90점이상",
         ifelse(x>=80,"80점이상~90점미만",
                ifelse(x>=70,"70점이상~80점미만",
                       ifelse(x>=60,"60점이상~70점미만",NA))))
  }

s <- categorical(score)
table(s)
data.frame(table(s))

factor(s,levels = c("90점이상","80점이상~90점미만","70점이상~80점미만","60점이상~70점미만"))
df <- data.frame(table(factor(s,levels = c("90점이상","80점이상~90점미만","70점이상~80점미만","60점이상~70점미만"))))

names(df) <- c('계급','도수')
df$상대도수 <- prop.table(df$도수) #상대도수 : prop.table(도수값)
df$누적도수 <- cumsum(df$도수) #누적도수 : cumsum(도수값)
df


계급                도수    상대도수  누적도수
----------------- -------   --------  --------
  90점이상             4       4/20        4
80점이상~90점미만    6                   10
70점이상~80점미만    3                   13
60점이상~70점미만    7                   20

★ cut
연속형 변수를 범주형 변수로 변환하는 함수
score <- scan()
min(score)
max(score)

table(cut(score,breaks=seq(60,100,by=10), right=FALSE)) 
# breaks옵션 : 60~100까지 10단위로 나눔, right=FALSE : [60,70) 60점이상 ~ 70점 미만 (60 <=점수 < 70)
table(cut(score,breaks=seq(60,100,by=10), right=TRUE))
# right=TRUE : (60,70] 60점초과 ~ 70점이하 (60 < 점수 <= 70)
x <- cut(score,breaks=seq(60,100,by=10), right=FALSE,
    labels = c("60점이상~70점미만","70점이상~80점미만","80점이상~90점미만","90점이상"))
result <- cbind(table(x), prop.table(table(x)),cumsum(table(x)))
class(result)
data.frame(result)           

#-----------------------------

[문제169] cost.txt 데이터를  분석하세요.
91 78 93 57 75 52 99 80 97 62
71 69 72 89 66 75 79 75 72 76
104 74 62 68 97 105 77 65 80 109
85 97 88 68 83 68 71 69 67 74
62 82 98 101 79 105 79 69 62 73

cost <- read.csv('c:/data/cost.txt',header=F)
cost <- scan() 
cost <- read.table("c:/data/cost.txt") # data.frame으로 읽어들임
str(cost) # 각 컬럼에 값들이 들어가 있음
dim(cost) # 5행10열을 하나의 행 으로 나열하고 싶을때는
cost <- as.matrix(cost) #matrix형으로 바꾸고
dim(cost) <- c(50,1) # dim(cost) 값을 50행 1열로 바꾸면 됨
cost

# 값의 범위 109에서 52니까 깔끔하게 110~50으로 범위를 잡고 10 단위로 도수표를 만들면 되겠다.
max(cost) # 109
min(cost) # 52
table(cut(cost,breaks =seq(50,110,by=10),right=FALSE))
fac_x <- factor(cut(cost,breaks=seq(50,110,by=10),right=FALSE), 
       labels = c('50이상~60미만','60이상~70미만','70이상~80미만','80이상~90미만','90이상~100미만','100이상'))
df <- data.frame(table(fac_x))
df
df$상대도수 <- prop.table(df$Freq)
df$누적도수 <- cumsum((df$Freq))
rownames(df) <- df[,1]
df <- df[,-1]
names(df)[1] <- '도수'
df

#차트만들어보기
graphics.off()
barplot(as.matrix(df),
        names.arg = names(df),las=2,col = brewer.pal(6,'RdBu'),beside=T)
pie(df[,2],labels = df[,1], col = brewer.pal(6,'RdBu'))
plot(df[,2],)
#

#--------------강사님 답
(1) 최대값, 최소값
(2) 계급의 수
(3) 계습 구간의 크기
(4) 각계급 구간의 속한 수를 세어 보면 된다.
(5) 상대도수, 누적도수

cost_cut <- cut(cost,breaks=seq(50,110,by=10),right=FALSE,
    labels=c('50이상~60미만','60이상~70미만','70이상~80미만','80이상~90미만','90이상~100미만','100이상'))
cost_result <- data.frame(cbind(table(cost_cut),prop.table(table(cost_cut))))
names(cost_result) <- c('도수','상대도수')
cost_result$누적도수 <- cumsum(cost_result$도수)
cost_result


★ 히스토그램(histogram)
- 연속형 자료가 모여 있는 위치나 자료의 분포에 관한 대략적인 정보를 파악할 수 있는 그래프
- 단점은 구체적인 수치정보를 알 수 없다.
cost
hist(cost) #히스토그램
hist(cost,breaks = seq(50,110,by=10),right=FALSE,col=brewer.pal(7,'RdBu'),
     ylim=c(0,20),labels=TRUE)

★ 상자그림(box plot)
- 최소값, 제1사분위수, 중앙값(굵은검은줄), 제3사분위수, 최대값 다섯가지의 요약수치등을 파악할 수 있는 그래프 
- 이상치데이터를 확인할 수 있다.
par(mfrow=c(2,2))
boxplot(1:10, main='1')
boxplot(c(1:10,20),main='2') #이상치 데이터 20 확인
boxplot(cost, main='3')
boxplot(cost,horizontal=T, main='4')

1. 중앙값(median) #평균이랑은 다름
median(cost)

(1) 관측값을 크기순으로 정렬(오름차순)
(2) 관측값의 개수(n) 홀수면 (n+1)/2 번째 관측값
    -(예) 1 2 3 4 5 6 7 8 9 
    n=9  (9+1)/2 = 5 , 5번째 위치값을 리턴
(3) 관측값의 개수(n) 짝수면 n/2 번째 관측값과, (n/2)+1 번째 관측값의 평균
    -(예) 1 2 3 4 5 6 7 8 9 10
    n=10 10/2 = 5, 5번째 위치값
         (10/2)+1 = 6, 6번째 위치값
         (5+6)/2 = 5.5 중앙값
    costs <- sort(cost)
    (costs[25] + costs[26])/2
    median(cost)
2. 사분위수(quartile)
Q1 : 1사분위 Q2(중앙값)보다 작은 데이터의 중앙값,25%
    -(예) 1 2 (3 Q1) 4 5 (5.5 중앙값) 6 7 8 9 10

Q2(중앙값)
  50% Q2 50%
    
Q3 : 3사분위 Q2(중앙값)보다 큰 데이터의 중앙값,75%
  -(예) 1 2 3 4 5 (5.5 중앙값) 6 7 (8 Q3) 9 10

quantile(1:10)
quantile(1:10,type=7) # type=7 기본값
quantile(1:10,type=2) # 보통 중앙값구할 때는 type=2
summary(1:10)

boxplot(c(1:10,20),horizontal=T) 
min(c(1:10,20))
max(c(1:10,20)) 

사분위수범위(Inter Quartile Range)
IQR = Q3-Q1

iqr = 8 - 3 

# 가상의 경계선(울타리선)
upper fence : Q3 + 1.5*IQR
8+1.5*5 = 15.5

lower fence : Q1 - 1.5*IQR
3 - 1.5*5 = -4.5

(-4.5 ~ 15.5) 기준으로 데이터의 최소값, 최대값을 찾는다.# 여기에 속하지 않는 데이터는 이상치 데이터

boxplot(c(1:10,20,-10),horizontal = T)

boxplot.stats(c(1:10,20,-10))
boxplot.stats(c(1:10)) #boxplot의 값들을 보는 함수

exam <- read.csv('c:/data/exam.csv', header=T)
exam              
sql <-exam[exam$subject == 'SQL','grade']
r <-exam[exam$subject == 'R','grade']
python <-exam[exam$subject == 'PYTHON','grade']

boxplot(sql,r,python,names = c('SQL','R','PYTHON'))
boxplot(sql,r,python,names = c('SQL','R','PYTHON'),horizontal=T)

[문제170] store.csv 파일에 있는 데이터를 분석하세요
store <- read.csv('c:/data/store.csv',header=T)
store
graphics.off()
par(mfrow=c(2,2))
hist(store[,1], xlab = 'A')
hist(store[,2], xlab = 'B')
hist(store[,3], xlab = 'C')
?hist
boxplot(store)

quantile(store[,1])
quantile(store[,2])
quantile(store[,3])
summary(store[,1])
summary(store[,2])
summary(store[,3])

#--------------------
par(mfrow=c(2,2))
hist(store$A,main='A배달', xlab = '분',ylab='건수')
hist(store$B,main='B배달', xlab = '분',ylab='건수')
hist(store$C,main='C배달', xlab = '분',ylab='건수')

boxplot(store$A, store$B, store$C, names=c('A','B','C'))

quantile(store$A)
quantile(store$B)
quantile(store$C)

mean(store$B)
mean(store$C)

var(store$B)
var(store$C)

sd(store$B)
sd(store$C)

문제1. median을 사용하지 않고 중앙값을 리턴하는 함수를 만들어주세요.(중앙값에 대해 이해하고 있는지)

med <- function(...){
  a <- c(...)
  x <- NULL
  if(length(a)%%2==1){ # 값의 개수가 홀수일 때
    x <- a[(length(a)+1)/2]
  }else if(length(a)%%2==0){
    x <- (a[length(a)/2] + a[length(a)/2+1])/2
  }else{
    NA
  }
  return(x)
}

med(c(1,2,3,4,5,6,7,8,9))

문제2. 군별로 합을 plot차트로 그리시오(x축은 날짜,감염병x, na값 -> 0)

data <- read.csv('c:/data/감염병_군별_발생현황.csv',header=T) # 데이터 읽어오기
data #확인
names(data)
names(data) <- c('군','감염병','2015','2016','2017','2018','2019')
head(data)
data1 <- data[,-2]
data2 <- reshape2::melt(data1,id=c('군'))
str(data2)
data2$value <- as.integer(data2$value)
data2
data2[is.na(data2$value),'value'] <- 0
data3 <- reshape2::dcast(data2,variable~군,sum)
rownames(data3) <- data3$variable
data3 <- data3[,-1]
data3
plot(data3$제1군,type='o', col='red',xlab="",ylab="",axes=F, ylim=c(0,120000))
lines(data3$제2군,type='o', col='blue', xlab="",ylab="")
lines(data3$제3군,type='o', col='purple', xlab="",ylab="")
lines(data3$제4군,type='o', col='orange', xlab="",ylab="")

axis(1,at=1:5,label=rownames(data3),las=2)
axis(2)
abline(h=seq(0,120000,20000),v=seq(1,10,1),lty=2,lwd=0.2)
legend("topleft",legend = names(data)[1:4],cex=0.5,lty=4, 
       col = c('red','blue','purple','orange'))

#------------------------------------
(1)데이터 읽어오기, 필요없는 행,열제거, 컬럼이름 변경
data <- read.csv('c:/data/감염병_군별_발생현황.csv',header=T) # 데이터 읽어오기
data #확인
data <- data[-1,-2]
data
names(data) <- c('군','2015','2016','2017','2018','2019')
data

(2)날짜와 군 행열 위치 변경
data1 <- reshape2::melt(data,id=c('군'))
str(data1) # value값이 chr형으로 되어 있기때문에 int형으로 수정해야한다
data1$value <- as.integer(data1$value) # value값을 int형으로 수정, Warning message: NAs introduced by coercion  (NAs강제 변환) 이부분은 일단 실행은 되니까 진행
data1[is.na(data1$value),'value'] <- 0 #na값은 0으로 수정
data1
data1 <- reshape2::dcast(data1,variable~군,sum) #variable->행, 군->열, 군,날짜별 합을 구함
data1
rownames(data1) <- data1[,1] #행이름에 날짜 넣기
data1 <- data1[,-1] # 행이름과 중복되는 1열 제거
data1

(3) 그래프
plot(data1$제1군, type='o',xlab="",ylab="", col="red",ylim=c(0,120000), axes=F)
lines(data1$제2군, type='o', col='blue')
lines(data1$제3군, type='o', col='black')
lines(data1$제4군, type='o', col='orange')
axis(1,at=1:5,labels=rownames(data1),las=2)
axis(2)
abline(h=seq(0,120000,by=20000),v=seq(1,10,1),lty=3)
legend("topleft",legend = names(data1), col=c('red','blue','black','orange'),cex=0.5,
       lty=4)
