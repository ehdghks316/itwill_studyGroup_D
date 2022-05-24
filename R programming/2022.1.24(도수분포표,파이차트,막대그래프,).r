★ 양적 자료
- 숫자, 크기로 측정되는 값
- 연속형자료 : 실수형, 키, 몸무게 ...
- 이산형자료 : 정수형, 남학생수, 여학생수, 출생아수...

★ 질적 자료(범주형)
- 자료에 내포하고 있는 의미가 있는 데이터를 의미한다.
- 순위형자료 : 학점(A,B,C..), 설문조사(좋음,보통,나쁨)
- 명목형자료 : 성별(남, 여), 혈액형(A,B,O,AB), 거주지역

              요약방법        자료정리        그래프
-----------------------------------------------------------------
질적자료      표              도수분포표      원, 막대그래프
                              빈도표          
                              상대빈도표


양적자료      수치,표         도수분포표      히스토그램,상자도표,
                              합,평균,        산점도,막대그래프
                              분산, 표준편차,
                              최대값,최소값,
                              범위,중앙값


★ pie chart
- 범주형 자료에 대한 상대도수분포표를 나타내기 위해 일반적으로 사용되는 그래프
- 원을 그린후 그 원에 각 계급의 상대도수에 대응하는 면적 또는 부분으로 나눈다.

예) s회사에서 새로 개발한 스마트폰의 디자인에 대하여 고객 100명을 임의로 뽑아 선호도 조사를 했다.
100명중에 45명이 좋다. 25명은 보통, 20명은 싫다. 10명은 답을 하지 않았다.
조사에 대한 도수분포표(빈도표)를 생성해보자

▶도수분포표(FREQUENCE TABLE)
범주형 자료에 대해서 도수와 상대도수를 나열하는 표

선호도    도수    상대도수        각도
--------------------------------------------------
좋다      45      45/100 = 0.45   360 * 0.45 
보통      25      25/100 = 0.25   360 * 0.25 
싫다      20      20/100 = 0.2    360 * 0.2  
무응답    10      10/100 = 0.1    360 * 0.1  

data <- data.frame(labels = c('좋다','보통','싫다','무응답'),
                   frequency = c(45,25,20,10))
data$상대도수 <- data$frequency/sum(data$frequency)
data

pie(data$상대도수, labels=data$labels)

?pie
pie(data$상대도수, 
    labels=paste0(data$labels,' ',data$상대도수*100,'%'),
    col=c("red","blue","yellow","green"),
    main='고객만족도조사',
    cex=0.8,
    lty=3)

colors()    
palette()
pie(rep(1,12),col=1:12)
pie(rep(1,12),col=rainbow(12))
pie(rep(1,12),col=heat.colors(12))
pie(rep(1,12),col=terrain.colors(12))
pie(rep(1,12),col=topo.colors(12))
pie(rep(1,12),col=cm.colors(12))

library(RColorBrewer)
display.brewer.all()
display.brewer.pal(8,"Dark2")

pie(data$상대도수, 
    labels=paste0(data$labels,' ',data$상대도수*100,'%'),
    col=brewer.pal(8,"Dark2"),
    main='고객만족도조사',
    cex=0.8,
    lty=3)

[문제152] blood.csv 파일을 읽어 들여서 도수분포표를 작성하고 pie chart도 생성
blood <- read.csv('c:/data/blood.csv',header = T)
blood
a <- aggregate(NAME~BLOODTYPE,blood,NROW)
a
a <- cbind(a,a$NAME/sum(a$NAME))
a
names(a)[c(2,3)] <- c('cn','pct')
a
a <- rbind(a,c('total',0,0))
a
a[5,2] <- sum(as.integer(a$cn))
a[5,3] <- sum(as.numeric(a$pct))
a
a$cn <- as.integer(a$cn)
a$pct <- as.numeric(a$pct)

pie(a$pct,
    labels=paste0(a$BLOODTYPE,' ',as.numeric(a$pct)*100,'%'),
    col=brewer.pal(8,"Dark2"),
    main='혈액형조사',
    cex=1.5,
    lty=3)

x <- aggregate(NAME~BLOODTYPE,blood,length)
names(x)[2] <- 'CN'
x$PCT <- x$CN/sum(x$CN)
x
x <- rbind(x, list('total',sum(x$CN),sum(x$PCT)))
x

pie(x$PCT[1:4],
    labels=paste0(x$PCT[1:4]*100,'%'),
    main='혈액형분포',
    col=brewer.pal(4,"Set1"),
    clockwise=T)
legend("topleft",x$BLOODTYPE[1:4],fill=brewer.pal(4,"Set1"),cex=0.5) #범례

#clockwise=T(시계방향),F(반시계방향)

install.packages("plotrix")
library(plotrix)

p <- plotrix::pie3D(x$PCT[1:4],
               labels=paste0(x$PCT[1:4]*100,'%'),
               labelcex=0.7,
               main='혈액형분포',
               explode=0.1,
               shade=0.5)

plotrix::pie3D.labels(p,labels = x$BLOODTYPE[1:4],
                      labelcex = 0.5,
                      labelrad = 0.8,
                      labelcol = "darkblue")


[문제153] survey.csv 파일을 읽어 들여서 도수분포표를 작성 하시고 pie chart도 생성해 주세요.
df <- data.frame()
survey <- read.csv("c:/data/survey.csv", header = F)
survey <- t(survey)
str(survey)
survey
dim(survey)
survey <- data.frame(name=t(survey))
str(survey)

library(dplyr)
survey%>%
  group_by(name)%>%
  summarise(cnt=n())

library(sqldf)
sqldf('select name, count(*) 
from survey 
group by name;
')

result <- aggregate(rownames(survey)~name,survey,length)
names(result)[2] <- "빈도"
result$상대도수 <- result$빈도/sum(result$빈도)
result

label <- paste(result$name,result$상대도수 *100)
label <- paste0(label,'%')
label
pie(result$상대도수,labels=label)

x <- c('a','b','a','a','b','c')
x
sum(x=='a')
sum(TRUE,FALSE,TRUE) #TRUE의 건수를 세어줌, TRUE가 1이라고 생각하면 됨

# table() : 데이터 빈도수를 생성하는 함수
table(x)

survey <- read.csv("c:/data/survey.csv", header = F)
survey

table(t(survey))
table(employees$DEPARTMENT_ID)

x <- c('a','b','a','a','b','c')
x
table(x)
sum(table(x))
table(x)

c(table(x),sum(table(x)))


# addmargins() : 빈도값의 핪을 구하는 함수
addmargins(table(x))

table(x)/sum(table(x))

# prop.table() : 상대도수를 구하는 함수
prop.table(table(x))


survey <- read.csv("c:/data/survey.csv", header = F)
survey

data.frame(table(t(survey)))
addmargins(table(t(survey)))
prop.table(table(t(survey)))

survey <- read.csv('c:/data/survey.csv',header=F)
survey
data.frame(t(survey))
table(t(survey))
addmargins(table(t(survey)))
prop.table(table(t(survey)))

merge(data.frame(table(t(survey))),
data.frame(prop.table(table(t(survey)))),by='Var1')

#빈도표
table(employees$JOB_ID)
xtabs(~JOB_ID,employees)

tapply(employees$EMPLOYEE_ID,list(employees$JOB_ID,employees$DEPARTMENT_ID),length,default=0)
table(employees$JOB_ID,employees$DEPARTMENT_ID)
xtabs(~JOB_ID+DEPARTMENT_ID,employees)

tapply(employees$SALARY,list(employees$JOB_ID,employees$DEPARTMENT_ID),sum,default=0)

x <- xtabs(SALARY~JOB_ID+DEPARTMENT_ID,employees)

#행의합
apply(x,1,sum)
rowSums(x)
addmargins(x)
addmargins(x,2) # 2는 각 행의 열들의 합
margin.table(x) # 전체합
margin.table(x,1)

#열의합
apply(x,2,sum) # 2: 열기준
colSums(x)
margin.table(x,2)
addmargins(x,1)

#행,열의 합
addmargins(x,c(1,2))

#상대비율
prop.table(x)
prop.table(x,1) # 1, 행기준
prop.table(x,2) # 2, 열기준

★ 막대그래프
-빈도표(도수분포표)를 활용하여 각 수준(도수)의 값(크기)을 높이(막대)로 표현하는 그래프

sales <- c(150,100,70,30)
team <- c("영업1팀","영업2팀","영업3팀","영업4팀")

#수직막대그래프
barplot(height = sales,
        names.arg = team,
        col=rainbow(length(sales)),
        main = "영업팀별 영업 실적",
        xlab = "영업팀",
        ylab = "영업실적(억원)",
        ylim = c(0,200),
        cex.names=0.8,
        horiz=FALSE)
        
#수평막대그래프
barplot(height = sales,
        names.arg = team,
        col=rainbow(length(sales)),
        main = "영업팀별 영업 실적",
        ylab = "영업팀",
        xlab = "영업실적(억원)",
        xlim = c(0,200),cex.names=0.8,
        horiz=TRUE)

[문제154] 부서별 인원수를 막대그래프로 시각화 하시오.
dept <- table(employees$DEPARTMENT_ID)
dept <- data.frame(dept)
barplot(height = dept$Freq,
        names.arg = dept$Var1,
        col = rainbow(NROW(dept)),
        main = '부서별 인원수',
        xlab = '부서',
        ylab = '인원수(명)',
        ylim = c(0,50),
        cex.names = 0.8,
        horiz=FALSE)

barplot(height = dept$Freq,
        names.arg = dept$Var1,
        col = rainbow(NROW(dept)),
        main = '부서별 인원수',
        ylab = '부서',
        xlab = '인원수(명)',
        xlim = c(0,50),
        cex.names = 0.8,
        horiz=TRUE)

[문제155] 부서이름별 총액급여에 대한 막대그래프를 생성하세요.
단 부서가 없는 사원들의 총액급여도 포함해주세요.
departments <- read.csv('c:/data/departments.csv',header = T)
emp <- employees[,c('DEPARTMENT_ID','SALARY')]
dept <- merge(emp,departments,by='DEPARTMENT_ID')[,c('DEPARTMENT_NAME','SALARY')]
dept
dept2 <- aggregate(SALARY~DEPARTMENT_NAME,dept,sum)

barplot(height = dept2$SALARY,
        names.arg = dept2$DEPARTMENT_NAME,
        col = rainbow(NROW(dept2)),
        main = '부서이름별 총액급여',
        xlab = '부서이름',
        ylab = '총액급여(원)',
        ylim = c(0,350000),
        cex.names = 0.9,
        horiz = FALSE)

barplot(height = dept2$SALARY,
        names.arg = dept2$DEPARTMENT_NAME,
        col = rainbow(NROW(dept2)),
        main = '부서이름별 총액급여',
        ylab = '부서이름',
        xlab = '총액급여(원)',
        xlim = c(0,350000),
        cex.names = 0.9,
        horiz = TRUE)

dept_sal <- employees%>%
  group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY))

result <- dept_sal%>%
  dplyr::left_join(departments)%>%
  select(DEPARTMENT_NAME,sum_sal)

barplot(height = result$sum_sal,
        names.arg = result$DEPARTMENT_NAME,
        col = rainbow(NROW(result)),
        main = "부서이름별 총액",
        xlab = "부서이름",
        ylab = "총급여",
        ylim = c(0,350000),
        las=2,cex.names=0.5,
        cex.axis=0.5)

text(5,340000,labels='오늘 하루도 행복하자')

bp <- barplot(height = result$sum_sal,
        names.arg = result$DEPARTMENT_NAME,
        col = rainbow(NROW(result)),
        main = "부서이름별 총액",
        xlab = "부서이름",
        ylab = "총급여",
        ylim = c(0,350000),
        las=2,cex.names=0.5,
        cex.axis=0.5)
text(x=bp,
     y=result$sum_sal,
     labels = result$sum_sal,
     cex=0.5,
     pos=3)
pos=1 : 막대끝선의 아래쪽
pos=2 : 막대끝선의 왼쪽
pos=3 : 막대끝선의 위쪽
pos=4 : 막대끝선의 오른쪽

막대그래프에 최대값, 최소값만 출력 

result[is.na(result$DEPARTMENT_NAME),1] <- '부서(X)'
result

bp <- barplot(height = result$sum_sal,
              names.arg = result$DEPARTMENT_NAME,
              col = rainbow(NROW(result)),
              main = "부서이름별 총액",
              xlab = "부서이름",
              ylab = "총급여",
              ylim = c(0,350000),
              las=2,cex.names=0.5,
              cex.axis=0.5)

text(x=bp[result$sum_sal == max(result$sum_sal)],
     y=max(result$sum_sal),
     labels=max(result$sum_sal),
     cex=0.5,
     pos=3)
text(x=bp[result$sum_sal == min(result$sum_sal)],
     y=min(result$sum_sal),
     labels=min(result$sum_sal),
     cex=0.5,
     pos=3)

★ stacked bar plot

x1 <- c(2,6,9,5)
x2 <- c(8,10,15,6)
data <- rbind(x1,x2)
name <- c('1팀','2팀','3팀','4팀')
label <- c('2020년','2021년')

barplot(height=data, names.arg = name,
        main='팀별실적',
        xlab='팀',ylab='판매실적',
        ylim=c(0,30),
        legend.text=label,
        col=c('purple','red'))

★ group bar plot

barplot(height=data, names.arg = name,
        beside=T,
        main='팀별실적',
        xlab='팀',ylab='판매실적',
        ylim=c(0,20),
        legend.text=label,
        col=c('purple','red'))

[문제156] fruits_sales.csv을 읽어 들인후 년도별, 과일이름별 판매량을 
그룹형 막대그래프로 시각화 해주세요.
sales <- read.csv('c:/data/fruits_sales.csv',header = T)
sales

tapply(sales$qty,list(sales$name,sales$year),sum)
x <- xtabs(qty~name+year,sales)
barplot(x,beside=TRUE,
        xlab='년도', ylab='판매량',
        col=c('red','yellow','green','orange'),
        ylim=c(0,20))
legend('topleft',legend=rownames(x),
       col=c('red','yellow','green','orange'),
       pch = 15, cex= 0.5)
title(main = '년도별 과일 판매량')


barplot(x,beside=FALSE,
        xlab='년도', ylab='판매량',
        col=c('red','yellow','green','orange'),
        ylim=c(0,50))
legend('topleft',legend=rownames(x),
       col=c('red','yellow','green','orange'),
       pch = 15, cex= 0.5)
title(main = '년도별 과일 판매량')
