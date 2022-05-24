a <- c(1:5) #����
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
df_new <- rbind(df,data) # data, df �� ���̰� �ٸ� �� ����̸�ŭ�� ������ �������� �� ����
df_new
df1 <- data.frame(x = c(11,12,13),
           y = c(15,14,16),
           z = c(18,17,19))

rbind(df,df1) # �������������� �� ��ĥ���� ���� ���� �� �̸��� �����ؾ��Ѵ�.

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
  df <- rbind(df,temp) #������� �� ���� rbind ��밡��
}
df
names(df)
n <- NULL
for(i in 2:9){
  n <- c(n,paste0(i,'��'))
}
names(df) <- n
df
df$'2��' #�÷��̸����� ���ڰ� �տ� �´ٸ� ��������ǥ�� �� ���



matrix(NA, nrow=9,ncol=8)

df <- data.frame(matrix(NA, nrow=9,ncol=8)) # ���븦 ����� ����
df
for(i in 2:9){
    temp <- NULL
    for(j in 1:9){
      temp <- c(temp, paste(i, '*',j,'=',i*j))
    }
    df[,i-1] <- temp # cbind�� �ȵ�, �������δ� �ȵǰ� rbind(�����)�� ��, ������ �� ���� ���븦 ����� ���� ������ �ٽ� �־��ִ� �۾��� �ؾ���
}
df


[����95] �Ʒ� ȭ��� ���� ������ּ���.(salary���� �������� 1000�� '*' 1���� ���)
name   sal                     star
King 24000 ************************
  Kochhar 17000        *****************
  De Haan 17000        *****************
  Hunold  9000                *********
  Ernst  6000                   ******
  Austin  4800                     ****
  Pataballa  4800                     ****
  ......
��
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

df[nchar(df$star) != num,] #���� ���� Ȯ��


�赥������������ ���������(na���� �ϳ� ���� ��)
df <- data.frame(name=employees$LAST_NAME,
                 sal=employees$SALARY,
                 star=NA) # �÷��� ������ �� NULL�� X, NA��, NULL�� ���������� ��
df[107,'sal'] <- NA #107���� salary���� na�� �ʱ�ȭ
df
idx <- 1 # idx������ star�÷����� �� ���� ��ġ�� ���� ����
for(i in df$sal){ #df$sal�� �ִ� ������ �ϳ��� �ݺ��ؼ� ����
  if(is.na(i)){ #i(df$sal)���� na�̸� next�Լ��� ����ؼ� ���� i������ �Ѿ�� ����
    next 
  }else{ # i���� na�� �ƴϸ� ������ ����
    v <- NULL # '*'�� �� ������ ����
    for(j in 1:trunc(i/1000)){ # salarty/1000��ŭ�� '*'�� ������ v������ �ʱ�ȭ 
    v <- paste0(v,'*')
  }
  df[idx,'star'] <- v # v������ ���� df(������������)�� star�÷��� idx��°�� �ʱ�ȭ
  idx <- idx + 1 # idx������ 1�� ������Ű�鼭 star�÷��� ���� ������ �Ѿ�� �۾��� ���ؼ�
  }
}
df

�� �Լ�(function)
- �ݺ��Ǿ� ����ϴ� ����� �����ϴ� ���α׷�
- ����� ���α׷�

toupper('king')

�Լ��̸� <- function(){
  �Լ������� �����ؾ��� �ڵ�
  return(��ȯ��) # ����
}

Sys.Date()
format(Sys.Date(),'%Y%m%d')

#format(Sys.Date(),'%Y%m%d')�� �����ϴ� date1�̶�� �Լ� �����
date1 <- function(){
  return(format(Sys.Date(),'%Y%m%d'))
}
date1() #�Լ� ȣ��

# �Ű�����(parameter variable)
- ���ĸŰ�����(formal parameter variable) : arg1, arg2, �Էº��� # �Ű����� �̸��� ���� ������ �ƹ��ų� ����
- �����Ű�����(actual parameter variable) : 'king'

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

[����96] hap�Լ��� ���ڸ� �Է��ϰ� �Ǹ� 1���� �Է¼��ڱ��� �������� ���ϴ� �Լ��� �������ּ���

hap <- function(x){
  y <- 0
  for(i in 1:x){
    y <- y + i
  }
  return(y)
}
hap(3)

#-------------------------- ���� ���ϴ� ���� ������ ���ϴ� �Լ�
gugudan <- function(a){
  for(i in 1:9){
    cat(a,'*',i,'=',a*i,'\n')
  }
}
#--------------------------

[����97] odd�Լ��� ���ڸ� �Է��ϰ� �Ǹ� 1���� �Է¼��ڱ��� Ȧ���� ���� ���ϼ���.

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

[����98] ����� �����ϴ� divisor�Լ��� �������ּ���.
��� : � ���� ������ �������� �ϴ� �ڿ���
��) 12�� ��� 1,2,3,4,6,12

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

# �����μ� : (...)
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

[����99] �Է°����� ���� ���� ���� ���� ���ϴ� hap�Լ��� �����ϼ���.
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


[����100] ����� ���ϴ� avg�Լ��� �������ּ���.
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

[����101] ¦��, Ȧ���� ����ϴ� odd_even�Լ��� �������ּ���.
> odd_even(1:5)
[1] "Ȧ��" "¦��" "Ȧ��" "¦��" "Ȧ��"

odd_even <- function(...){
  odd1 <- NULL
  for(i in c(...)){
    if(i%%2==0){
      odd1 <- c(odd1,'¦��')
    }else{
      odd1 <- c(odd1,'Ȧ��')
    }
  }
  return(odd1)
}

> odd_even(c(1,2,3,4,5))
[1] "Ȧ��" "¦��" "Ȧ��" "¦��" "Ȧ��"



odd_even <- function(...){
  v <- NULL
  for(i in c(...)){
    if(i%%2==0){
      v <- c(v,"¦��")
    }else{
      v <- c(v,"Ȧ��")
    }
  }
  return(v)
}

odd_even <- function(...){
  ifelse(c(...)%%2==0,"¦��","Ȧ��")
}

lst <-list(1,2,3,4,5)
odd_even(lst)
odd_even(lst[[1]])
odd_even(lst[[2]])
odd_even(unlist(lst))

lapply(lst,odd_even) #����Ʈ��
sapply(lst,odd_even) #���ͷ�

lapply(lst,function(arg){ifelse(arg%%2==0, "¦��","Ȧ��")})
sapply(lst,function(arg){ifelse(arg%%2==0, "¦��","Ȧ��")})

ls()
rm(list=ls())
ls()

# ��������(global variable)
- R���α׷��� ����Ǵ� ���ȿ��� ��𼭵��� ����� �� �ִ� ����, �޸𸮿��� ����� ������ ��𼭵� ����� �� �ִ� ����
x <- 1
y <- 2
z <- 3

ls()

f <- function(){
  y <-20 # ��������(private variable, local variable) : �Լ��������� ���Ǵ� ����
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
  x <<- 10  # '<<-'��������
  y <- 20  # '<-' ��������
  z = 30   # '=' ��������
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
  x <<- 1  # '<<-'��������
  y <- 20  # '<-' ��������
  z = 30   # '=' ��������
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

# private variable : �Լ��� ��ø�� �Լ� �� ��� ���� �Լ��� arg1, arg2 �Լ������� ��𼭵� ����� �� �ִ�.
# local variable : �Լ��� ��ø�� �Լ� �� ��� ��ø�Լ����� ����� arg3������ ��ø�Լ� �������� ����� �� �ִ�.

f <- function(arg1,arg2){
  x1 <- arg1 #x1������ private variable �� f�Լ������� ��𼭵��� ����� �� �ִ�.
  x2 <- arg2 #x1������ private variable �� f�Լ������� ��𼭵��� ����� �� �ִ�.
  
  f1 <- function(arg3){
    x3 <- x1+x2 + arg3 #x3������ local variable, �� x3������ f1�Լ� �������� ����ؾ� �Ѵ�.
    print(x3)
  }
  f1(x2) #arg2(20) -> f1.arg3(20)
  print(x1)
  print(x2)
  print(x3) # �����߻� : local variable�� �ڽ��� �Լ� �������� ����ؾ� �ϱ� ������ ���� �߻�
}

f(10,20)

[����102] avg�Լ� �ȿ� hap�Լ��� ��ø�ؼ� avg�Լ��� �������ּ���.
avg <- function(...){
  
  hap <- function(...){
    
    return() #��ø�Լ��� ȣ���� �����Լ� ������ ���� ��������� �Ѵ�.
  }
  hap # �����Լ� �ȿ��� ������ ��ø�Լ��� ȣ���ϴ� ��ġ(hap�Լ��� ���� ���� �ؾ���)
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
  return(hap(x)/length(x)) #hap �Լ����� ����(v_sum) �� ���� �̰����� �´�.
}

avg(1,2,3,NA,4,5,NA)
