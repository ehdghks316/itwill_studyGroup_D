
[����132]�μ����� �ְ� �޿��ڵ��� ������ ������ּ���.
library(plyr)
employees <- read.csv('c:/data/employees.csv',header = T)

a <- plyr::ddply(employees,'DEPARTMENT_ID',transform,max_s=max(SALARY))
a[a$SALARY == a$max_s,][,-12]

plyr::ddply(employees,'DEPARTMENT_ID',subset,SALARY==max(SALARY))

a <- aggregate(SALARY~DEPARTMENT_ID,employees,max)
merge(a,employees,by=c('DEPARTMENT_ID','SALARY'))

[����133]�μ����� ���� ó������ �Ի��� ��� ������ ������ּ���.


employees$HIRE_DATE <- as.Date(employees$HIRE_DATE,format='%Y-%d-%m')
a <- ddply(employees,'DEPARTMENT_ID',transform,min_e= min(HIRE_DATE))
a[a$HIRE_DATE==a$min_e,][,-12]

plyr::ddply(employees,'DEPARTMENT_ID',subset,HIRE_DATE==min(HIRE_DATE))

a <- aggregate(HIRE_DATE~DEPARTMENT_ID,employees,min)
merge(a,employees,by=c('HIRE_DATE','DEPARTMENT_ID'))


[����134]�ڽ��� �μ� ��� �޿� ���� �� ���� �޴� ������� EMPLOYEE_ID,DEPARTMENT_ID,SALARY�� ������ּ���.

ddply(employees,'DEPARTMENT_ID',subset,SALARY > mean(SALARY))[,c('EMPLOYEE_ID','DEPARTMENT_ID','SALARY')]

dept_avg <- aggregate(SALARY~DEPARTMENT_ID,employees,mean)
names(dept_avg)[2] <- 'AVG_SAL'
dept_avg
df <- merge(employees,dept_avg)
df[df$SALARY > df$AVG_SAL,c('EMPLOYEE_ID','DEPARTMENT_ID','SALARY','AVG_SAL')]

df <- ddply(employees, 'DEPARTMENT_ID', transform,AVG_SAL = mean(SALARY))
df[df$SALARY > df$AVG_SAL,c('EMPLOYEE_ID','DEPARTMENT_ID','SALARY','AVG_SAL')]



#---------------------------------------------------------------

������ ���͸�
employees[employees$DEPARTMENT_ID == 20,]
subset(employees,DEPARTMENT_ID == 20)

�� dplyr ��Ű�� �Լ� ���
install.packages("dplyr")
library(dplyr)

dplyr::filter() : ���ǿ� �ش��ϴ� ���� ���͸��ϴ� �Լ�

filter(employees,DEPARTMENT_ID==20)

dplyr::select() : Ư���� �÷��� �����ϴ� �Լ�

select(employees,EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID)
select(employees,1,4,7) #1,4,7�� �÷� ����
select(employees,1:7) # 1������ 7������ �÷� ����
select(employees,-1,-4,-7) # Ư��(1,4,7)�÷� ���� ����
select(employees,-LAST_NAME,-FIRST_NAME) # LAST_NAME,-FRIST_NAME�� �����ϰ� ����

x <- subset(employees,SALARY>=10000,select=c(LAST_NAME,SALARY))
order(x$SALARY,decreasing = T)
x[order(x$SALARY),]
x[order(x$SALARY,decreasing=T),]

library(doBy)
doBy::orderBy(~SALARY,x)#��������
doBy::orderBy(~-SALARY,x) #��������
doBy::orderBy(~-SALARY+LAST_NAME,x)# SALARY������������, LAST_NAME ������������

dplyr::arrange() : ����
arrange(x,SALARY) # ������������
arrange(x,desc(SALARY)) # ������������
arrange(x,desc(SALARY),LAST_NAME) # SALARY������������, LAST_NAME ������������

#sql
select last_name, job_id, salary
from employees
where salary >= 10000
order by salary;

filter(employees,SALARY >= 10000)
select(employees,LAST_NAME,JOB_ID,SALARY)
arrange(employees,SALARY)

%>%(������) : ���������� �����ؼ� ����ϴ� ��� ������.(dplyr������ ���)

employees%>%
  filter(DEPARTMENT_ID==20)

employees%>% #������������
  select(LAST_NAME,JOB_ID,SALARY)%>% #����1
  filter(SALARY>=10000)%>% #����2
  arrange(desc(SALARY),LAST_NAME) #����÷��� ���� ������ ���� , ���� 3
  

# �÷��߰�
employees$ann_sal <- employees$SALARY * 12
head(employees) 

#�÷� ����
employees$ann_sal <- NULL
head(employees)

�� dplyr::mutate : ���ο� �÷��� �߰��ϴ� �Լ�,�̸�����

mutate(employees,ann_sal=SALARY*12) #�̸�����
head(employees) #������ ����

df <- mutate(employees,ann_sal=SALARY*12)
head(df)

employees%>%
  select(LAST_NAME,SALARY,COMMISSION_PCT)%>%
  mutate(ann_sal=SALARY*12)%>%
  arrange(desc(ann_sal))

[����135] employees ������ �������� ���ο� df �̸����� �����ϼ���.
df ������ �����ӿ�  ���ο� comm �÷��� �����ϴµ� COMMISSION_PCT ���� ������� ���� �Է��Ͻð�
�������� ���� COMMISSION_PCT�� ��� ������ �Է����ּ���.(�� mutate�Լ��� �̿��ϼ���)

df <- employees
head(df)

df>%%
  mutate(comm=ifelse(is.na(COMMISSION_PCT),mean(COMMISSION_PCT,na.rm=T),COMMISSION_PCT))
       
df$comm <- ifelse(is.na(df$COMMISSION_PCT),mean(df$COMMISSION_PCT,na.rm=T),df$COMMISSION_PCT)
df
[����136]30�� �μ� ������̸鼭 �޿��� 5000�̻��� ������� employee_id, salary, department_id�� ����ϼ���.
(dplyr ��Ű���� �ִ� �Լ��� �̿��ϼ���.)

employees%>%
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>% #select�� �������ư�
  filter(DEPARTMENT_ID ==30 & SALARY >= 5000)

employees%>%
  filter(DEPARTMENT_ID ==30 & SALARY >= 5000)%>% #filter�� �������ư�
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)
  
employees%>%
  filter(DEPARTMENT_ID ==30 & SALARY >= 5000)%>%
  select(EMPLOYEE_ID,DEPARTMENT_ID)

select employee_id, department_id
from employees
where salary >= 5000;

[����137]30�� �Ǵ� 50�� �μ� ������̸鼭 �޿��� 5000�̻��� ������� employee_id, salary, department_id�� ����ϼ���.
(dplyr ��Ű���� �ִ� �Լ��� �̿��ϼ���.)

employees%>%
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>%
  filter((DEPARTMENT_ID==30 |DEPARTMENT_ID==50) & SALARY >= 5000)

employees%>%
  select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>%
  filter(DEPARTMENT_ID %in% c(30,50) & SALARY >= 5000)

[����138] COMMISSON_PCT�� NA�� ����� �߿� �޿��� 10000�̻��� ������� ������ ������ּ���.
(dplyr ��Ű���� �ִ� �Լ��� �̿��ϼ���.)

employees%>%
  filter(is.na(COMMISSION_PCT), SALARY >= 10000)

[����139] �����Ͽ� �Ի��� ������� LAST_NAME, SALARY,HIRE_DATE�� ����ϼ���. �Ի��� ��¥�� �������� �������� �����ϼ���.
(dplyr ��Ű���� �ִ� �Լ��� �̿��ϼ���.)

employees%>%
  select(LAST_NAME,SALARY,HIRE_DATE)%>%
  filter(format(HIRE_DATE,'%A')=='������')%>%
  arrange(HIRE_DATE)

library(lubridate)

employees%>%
  select(LAST_NAME,SALARY,HIRE_DATE)%>%
  filter(wday(HIRE_DATE,week_start=1,label=T)=='��')%>%
  arrange(HIRE_DATE)

#��ü ���谪
data.frame(sum_sal = sum(employees$SALARY),
           mean_sal = mean(employees$SALARY))
plyr::summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))
dplyr::summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))

select department_id, sum(salary)
from employees
group by deparment_id;

aggregate(SALARY~DEPARTMENT_ID,employees,sum)
plyr::ddply(employees,'DEPARTMENT_ID',summarise,sum_sal=sum(SALARY))

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY))

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal=sum(SALARY)) # summarise �Լ� ���ÿ� ��Ű���̸��� �������� ������ �켱������  plyr::summarise�� ����ȴ�.

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  plyr::summarise(sum_sal=sum(SALARY))  #���ϴ� ���� ������� ���ϰ� ��ü���谪������ 

#sql
select department_id,job_id,sum(salary) sum_sal, avg(salary) avg_sal
from employees
group by department_id,job_id;

employees%>%
  dplyr::group_by(DEPARTMENT_ID,JOB_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY),avg_sal=mean(SALARY))

employees%>%
  dplyr::summarise(sum_sal=sum(SALARY),sum_comm=sum(COMMISSION_PCT,na.rm=T),
                   mean_sal=mean(SALARY),mean_comm=mean(COMMISSION_PCT,na.rm=T))

employees%>%
  dplyr::summarise_at(c('SALARY','COMMISSION_PCT'),c(sum,mean),na.rm=T)

# �ε�� ��Ű�� Ȯ��
search()

# �ε�� ��Ű�� ����
detach(package:plyr,unload=TRUE)
detach(package:dplyr,unload=TRUE)
search()

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal=sum(SALARY))
#plyr�� �ε�Ǿ� ���� ������, dply::summarise����ȴ�.
install.packages('plyr')
library(plyr)
library(dplyr)

summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))
dplyr::summarise(employees,sum_sal=sum(SALARY),mean_sal=mean(SALARY))
#dply �޸𸮿� �ε尡 �Ǿ� ���� �ʾƵ� �� ��ǻ�Ϳ� dplyr��Ű���� ��ġ�� �������� dplyr::summarise() ������ �� �ִ�.

library(plyr)
library(dplyr)
search()

employees%>%
  dplyr::summarise_if(is.numeric,c(sum,mean),na.rm=T)

employees%>%
  dplyr::summarise_if(is.integer,c(sum,mean),na.rm=T)
str(employees)

employees%>%
  dplyr::summarise_if(is.character,c(max,min,NROW))

employees%>%
  dplyr::summarise_if(is.integer,c(max,min,length))

max(employees$FIRST_NAME) # ���ĺ� �� ���� ������
min(employees$FIRST_NAME) # ���ĺ� �� ���� ù��°


detach(package:plyr,unload=TRUE)
detach(package:dplyr,unload=TRUE)
install.packages(dplyr)
library(dplyr)
library(plyr)
search()

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal=sum(SALARY))
#���������� ��Ű���� �ε� ��ų�� ���� �������� �ε��Ų ��Ű���� �켱������ ����ȴ�.

employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(sum_sal=sum(SALARY)) #��Ű�� �̸� �������ֱ�

#select���� �����ϰ� �ִ� user�� insa�����Դϴ�
select ...
from hr.emp, scott.emp, hr.dept, scott.dept, emp # insa�������� emp���̺��� ã�´�.
where ...;


[����140] �μ��� �޿��� �Ѿ��� ���� �� 10000���� ������ ������ּ���.
#sql
select department_id, sum(salary)
from employees
group by department_id
having sum(salary) <= 10000;

(1) tapply

x <-tapply(employees$SALARY,employees$DEPARTMENT_ID,sum)
x <- data.frame(x)
names(x) <- 'SUM_SAL'
x
rownames(x)
x$DEPARTMENT_ID <- rownames(x)
x
rownames(x) <- NULL
x <- x[,c(2,1)]
x[x$SUM_SAL <= 10000,]

a <- tapply(employees$SALARY,employees$DEPARTMENT_ID,sum)
a <- data.frame(a)
names(a) <- 'SUM_SAL'
a
rownames(a)
a$DEPARTMENT_ID <- rownames(a)
a
rownames(a) <- NULL
a <- a[,c(2,1)]
a[a$SUM_SAL <= 10000,]

(2) aggregate
a <-aggregate(SALARY~DEPARTMENT_ID,employees,sum)
a[a$SALARY <= 10000,]

(3) plyr::ddply

x <- plyr::ddply(employees,'DEPARTMENT_ID',summarise,SUM_SAL=sum(SALARY))
na.omit(x[x$SUM_SAL <= 10000,])

(4) dplyr
employees%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(SUM_SAL=sum(SALARY))%>%
  dplyr::filter(SUM_SAL <= 10000)

employees%>%
  dplyr::select(EMPLOYEE_ID,SALARY,DEPARTMENT_ID)%>%
  dplyr::filter(!DEPARTMENT_ID %in% c(10,70))%>%
  dplyr::group_by(DEPARTMENT_ID)%>%
  dplyr::summarise(SUM_SAL=sum(SALARY))%>%
  dplyr::filter(SUM_SAL <= 10000)

select department_id, sum(salary)
from employees
where department_id not in (10,70)
group by DEPARTMENT_ID
having sum(salary) <= 10000;

[����141]�μ���, ���Ϻ� �Ի� �ο����� ����ϼ���.

(1) tapply
tapply(employees$EMPLOYEE_ID,
       list(employees$DEPARTMENT_ID,lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)),length,default=0)


(2) aggregate
1.
aggregate(EMPLOYEE_ID~DEPARTMENT_ID+format(HIRE_DATE,'%A'),employees,NROW)
2.
aggregate(EMPLOYEE_ID~DEPARTMENT_ID+lubridate::wday(employees$HIRE_DATE,week_start=1,label=T),employees,length)

(3) plyr::ddply
df1 <- format(employees$HIRE_DATE,'%A')
df <- employees
df$yoil <- df1 
plyr::ddply(df,c('DEPARTMENT_ID','yoil'),summarise,cnt=NROW(EMPLOYEE_ID))

#-------����� ��
plyr::ddply(employees,c('DEPARTMENT_ID','lubridate::wday(employees$HIRE_DATE,week_start=1,label=T)'),summarise,cnt=length(EMPLOYEE_ID))


(4) dplyr
options(tibble.print_max=Inf) #tibble�� ���� �������� �ʰ� ��� ����ϰ� �ϴ� �ɼ�
options(tibble.print_max=10)

employees%>%
  dplyr::group_by(DEPARTMENT_ID,lubridate::wday(employees$HIRE_DATE,week_start=1,label=T))%>%
  dplyr::summarise(cnt=length(EMPLOYEE_ID))
#�̵��� �̰� �ٽ� ������ �������� tapplyó�� ���̰� �غ���

#---------------------------------
�� rank

x <- c(85,80,90,70,60,80,NA)
x

sort(x)
sort(x,decreasing=F, na.last=NA) #�������� na�� ������
sort(x,decreasing=T, na.last=NA) # ��������  na�� ������
sort(x,decreasing=T, na.last=T) # �������� na�� �������� ����
sort(x,decreasing=F, na.last=T) # �������� na�� �������� ����
sort(x,decreasing=T, na.last=F) # �������� na�� �� ó���� ����
sort(x,decreasing=F, na.last=F) # �������� na�� �� ó���� ����

order(x) # �ε����� ����
x[order(x)] # ��������
x[order(x,decreasing=F,na.last = T)] # �⺻��
x[order(x,decreasing=T,na.last = T)] # ��������

#�������� ����
x <- c(85,80,90,70,60,80,NA)
rank(x)
data.frame(x,rank(x))
data.frame(x,rank(x,na.last = T))
data.frame(x,rank(x,na.last = F))

data.frame(���� = x,
           ���� = rank(x))

data.frame(���� = x,
           ���� = rank(x,na.last = T,ties.method = 'average')) # �⺻��, ���� ������ ��� ����� ���ؼ� ������ ��Ÿ��

data.frame(���� = x,
             ���� = rank(x,na.last = T,ties.method = 'first'))  # ���� ������ ���ʿ� �ִ� ���� �켱 

data.frame(���� = x,
             ���� = rank(x,na.last = T,ties.method = 'last')) # ���� ������ �� �ʰ� ���� ��(���ʿ� �ִ� ����) �켱

data.frame(���� = x,
             ���� = rank(x,na.last = T,ties.method = 'random')) # ���� ������ �����ϰ� ������ �Ű�����

data.frame(���� = x,
             ���� = rank(x,na.last = T,ties.method = 'max')) # ���� ������ ������ �ִ밪���� ����

data.frame(���� = x,
             ���� = rank(x,na.last = T,ties.method = 'min')) # ���� ������ ������ �ּҰ�

data.frame(���� = x,
             ���� = rank(x,na.last = 'keep',ties.method = 'min')) # na���� �ϴ� na��

data.frame(���� = na.omit(x),
             ���� = rank(x,na.last = NA,ties.method = 'min')) # ���� �� ������ na�� �����ϰ� ���ϱ�

data.frame(���� = x,
             ����_1 = rank(x,na.last = T,ties.method = 'min'),
             ����_2 = dplyr::min_rank(x), #dplyr��Ű���� min_rank�� ����ϰ� ����
             ����_3 = dplyr::dense_rank(x)) # dplyr::dense_rank(x) ������ ���� ��������


# �������� ����
data.frame(���� = x,
             ����_1 = rank(-x,na.last = T,ties.method = 'min'), # '-'ǥ��
             ����_2 = dplyr::min_rank(desc(x)),
             ����_3 = dplyr::dense_rank(desc(x))) # dplyr::dense_rank(desc(x)) ������ ���� ��������


[����142] �޿��� ���� �޴� ������ ������ ���Ѵ����� 1�� ���� 5�� ���� ������ּ���.
������ ������ �̿��ϼ���.
1.
employees%>%
  dplyr::filter(dplyr::dense_rank(desc(employees$SALARY)) <=5)

employees%>%
  dplyr::mutate(rank=dplyr::dense_rank(desc(SALARY)))%>%
  dplyr::filter(rank<=5)

employees%>%
  dplyr::mutate(rank=dplyr::min_rank(desc(SALARY)))%>%
  dplyr::filter(rank<=5)

2.
employees$rank <- dplyr::dense_rank(desc(employees$SALARY))
employees[employees$rank <= 5,]
employees$rank <- NULL
head(employees)


[����143]  ann_sal ���ο� �÷��� �����ϼ���. ���� commission_pct NA �� salary * 12,
�ƴϸ� (salary * 12) + (salary * 12 * commission_pct) �Է��� �� ann_sal�÷��� ���� �������� ��������
10������ ������ּ���

employees$ann_sal <- ifelse(is.na(employees$COMMISSION_PCT),employees$SALARY*12,
       (employees$SALARY*12)+(employees$SALARY*12*employees$COMMISSION_PCT))

head(employees)

employees$rank <- dplyr::dense_rank(desc(employees$ann_sal))
employees[employees$rank <= 10,]


employees$min_rank <- dplyr::min_rank(desc(employees$ann_sal))
employees[employees$rank <= 10,]

#dense_rank�� min_rank�� �����ٸ� �Լ�

employees$ann_sal <- NULL
employees$dense_rank <- NULL
employees$min_rank <- NULL

employees%>%
  dplyr::mutate(ann_sal = ifelse(is.na(COMMISSION_PCT),SALARY*12,
                                 (SALARY*12)+(SALARY*12*COMMISSION_PCT)),
                dense_rank=dplyr::dense_rank(desc(ann_sal)),
                min_rank=dplyr::min_rank(desc(ann_sal)))%>%
  dplyr::filter(dense_rank<=10)
