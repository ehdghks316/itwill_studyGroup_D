[문제171] 사원들의 급여의 분포를 histogram, boxplot을 이용해서 시각화 해주세요.
employees <- read.csv('c:/data/employees.csv',header=T)
employees
emp <- employees[,c('EMPLOYEE_ID','SALARY')]
h <- hist(emp$SALARY)

h

boxplot(emp$SALARY)
min(emp$SALARY)
max(emp$SALARY)
table(cut(emp$SALARY,breaks=seq(2000,24000,by=2000),right=F))

hist(employees$SALARY,breaks = seq(0,25000,5000),right=F,
     labels=T,ylim=c(0,60),
     xlab='급여',ylab='빈도수',main='급여 히스토그램')

h <- hist(employees$SALARY,breaks = 10,right=F,
     labels=T,ylim=c(0,60),
     xlab='급여',ylab='빈도수',main='급여 히스토그램')
h

hist(employees$SALARY,breaks = c(0,5000,10000,15000,20000,25000),right=F,
      labels=T,ylim=c(0,60),
      xlab='급여',ylab='빈도수',main='급여 히스토그램')

b <- boxplot(employees$SALARY)
b
text(1.2,b$out,b$out,col='red')
b$out

h <-hist(employees$SALARY,breaks = seq(0,25000,5000),right=F,
         labels=T,ylim=c(0,60),
         xlab='급여',ylab='빈도수',main='급여 히스토그램')
#employees데이터프레임에서 salary컬럼으로 histogram을 만든다. 
#breaks옵션으로 0~25000까지 5000단위로 나눔, right=f는 0이상 5000미만 ~~
#labels=T는 그래프의 각 막대마다 값을 표시,ylim은 y축의 눈금 범위 정할 수 있다
boxplot(employees$SALARY)

#-----------------------------------
★ ggplot2

library(ggplot2)

?mtcars
mtcars$cyl
barplot(mtcars$cyl)
barplot(table(mtcars$cyl))

factor(mtcars$cyl) #있는 값으로만 x축을 표현하기 위해서 사용
ggplot(data=mtcars,aes(x=factor(cyl))) + 
  geom_bar()

df <- data.frame(table(mtcars$cyl))
ggplot(data=df,aes(x=Var1,y=Freq)) + 
  geom_col(fill='lightblue', colour='black') # geom_col은 y축이 꼭 필요
#fill 색, colour테두리색
ggplot(data=df,aes(x=Var1,y=Freq))+
  geom_col(fill='lightblue', colour='black')

exam <- read.csv("c:/data/exam.csv",header=T)
sql <- exam[exam$subject=='SQL',]
sql

#geom_col
barplot(sql$grade)
ggplot(data=sql,aes(x=name,y=grade)) + # aes축표현
  geom_col(fill=rainbow(nrow(sql)))+
  theme(axis.text.x = element_text(angle = 45, hjust=1,vjust = 1, colour = 'blue',size = 7)) + # axis.text.x x축의 텍스트를 45도 각도로 표현,hjust x축수직,vjust x축수평
  labs(title="SQL시험점수",x="학생이름",y="점수") + # 제목
  theme(plot.title = element_text(face="bold",color="darkblue",hjust=0.5,size=20)) + #plot.title : title 제목을 수정할 때 사용, hjust는 숫자로 위치 결정
  theme(axis.title.x = element_text(face="bold.italic")) + #x축 제목
  theme(axis.title.y = element_text(angle=45,vjust = 0.5)) # y축 제목

#geom_bar
ggplot(data=sql,aes(x=name,y=grade)) +
  geom_bar(stat='identity', fill=rainbow(nrow(sql))) +
  theme(axis.text.x = element_text(angle = 45, hjust=1,vjust = 1, colour = 'blue',size = 7)) + # axis.text.x x축의 텍스트를 45도 각도로 표현,hjust x축수직,vjust x축수평
  labs(title="SQL시험점수",x="학생이름",y="점수") + # 제목
  theme(plot.title = element_text(face="bold",color="darkblue",hjust=0.5,size=20)) + #plot.title : title 제목을 수정할 때 사용, hjust는 숫자로 위치 결정
  theme(axis.title.x = element_text(face="bold.italic")) + #x축 제목
  theme(axis.title.y = element_text(angle=45,vjust = 0.5)) # y축 제목

#stat = 'identity' : y축에 명시한 값을 기준으로 그래프를 표현

# 스택형 막대그래프,geom_bar
ggplot(data=exam, aes(x=name,y=grade,fill=subject))+
  geom_bar(stat='identity')+ 
  geom_text(aes(y=grade,label=paste0(grade,'점')),
            position = position_stack(vjust = 0.5),
            col='blue',size=3)
# 스택형 막대그래프,geom_col
ggplot(data=exam,aes(x=name,y=grade,group=subject))+
  geom_col(aes(fill=subject)) +
  geom_text(aes(label=grade),
            position = position_stack(vjust=0.5))

# 기본값 스택형
ggplot(data=exam,aes(x=name,y=grade,group=subject))+
  geom_col(aes(fill=subject),position = 'stack') +
  geom_text(aes(label=grade),
            position = position_stack(vjust=0.5))

# 그룹형 막대그래프
ggplot(data=exam,aes(x=name,y=grade,group=subject))+ # 과목별
  geom_col(aes(fill=subject), position='dodge') +
  geom_text(aes(label=grade),
            position = position_dodge(1))

ggplot(data=exam,aes(x=subject,y=grade,group=name))+ # 이름별
  geom_col(aes(fill=name), position='dodge') +
  geom_text(aes(label=grade),
            position = position_dodge(1))

[문제172] 부서인원수를 ggplot을 이용해서 막대그래프로 시각화 해주세요.
?ggplot
library(RColorBrewer)
library(plyr)
dept_cnt <- plyr::ddply(employees,'DEPARTMENT_ID',summarise,cnt=length(EMPLOYEE_ID)) #na값까지 포함
dept_cnt
factor(employees$DEPARTMENT_ID)

#geom_bar
ggplot(data=dept_cnt,aes(x=factor(DEPARTMENT_ID),y=cnt))+
  geom_bar(stat='identity', fill=rainbow(nrow(dept_cnt)))+
  geom_text(aes(label=cnt),vjust=0.1,size=2,col='red')+
  labs(title="부서별 인원 현황",x="부서번호",y="인원수")+
  theme(plot.title=element_text(face="bold",color="darkblue",hjust=0.5))+
  coord_flip() ##수직형인 그래프를 수평형으로 변경, 큰 제목이 그대로


library(dplyr)
emp <- employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(num = NROW(EMPLOYEE_ID))

ggplot(data=emp,aes(x=factor(DEPARTMENT_ID),y=num))+
  geom_col(aes(fill=rainbow(nrow(emp))))

#geom_col           
ggplot(data=dept_cnt,aes(x=factor(DEPARTMENT_ID),y=cnt))+
  geom_col(fill=rainbow(nrow(dept_cnt)))+
  geom_text(aes(label=cnt),vjust=0.1,size=2,col='red')+
  labs(title="부서별 인원 현황",x="부서번호",y="인원수")+
  theme_bw()+ # 뒷배경 흰색
  theme(plot.title=element_text(face="bold",color="darkblue",hjust=0.5))+ # 순서 중요
  coord_flip() #수직형인 그래프를 수평형으로 변경

ggplot(data=dept_cnt,aes(x=factor(DEPARTMENT_ID),y=cnt))+
  geom_col(fill=rainbow(nrow(dept_cnt)))+
  geom_text(aes(label=cnt),vjust=0.1,size=2,col='red')+
  labs(title="부서별 인원 현황",x="부서번호",y="인원수")+
  theme(plot.title=element_text(face="bold",color="darkblue",hjust=0.5))+
  scale_x_discrete(labels=c(paste('10',"\n","부서"),20,30,40,50,60,70,80,90,100,110,'부서x'))+ #x축 눈금들 수정
  scale_y_discrete()

[문제173] fruits_sales.csv를 읽어들인 후, 년도별 과일이름별 판매량을  
ggplot을 이용해서 스택형,그룹형 막대 그래프로 만드세요

sales <- read.csv('c:/data/fruits_sales.csv',header=T)
sales
library(ggplot2)
ggplot(data=sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name))
sales
?geom_col
ggplot(data=sales,aes(x=name,y=qty,group=year))+
  geom_bar(stat = 'identity', fill=rainbow(nrow(sales)))

ggplot(data=sales,aes(x=name,y=qty,group=year))+
  geom_bar(stat = 'identity', fill=rainbow(nrow(sales)),position = 'dodge')

#--------------------강사님
x <- xtabs(qty~name+year,sales)
x
bp <- barplot(x,beside=T,xlab="년도",ylab="판매량",
        col=rainbow(4),ylim=c(0,20))
legend("topleft",legend=rownames(x), col=rainbow(4),pch=15, cex=0.5)
title(main="년도별 과일 판매량")
library(plotrix)
plotrix::barlabels(bp,5,x,bg=NA,border=NA,cex=0.5)

bp <- barplot(x,beside=F,xlab="년도",ylab="판매량",
              col=rainbow(4),ylim=c(0,50))
legend("topleft",legend=rownames(x), col=rainbow(4),pch=15, cex=0.5)
title(main="년도별 과일 판매량")
library(plotrix)
plotrix::barlabels(bp,x,bg=NA,border=NA,cex=0.5)

#ggplot
ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='stack')+
  geom_text(aes(label=qty),position=position_stack(vjust=0.5))+
  labs(title='년도별 과일 판매량', x='년도',y='과일수량')+
  guides(fill=guide_legend(title="과일"))+ # 범례수정
  scale_fill_discrete(labels=c("사과","바나나","베리","오렌지"))+ # 범례 이름 수정
  theme(legend.title.align = 0.5,
        legend.box.background = element_rect())

#ggplot 그룹형
ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='dodge')+
  geom_text(aes(label=qty),position=position_dodge(1))+
  labs(title='년도별 과일 판매량', x='년도',y='과일수량')+
  guides(fill=guide_legend(title="과일"))+ # 범례수정
  scale_fill_discrete(labels=c("사과","바나나","베리","오렌지"))+ # 범례 이름 수정
  theme(legend.title.align = 0.5,
        legend.box.background = element_rect())

ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='stack')+
  geom_text(aes(label=qty),position=position_stack(vjust=0.5,size=3))+
  labs(title='년도별 과일 판매량', x='년도',y='과일수량')+
  guides(fill=guide_legend(title="과일"))+ # 범례수정
  scale_fill_manual(values = c("red","yellow","brown","orange"),
                    labels=c("사과","바나나","베리","오렌지"))+
  #scale_fill_discrete(labels=c("사과","바나나","베리","오렌지"))+ # 범례 이름 수정 scale_fill_manual이랑 같이 못 씀
  theme(legend.title.align = 0.5,
        legend.box.background = element_rect())

ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='stack')+
  geom_text(aes(label=qty),position=position_stack(vjust=0.5,size=3))+
  labs(title='년도별 과일 판매량', x='년도',y='과일수량')+
  guides(fill=guide_legend(title="과일"))+ # 범례수정
  scale_fill_brewer(palette = 'Set1',labels=c("사과","바나나","베리","오렌지"))

  
[문제174] 요일별 입사인원수를  ggplot을 이용해서 시각화 해주세요.

employees
library(lubridate)

a <- lubridate::wday(employees$HIRE_DATE, week_star=1,label=T)
emp_wn <- data.frame(table(a))
ggplot(data=emp_wn,aes(x=a,y=Freq))+
  geom_col(aes(fill=a))+
  geom_text(aes(label=Freq),position=position_stack(vjust=0.5))

#---------------------------강사님
str(employees)
employees$HIRE_DATE <- as.Date(employees$HIRE_DATE,format='%Y-%m-%d')
str(employees)
format(employees$HIRE_DATE,'%A')
data.frame(table(lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)))

library(plyr)
week_cnt <- plyr::count(employees,"lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)")
#데이터프레임 형식으로 만들어짐
names(week_cnt) <- c('week','cnt')
week_cnt

ggplot(data=week_cnt,aes(x=week,y=cnt, fill=week))+
  geom_bar(stat='identity')+
  geom_text(aes(label=cnt),vjust=-0.1,size=2)+
  ggtitle('요일변 입사현황',subtitle='신입사원')+
  labs(x="년도",y="인원수",fill="요일",caption='2001년 ~ 2008년')+
  theme(plot.title = element_text(face='bold',color='darkblue',hjust=0.5,))+
  theme(plot.subtitle = element_text(face='bold',color='darkblue',hjust=0.5,))

week_cnt <- plyr::count(employees,"lubridate::wday(employees$HIRE_DATE,week_start=1)")
names(week_cnt) <- c('week','cnt')
str(week_cnt)

ggplot(data=week_cnt,aes(x=week,y=cnt, fill=factor(week)))+
  geom_bar(stat='identity')+
  geom_text(aes(label=cnt),vjust=-0.1,size=2)+
  ggtitle('요일변 입사현황',subtitle='신입사원')+
  labs(x="년도",y="인원수",fill="요일",caption='2001년 ~ 2008년')+
  theme(plot.title = element_text(face='bold',color='darkblue',hjust=0.5,))+
  theme(plot.subtitle = element_text(face='bold',color='darkblue',hjust=0.5,))+
  scale_x_continuous(breaks=1:7,labels=c("월","화","수","목","금","토","일"))+
  scale_fill_brewer(palette='BuPu',labels=c("월","화","수","목","금","토","일"))
  
week_cnt$week <- as.factor(week_cnt$week)
str(week_cnt)

scale_x_continuous을 이용해서 x축이름들을 변경하려는 경우
factor형은 수행될 수 없다. 숫자형으로 바꾼후에 변경작업을 수행해야 한다.

week_cnt$week <- as.integer(week_cnt$week)
str(week_cnt)

ggplot(data=week_cnt,aes(x=week,y=cnt, fill=factor(week)))+
  geom_bar(stat='identity')+
  geom_text(aes(label=cnt),vjust=-0.1,size=2)+
  ggtitle('요일변 입사현황',subtitle='신입사원')+
  labs(x="년도",y="인원수",fill="요일",caption='2001년 ~ 2008년')+
  theme(plot.title = element_text(face='bold',color='darkblue',hjust=0.5,))+
  theme(plot.subtitle = element_text(face='bold',color='darkblue',hjust=0.5,))+
  scale_x_continuous(breaks=1:7,labels=c("월","화","수","목","금","토","일"))+ # factor형일 때 축은 변경불가
  scale_fill_brewer(palette='BuPu',labels=c("월","화","수","목","금","토","일")) # 범례는 팩터형일 때도 변경가능


# 원형차트
week_cnt <- plyr::count(employees,"lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)")
names(week_cnt) <- c('week','cnt')
str(week_cnt)
week_cnt

week_cnt$pct <- round(prop.table(week_cnt$cnt) * 100)
week_cnt

ggplot(data=week_cnt,aes(x='',y=pct,fill=factor(week)))+
  geom_bar(stat='identity')+
  geom_text(aes(label=paste0(pct,'%')),position = position_stack(vjust=0.5))

ggplot(data=week_cnt,aes(x='',y=pct,fill=factor(week)))+
  geom_bar(stat='identity')+
  coord_polar(theta='y', start=0)+
  theme_void()+
  geom_text(aes(label=paste0(pct,'%')),position = position_stack(vjust=0.5))+
  scale_fill_brewer(palette='Set3')

[문제175] blood.csv 파일의 데이터를 이용해서 원형차트를 생성해주세요.
blood <- read.csv('c:/data/blood.csv', header = T)
blood
blood1 <- data.frame(table(blood$BLOODTYPE))
#blood1 <- plyr::count(blood,"blood$BLOODTYPE")
names(blood1) <- c('bloodtype','num')
blood1
blood1$r_fre <- prop.table(blood1$num) * 100
blood1

ggplot(data=blood1,aes(x='',y=r_fre,fill=bloodtype))+
  geom_bar(stat='identity')+
  coord_polar(theta='y',start=0)+
  theme_void()+
  geom_text(aes(label=paste0(r_fre,'%')),position=position_stack(vjust=0.5))

            
#---------------------------------강사님
blood <- read.csv('c:/data/blood.csv',header = T)
blood_freq <- data.frame(table(blood$BLOODTYPE))
names(blood_freq) <- c('BLOODTYPE','FREQ')
blood_freq$PCT <- prop.table(blood_freq$FREQ) * 100
blood_freq

ggplot(data=blood_freq,aes(x='',y=PCT,fill=BLOODTYPE))+
  geom_bar(stat='identity')+
  coord_polar(theta='y')+
  theme_void()+
  theme(legend.position = 'bottom')+ # left,right,bottom,top 범례 위치 조정
  scale_fill_brewer(palette='GnBu')

library(RColorBrewer)
display.brewer.all()

# 양방향 barplot

blood_gender <- aggregate(NAME~GENDER+BLOODTYPE,blood,length)
names(blood_gender)[3] <- 'CN'
blood_gender

blood_gender[blood_gender$GENDER=='M','CN'] <- blood_gender[blood_gender$GENDER=='M','CN'] * -1
blood_gender

ggplot(data=blood_gender,aes(x=BLOODTYPE,y=CN,fill=GENDER))+
  geom_bar(stat='identity')

ggplot(data=blood_gender,aes(x=BLOODTYPE,y=CN,fill=GENDER))+
  geom_bar(data=subset(blood_gender,GENDER='M'),stat='identity')+
  geom_bar(data=subset(blood_gender,GENDER='F'),stat='identity')

ggplot(data=blood_gender,aes(x=BLOODTYPE,y=CN,fill=GENDER))+
  geom_bar(stat='identity')+
  geom_text(aes(label=abs(CN)))+
  theme(legend.position ='bottom')+
  scale_fill_brewer(palette='Pastel2')+
  labs(x='',y='성별1',fill='성별')+
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())+
  coord_flip()
  
