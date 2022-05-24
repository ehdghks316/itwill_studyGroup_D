#[����103] �л��� ���ϴ� variance �Լ��� �����ϼ���.



��((���������� - ���)^2)
------------------------
          n-1

����
1)��
2)���
3)����


1. �Լ� ����          
variance <- function(...){
  x <- na.omit(c(...)) #������ ���� X������ �Ű����� �ʱ�ȭ
  y <- 0 # ����� ���ϱ� ���� ���� �����ϴ� ����
  avg <- 0 # ����� ���� �Լ�
  sum_a <- 0 # ��((���������� - ���)^2 ���� ���� ����
  for(i in x){ # x���� ��
    y <- y + i
  }
  avg <- y/length(x) # x���� ���
  
  for(i in x){ # ��((���������� - ���)^2)
    sum_a <- sum_a + (i - avg)^2
  }
  return(sum_a/(length(x)-1)) # �л��� ���� ����
  
}
variance(1:5)

2. �Լ� ���
variance <- function(...){
  x <- na.omit(c(...))
  return(sum((x - mean(x))^2)/(length(x)-1))
  
}

1. �Լ� ����(length ����)          
variance <- function(...){
  x <- na.omit(c(...)) #������ ���� X������ �Ű����� �ʱ�ȭ
  y <- 0 # ����� ���ϱ� ���� ���� �����ϴ� ����
  v_cnt <- 0
  avg <- 0 # ����� ���� �Լ�
  sum_a <- 0 # ��((���������� - ���)^2 ���� ���� ����
  for(i in x){ # x���� ��
    y <- y + i
    v_cnt <- v_cnt + 1
  }
  avg <- y/v_cnt # x���� ���
  
  for(i in x){ # ��((���������� - ���)^2)
    sum_a <- sum_a + (i - avg)^2
  }
  return(sum_a/(v_cnt-1)) # �л��� ���� ����
  
}
variance(1:5)
sqrt(variance(1:5)) #ǥ������
var(c(1,2,3,4,5,NA),na.rm=T)
sd(c(1,2,3,4,5,NA),na.rm=T)

[����104]��� ��ȣ�� �Է� ������ �޾Ƽ� ����� LAST_NAME, SALARY�� ����ϴ� 
find �Լ��� �����ϼ���.
employees <- read.csv('c:/data/employees.csv',header = T)


find(100)
LAST_NAME SALARY
King  24000

find(300)
"����� �������� �ʽ��ϴ�."
employees <- read.csv('c:/data/employees.csv',header = T)

find <- function(x){
  df <- employees[employees$EMPLOYEE_ID == x, c('LAST_NAME','SALARY')]
  if(nrow(df)==1){
    print(df)
  } else{
    print('����� �������� �ʽ��ϴ�.')
  }
}
find(100)
find(300)

'employees' %in% ls()
rm(list=ls())
ls
'employees' %in% ls()

find <- function(arg){
  if(arg==100){
    #NULL #�ƹ��͵� ���ϰڴ�
    return() # �ƹ��͵� ���ϰڴ�. ���� ���� retrun()�� NULL�� �����Ѵ�.
  }else{
    if(!'employees' %in% ls()){
      employees <- read.csv("c:/data/employees.csv",header = T)
    }
    df <- employees[employees$EMPLOYEE_ID == arg, c('LAST_NAME','SALARY')]
    if(nrow(df)==1){
      print(df)
    } else{
      print('����� �������� �ʽ��ϴ�.')
    } 
  }
  
}
find(100)

find <- function(arg){
  if(arg==100){
    print('���� �Ϸ絵 �ູ����') # �����
    stop('��ȸ�� �� ����.') # ������ ���߽�Ű�� �Լ�
    print('���� �Ϸ絵 �ູ����') # ������� �ʴ´�. �ǹ̾��� �ڵ� �۾��� ��
  }else{
    if(!'employees' %in% ls()){
      employees <- read.csv("c:/data/employees.csv",header = T)
    }
    df <- employees[employees$EMPLOYEE_ID == arg, c('LAST_NAME','SALARY')]
    if(nrow(df)==1){
      print(df)
    } else{
      print('����� �������� �ʽ��ϴ�.')
    } 
  }
  
}
find(100)
find(101)
find(300)

find <- function(arg){
  if(arg==100){
    warning('��ȸ�� �� ����.') # warning�� ���α׷��� �����ϸ鼭 �������� ��� ����ϴ� ���
    print('���� �Ϸ絵 �ູ����') # �����
    print('���ϵ� �ູ����') # �����
  }else{
    if(!'employees' %in% ls()){
      employees <- read.csv("c:/data/employees.csv",header = T)
    }
    df <- employees[employees$EMPLOYEE_ID == arg, c('LAST_NAME','SALARY')]
    if(nrow(df)==1){
      print(df)
    } else{
      print('����� �������� �ʽ��ϴ�.')
    } 
  }
  
}
find(100)
find(101)
find(300)

x1 <- data.frame(id=c(100,200,300),sql=c(70,80,90))
x2 <- data.frame(id=c(100,200,300),r=c(85,90,60))
x1
x2
rbind(x1,x2) # ���� �ٸ� �������������� ������ ��ġ���� �÷��̸��� �����ؾ��Ѵ�.
cbind(x1,x2) # ���� �ٸ� �������������� ���� ��ġ���� ���� ���� �����ؾ��Ѵ�.

�� merge(join)
�� �������������� ����� ���� �������� ����(����) �Ѵ�.

#sql���� equi join, simple join, �����
select x1.*, x2.*
from x1,x2
where x1.id = x2.id;

select x1.*, x2.*
from x1 join x2
on x1.id = x2.id;

select x1.*, x2.*
from x1 natural join x2;

merge(x1,x2) # sql�� natural���ΰ� �Ȱ���. ���� �ٸ� �������������� ������ �÷��� ������� �����Ѵ�.
# ���࿡ ������ �÷��̸��� ���� ��� īƼ�þ� ���� �߻��Ѵ�.

select x1.*, x2.*
  from x1 join x2
using(id);

merge(x1,x2,by='id') # by='id' ������ �÷��� ������ ���� ��� Ư���� �÷��� ������� �����ϴ� ���


x1 <- data.frame(id=c(100,200,300),sql=c(70,80,90), p=c(1,2,3))
x2 <- data.frame(no=c(100,200,300,400,500),r=c(85,90,60,10,20), j=c(5,6,7,8,9))

select x1.*, x2.*
  from x1,x2
where x1.id = x2.no;

select x1.*, x2.*
  from x1 join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no') # x1 -> by.x, x2 -> by.y
merge(x2,x1,by.x='no',by.y='id') # x1�ڸ��� x2�ڸ��� x��� y�࿡ �� ����� �����

x1
x2

#sql left outer join
select x1.*, x2.*
  from x1,x2
where x1.id = x2.no(+);

select x1.*, x2.*
  from x1 left outer join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no', all.x=TRUE) 
# all.x=TRUE Ű���� ��ġ�ϴ� ������ �� ����ϰ� ��ġ���� �ʴ� x�� �����͸� ���(left outer join)

#sql right outer join
select x1.*, x2.*
  from x1,x2
where x1.id(+) = x2.no;

select x1.*, x2.*
  from x1 right outer join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no', all.y=TRUE) 
# all.x=TRUE Ű���� ��ġ�ϴ� ������ �� ����ϰ� ��ġ���� �ʴ� y�� �����͸� ���(right outer join)

#sql full outer join
select x1.*, x2.*
  from x1,x2
where x1.id(+) = x2.no;
union
select x1.*, x2.*
  from x1,x2
where x1.id = x2.no(+);

select x1.*, x2.*
  from x1 full outer join x2
on x1.id = x2.no;

merge(x1,x2,by.x='id',by.y='no', all.y=TRUE, all.x=TRUE) 
# all.x=TRUE Ű���� ��ġ�ϴ� ������ �� ����ϰ� ��ġ���� �ʴ� x��, y�� �����͸� ���(full outer join)


[����105]20�� �μ��� �ҼӵǾ� �ִ� �������
LAST_NAME,SALARY, JOB_ID, DEPARTMENT_NAME�� ������ּ���.
departments <- read.csv("c:/data/departments.csv",header = T)
str(departments)
str(employees)

x1 <- employees[employees$DEPARTMENT_ID==20,c('LAST_NAME','SALARY','JOB_ID','DEPARTMENT_ID')]
x2 <- departments[departments$DEPARTMENT_ID==20,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2)[,-1]

[����106] �޿��� 3000 �̻��̰� JOB_ID�� ST_CLERK�� ������� employee_id, salary, job_id, department_name�� ������ּ���

x <- employees[employees$SALARY >= 3000 & employees$JOB_ID %in% 'ST_CLERK', c('EMPLOYEE_ID','SALARY','JOB_ID','DEPARTMENT_ID')]
merge(x,departments)[,c('EMPLOYEE_ID','SALARY','JOB_ID','DEPARTMENT_NAME')]

[����107] commission_pct�� NA�� �������
LAST_NAME, SALARY, DEPARTMENT_ID,DEPARTMENT_NAME�� ������ּ���.

x1 <- employees[is.na(employees$COMMISSION_PCT), c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2, by='DEPARTMENT_ID')

merge(x1,departments)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[����108] commission_pct�� NA�� �ƴ� �������
LAST_NAME, SALARY, DEPARTMENT_ID,DEPARTMENT_NAME�� ������ּ���.

x1 <- employees[!is.na(employees$COMMISSION_PCT), c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2, by='DEPARTMENT_ID')

merge(x1,departments)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[����109] commission_pct�� NA�� �ƴ� �������
LAST_NAME, SALARY, DEPARTMENT_ID,DEPARTMENT_NAME�� ������ּ���. �� �μ��� ���� ����� ������ּ���.

x1 <- employees[!is.na(employees$COMMISSION_PCT), c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
merge(x1,x2, by='DEPARTMENT_ID', all.x=T)

merge(x1,departments,all.x=T)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[����110] ����� last_name, ������ last_name�� ������ּ���.

x1 <- employees[,c('MANAGER_ID','LAST_NAME')]
x2 <- employees[,c('EMPLOYEE_ID','LAST_NAME')]
merge(x1,x2, by.x='MANAGER_ID',by.y = 'EMPLOYEE_ID')[,c('LAST_NAME.x','LAST_NAME.y')]

#sql
select w.last_name, m.last_name
from employees w, employees m
where w.manager_id = m.employee_id;


[����111] ����� last_name, ������ last_name�� ������ּ���. �����ڰ� ���� ����� ������ּ���.

x1 <- employees[,c('MANAGER_ID','LAST_NAME')] #sql���� inline view
x2 <- employees[,c('EMPLOYEE_ID','LAST_NAME')] #sql���� inline view
df <- merge(x1,x2, by.x='MANAGER_ID',by.y = 'EMPLOYEE_ID', all.x = T)[,c('LAST_NAME.x','LAST_NAME.y')]
names(df) <- c('����̸�','�������̸�')
head(df)
#sql
select w.last_name, m.last_name
from employees w, employees m
where w.manager_id = m.employee_id(+);

select w.last_name, m.last_name
from employees w left outer join employees m
on w.manager_id = m.employee_id;

[����112] �μ��̸��� �Ѿ� �޿��� ����ϼ���.

x1 <- employees[,c('SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_NAME','DEPARTMENT_ID')]
df <- merge(x1,x2)[,c('DEPARTMENT_NAME','SALARY')]
df
aggregate(SALARY ~ DEPARTMENT_NAME,df,sum)

x <- aggregate(SALARY~DEPARTMENT_ID,employees,sum)
merge(x,departments)[,c('DEPARTMENT_NAME','SALARY')]
t <- tapply(employees$SALARY,employees$DEPARTMENT_ID,sum)
t
class(t)
df <- data.frame(t)
df$dept_id <- rownames(df)
rownames(df) <- NULL
df
merge(df,departments,by.x='dept_id',by.y='DEPARTMENT_ID')[,c('DEPARTMENT_NAME','t')]

[����113] �μ��̸�,������ �޿��� �Ѿ��� ���ϼ���.
x1 <- employees[,c('SALARY','DEPARTMENT_ID','JOB_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
df <- merge(x1,x2)[,c('DEPARTMENT_NAME','JOB_ID','SALARY')]
df
aggregate(SALARY ~ DEPARTMENT_NAME+JOB_ID,df,sum)

x <- aggregate(SALARY~DEPARTMENT_ID+JOB_ID,employees,sum)
merge(x,departments)[,c('DEPARTMENT_NAME','JOB_ID','SALARY')]


[����114] �ְ� �޿��� �޴� ����� �̸�, �޿�, �μ��ڵ�, �μ��̸��� ����ϼ���.

x1 <- employees[,c('LAST_NAME','SALARY','DEPARTMENT_ID')]
x2 <- departments[,c('DEPARTMENT_ID','DEPARTMENT_NAME')]
df <- merge(x1,x2)
df
max(df$SALARY)
df[df$SALARY == max(df$SALARY),]

x <- employees[employees$SALARY == max(employees$SALARY),c('LAST_NAME','SALARY','DEPARTMENT_ID')]
merge(x,departments)[,c('LAST_NAME','SALARY','DEPARTMENT_ID','DEPARTMENT_NAME')]

[����115] ������� �޿� ����� ������ּ���. last_name, salary, grade_level
job_grades <- read.csv("c:/data/job_grades.csv",header=T)

level <- NULL
for(i in employees$SALARY){
  level <- c(level,job_grades[i >= job_grades$LOWEST_SAL & i <= job_grades$HIGHEST_SAL,'GRADE_LEVEL'])
}
level
data.frame(name = employees$LAST_NAME,
           sal = employees$SALARY,
           level=level)

[���� 116] ������� ��� , �μ� �̸��� ������ּ���. (merge�Լ� �̿����� ���� for���� �������ּ���.)

data.frame(��� = employees$EMPLOYEE_ID,
             �μ��̸� = ����)
#merge(join) = �ݺ��� ����ǰ� �ִ�.

employees$DEPARTMENT_ID

dept_name <- NULL
for(i in employees$DEPARTMENT_ID){
  if(is.na(i)){
    dept_name <- c(dept_name,NA)
  }else{
  dept_name <- c(dept_name,departments[departments$DEPARTMENT_ID == i,'DEPARTMENT_NAME'])
  }
}
dept_name

data.frame(��� = employees$EMPLOYEE_ID,
             �μ��̸� = dept_name)
employees[employees$EMPLOYEE_ID==178,]

