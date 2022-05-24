[����171] ������� �޿��� ������ histogram, boxplot�� �̿��ؼ� �ð�ȭ ���ּ���.
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
     xlab='�޿�',ylab='�󵵼�',main='�޿� ������׷�')

h <- hist(employees$SALARY,breaks = 10,right=F,
     labels=T,ylim=c(0,60),
     xlab='�޿�',ylab='�󵵼�',main='�޿� ������׷�')
h

hist(employees$SALARY,breaks = c(0,5000,10000,15000,20000,25000),right=F,
      labels=T,ylim=c(0,60),
      xlab='�޿�',ylab='�󵵼�',main='�޿� ������׷�')

b <- boxplot(employees$SALARY)
b
text(1.2,b$out,b$out,col='red')
b$out

h <-hist(employees$SALARY,breaks = seq(0,25000,5000),right=F,
         labels=T,ylim=c(0,60),
         xlab='�޿�',ylab='�󵵼�',main='�޿� ������׷�')
#employees�����������ӿ��� salary�÷����� histogram�� �����. 
#breaks�ɼ����� 0~25000���� 5000������ ����, right=f�� 0�̻� 5000�̸� ~~
#labels=T�� �׷����� �� ���븶�� ���� ǥ��,ylim�� y���� ���� ���� ���� �� �ִ�
boxplot(employees$SALARY)

#-----------------------------------
�� ggplot2

library(ggplot2)

?mtcars
mtcars$cyl
barplot(mtcars$cyl)
barplot(table(mtcars$cyl))

factor(mtcars$cyl) #�ִ� �����θ� x���� ǥ���ϱ� ���ؼ� ���
ggplot(data=mtcars,aes(x=factor(cyl))) + 
  geom_bar()

df <- data.frame(table(mtcars$cyl))
ggplot(data=df,aes(x=Var1,y=Freq)) + 
  geom_col(fill='lightblue', colour='black') # geom_col�� y���� �� �ʿ�
#fill ��, colour�׵θ���
ggplot(data=df,aes(x=Var1,y=Freq))+
  geom_col(fill='lightblue', colour='black')

exam <- read.csv("c:/data/exam.csv",header=T)
sql <- exam[exam$subject=='SQL',]
sql

#geom_col
barplot(sql$grade)
ggplot(data=sql,aes(x=name,y=grade)) + # aes��ǥ��
  geom_col(fill=rainbow(nrow(sql)))+
  theme(axis.text.x = element_text(angle = 45, hjust=1,vjust = 1, colour = 'blue',size = 7)) + # axis.text.x x���� �ؽ�Ʈ�� 45�� ������ ǥ��,hjust x�����,vjust x�����
  labs(title="SQL��������",x="�л��̸�",y="����") + # ����
  theme(plot.title = element_text(face="bold",color="darkblue",hjust=0.5,size=20)) + #plot.title : title ������ ������ �� ���, hjust�� ���ڷ� ��ġ ����
  theme(axis.title.x = element_text(face="bold.italic")) + #x�� ����
  theme(axis.title.y = element_text(angle=45,vjust = 0.5)) # y�� ����

#geom_bar
ggplot(data=sql,aes(x=name,y=grade)) +
  geom_bar(stat='identity', fill=rainbow(nrow(sql))) +
  theme(axis.text.x = element_text(angle = 45, hjust=1,vjust = 1, colour = 'blue',size = 7)) + # axis.text.x x���� �ؽ�Ʈ�� 45�� ������ ǥ��,hjust x�����,vjust x�����
  labs(title="SQL��������",x="�л��̸�",y="����") + # ����
  theme(plot.title = element_text(face="bold",color="darkblue",hjust=0.5,size=20)) + #plot.title : title ������ ������ �� ���, hjust�� ���ڷ� ��ġ ����
  theme(axis.title.x = element_text(face="bold.italic")) + #x�� ����
  theme(axis.title.y = element_text(angle=45,vjust = 0.5)) # y�� ����

#stat = 'identity' : y�࿡ ����� ���� �������� �׷����� ǥ��

# ������ ����׷���,geom_bar
ggplot(data=exam, aes(x=name,y=grade,fill=subject))+
  geom_bar(stat='identity')+ 
  geom_text(aes(y=grade,label=paste0(grade,'��')),
            position = position_stack(vjust = 0.5),
            col='blue',size=3)
# ������ ����׷���,geom_col
ggplot(data=exam,aes(x=name,y=grade,group=subject))+
  geom_col(aes(fill=subject)) +
  geom_text(aes(label=grade),
            position = position_stack(vjust=0.5))

# �⺻�� ������
ggplot(data=exam,aes(x=name,y=grade,group=subject))+
  geom_col(aes(fill=subject),position = 'stack') +
  geom_text(aes(label=grade),
            position = position_stack(vjust=0.5))

# �׷��� ����׷���
ggplot(data=exam,aes(x=name,y=grade,group=subject))+ # ����
  geom_col(aes(fill=subject), position='dodge') +
  geom_text(aes(label=grade),
            position = position_dodge(1))

ggplot(data=exam,aes(x=subject,y=grade,group=name))+ # �̸���
  geom_col(aes(fill=name), position='dodge') +
  geom_text(aes(label=grade),
            position = position_dodge(1))

[����172] �μ��ο����� ggplot�� �̿��ؼ� ����׷����� �ð�ȭ ���ּ���.
?ggplot
library(RColorBrewer)
library(plyr)
dept_cnt <- plyr::ddply(employees,'DEPARTMENT_ID',summarise,cnt=length(EMPLOYEE_ID)) #na������ ����
dept_cnt
factor(employees$DEPARTMENT_ID)

#geom_bar
ggplot(data=dept_cnt,aes(x=factor(DEPARTMENT_ID),y=cnt))+
  geom_bar(stat='identity', fill=rainbow(nrow(dept_cnt)))+
  geom_text(aes(label=cnt),vjust=0.1,size=2,col='red')+
  labs(title="�μ��� �ο� ��Ȳ",x="�μ���ȣ",y="�ο���")+
  theme(plot.title=element_text(face="bold",color="darkblue",hjust=0.5))+
  coord_flip() ##�������� �׷����� ���������� ����, ū ������ �״��


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
  labs(title="�μ��� �ο� ��Ȳ",x="�μ���ȣ",y="�ο���")+
  theme_bw()+ # �޹�� ���
  theme(plot.title=element_text(face="bold",color="darkblue",hjust=0.5))+ # ���� �߿�
  coord_flip() #�������� �׷����� ���������� ����

ggplot(data=dept_cnt,aes(x=factor(DEPARTMENT_ID),y=cnt))+
  geom_col(fill=rainbow(nrow(dept_cnt)))+
  geom_text(aes(label=cnt),vjust=0.1,size=2,col='red')+
  labs(title="�μ��� �ο� ��Ȳ",x="�μ���ȣ",y="�ο���")+
  theme(plot.title=element_text(face="bold",color="darkblue",hjust=0.5))+
  scale_x_discrete(labels=c(paste('10',"\n","�μ�"),20,30,40,50,60,70,80,90,100,110,'�μ�x'))+ #x�� ���ݵ� ����
  scale_y_discrete()

[����173] fruits_sales.csv�� �о���� ��, �⵵�� �����̸��� �Ǹŷ���  
ggplot�� �̿��ؼ� ������,�׷��� ���� �׷����� ���弼��

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

#--------------------�����
x <- xtabs(qty~name+year,sales)
x
bp <- barplot(x,beside=T,xlab="�⵵",ylab="�Ǹŷ�",
        col=rainbow(4),ylim=c(0,20))
legend("topleft",legend=rownames(x), col=rainbow(4),pch=15, cex=0.5)
title(main="�⵵�� ���� �Ǹŷ�")
library(plotrix)
plotrix::barlabels(bp,5,x,bg=NA,border=NA,cex=0.5)

bp <- barplot(x,beside=F,xlab="�⵵",ylab="�Ǹŷ�",
              col=rainbow(4),ylim=c(0,50))
legend("topleft",legend=rownames(x), col=rainbow(4),pch=15, cex=0.5)
title(main="�⵵�� ���� �Ǹŷ�")
library(plotrix)
plotrix::barlabels(bp,x,bg=NA,border=NA,cex=0.5)

#ggplot
ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='stack')+
  geom_text(aes(label=qty),position=position_stack(vjust=0.5))+
  labs(title='�⵵�� ���� �Ǹŷ�', x='�⵵',y='���ϼ���')+
  guides(fill=guide_legend(title="����"))+ # ���ʼ���
  scale_fill_discrete(labels=c("���","�ٳ���","����","������"))+ # ���� �̸� ����
  theme(legend.title.align = 0.5,
        legend.box.background = element_rect())

#ggplot �׷���
ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='dodge')+
  geom_text(aes(label=qty),position=position_dodge(1))+
  labs(title='�⵵�� ���� �Ǹŷ�', x='�⵵',y='���ϼ���')+
  guides(fill=guide_legend(title="����"))+ # ���ʼ���
  scale_fill_discrete(labels=c("���","�ٳ���","����","������"))+ # ���� �̸� ����
  theme(legend.title.align = 0.5,
        legend.box.background = element_rect())

ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='stack')+
  geom_text(aes(label=qty),position=position_stack(vjust=0.5,size=3))+
  labs(title='�⵵�� ���� �Ǹŷ�', x='�⵵',y='���ϼ���')+
  guides(fill=guide_legend(title="����"))+ # ���ʼ���
  scale_fill_manual(values = c("red","yellow","brown","orange"),
                    labels=c("���","�ٳ���","����","������"))+
  #scale_fill_discrete(labels=c("���","�ٳ���","����","������"))+ # ���� �̸� ���� scale_fill_manual�̶� ���� �� ��
  theme(legend.title.align = 0.5,
        legend.box.background = element_rect())

ggplot(sales,aes(x=year,y=qty,group=name))+
  geom_col(aes(fill=name),position='stack')+
  geom_text(aes(label=qty),position=position_stack(vjust=0.5,size=3))+
  labs(title='�⵵�� ���� �Ǹŷ�', x='�⵵',y='���ϼ���')+
  guides(fill=guide_legend(title="����"))+ # ���ʼ���
  scale_fill_brewer(palette = 'Set1',labels=c("���","�ٳ���","����","������"))

  
[����174] ���Ϻ� �Ի��ο�����  ggplot�� �̿��ؼ� �ð�ȭ ���ּ���.

employees
library(lubridate)

a <- lubridate::wday(employees$HIRE_DATE, week_star=1,label=T)
emp_wn <- data.frame(table(a))
ggplot(data=emp_wn,aes(x=a,y=Freq))+
  geom_col(aes(fill=a))+
  geom_text(aes(label=Freq),position=position_stack(vjust=0.5))

#---------------------------�����
str(employees)
employees$HIRE_DATE <- as.Date(employees$HIRE_DATE,format='%Y-%m-%d')
str(employees)
format(employees$HIRE_DATE,'%A')
data.frame(table(lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)))

library(plyr)
week_cnt <- plyr::count(employees,"lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)")
#������������ �������� �������
names(week_cnt) <- c('week','cnt')
week_cnt

ggplot(data=week_cnt,aes(x=week,y=cnt, fill=week))+
  geom_bar(stat='identity')+
  geom_text(aes(label=cnt),vjust=-0.1,size=2)+
  ggtitle('���Ϻ� �Ի���Ȳ',subtitle='���Ի��')+
  labs(x="�⵵",y="�ο���",fill="����",caption='2001�� ~ 2008��')+
  theme(plot.title = element_text(face='bold',color='darkblue',hjust=0.5,))+
  theme(plot.subtitle = element_text(face='bold',color='darkblue',hjust=0.5,))

week_cnt <- plyr::count(employees,"lubridate::wday(employees$HIRE_DATE,week_start=1)")
names(week_cnt) <- c('week','cnt')
str(week_cnt)

ggplot(data=week_cnt,aes(x=week,y=cnt, fill=factor(week)))+
  geom_bar(stat='identity')+
  geom_text(aes(label=cnt),vjust=-0.1,size=2)+
  ggtitle('���Ϻ� �Ի���Ȳ',subtitle='���Ի��')+
  labs(x="�⵵",y="�ο���",fill="����",caption='2001�� ~ 2008��')+
  theme(plot.title = element_text(face='bold',color='darkblue',hjust=0.5,))+
  theme(plot.subtitle = element_text(face='bold',color='darkblue',hjust=0.5,))+
  scale_x_continuous(breaks=1:7,labels=c("��","ȭ","��","��","��","��","��"))+
  scale_fill_brewer(palette='BuPu',labels=c("��","ȭ","��","��","��","��","��"))
  
week_cnt$week <- as.factor(week_cnt$week)
str(week_cnt)

scale_x_continuous�� �̿��ؼ� x���̸����� �����Ϸ��� ���
factor���� ����� �� ����. ���������� �ٲ��Ŀ� �����۾��� �����ؾ� �Ѵ�.

week_cnt$week <- as.integer(week_cnt$week)
str(week_cnt)

ggplot(data=week_cnt,aes(x=week,y=cnt, fill=factor(week)))+
  geom_bar(stat='identity')+
  geom_text(aes(label=cnt),vjust=-0.1,size=2)+
  ggtitle('���Ϻ� �Ի���Ȳ',subtitle='���Ի��')+
  labs(x="�⵵",y="�ο���",fill="����",caption='2001�� ~ 2008��')+
  theme(plot.title = element_text(face='bold',color='darkblue',hjust=0.5,))+
  theme(plot.subtitle = element_text(face='bold',color='darkblue',hjust=0.5,))+
  scale_x_continuous(breaks=1:7,labels=c("��","ȭ","��","��","��","��","��"))+ # factor���� �� ���� ����Ұ�
  scale_fill_brewer(palette='BuPu',labels=c("��","ȭ","��","��","��","��","��")) # ���ʴ� �������� ���� ���氡��


# ������Ʈ
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

[����175] blood.csv ������ �����͸� �̿��ؼ� ������Ʈ�� �������ּ���.
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

            
#---------------------------------�����
blood <- read.csv('c:/data/blood.csv',header = T)
blood_freq <- data.frame(table(blood$BLOODTYPE))
names(blood_freq) <- c('BLOODTYPE','FREQ')
blood_freq$PCT <- prop.table(blood_freq$FREQ) * 100
blood_freq

ggplot(data=blood_freq,aes(x='',y=PCT,fill=BLOODTYPE))+
  geom_bar(stat='identity')+
  coord_polar(theta='y')+
  theme_void()+
  theme(legend.position = 'bottom')+ # left,right,bottom,top ���� ��ġ ����
  scale_fill_brewer(palette='GnBu')

library(RColorBrewer)
display.brewer.all()

# ����� barplot

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
  labs(x='',y='����1',fill='����')+
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())+
  coord_flip()
  
