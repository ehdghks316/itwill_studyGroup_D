�� ���� �ڷ�
- ����, ũ��� �����Ǵ� ��
- �������ڷ� : �Ǽ���, Ű, ������ ...
- �̻����ڷ� : ������, ���л���, ���л���, ����Ƽ�...

�� ���� �ڷ�(������)
- �ڷῡ �����ϰ� �ִ� �ǹ̰� �ִ� �����͸� �ǹ��Ѵ�.
- �������ڷ� : ����(A,B,C..), ��������(����,����,����)
- ������ڷ� : ����(��, ��), ������(A,B,O,AB), ��������

              �����        �ڷ�����        �׷���
-----------------------------------------------------------------
�����ڷ�      ǥ              ��������ǥ      ��, ����׷���
                              ��ǥ          
                              ����ǥ


�����ڷ�      ��ġ,ǥ         ��������ǥ      ������׷�,���ڵ�ǥ,
                              ��,���,        ������,����׷���
                              �л�, ǥ������,
                              �ִ밪,�ּҰ�,
                              ����,�߾Ӱ�


�� pie chart
- ������ �ڷῡ ���� ��뵵������ǥ�� ��Ÿ���� ���� �Ϲ������� ���Ǵ� �׷���
- ���� �׸��� �� ���� �� ����� ��뵵���� �����ϴ� ���� �Ǵ� �κ����� ������.

��) sȸ�翡�� ���� ������ ����Ʈ���� �����ο� ���Ͽ� �� 100���� ���Ƿ� �̾� ��ȣ�� ���縦 �ߴ�.
100���߿� 45���� ����. 25���� ����, 20���� �ȴ�. 10���� ���� ���� �ʾҴ�.
���翡 ���� ��������ǥ(��ǥ)�� �����غ���

����������ǥ(FREQUENCE TABLE)
������ �ڷῡ ���ؼ� ������ ��뵵���� �����ϴ� ǥ

��ȣ��    ����    ��뵵��        ����
--------------------------------------------------
����      45      45/100 = 0.45   360 * 0.45 
����      25      25/100 = 0.25   360 * 0.25 
�ȴ�      20      20/100 = 0.2    360 * 0.2  
������    10      10/100 = 0.1    360 * 0.1  

data <- data.frame(labels = c('����','����','�ȴ�','������'),
                   frequency = c(45,25,20,10))
data$��뵵�� <- data$frequency/sum(data$frequency)
data

pie(data$��뵵��, labels=data$labels)

?pie
pie(data$��뵵��, 
    labels=paste0(data$labels,' ',data$��뵵��*100,'%'),
    col=c("red","blue","yellow","green"),
    main='������������',
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

pie(data$��뵵��, 
    labels=paste0(data$labels,' ',data$��뵵��*100,'%'),
    col=brewer.pal(8,"Dark2"),
    main='������������',
    cex=0.8,
    lty=3)

[����152] blood.csv ������ �о� �鿩�� ��������ǥ�� �ۼ��ϰ� pie chart�� ����
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
    main='����������',
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
    main='����������',
    col=brewer.pal(4,"Set1"),
    clockwise=T)
legend("topleft",x$BLOODTYPE[1:4],fill=brewer.pal(4,"Set1"),cex=0.5) #����

#clockwise=T(�ð����),F(�ݽð����)

install.packages("plotrix")
library(plotrix)

p <- plotrix::pie3D(x$PCT[1:4],
               labels=paste0(x$PCT[1:4]*100,'%'),
               labelcex=0.7,
               main='����������',
               explode=0.1,
               shade=0.5)

plotrix::pie3D.labels(p,labels = x$BLOODTYPE[1:4],
                      labelcex = 0.5,
                      labelrad = 0.8,
                      labelcol = "darkblue")


[����153] survey.csv ������ �о� �鿩�� ��������ǥ�� �ۼ� �Ͻð� pie chart�� ������ �ּ���.
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
names(result)[2] <- "��"
result$��뵵�� <- result$��/sum(result$��)
result

label <- paste(result$name,result$��뵵�� *100)
label <- paste0(label,'%')
label
pie(result$��뵵��,labels=label)

x <- c('a','b','a','a','b','c')
x
sum(x=='a')
sum(TRUE,FALSE,TRUE) #TRUE�� �Ǽ��� ������, TRUE�� 1�̶�� �����ϸ� ��

# table() : ������ �󵵼��� �����ϴ� �Լ�
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


# addmargins() : �󵵰��� �D�� ���ϴ� �Լ�
addmargins(table(x))

table(x)/sum(table(x))

# prop.table() : ��뵵���� ���ϴ� �Լ�
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

#��ǥ
table(employees$JOB_ID)
xtabs(~JOB_ID,employees)

tapply(employees$EMPLOYEE_ID,list(employees$JOB_ID,employees$DEPARTMENT_ID),length,default=0)
table(employees$JOB_ID,employees$DEPARTMENT_ID)
xtabs(~JOB_ID+DEPARTMENT_ID,employees)

tapply(employees$SALARY,list(employees$JOB_ID,employees$DEPARTMENT_ID),sum,default=0)

x <- xtabs(SALARY~JOB_ID+DEPARTMENT_ID,employees)

#������
apply(x,1,sum)
rowSums(x)
addmargins(x)
addmargins(x,2) # 2�� �� ���� ������ ��
margin.table(x) # ��ü��
margin.table(x,1)

#������
apply(x,2,sum) # 2: ������
colSums(x)
margin.table(x,2)
addmargins(x,1)

#��,���� ��
addmargins(x,c(1,2))

#������
prop.table(x)
prop.table(x,1) # 1, �����
prop.table(x,2) # 2, ������

�� ����׷���
-��ǥ(��������ǥ)�� Ȱ���Ͽ� �� ����(����)�� ��(ũ��)�� ����(����)�� ǥ���ϴ� �׷���

sales <- c(150,100,70,30)
team <- c("����1��","����2��","����3��","����4��")

#��������׷���
barplot(height = sales,
        names.arg = team,
        col=rainbow(length(sales)),
        main = "�������� ���� ����",
        xlab = "������",
        ylab = "��������(���)",
        ylim = c(0,200),
        cex.names=0.8,
        horiz=FALSE)
        
#���򸷴�׷���
barplot(height = sales,
        names.arg = team,
        col=rainbow(length(sales)),
        main = "�������� ���� ����",
        ylab = "������",
        xlab = "��������(���)",
        xlim = c(0,200),cex.names=0.8,
        horiz=TRUE)

[����154] �μ��� �ο����� ����׷����� �ð�ȭ �Ͻÿ�.
dept <- table(employees$DEPARTMENT_ID)
dept <- data.frame(dept)
barplot(height = dept$Freq,
        names.arg = dept$Var1,
        col = rainbow(NROW(dept)),
        main = '�μ��� �ο���',
        xlab = '�μ�',
        ylab = '�ο���(��)',
        ylim = c(0,50),
        cex.names = 0.8,
        horiz=FALSE)

barplot(height = dept$Freq,
        names.arg = dept$Var1,
        col = rainbow(NROW(dept)),
        main = '�μ��� �ο���',
        ylab = '�μ�',
        xlab = '�ο���(��)',
        xlim = c(0,50),
        cex.names = 0.8,
        horiz=TRUE)

[����155] �μ��̸��� �Ѿױ޿��� ���� ����׷����� �����ϼ���.
�� �μ��� ���� ������� �Ѿױ޿��� �������ּ���.
departments <- read.csv('c:/data/departments.csv',header = T)
emp <- employees[,c('DEPARTMENT_ID','SALARY')]
dept <- merge(emp,departments,by='DEPARTMENT_ID')[,c('DEPARTMENT_NAME','SALARY')]
dept
dept2 <- aggregate(SALARY~DEPARTMENT_NAME,dept,sum)

barplot(height = dept2$SALARY,
        names.arg = dept2$DEPARTMENT_NAME,
        col = rainbow(NROW(dept2)),
        main = '�μ��̸��� �Ѿױ޿�',
        xlab = '�μ��̸�',
        ylab = '�Ѿױ޿�(��)',
        ylim = c(0,350000),
        cex.names = 0.9,
        horiz = FALSE)

barplot(height = dept2$SALARY,
        names.arg = dept2$DEPARTMENT_NAME,
        col = rainbow(NROW(dept2)),
        main = '�μ��̸��� �Ѿױ޿�',
        ylab = '�μ��̸�',
        xlab = '�Ѿױ޿�(��)',
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
        main = "�μ��̸��� �Ѿ�",
        xlab = "�μ��̸�",
        ylab = "�ѱ޿�",
        ylim = c(0,350000),
        las=2,cex.names=0.5,
        cex.axis=0.5)

text(5,340000,labels='���� �Ϸ絵 �ູ����')

bp <- barplot(height = result$sum_sal,
        names.arg = result$DEPARTMENT_NAME,
        col = rainbow(NROW(result)),
        main = "�μ��̸��� �Ѿ�",
        xlab = "�μ��̸�",
        ylab = "�ѱ޿�",
        ylim = c(0,350000),
        las=2,cex.names=0.5,
        cex.axis=0.5)
text(x=bp,
     y=result$sum_sal,
     labels = result$sum_sal,
     cex=0.5,
     pos=3)
pos=1 : ���볡���� �Ʒ���
pos=2 : ���볡���� ����
pos=3 : ���볡���� ����
pos=4 : ���볡���� ������

����׷����� �ִ밪, �ּҰ��� ��� 

result[is.na(result$DEPARTMENT_NAME),1] <- '�μ�(X)'
result

bp <- barplot(height = result$sum_sal,
              names.arg = result$DEPARTMENT_NAME,
              col = rainbow(NROW(result)),
              main = "�μ��̸��� �Ѿ�",
              xlab = "�μ��̸�",
              ylab = "�ѱ޿�",
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

�� stacked bar plot

x1 <- c(2,6,9,5)
x2 <- c(8,10,15,6)
data <- rbind(x1,x2)
name <- c('1��','2��','3��','4��')
label <- c('2020��','2021��')

barplot(height=data, names.arg = name,
        main='��������',
        xlab='��',ylab='�ǸŽ���',
        ylim=c(0,30),
        legend.text=label,
        col=c('purple','red'))

�� group bar plot

barplot(height=data, names.arg = name,
        beside=T,
        main='��������',
        xlab='��',ylab='�ǸŽ���',
        ylim=c(0,20),
        legend.text=label,
        col=c('purple','red'))

[����156] fruits_sales.csv�� �о� ������ �⵵��, �����̸��� �Ǹŷ��� 
�׷��� ����׷����� �ð�ȭ ���ּ���.
sales <- read.csv('c:/data/fruits_sales.csv',header = T)
sales

tapply(sales$qty,list(sales$name,sales$year),sum)
x <- xtabs(qty~name+year,sales)
barplot(x,beside=TRUE,
        xlab='�⵵', ylab='�Ǹŷ�',
        col=c('red','yellow','green','orange'),
        ylim=c(0,20))
legend('topleft',legend=rownames(x),
       col=c('red','yellow','green','orange'),
       pch = 15, cex= 0.5)
title(main = '�⵵�� ���� �Ǹŷ�')


barplot(x,beside=FALSE,
        xlab='�⵵', ylab='�Ǹŷ�',
        col=c('red','yellow','green','orange'),
        ylim=c(0,50))
legend('topleft',legend=rownames(x),
       col=c('red','yellow','green','orange'),
       pch = 15, cex= 0.5)
title(main = '�⵵�� ���� �Ǹŷ�')
