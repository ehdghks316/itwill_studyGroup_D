��ggplot(������ �׷���)
x <- data.frame(day=1:5,weight=c(50,30,60,28,69),height=c(10,20,30,50,60))

ggplot(data=x,aes(x=day,y=weight))+
  geom_line(linetype=6) # 0~6

ggplot(data=x,aes(x=day,y=weight))+
  geom_line(linetype='twodash', color='blue', size=1.5) 
# 0 : blank, 1: solid, 2 : dashed, 3: dotted, 4 : dotdash, 5: longdash, 6: twodash

[����176] ggplot�� �̿��ؼ� line plot�� �������ּ���.
data <- read.csv("c:/data/������_����_�߻���Ȳ.csv",header=T)
data

data <- data[-1,]
names(data) <- c('����','������','2015','2016','2017','2018','2019')
data

new <- data[data$���� =='��1��',]
new <- new[,-1]
str(new)
new[,-1] <- lapply(new[,-1],as.integer)
str(new)
new1 <- melt(new,id='������')
new1 <- dcast(new1,variable~������)
str(new1)
ggplot(data=new1,aes(x=variable,y=���ռ�����,group=1))+ #group=1�� �� �ϸ� ������ ��
  geom_line()

#-------------------�����
data <- read.csv("c:/data/������_����_�߻���Ȳ.csv",header=T)
data <- data[data$��������������.1.=='��1��',]
data <- data[-1,-1]
names(data) <- c('������','2015','2016','2017','2018','2019')
str(data)
data[,2:6] <- lapply(data[,2:6],as.integer)
str(data)
data

������ �⵵ �Ǽ�
�ݷ��� 2015 0
...

df <- melt(data, id='������')
str(df)
names(df)[2:3] <- c('�⵵','�Ǽ�')
df
ggplot(data=df,aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_line()

ggplot(data=df[df$������=='A������',],aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_line()

ggplot(data=df[df$������ !='A������',],aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_line(linetype=2)

ggplot(data=df[df$������ !='A������',],aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_line(aes(linetype=������,color=������,size=������))+ # �� ���� ������ �� �׷��� ���� ũ�� ���϶�� ��Warning message: Using size for a discrete variable is not advised. 
  scale_linetype_manual(values=c('dashed','dotted','dotdash','longdash','twodash'))+
  scale_color_manual(values=c('red','darkblue','orange','green','pink'))+
  scale_size_manual(values=c(seq(1,1.8,by=0.2)))

��ggplot(������)
ggplot(data=df[df$������ !='A������',],aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_point(shape=23, fill='yellow', color='green', size=10) #fill�� ���ȿ� �� ä��� ��, color�� ���� �׵θ�
#shape 0 ~ 25
ggplot(data=df[df$������ !='A������',],aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_point(aes(shape=������,color=������,size=������))+
  scale_shape_manual(values=c(10:14))+ #���� ��� ����
  sclae_color_manual(values=c('red','darkblue','orange','green','pink'))+
  scale_size_manual(values=c(seq(1,1.8,by=0.2)))


ggplot(data=df[df$������=='A������',],aes(x=�⵵,y=�Ǽ�,group=������,color=������))+
  geom_line()

library(dplyr)

df%>%
  filter(������ =='A������')%>%
  select(�⵵, �Ǽ�)%>%
  ggplot(aes(x=�⵵,y=�Ǽ�,group=������))+
  geom_line()

str(df)
df%>%
  filter(������ =='A������')%>%
  select(�⵵, �Ǽ�)%>%
  ggplot(aes(x=as.integer(�⵵),y=�Ǽ�))+ #factor���� �� ������ ����?
  geom_line()+
  scale_x_continuous(breaks = 1:5,labels=2015:2019)

x <- data.frame(day=1:5,weight=c(50,30,60,28,69))
ggplot(data=x,aes(x=day,y=weight))+
  geom_line(linetype=6) # 0~6

cost <- read.table("c:/data/cost.txt")
cost <- as.matrix(cost)
dim(cost) <- c(50,1)
dim(cost)


��ggplot(hist)
hist(cost)

cost <- data.frame(cost)
head(cost)
names(cost) <- 'freq'
head(cost)

ggplot(data=cost,aes(x=freq))+
  geom_histogram() #binwidth�� ����ϱ⸦ �����ϴ� ��� �� ������ �ǰ�

ggplot(data=cost,aes(x=freq))+
  geom_histogram(binwidth=10,aes(fill=..count..), colour='red')

employees <- read.csv('c:/data/employees.csv',header=T)
employees

ggplot(data=employees,aes(x=SALARY))+
  geom_histogram(birwidth = 5000)

ggplot(data=subset(employees,DEPARTMENT_ID %in% c(30,50)),aes(x=SALARY))+
  geom_histogram(binwidth = 2000)+
  facet_grid(.~DEPARTMENT_ID) # ���ι���, 30,50�̶� ������ �׷��� ǥ��

ggplot(data=subset(employees,DEPARTMENT_ID %in% c(30,50,80)),aes(x=SALARY))+
  geom_histogram(binwidth = 2000)+
  facet_grid(DEPARTMENT_ID~.) # ���ι���

��ggplot(boxplot)
boxplot(cost)
cost[50,] <- 200
ggplot(data=cost,aes(x=1,y=freq))+
  geom_boxplot(outlier.color = "red", outlier.shape=10)

ggplot(data=cost,aes(x=1,y=freq))+
  geom_boxplot(outlier.color = "red", outlier.shape=10)+
  coord_flip()+
  stat_summary(fun='median',geom='point',shape=22,fill='orange',size=2)+
  stat_summary(fun='mean',geom='point',shape=25,fill='red',size=2)+
  stat_summary(fun='quantile',geom='point',shape=24,fill='purple',size=2)+
  geom_jitter(width = 0.1,alpha=0.3) #���� ��� �ȿ� ���� ���ִ��� 

store <- read.csv('c:/data/store.csv',header=T)
ggplot(data=store,aes(x=1,y=C))+
  geom_boxplot(outlier.color = "red", outlier.shape=10)+
  coord_flip()+
  stat_summary(fun='median',geom='point',shape=22,fill='orange',size=2)+
  stat_summary(fun='mean',geom='point',shape=25,fill='red',size=2)+
  stat_summary(fun='quantile',geom='point',shape=24,fill='purple',size=2)+
  geom_jitter(width = 0.1,alpha=0.3) #���� ��� �ȿ� ���� ���ִ��� 

boxplot(store$A,store$B,store$C)

store
��� �ð�
A B C
20 30 40 

�ؿ� �������� �ٲٴ� �۾��� �ʿ��� ��

A   20
.
B   30
.
C   40

melt(store)
store.m <- reshape2::melt(store,measure.vars=c('A','B','C'))
ggplot(data=store.m,aes(x=variable,y=value))+
  geom_boxplot(outlier.color = "red", outlier.shape=10)+
  coord_flip()+
  stat_summary(fun='median',geom='point',shape=22,fill='orange',size=2)+
  stat_summary(fun='mean',geom='point',shape=25,fill='red',size=2)+
  stat_summary(fun='quantile',geom='point',shape=24,fill='purple',size=2)+
  geom_jitter(width = 0.1,alpha=0.3) #���� ��� �ȿ� ���� ���ִ��� 

[����177] �ڷγ� ���̷��� �����Ϳ��� ���� �ֱ� ������ Ȯ����, �����, ȸ���� ���� ������ Ȯ���� ���� �������� �����ϼ���.

covid <- read.csv("c:/data/covid_19_clean_complete.csv", header=T)
covid
head(covid)
str(covid)

cov<- covid%>%
  dplyr::group_by(Country.Region)%>%
  dplyr::filter(max(as.Date(Date))==Date)%>%
  dplyr::select(Confirmed,Deaths,Recovered)

cov_1 <- cov[order(-cov$Confirmed),]
cov_1

#-------------------�����
covid$Date <- as.Date(covid$Date)
str(covid)
current_covid <- covid[covid$Date == max(covid$Date),]
head(current_covid)
View(current_covid)

library(plyr)
country_covid <- plyr::ddply(current_covid,"Country.Region",summarise,
            Confirmed = sum(Confirmed),
            Deaths = sum(Deaths),
            Recovered = sum(Recovered))
library(doBy)
result <- orderBy(~-Confirmed,country_covid)
View(result)

library(dplyr)
current_covid%>%
  dplyr::group_by(Country.Region)%>%
  dplyr::summarise(Confirmed = sum(Confirmed),
                   Deaths = sum(Deaths),
                   Recovered = sum(Recovered))%>%
  dplyr::arrange(desc(Confirmed))

new <- current_covid
names(new)[2] <- 'CountryRegion'
names(new)
library(sqldf)
sqldf("select CountryRegion, sum(Confirmed) Confirmed, sum(Deaths) Deaths, sum(Recovered) Recovered
      from new
      group by CountryRegion
      order by 2 desc")

c <- aggregate(Confirmed~Country.Region,current_covid,sum)
b <- aggregate(Deaths~Country.Region,current_covid,sum)
r <- aggregate(Recovered~Country.Region,current_covid,sum)
c;b;r
result <- merge(merge(c,b),r)
orderBy(~-Confirmed,result)

[����178] Ȯ���� ���� ���� ���� 10���� ������ Ȯ���ڼ�,����ڼ�,ȸ���ڼ��� �׷��� ����׷���  �ð�ȭ �ϼ���.(barplot �̿�)
cov_2 <- cov_1[order(-cov_1$Confirmed) <= 10,]
cov_2 <- data.frame(cov_2) 
cov_3 <- dcast(melt(cov_2,id=c('Country.Region')),variable~Country.Region)
rownames(cov_3) <- cov_3[,1]
cov_3 <- cov_3[,-1]

barplot(as.matrix(cov_3),beside=T, col=c('red','blue','orange'),main="������ Ȯ����,�����,ȸ���� �� ")
axis(2,ylim=seq(0,500000,100000))
legend("topleft",legend=rownames(cov_3),pch=15,col=c('red','blue','orange'))  

#------------------�����

orderBy(~-Confirmed,result)[1:10,]

result
result$rank <- dplyr::dense_rank(desc(result$Confirmed))
df <- result[result$rank<=10,]
orderBy(~rank,df)

result$rank <- NULL

top_10 <- result%>%
  dplyr::mutate(rank=dplyr::dense_rank(result$Confirmed))%>%
  dplyr::filter(rank<=10)%>%
  dplyr::arrange(rank)

top <- t(top_10[,c(-1,-5)])
label <- top_10[,1]  
top

options('scipen'=100)
barplot(top,names.arg=label,beside=T,las=2,
        legend.text = rownames(top),
        col=c('darkblue','red','yellow'),
        main = 'Covid Ȯ���ڼ��� ���� 10�� ����')

[����179] Ȯ���� ���� ���� ���� 10���� ������ Ȯ���ڼ�,����ڼ�,ȸ���ڼ��� �׷��� ����׷���  �ð�ȭ �ϼ���.(ggplot �̿�)
cov_2 # dcast(melt)�۾� ��
cov_4 <- melt(cov_2,measure.vars=c('Confirmed','Deaths','Recovered'))
ggplot(data=cov_4,aes(x=cov_4$Country.Region,y=cov_4$value,fill=variable))+
  geom_bar(stat='identity', position=position_dodge())

#-------------------------�����
top_10 <- reshape2::melt(top_10[,-5],id='Country.Region')
ggplot(top_10,aes(x=Country.Region,y=value,group=variable))+
  geom_col(aes(fill=variable), position='dodge')+
  theme(axis.text.x=element_text(angle=90))

ggplot(top_10,aes(x=reorder(Country.Region,-value),y=value,group=variable))+ # reorder���� �������� ����
  geom_col(aes(fill=variable), position='dodge')+
  theme(axis.text.x=element_text(angle=90))+
  labs(title = "Covid Ȯ���ڼ��� ���� 10�� ����",
       x='',y='')+
  #labs(fill='�߻�')
  #guides(fill=guide_legend(title='�߻�'))
  scale_fill_discrete(name='�߻�',labels=c("Ȯ����","�����","ȸ����"))


[����180] ��¥�� Ȯ���ڼ�,����ڼ�,ȸ���ڼ��� line plot �׷����� �ð�ȭ �ϼ���.(plot �̿�)
library(sqldf)
cov_5 <- sqldf("select Date, Confirmed,Deaths,Recovered
      from covid
      group by Date")

cov_5$Date <- as.integer(format(cov_5$Date,"%m"))

cov_6 <- sqldf("select Date,sum(Confirmed),sum(Deaths),sum(Recovered)
      from cov_5
      group by Date")
names(cov_6) <-c('Date','Confirmed','Deaths','Recovered') 
cov_6

plot(x=cov_6$Date,y=cov_6$Confirmed,xlab='��¥',ylab='��',
     main='��¥�� �ڷγ� Ȯ����,�����,ȸ����',type='l',col='blue',
     lwd=2)
lines(x=cov_6$Date,y=cov_6$Deaths,type='l',lwd=2,col='red')
lines(x=cov_6$Date,y=cov_6$Recovered,type='l',lwd=2,col='green')

#-------------------------�����
covid <- read.csv("c:/data/covid_19_clean_complete.csv", header=T)
covid$Date <- as.Date(covid$Date)
str(covid)
date_covid <- covid%>%
  dplyr::group_by(Date)%>%
  dplyr::summarise(Confirmed = sum(Confirmed),
                   Deaths = sum(Deaths),
                   Recovered = sum(Recovered))
plot(date_covid$Confirmed,xlab='',ylab='',axes=F,col='violet',
     type='l',lwd=1, main='��¥�� covid �߻� ��Ȳ')  
lines(date_covid$Deaths,col='red',type='l',lwd=1)
lines(date_covid$Recovered,col='blue',type='l',lwd=1)
axis(1,at=1:nrow(date_covid),labels=date_covid$Date,las=2)
axis(2,las=1)
legend("topleft",legend = c('Confirmed','Deaths','Recovered'),
       col = c('violet','red','blue'),cex=0.6, lty=1,lwd=2,bg='white')

[����181] ��¥�� Ȯ���ڼ�,����ڼ�,ȸ���ڼ��� line plot �׷����� �ð�ȭ �ϼ���.(ggplot �̿�)
cov_6
cov_7 <- melt(cov_6,id='Date')
ggplot(data=cov_7,aes(x=variable,y=value,group=Date))+
  geom_line()

#--------------------------�����

covid_19 <- melt(date_covid,id='Date')
head(covid_19)
ggplot(data=covid_19,aes(x=Date,y=value,group=variable, color=variable))+
  geom_line()+
  scale_x_date(date_labels="%Y-%m-%d",date_breaks = "30 days")+ #x�࿡ ��¥ ������ ���, ��¥ ����
  theme(axis.text.x = element_text(angle = 90))
