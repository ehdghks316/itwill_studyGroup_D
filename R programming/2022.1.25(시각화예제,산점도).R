library(RColorBrewer)
display.brewer.all()
display.brewer.pal(10,'RdBu')
par(mfrow=c(1,1))
par(mfrow=c(2,3))
graphics.off()

[문제157] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 SQL 점수를 막대그래프로 출력해주세요.
exam <- read.csv('c:/data/exam.csv',header = T)
exam
x <- exam[exam$subject %in% 'SQL',c('name','grade')]

barplot(height = x$grade,
        names.arg = x$name,
        col = rainbow(NROW(x)),
        main = 'sql점수',
        xlab = '이름',
        ylab = 'sql점수',
        ylim = c(0,100),
        cex.names=0.9,
        horiz = FALSE)

barplot(exam[exam$subject == 'SQL','grade'],
        names.arg = exam[exam$subject == 'SQL','name'],
        las=2,
        ylim=c(0,100),
        main='SQL점수',
        cex.names=0.5,
        border=NA,
        col=rainbow(length(exam[exam$subject == 'SQL','name'])))
exam[exam$subject == 'SQL','name']
[문제158] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 R 점수를 막대그래프로 출력해주세요
x <- exam[exam$subject %in% 'R',c('name','grade')]
library(plotrix)
barplot(height = x$grade,
        names.arg = x$name,
        col = rainbow(NROW(x)),
        main = 'r점수',
        xlab = '이름',
        ylab = 'r점수',
        ylim = c(0,100),
        cex.names=0.8,
        horiz = FALSE)


barplot(exam[exam$subject == 'R','grade'],
        names.arg = exam[exam$subject == 'R','name'],
        las=2,
        ylim=c(0,100),
        main='R점수',
        cex.names=0.7,
        border=NA,
        col=rainbow(length(exam[exam$subject == 'PYTHON','name'])))

[문제159] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 PYTHON 점수를 막대그래프로 출력해주세요.
x <- exam[exam$subject %in% 'PYTHON',c('name','grade')]
library(plotrix)
barplot(height = x$grade,
        names.arg = x$name,
        col = rainbow(NROW(x)),
        main = 'PYTHON점수',
        xlab = '이름',
        ylab = 'PYTHON점수',
        ylim = c(0,100),
        cex.names=0.8,
        horiz = FALSE)

barplot(exam[exam$subject == 'PYTHON','grade'],
        names.arg = exam[exam$subject == 'PYTHON','name'],
        las=2,
        ylim=c(0,100),
        main='PYTHON점수',
        cex.names=0.7,
        border=NA,
        col=rainbow(length(exam[exam$subject == 'PYTHON','name'])))


[문제160] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 과목 총 점수를 막대그래프로 출력하세요.
apply(exam[,'grade'],2,sum)
z <- data.frame(subject = 'TOTAL', sum_sal = sum(exam$grade))
library(dplyr)
x <- exam%>%
  group_by(subject)%>%
  summarise(sum_sal = sum(grade))
y <- rbind(x,z)

barplot(height = y$sum_sal,
        names.arg = y$subject,
        col = rainbow(NROW(y)),
        main = '과목, 총합',
        xlab = '과목명',
        ylab = '총합',
        ylim = c(0,2000),
        cex.names= 0.8,
        horiz = FALSE)

exam_total <- aggregate(grade~name,exam,sum)

barplot(exam_total$grade,
        names.arg = exam_total$name,
        las=2,ylim=c(0,300),main='총점수',
        cex.names=0.7,border=NA,
        col=brewer.pal(NROW(exam),'RdBu'))


[문제161] 학생들의 이름을 기준으로 과목점수를 스택형 막대그래프로 생성하세요.

t <- tapply(exam$grade,list(exam$subject,exam$name),sum)
class(t)
bp <- barplot(t,
        names.arg = colnames(t),
        las=2,
        ylim=c(0,300),
        main='과목총점수',
        cex.names=0.7,
        border=NA,
        col=rainbow(3))
legend('topright',legend = rownames(t),title = '과목',pch=15,
       col = rainbow(3),cex=0.5)
abline(h=seq(100,300,50),col='red',lty=2)

t <- tapply(exam$grade,list(exam$subject,exam$name),sum)
install.packages("plotrix")
library(plotrix)
plotrix::barlabels(bp,t,bg=rainbow(5),border=NA,cex=0.5)


[문제162] 학생들의 이름을 기준으로 과목점수를 그룹형 막대그래프로 생성하세요.
t
bp <- barplot(t,
        names.arg = colnames(t),
        las=2,
        ylim=c(0,100),
        main='과목총점수',
        cex.names=0.7,
        border=NA,
        col=rainbow(3),beside=TRUE)
legend('topright',legend = rownames(t),title = '과목',pch=15,
       col = rainbow(3),cex = 0.5)

plotrix::barlabels(bp,200,t,bg=rainbow(3),border=NA,cex=0.5)

[문제163] 구별 진료과목별 병원현황을 그룹형 막대그래프로 시각화 해주세요.
data <- read.csv('c:/data/kosis.csv',header=T)
data
head(data)
data <- data[,-1]
names(data) <- data[1,]
data <- data[c(-1,-2),-2]
names(data)[1] <- '구'
data
data.frame(data)
str(t(data))
data[,2:27] <- lapply(data[,2:27],as.integer)
str(data)
data

par(mfrow=c(2,3))
for(i in 1:6){
  barplot(as.matrix(data[i,2:7]),
          names.arg = names(data)[2:7],
          main = '구별 진료과목별 병원현황',
          xlab='진료과목',
          ylab='병원개수',
          ylim=c(0,200),
          las=2, cex.names=0.8,
          col = brewer.pal(6,'RdBu'))
}


data <- t(data)
data <- data.frame(data)
str(data)
names(data) <- data[1,]
data <- data[-1,]
data
data[,1:25] <- lapply(data[,1:25],as.integer)
barplot(as.matrix(data[1:6,1:6]), beside=T,
        col= brewer.pal(6,'RdBu'), main = '구별/진료과목별 병원현황')

#---------------------- 강사님
names(data) <- data[1,]
data
head(data[-1,c(-1,-3)])
data <- data[-1,c(-1,-3)]
data <- data[-1,]
head(data)
names(data)[1] <- "구"
head(data)

t(data) # 다 문자형으로 바뀜
new <- data.frame(t(data))
str(new)
names(new) <- new[1,]
str(new)
new <- new[-1,]
head(new)
str(new) #수치형만 그래프를 그릴 수 있기에 이 new에 있는 문자형 값은 그래프를 그릴 수 없다.

for(i in 1:25){
  new[,i] <- as.integer(new[,i])
}
str(new)

new[,1:25] <-lapply(new[,1:25],as.integer) # 위의 for문 대신에 integer형으로 한꺼번에 바꾸어줄 수 있음
str(new)
new
barplot(as.matrix(new[1:9,1:11]),beside=T,
        col= brewer.pal(6,'RdBu'), main = '구별/진료과목별 병원현황') #데이터프레임은 안되고 vector나 matrix만 가능
par(mfrow=c(1,1))
[문제164] 구별 진료과목에 해당하는 병원수를 막대형 그래프로 만드세요.
단 막대높이 10개당 1개로 만드세요.
#1개의 barplot당 1개의 구가 진료과목별로 나오는데 반복문을 사용해서 26개의 구를 다 보일 수 있게 하는 문제

data <- read.csv('c:/data/kosis.csv',header=T)
data
names(data) <- data[1,]
head(data)
data <- data[c(-1,-2),c(-1,-3)]
head(data)
str(data)
names(data)[1] <- '구'
data
data[1,1:9]
rownames(data) <- data[,1]
data <- data[,-1]
data <- data.frame(t(data))
data
str(data)
str(new)
data [,1:25] <- lapply(data[,1:25],as.integer)
data  <- as.matrix(data)

gu <- rownames(data)
for(i in 2:10){
  barplot(data[1:9,i] ,
          axes = F, xlab="",
          names.arg = rownames(data)[1:9],
          cex.names=0.8,
          col = rainbow(11),
          border= "white",
          main = paste(gu[i],"병원현황"),
          las=2,ylim = c(0,50))
  axis(2,ylim=seq(0,50,10))
  abline(h=seq(0,50,5),lty=2)
  
}


#-------------------------강사님답
graphics.off()

barplot(new[1:9,1]*0.1,
        axes=F, xlab="",
        names.arg = rownames(new)[1:9],
        cex.names=0.8,
        col = rainbow(9),
        border = "white",
        main = paste(gu[1],"병원현황"),
        las=2,ylim=c(0,50))
axis(2,ylim=seq(0,50,10))
abline(h=seq(0,50,5),lty=2)

gu <- names(new)
graphics.off()
par(mfrow=c(2,5))
for(i in 2:10){
  barplot(new[1:9,i]*0.1,
          axes=F, xlab="",
          names.arg = rownames(new)[1:9],
          cex.names=0.8,
          col = rainbow(9),
          border = "white",
          main = paste(gu[i],"병원현황"),
          las=2,ylim=c(0,10))
  axis(2,ylim=seq(0,50,10))
  abline(h=seq(0,50,5),lty=2)
  
}

#----------------------------------
감염병 군별 발생현황 데이터
[문제165] 2015~2019년도별 1군 전염병 발생 현황에 대해 시각화 해주세요.

data <- read.csv('c:/data/감염병_군별_발생현황.csv',header=T)
data
#군별로 그룹해서 1군만 뽑고 1군이라고 작성된 열을 제거, 날짜 행들과 감염병군별열을 t트랜스로 바꿔주고 값들을 integer형으로 하고 그래프 만들기
data

library(dplyr)
new <- data%>%
  group_by(법정감염병군별.1.)%>%
  filter(법정감염병군별.1. =='제1군')
new <- data.frame(new)
new <- new[-1,-1]
rownames(new) <- new[,1] 
new <- new[,-1]
names(new) <- c('2015','2016','2017','2018','2019')
str(new)
new[,1:5] <- lapply(new[,1:5],as.integer)
str(new)
library(RColorBrewer)
bq <- barplot(as.matrix(new), beside = T,
        names.arg = names(new),axes=F,
        main = '년도별 제1군 감염자수',
        xlab='년도',
        ylab='감염자',
        col = brewer.pal(NROW(new),'RdBu'))
legend('topleft',legend=rownames(new),pch=15,col=brewer.pal(NROW(new),'RdBu'),cex = 0.8)
abline(h=seq(0,15000,5000),lty=2)
axis(2,ylim=seq(0,15000,3000))


new <- t(new)
new <- data.frame(new)
new[,1:6] <- lapply(new[,1:6],as.integer)
str(new)
barplot(as.matrix(new[1,1:5]))
graphics.off()
par(mfrow=c(2,3))
years <- names(new)
for(i in 1:5){
  barplot(as.matrix(new[1:5,i]),beside=T,
          axes = F,xlab="",
          names.arg = rownames(new)[1:5],
          cex.names=0.9,
          col = rainbow(6),
          border = "white",
          main = paste(years[i],"년 제1군감염"),
          las=2)
  axis(2,ylim=seq(0,50,10))
  abline(h=seq(0,50,5),lty=2)
}

graphics.off()

#-------------------강사님
data <- read.csv('c:/data/감염병_군별_발생현황.csv',header=T)
data <- data[data$법정감염병군별.1. =="제1군",]
data <- data[-1,-1]
names(data) <- c("전염병","2015","2016","2017","2018","2019")
data
str(data)

data[,2:6] <- lapply(data[,2:6],as.integer)
str(data)
par(mfrow=c(1,1))
barplot(as.matrix(data[,-1]),beside=T,las=2,
        main='제1군 년도별 감염병발생현황')

bp <- barplot(as.matrix(data[data$전염병 != 'A형간염',-1]),
        beside=T, col=rainbow(5),las=2,ylim=c(0,250))
legend("topright",title="질병",legend=data$전염병[1:5],
       cex=0.5,pch=15,col=rainbow(5),box.lty=0)
library(plotrix)
as.matrix(data[data$전염병 != 'A형간염',-1])
plotrix::barlabels(bp,100,as.matrix(data[data$전염병 != 'A형간염',-1]),
                   bg=NA,border=NA,cex=0.5)

★ 산점도(scatter plot)
- 주어진 데이터를 점으로 표시해 흩뿌리듯이 시각화한 그래프
- 데이터의 실제값들이 표시되므로 분포를 한눈에 살펴보는데 유용
-  x-y plotting

data()

?women

plot(women$height)
plot(women$weight)
plot(x=women$height,y=women$weight,
     xlab="키", ylab="몸무게",
     main="여성의 키와 몸무게", sub="미국 70년대 기준",
     type='b', lty = 2, lwd = 5, pch=23, cex = 2,
     col= 'darkblue'
     )
type
p : 점, l : 선, b : 점,선,
c: b의 선, o : 점위의 선, h :수직선, s : 계단형 , n: 나타나지 않음

lty : 선의 유형( 0~6)
lwd : 선의 굵기(기본값 1)
pch : 점의 종류

data <- read.csv('c:/data/감염병_군별_발생현황.csv',header=T)
data <- data[data$법정감염병군별.1. =="제1군",]
data <- data[-1,-1]
names(data) <- c("전염병","2015","2016","2017","2018","2019")
data
str(data)

data[,2:6] <- lapply(data[,2:6],as.integer)
str(data)
par(mfrow=c(1,1))
#data[data$전염병 != 'A형간염',-1]
t(data)
new <- data.frame(t(data))
str(new)
names(new) <- new[1,]
new <- new[-1,]
new
str(new)
new[,1:6] <- lapply(new[,1:6],as.integer)
str(new)

plot(new$콜레라,xlab="",ylab="",ylim=c(0,300),
     axes=F,type='o', col="violet")
lines(new$장티푸스,type='o', col="blue")
lines(new$파라티푸스,type='o', col="red")
lines(new$세균성이질,type='o', col="black")
lines(new$장출혈성대장균감염증,type='o', col="green")

axis(1,at=1:5,label=rownames(new),las=2)
axis(2)
abline(h=seq(0,300,50),v=seq(1,10,1),lty=3,lwd=0.2)
legend("topright",legend=names(new)[1:5],cex=0.5,lty=2,lwd=1,
       col=c('violet','blue','red','black','green'))
