[����72] �⵵�� �Ѿױ޿��� ���ϼ���.(���ι������� ���)
1.�Ϲ�
aggregate(SALARY ~ format(employees$HIRE_DATE,'%Y'),employees,sum) # ������
t(aggregate(SALARY ~ format(employees$HIRE_DATE,'%Y'),employees,sum)) #������

2.lubridate::year
lubridate::year(employees$HIRE_DATE) # ������

tapply(employees$SALARY,lubridate::year(employees$HIRE_DATE),sum)

install.packages("doBy")
library(doBy)
library(lubridate)

[����73] ���Ϻ� �Ѿױ޿��� ���ϼ���.(���ι������� ���)
1.
x <- tapply(employees$SALARY,format(employees$HIRE_DATE,'%u'),sum)
names(x) <- c('��','ȭ','��','��','��','��','��')
x
t(t(x)) # ���ι������� �ٲ� �� �ִ�.

2.
tapply(employees$SALARY,lubridate::wday(employees$HIRE_DATE,week_start=1, label=T),sum)

[����74] �μ���,�⵵�� �Ѿױ޿��� ������ּ���.
1. ������
x <- aggregate(SALARY ~ DEPARTMENT_ID+lubridate::year(employees$HIRE_DATE),employees,sum)
names(x)[2] <- 'YEAR'
x
doBy::orderBy(~DEPARTMENT_ID+YEAR,x)

2.������(���μ�����)
tapply(employees$SALARY,list(employees$DEPARTMENT_ID,lubridate::year(employees$HIRE_DATE)),sum,default = 0)

[����75] �⵵��(��), �б⺰(��) �Ѿױ޿�, ���� ��, ���� ���� ������ּ���.

year_s <- lubridate::year(employees$HIRE_DATE)
quarter_s <- lubridate::quarter(employees$HIRE_DATE)
tapply(employees$SALARY,list(year_s,quarter_s),sum,default = 0)

x <- tapply(employees$SALARY,list(lubridate::year(employees$HIRE_DATE),lubridate::quarter(employees$HIRE_DATE)),sum,default = 0)
class(x)
x <- data.frame(x) #data.frame���� ���� ����
names(x) <- c('1�б�', '2�б�',' 3�б�', '4�б�')
x
x$�� <- apply(x,1,sum) # �÷��߰�
x
x <- rbind(x,apply(x,2,sum)) #���߰�
x
x <- rownames(x)[nrow(x)] <- '��' #9���� �̸��� '��'���� ����
x

#----------------------------------------------------------------

�� �������
-������ �帧�� ����

1. if ��

if(����){
  ���ǿ� ���� �� ����
} 

if(����){
  ���ǿ� ���� �� ����
} else{
  ���ǿ� ������ �� ����
}

if(TRUE){
  print('��')
}

if(FALSE){
  print('��')
} else{
  print('����')
}

x <- 100
y <- 200
if(x==y){
  print('x�� y�� ����')
} else{
  print('x�� y�� ���� �ʴ�')
}

x <- 100
y <- 200
if(x==y){
  print('x�� y�� ����')
} else{
  if(x>y){
    print('x�� y���� ũ��')
  } else{
    print('y�� x���� ũ��')
  }
   
}

x <- 100
y <- 200
if(x==y){
  print('x�� y�� ����')
} else if(x>y){
    print('x�� y���� ũ��')
} else{
    print('y�� x���� ũ��')
}


[����76]������ 2�� �Է����� �� ������ ���� 2�� ����� "2�� ���" ���	�ƴϸ� "2�� ����� �ƴϴ�" ������ּ���.

x <- 2
if(x%%2==0){
  print('2�� ���')
} else{
  print('2�� ����� �ƴϴ�')
}

#-------------------------- ���� ���� �Է���(ȥ�ڰ���)
if(as.numeric(readline('insert please : '))%%2==0){
  print('2�� ���')
} else{
  print('2�� ����� �ƴϴ�')
}
#---------------------------

2. ifelse �Լ�
ifelse(����,��,����)
ifelse(����,��,ifelse(����,��,ifelse(����,��,����)))

x <- 1
y <- 2
ifelse(x==y,'����','�ٸ���')
ifelse(x==y,'����',ifelse(x>y,'x�� ũ��','y�� ũ��'))

x <- 2
ifelse(x%%2==0, '2�� ���','2�� ����� �ƴϴ�')

[����77] x ������ 1���� 100���� �Է��� �� ¦������ �ڽ��� ���� 10�� ���� ������ �����ϼ���.

x <- c(1:100)
ifelse(x%%2==0,x*10,x)

x<- 1:100
x[x%%2==0] * 10

x <- 1:100
if(x[1]%%2==0){  #if�����δ� �ݺ����� ������� ������ ������ �� ����. �Լ��� �ݺ��ؼ� ���Ǵµ� if���� �ε������ؼ� �ϳ��� ������ �ȴ�.
  print(x[1] * 10)
}

[����78]  x <- c(2,10,6,4,3,NA,7,9,1) x ������ NA�� ������ 0���� �����ϼ���

x <- c(2,10,6,4,3,NA,7,9,1)
ifelse(is.na(x),0,x)
ifelse(!is.na(x),x,0)

x[is.na(x)] <- 0
x

[����79] last_name, salary, commission_pct, commission_pct NA �� salary * 12,
�ƴϸ� (salary * 12) + (salary * 12 * commission_pct)�� �����ϼ���.

g <- ifelse(is.na(employees$COMMISSION_PCT),
       employees$SALARY*12,
       (employees$SALARY*12)+(employees$SALARY*12*employees$COMMISSION_PCT))

x <- employees[,c('LAST_NAME','SALARY','COMMISSION_PCT')]
x$��갪 <-g
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

[����80] last_name, salary, �޿��� 10000  �̻��̸� A, 5000�̻� 10000���� ������ B,
�������� C�� �ԷµǾ� �ִ� ���ο� �÷��� �����ϼ���.  
�÷��̸��� name, sal, level �� �����ϼ���.

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
- �������� ���� ���ǿ� �´� ���๮�� �����ϴ� �Լ�

x <- 2
switch(x,'���� �Ⱓ �ּ��� ������', '�ູ����', '�ǰ��ϰ� ����')
switch(1,'���� �Ⱓ �ּ��� ������', '�ູ����', '�ǰ��ϰ� ����')
switch(3,'���� �Ⱓ �ּ��� ������', '�ູ����', '�ǰ��ϰ� ����')

x<- '��'
switch(x,'��' = '�Ѷ�� ���� �ʹ�',
       '�ٴ�' = '�Դ��ؼ����� ���� �ʹ�.',
       paste0(x,'�׳� �����ϼ���'))

x <- '�ٴ�'
if(x=='��'){
  print('�Ѷ�� ���� �ʹ�.')
} else if(x=='�ٴ�'){
  print('�Դ� �ؼ����� ���� �ʹ�.')
} else{
  print('������ ���̳� ����')
}

ifelse(x=='��','�Ѷ�� ���� �ʹ�',
       ifelse(x=='�ٴ�','�Դ� �ؼ����� ����','������ ���̳� ����'))

�� �ݺ���
1. for ��

for(ī���ͺ��� in �ݺ������� ������ ����){
  �ݺ������� ����
}

x <- 1:100
x
for(i in x){
  print(i)
}

for(i in 1:100){
  print("���� �Ϸ絵 �ູ����")
}

x <- c('�ٴ�','��','���','��')
x
for (i in x){
  print(i)
}

x <- c(-1,1,2,3)
for(i in x){
  if(i < 0){
    print('����')
  } else{
    print('���')
  }
}

ifelse(x<0,'����','���')

for(i in '���� �Ϸ絵 �ູ����'){
  print(i)
}

[����81] 1���� 10���� ���� for���� �̿��ؼ� ���ϼ���
hap <- 0
for(i in 1:10){
  hap <- hap + i
}
hap

[����82] 1����100���� ��ü��, ¦����, Ȧ������ ������ּ���.
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

[����83] 1����100���� Ȧ���� x������ �Է����ּ���.�� for���� �̿��ϼ���.
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

[����84] 1���� 10���� ���� ����ϼ���. �� 3,5�� �����ϼ���.
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
# next �Լ� : ���� �������� �ݺ����� �����ϰ� ���� �ݺ������� �Ѿ�� �Լ� (NULL�̳� NA�� �ƴ�)

for(i in 1:10){
  if(i == 3 | i == 5){
    next
  } else{
    print(i)
  }
}


# break �Լ� : �ݺ��� ����

for(i in 1:10){
  if(i == 3 | i == 5){
    break
  } else{
    print(i)
  }
}

[����85] 2���� ���
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
print('2 * ',1,'=',2) # �޸��� ������ �Ǿ� �ִ� ������ ������ ����� �� ����.
print(paste('2 *',1:9,'=',2*1:9)) # �޸��� ������ �Ǿ��ִ� �κ��� paste�� �̿��ؼ� �ϳ��� �ٿ��� ���
cat('2 * ',1,'=',2) # �޸��� ������ �Ǿ� �ִ� ������ ������ ����� �� �ִ�.

for(i in 1:9){
  cat('2 *',i,'=',2*i, '\n') # '\n'(���๮��) <- �����ٷ� �Ѿ�� ������
}

cat(paste('2 *',1:9,'=',2*1:9,'\n'))

[����86] ������(2~9)�� ���

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
    cat(j, 'x', i, '=',j*i, '\t') #cat �Լ� : print�� ��ȭ����.cat() '\n'->����, '\t' -> tab
  }
  cat('\n')
}

[����87] ������(2~9)�� ȭ��� ���� ������ּ���.

2 * 1 = 2 	3 * 1 = 3 	4 * 1 = 4 	5 * 1 = 5 	6 * 1 = 6 	7 * 1 = 7 	8 * 1 = 8 	9 * 1 = 9 	
2 * 2 = 4 	3 * 2 = 6 	4 * 2 = 8 	5 * 2 = 10 	6 * 2 = 12 	7 * 2 = 14 	8 * 2 = 16 	9 * 2 = 18 	
...

for(i in 1:9){
  for(j in 2:9){
    cat(j, '*',i,'=',j*i,'\t')
  }
  cat('\n')
}


2.while ��
- ������ TRUE�� ���� �ݺ������ϰ� ������ FALSE�� �ݺ����� �����ϴ� �ݺ���

while(����){
  �ݺ������� ����
}

for(i in 1:10){
  print(i)
}

i<- 1
while(i<=10){
  print(i)
 i<- i+1
}

[����88] while���� �̿��ؼ� 2���� ������ּ���.
i<-1
while(i<=9){
  cat('2 *',i,'=',2*i,'\n')
  i <- i+1
}
[����89] while���� �̿��ؼ� �������� ������ּ���.
1.���η� ������
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

2.���η� ������
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

#--------------����Դ�
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

[����90] while���� �̿��ؼ� ������(2~9)�� ȭ��� ���� ������ּ���.

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
- ������ ���� ���¿��� �ݺ�

repeat{
  �ݺ������� ����
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


[����91] repeat���� �̿��ؼ� 2���� ������ּ���.
i<-1
repeat{
  
  if(i==10){
    break
  }
  print(paste('2 *',i,'=',2*i))
  i <- i + 1
}

[����92] repeat���� �̿��ؼ� ������(2~9)�� ������ּ���.
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

#----�����
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
[����93] repeat���� �̿��ؼ� ������(2~9)�� ȭ��� ���� ������ּ���.

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

#--------�����
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

[����94] �������� DATAFRAME�� �����ϱ�. ���� ���� �÷����� ���� �ǵ��� ���ּ���.

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
  n <- c(n,paste0(i,'��'))
}
n

names(gugudan)<- n
gugudan
