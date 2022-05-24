[����166] 2015��~2021����� ���￡�� '��⵵','�λ걤����','��õ������',
'�뱸������','����Ư����ġ��' ���� �̵��ڼ��� �׷����� �ð�ȭ���ּ���.

#-----------------------�������۾�
data <- read.csv('c:/data/������_������_�õ�_��_�̵��ڼ�.csv',header=T)
data
#������ ����,�࿡�� �⵵ 
data <- data[-1,-1]
names(data) <- c('��������','2015','2016','2017','2018','2019','2020','2021')
data
new <- data.frame(t(data))
names(new) <- new[1,]
new <- new[-1,]
str(new)
new[,1:16] <- lapply(new[,1:16],as.integer)
str(new)
new
#---------------------�׷����׸���(x�⵵, 5���� �׷��� �� )
plot(new$��⵵, axes=F, ylab="",xlab="",
     type='o', col='red', ylim=c(0,380000))
lines(new$�λ걤����, type='o', col='blue')
lines(new$��õ������, type='o', col='purple')
lines(new$�뱸������, type='o', col='green')
lines(new$����Ư����ġ��, type='o', col='black')
axis(1,at=1:7,label=rownames(new),las=2)
axis(2)
abline(h=seq(0,300000,50000),v=seq(1,10,1),lty=3,lwd=0.2)
legend("topright",legend = names(new)[c(8,1,3,2,7)],cex=0.5,lty = 2,lwd=1,
       col=c('red','blue','red','black','green'))



#--------------------------�����
data <- read.csv('c:/data/������_������_�õ�_��_�̵��ڼ�.csv',header=T)
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
plot(data$��⵵,xlab="",ylab="",ylim=c(0,400000),axes=F,col='violet',type='b')
lines(data$�λ걤����, col='blue',type='b')
lines(data$��õ������, col='red', type='b')
lines(data$�뱸������, col='black', type='b')
lines(data$����Ư����ġ��, col='green', type='b')
axis(1,at=1:7,label=rownames(data),las=2)
axis(2,at=seq(0,400000,by=50000),las=2)
abline(v=seq(1,10,1),lty=3,lwd=0.2)
legend('topleft',legend=c('��⵵','�λ걤����','��õ������',
                          '�뱸������','����Ư����ġ��'),
        col=c('violet','blue','red','black','green'),cex=0.5,lty=1,lwd=0.5)

#------------------------------------------
install.packages('reshape2')
library(reshape2)
sales <- read.csv('c:/data/fruits_sales.csv',header=T)
sales

#reshape2::melt : �÷��� ���� ����(wide) ���θ� ���ι��� ��(long)���·� �����ϴ� �Լ�
reshape2::melt(sales,id='year')
reshape2::melt(sales,id='name')

a<- reshape2::melt(sales,id=c('name'), measure=c('qty','price'))
# name�÷��� �������� variable�÷��� value�÷��� �����ϴµ� variable�÷����� qty,price�� ���� value�� �׿� �´� ������ ����.
dcast(a,name~variable,sum) # name�� �������� �׷��Ͽ� variable�� �ִ� ������ ���� ���Ѵ�. sum�� �ۼ����� �ʰ� �����ϸ� �󵵼��� ���Ѵ�. 
#dcast(����������, �����~unstackó���÷�(�÷��и�),)


m <- reshape2::melt(sales,id=c('year','name'))
str(m) #data.frame����, ���ο�� 2�� ����

m -> sales�� �ٲٰ� ���� �� dcast�Լ� ���
# reshape2::dcast : long(����)�� wide(����)���·� �����ϴ� �Լ�

dcast(m,year+name~variable) # ���� ���·� ����
reshape2::dcast(m,year~variable,sum) #�⵵�� ��������,price�� ��
reshape2::dcast(m,name~variable,sum) #name�� ��������,price�� ��

library(dplyr)
sales%>%
  dplyr::group_by(year)%>%
  dplyr::summarise(qty=sum(qty),price=sum(price))
sales%>%
  dplyr::group_by(name)%>%
  dplyr::summarise(qty=sum(qty),price=sum(price))

#-----------------------------------------------------
data <- read.csv('c:/data/������_������_�õ�_��_�̵��ڼ�.csv',header=T)
data <- data[-1,-1]
names(data)[2:8] <- c(2015:2021)
data

data <- dcast(melt(data,id='��������'),variable~��������) #���������������� ����� �۾��� �� �ʿ䰡 ����(t�Լ��� ����ϸ� data.frame�� �����ؾ���)
data
str(data)

data[,-1] <- lapply(data[,-1],as.integer) # rownames�� 1���� �ٲٰ� 1���� �����ؼ�  data[,1:����]�ϴ� ����� �ִ�.
str(data)
data
plot(data$��⵵,xlab="",ylab="",ylim=c(0,400000),axes=F,col='violet',type='b')
lines(data$�λ걤����, col='blue',type='b')
lines(data$��õ������, col='red', type='b')
lines(data$�뱸������, col='black', type='b')
lines(data$����Ư����ġ��, col='green', type='b')
axis(1,at=1:7,label=data$variable,las=2)
axis(2,at=seq(0,400000,by=50000),las=2)
abline(v=seq(1,10,1),lty=3,lwd=0.2)
legend('topleft',legend=c('��⵵','�λ걤����','��õ������',
                          '�뱸������','����Ư����ġ��'),
       col=c('violet','blue','red','black','green'),cex=0.5,lty=1,lwd=0.5)


[����167] ����� ������ ������ �ֽ��ϴ�. ��������ǥ�� ���弼��.
#����: ������� �����, 
#��뵵�� : ��ü���� ������ ������
#�������� : ������ ���� ������
90 88 78 65 80 94 69 72 83 64 95 68 87 69 82 91 63 70 81 67 

���                ����    ��뵵��  ��������
----------------- -------   --------  --------
  90���̻�             4       4/20        4
80���̻�~90���̸�    6                   10
70���̻�~80���̸�    3                   13
60���̻�~70���̸�    7                   20

# scan�� �̿��ؼ� ������ ���Ϳ� ���� �� ����()
#scan() �Լ��� console���� �����ϼ���.
> score <- scan()

score
ft <- data.frame(���=c('90�� �̻�','80���̻�~90���̸�','70���̻�~80���̸�','60���̻�~70���̸�'),
             ����=c(0,0,0,0))

# 1.���� �� ���ϱ�
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

# 2.��뵵�� �� ���ϱ�(��뵵������ ���������� ���� �� ���� �߰��ϴ� ���)
a <- NULL
for(i in 1:4){
  a <- c(a,ft[,2][i]/sum(ft[,2]))
}
a
ft$��뵵�� <- a
ft

# 3.�������� ���ϱ�
nu <- c(0,0,0,0)
a <- 0
for(i in 1:4){
  a <-  a + ft[,2][i]
  nu[i] <- a
}
nu
ft$�������� <- nu

#----------------------------------------����� ��
score
ft <- data.frame(���=c('90�� �̻�','80���̻�~90���̸�','70���̻�~80���̸�','60���̻�~70���̸�'),
                   ����=c(0,0,0,0))
#����
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

#��뵵��
ft$���� / sum(ft$����)
ft$��뵵�� <- prop.table(ft$����)
ft

#��������
  #ù��° ���� �������� �״�� ���������� �Է�
  #�ι�° ���� �������� �ٷ� �տ� �ִ� ���������� ������ ���ϸ� �ȴ�.
# ù��° ���� �������� : ft$��������[1] <-ft$����[1]
# �ι�° ���� �������� : ft$��������[2] <- ft$��������[1] + ft$����[2]
# ����° ���� �������� : ft$��������[3] <- ft$��������[2] + ft$����[3]

ft$�������� <- NULL
for(i in 1:nrow(ft)){
  if(i==1){
    ft$��������[i] <- ft$����[i]
  } else{
    ft$��������[i] <- ft$����[i] + ft$��������[i-1]
  }
}
ft


[����168] ����� ������ ������ �ֽ��ϴ�. ��������ǥ�� ���弼��.
�� ������(��ġ��)�� ����(������)�� ������ �� ������ ���ϼ���.

(��) 90 ->"90���̻�",95 -> "90���̻�", 88 -> "80���̻�~90���̸�"

score

# score�� ������ ���������� �����ϱ�

for(i in 1:length(score)){
  if(score[i] >= 90){
    score[i] <- "90���̻�" 
  }else if(score[i] >= 80){
    score[i] <- "80���̻�~90���̸�"
  }else if(score[i] >= 70){
    score[i] <- "70���̻�~80���̸�"
  }else if(score[i] >= 60){
    score[i] <- "60���̻�~70���̸�"
  }
}
score
table(score)
score_df <- data.frame(table(score))

#------------------------�ٸ� ���
categorical <- function(x){
  ifelse(x>=90,"90���̻�",
         ifelse(x>=80,"80���̻�~90���̸�",
                ifelse(x>=70,"70���̻�~80���̸�",
                       ifelse(x>=60,"60���̻�~70���̸�",NA))))
  }

s <- categorical(score)
table(s)
data.frame(table(s))

factor(s,levels = c("90���̻�","80���̻�~90���̸�","70���̻�~80���̸�","60���̻�~70���̸�"))
df <- data.frame(table(factor(s,levels = c("90���̻�","80���̻�~90���̸�","70���̻�~80���̸�","60���̻�~70���̸�"))))

names(df) <- c('���','����')
df$��뵵�� <- prop.table(df$����) #��뵵�� : prop.table(������)
df$�������� <- cumsum(df$����) #�������� : cumsum(������)
df


���                ����    ��뵵��  ��������
----------------- -------   --------  --------
  90���̻�             4       4/20        4
80���̻�~90���̸�    6                   10
70���̻�~80���̸�    3                   13
60���̻�~70���̸�    7                   20

�� cut
������ ������ ������ ������ ��ȯ�ϴ� �Լ�
score <- scan()
min(score)
max(score)

table(cut(score,breaks=seq(60,100,by=10), right=FALSE)) 
# breaks�ɼ� : 60~100���� 10������ ����, right=FALSE : [60,70) 60���̻� ~ 70�� �̸� (60 <=���� < 70)
table(cut(score,breaks=seq(60,100,by=10), right=TRUE))
# right=TRUE : (60,70] 60���ʰ� ~ 70������ (60 < ���� <= 70)
x <- cut(score,breaks=seq(60,100,by=10), right=FALSE,
    labels = c("60���̻�~70���̸�","70���̻�~80���̸�","80���̻�~90���̸�","90���̻�"))
result <- cbind(table(x), prop.table(table(x)),cumsum(table(x)))
class(result)
data.frame(result)           

#-----------------------------

[����169] cost.txt �����͸�  �м��ϼ���.
91 78 93 57 75 52 99 80 97 62
71 69 72 89 66 75 79 75 72 76
104 74 62 68 97 105 77 65 80 109
85 97 88 68 83 68 71 69 67 74
62 82 98 101 79 105 79 69 62 73

cost <- read.csv('c:/data/cost.txt',header=F)
cost <- scan() 
cost <- read.table("c:/data/cost.txt") # data.frame���� �о����
str(cost) # �� �÷��� ������ �� ����
dim(cost) # 5��10���� �ϳ��� �� ���� �����ϰ� ��������
cost <- as.matrix(cost) #matrix������ �ٲٰ�
dim(cost) <- c(50,1) # dim(cost) ���� 50�� 1���� �ٲٸ� ��
cost

# ���� ���� 109���� 52�ϱ� ����ϰ� 110~50���� ������ ��� 10 ������ ����ǥ�� ����� �ǰڴ�.
max(cost) # 109
min(cost) # 52
table(cut(cost,breaks =seq(50,110,by=10),right=FALSE))
fac_x <- factor(cut(cost,breaks=seq(50,110,by=10),right=FALSE), 
       labels = c('50�̻�~60�̸�','60�̻�~70�̸�','70�̻�~80�̸�','80�̻�~90�̸�','90�̻�~100�̸�','100�̻�'))
df <- data.frame(table(fac_x))
df
df$��뵵�� <- prop.table(df$Freq)
df$�������� <- cumsum((df$Freq))
rownames(df) <- df[,1]
df <- df[,-1]
names(df)[1] <- '����'
df

#��Ʈ������
graphics.off()
barplot(as.matrix(df),
        names.arg = names(df),las=2,col = brewer.pal(6,'RdBu'),beside=T)
pie(df[,2],labels = df[,1], col = brewer.pal(6,'RdBu'))
plot(df[,2],)
#

#--------------����� ��
(1) �ִ밪, �ּҰ�
(2) ����� ��
(3) ��� ������ ũ��
(4) ����� ������ ���� ���� ���� ���� �ȴ�.
(5) ��뵵��, ��������

cost_cut <- cut(cost,breaks=seq(50,110,by=10),right=FALSE,
    labels=c('50�̻�~60�̸�','60�̻�~70�̸�','70�̻�~80�̸�','80�̻�~90�̸�','90�̻�~100�̸�','100�̻�'))
cost_result <- data.frame(cbind(table(cost_cut),prop.table(table(cost_cut))))
names(cost_result) <- c('����','��뵵��')
cost_result$�������� <- cumsum(cost_result$����)
cost_result


�� ������׷�(histogram)
- ������ �ڷᰡ �� �ִ� ��ġ�� �ڷ��� ������ ���� �뷫���� ������ �ľ��� �� �ִ� �׷���
- ������ ��ü���� ��ġ������ �� �� ����.
cost
hist(cost) #������׷�
hist(cost,breaks = seq(50,110,by=10),right=FALSE,col=brewer.pal(7,'RdBu'),
     ylim=c(0,20),labels=TRUE)

�� ���ڱ׸�(box plot)
- �ּҰ�, ��1�������, �߾Ӱ�(����������), ��3�������, �ִ밪 �ټ������� ����ġ���� �ľ��� �� �ִ� �׷��� 
- �̻�ġ�����͸� Ȯ���� �� �ִ�.
par(mfrow=c(2,2))
boxplot(1:10, main='1')
boxplot(c(1:10,20),main='2') #�̻�ġ ������ 20 Ȯ��
boxplot(cost, main='3')
boxplot(cost,horizontal=T, main='4')

1. �߾Ӱ�(median) #����̶��� �ٸ�
median(cost)

(1) �������� ũ������� ����(��������)
(2) �������� ����(n) Ȧ���� (n+1)/2 ��° ������
    -(��) 1 2 3 4 5 6 7 8 9 
    n=9  (9+1)/2 = 5 , 5��° ��ġ���� ����
(3) �������� ����(n) ¦���� n/2 ��° ��������, (n/2)+1 ��° �������� ���
    -(��) 1 2 3 4 5 6 7 8 9 10
    n=10 10/2 = 5, 5��° ��ġ��
         (10/2)+1 = 6, 6��° ��ġ��
         (5+6)/2 = 5.5 �߾Ӱ�
    costs <- sort(cost)
    (costs[25] + costs[26])/2
    median(cost)
2. �������(quartile)
Q1 : 1����� Q2(�߾Ӱ�)���� ���� �������� �߾Ӱ�,25%
    -(��) 1 2 (3 Q1) 4 5 (5.5 �߾Ӱ�) 6 7 8 9 10

Q2(�߾Ӱ�)
  50% Q2 50%
    
Q3 : 3����� Q2(�߾Ӱ�)���� ū �������� �߾Ӱ�,75%
  -(��) 1 2 3 4 5 (5.5 �߾Ӱ�) 6 7 (8 Q3) 9 10

quantile(1:10)
quantile(1:10,type=7) # type=7 �⺻��
quantile(1:10,type=2) # ���� �߾Ӱ����� ���� type=2
summary(1:10)

boxplot(c(1:10,20),horizontal=T) 
min(c(1:10,20))
max(c(1:10,20)) 

�����������(Inter Quartile Range)
IQR = Q3-Q1

iqr = 8 - 3 

# ������ ��輱(��Ÿ����)
upper fence : Q3 + 1.5*IQR
8+1.5*5 = 15.5

lower fence : Q1 - 1.5*IQR
3 - 1.5*5 = -4.5

(-4.5 ~ 15.5) �������� �������� �ּҰ�, �ִ밪�� ã�´�.# ���⿡ ������ �ʴ� �����ʹ� �̻�ġ ������

boxplot(c(1:10,20,-10),horizontal = T)

boxplot.stats(c(1:10,20,-10))
boxplot.stats(c(1:10)) #boxplot�� ������ ���� �Լ�

exam <- read.csv('c:/data/exam.csv', header=T)
exam              
sql <-exam[exam$subject == 'SQL','grade']
r <-exam[exam$subject == 'R','grade']
python <-exam[exam$subject == 'PYTHON','grade']

boxplot(sql,r,python,names = c('SQL','R','PYTHON'))
boxplot(sql,r,python,names = c('SQL','R','PYTHON'),horizontal=T)

[����170] store.csv ���Ͽ� �ִ� �����͸� �м��ϼ���
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
hist(store$A,main='A���', xlab = '��',ylab='�Ǽ�')
hist(store$B,main='B���', xlab = '��',ylab='�Ǽ�')
hist(store$C,main='C���', xlab = '��',ylab='�Ǽ�')

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

����1. median�� ������� �ʰ� �߾Ӱ��� �����ϴ� �Լ��� ������ּ���.(�߾Ӱ��� ���� �����ϰ� �ִ���)

med <- function(...){
  a <- c(...)
  x <- NULL
  if(length(a)%%2==1){ # ���� ������ Ȧ���� ��
    x <- a[(length(a)+1)/2]
  }else if(length(a)%%2==0){
    x <- (a[length(a)/2] + a[length(a)/2+1])/2
  }else{
    NA
  }
  return(x)
}

med(c(1,2,3,4,5,6,7,8,9))

����2. ������ ���� plot��Ʈ�� �׸��ÿ�(x���� ��¥,������x, na�� -> 0)

data <- read.csv('c:/data/������_����_�߻���Ȳ.csv',header=T) # ������ �о����
data #Ȯ��
names(data)
names(data) <- c('��','������','2015','2016','2017','2018','2019')
head(data)
data1 <- data[,-2]
data2 <- reshape2::melt(data1,id=c('��'))
str(data2)
data2$value <- as.integer(data2$value)
data2
data2[is.na(data2$value),'value'] <- 0
data3 <- reshape2::dcast(data2,variable~��,sum)
rownames(data3) <- data3$variable
data3 <- data3[,-1]
data3
plot(data3$��1��,type='o', col='red',xlab="",ylab="",axes=F, ylim=c(0,120000))
lines(data3$��2��,type='o', col='blue', xlab="",ylab="")
lines(data3$��3��,type='o', col='purple', xlab="",ylab="")
lines(data3$��4��,type='o', col='orange', xlab="",ylab="")

axis(1,at=1:5,label=rownames(data3),las=2)
axis(2)
abline(h=seq(0,120000,20000),v=seq(1,10,1),lty=2,lwd=0.2)
legend("topleft",legend = names(data)[1:4],cex=0.5,lty=4, 
       col = c('red','blue','purple','orange'))

#------------------------------------
(1)������ �о����, �ʿ���� ��,������, �÷��̸� ����
data <- read.csv('c:/data/������_����_�߻���Ȳ.csv',header=T) # ������ �о����
data #Ȯ��
data <- data[-1,-2]
data
names(data) <- c('��','2015','2016','2017','2018','2019')
data

(2)��¥�� �� �࿭ ��ġ ����
data1 <- reshape2::melt(data,id=c('��'))
str(data1) # value���� chr������ �Ǿ� �ֱ⶧���� int������ �����ؾ��Ѵ�
data1$value <- as.integer(data1$value) # value���� int������ ����, Warning message: NAs introduced by coercion  (NAs���� ��ȯ) �̺κ��� �ϴ� ������ �Ǵϱ� ����
data1[is.na(data1$value),'value'] <- 0 #na���� 0���� ����
data1
data1 <- reshape2::dcast(data1,variable~��,sum) #variable->��, ��->��, ��,��¥�� ���� ����
data1
rownames(data1) <- data1[,1] #���̸��� ��¥ �ֱ�
data1 <- data1[,-1] # ���̸��� �ߺ��Ǵ� 1�� ����
data1

(3) �׷���
plot(data1$��1��, type='o',xlab="",ylab="", col="red",ylim=c(0,120000), axes=F)
lines(data1$��2��, type='o', col='blue')
lines(data1$��3��, type='o', col='black')
lines(data1$��4��, type='o', col='orange')
axis(1,at=1:5,labels=rownames(data1),las=2)
axis(2)
abline(h=seq(0,120000,by=20000),v=seq(1,10,1),lty=3)
legend("topleft",legend = names(data1), col=c('red','blue','black','orange'),cex=0.5,
       lty=4)
