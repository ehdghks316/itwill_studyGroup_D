�� matrix(���)
- ��, ���ڸ� ���簢�� ���·� ��Ÿ�� �ڷ���
- ����ó�� �Ѱ��� ������ Ÿ�Ը� �����Ѵ�.
- ��(����)�� ��(����) �����ȴ�.

matrix(c(1:9))
matrix(c(1:9),nrow=3) # nrow : ���Ǽ�
matrix(c(1:9),ncol=3) # ncol : ���Ǽ�
matrix(c(1:10),nrow=2,ncol=5)
matrix(c(1:10),nrow=5,ncol=2)

x <- matrix(c(1:12), ncol=2,nrow=6)
x
str(x)
class(x)
mode(x)
typeof(x)
is.integer(x)
is.numeric(x)
is.list(x)
is.character(x)
is.matrix(x)

dim(x) # ����� ũ��, 6 x 2, ���Ǽ� x ���Ǽ�
NROW(x) # ���Ǽ�
nrow(x) # ���Ǽ�
ncol(x) # ���Ǽ�
length(x) # ���� �ȿ� ��� �ִ� ���� ��

dim(x)[1] # ���Ǽ�
dim(x)[2] # ���Ǽ�

z <- c(1:9)
length(z)
NROW(z)
nrow(z) # ���Ϳ����� ������� �ʴ´�

matrix(c(1:9),ncol=3) # byrow=FALSE : ���������� ���� ä��, �⺻��
matrix(c(1:9),ncol=3,byrow=FALSE)
matrix(c(1:9),ncol=3,byrow=TRUE) # byrow=TRUE : ��������� ���� ä��

x <- matrix(c(1,2,3,4),nrow=2,ncol=2,byrow=T,
       dimnames=list(c('row1','row2'),
                     c('col1','col2')))
x
class(dimnames(x))
dimnames(x)[1] # ���� �̸�
dimnames(x)[[1]] # ������ �̸� ���� ���� �̸���

dimnames(x)[2] # ���� �̸�
dimnames(x)[[2]]

y <- matrix(c(1:9),ncol=3)
y
# ����� �̸� ����
dimnames(y) <- list(c('row1','row2','row3'),
                    c('col1','col2','col3'))
dimnames(y)
y
# ���̸� ����
rownames(y) <- c('r1','r2','r3')
dimnames(y)[[1]] <-c('row1','row2','row3')
rownames(y)[2] <- 'r2' # ���� �ι�° �̸��� ����
'r2' %in% rownames(y)
rownames(y) %in% 'r2'
which(rownames(y) %in% 'r2')
rownames(y) == 'r2'
which(rownames(y) %in% 'r2')
rownames(y)[which(rownames(y) %in% 'r2')] <- 'row2'
y

# ���̸� ����
colnames(y) <- c('c1','c2','c3')
y
dimnames(y)[[2]] <- c('col1','col2','col3')
colnames(y)[2] <- 'c2'
colnames(y)[which(colnames(y) %in% 'c2')] <- 'col2'
y

cell <- c(1:9)
rname <- c('a','b','c')
cname <- c('c1','c2','c3')
x <- matrix(cell,nrow=3,byrow=T,dimnames=list(rname,cname))
x

# �������(transposed matrix), ��� ���� ��ġ�� �ٲ� ���
t(x)

x_t <- t(x)
x_t
rownames(x_t) <- rownames(x) # ���� �̸����� ���� �ٲ�� �־ ���� �̸��� �ٽ� �ٲٱ�
colnames(x_t) <- colnames(x) # ���� �̸����� ������ �ٲ�� �־ ���� �̸��� �ٽ� �ٲٱ�
x_t

# ����� �ε���
x[1,1] #[���ε���, ���ε���]
x[1,2]
x[2,3]
x[2,] # [���ε���,] 2���� ������ �� ����
x[,3] # [,���ε���] 3���� ������ �� ����

x[-1,] # ù��° ���� ���ܽ�Ű�� ���� ( Ư���� �� ����)
x[,-2] # �ι�° ���� ���ܽ�Ű�� ���� ( Ư���� �� ����)
x[-1,-2] # Ư���� ��, �� ����

x[c(1,3),] # Ư���� ��� ����
x[,c(2,3)] # Ư���� ���� ����
x[c(1,3),2] # Ư���� ��� �� ������

x['a',] # �� �̸����� ����
x[,'c3'] # �� �̸����� ����
x
which(x==10)
which(x==5) # ��� �ȿ� ���� ���������� ã�´�.
which(x==3)
which(x==6)

x <- matrix(c(1:4),ncol=2)
x
# ����� ����
x+10
x-10
x*10
x/2
x%/%2
x%%2

y <- matrix(c(5:8),ncol=2)
y
# ����� ���� ��ġ�� �ִ� ���г��� ���� �۾��� �����Ѵ�.
x+y 
x-y
x*y
x/y
x%/%y
x%%y

# ����� ��
x
y
x %*% y

 1 3 %*% 5 7   = (1*5 + 3*6, 1*7 + 3*8)
 2 4     6 8     (2*5 + 4*7, 2*7 + 4*8)
 
dim(x)
dim(y) 
2*2 2*2

# �������(square matrix) : ���� ���� ��� ���� ������ ���
2*2, 3*3, 4*4...

# �׵����(identity matrix), �������(unit matrix)
- �밢������ ��� 1�̰� �� �̿��� ��� ������ 0�� �������
diag(4)
diag(3)
diag(2)

# �밢���(diagonal matrix) : �밢������ �ƴ� ��� ������ 0�� ���

a <- c(1:3)
diag(a)
diag(2,nrow=3)
diag(7,nrow=5)

# �����(invertible matrix)
solve(x)
x %*% solve(x) # �������

x <- c(1:4)
y <- c(5:8)
x
y
z <- cbind(x,y) # ������
class(z)
z
r <- rbind(x,y) # �����
class(r)
r
[����16] x ������ ����� �����ϼ���. ���� 1���� 10���� �Է��Ͻð� 5�� 2������ ����鼭 ���� ���� �������� �����ϼ���.
x <- matrix(c(1:10),nrow=5, byrow=FALSE)
x

[����17] x ������ ���� �������� 11,12,13,14,15 ���� �߰��ϼ���.
x <- cbind(x,c(11:15)) 
x
[����18] x ������ ���� �������� 16,17,18 ���� �߰��ϼ���.
x <- rbind(x,c(16:18))

[����19] x������ 6���� ���� 20,21,22 �� �����ϼ���.
x[6,] <- c(20,21,22)
x

[����20] x ������ 6���� �������ּ���.
x <- x[-6,]
x
x <- x[-6,]

x <- matrix(c(1:18),nrow=6, byrow=FALSE)
x[-6,]
x <- x[-6,]
x

dim(x)
x
dim(x) <- c(3,5) # 5�� 3�� -> 3��5�� ���� #c(��,��)
x
dim(x) <- c(1,15)
x
dim(x) <- c(15,1)
x
dim(x) <- c(5,3)
x

�� array(�迭)
- ���� ������ Ÿ���� ���� 3���� �迭����

x <- array(c(1:9),dim=c(2,3))
x
class(x)
str(x)
mode(x)
is.matrix(x) # matrixȮ�� ���
is.array(x) # array Ȯ�� ���
dim(x)

y <- array(c(1:24),dim=c(2,3,4)) # dim=c(��,��,���)
y
class(y)
mode(y)
str(y)
is.matrix(y)
is.array(y)

y[1,1,1] # [��,��,��]
y[,,1] # Ư���� �鸸 Ȯ��

dimnames(y) <- list(c('r1','r2'),c('c1','c2','c3'))
rownames(y)
colnames(y)
dimnames(y) <- NULL # ������� �̸��� �� ����ڴ�
y
dim(y) # array ��� Ȯ��
dim(y) <- c(3,4,2) # 3��, 4��, 2������ �ٲٱ�
y

[����21] x �迭�� �����ϼ���. 1���� 12���� ���� �������ִ� �迭�� �����ϼ���. ��2,��2,���� 3���� ������������ϼ���.
x <- array(c(1:12),dim=c(2,2,3))
x

dim(x)

[����22] x �迭 ������ �÷��̸��� 'a','b'�� �����ϼ���.
dimnames(x) <- list(NULL,c('a','b'))
x
colnames(x) <- c('a','b')
dimnames(x)[[1]]

[����23] x �迭 ������ ���̸��� 'row1','row2'�� �����ϼ���.
dimnames(x)[[1]] <- c('row1','row2')
rownames(x) <- c('row1','row2')
x
dimnames(x)[[3]] <- c('one','two','three') # �� �̸� ����
x[,,3]
x[,,'three']
x[1,1,]
x['row1','a',]

dimnames(x) <- NULL

[����24] x �迭 ������ ���� 2�� �����ϼ���.
dim(x) <- c(2,3,2)
dim(x)
dim(x) <- c(1,6,2)
x

�� factor
- ������ �����͸� ǥ���ϴ� �ڷ���
- (����, ����, ����), (����, ����), ��������, ������
- ���� : ������, ������(ordinal), �����(nominal)
x <- factor("����",levels=c("����","����","����")) #level�� �ִ� ������ ǥ���� �� ����,���°��� <na>���
x
str(x)
class(x)
mode(x)
typeof(x)
y <- factor("����",levels=c("����","����","����"),ordered=T) # ������ factor
y
str(y)
class(y)
mode(y)
typeof(y)

is.factor(x) #factor �� üũ
is.factor(y)
is.ordered(x) # ������ factor üũũ
is.ordered(y)

nlevels(x) # factor level �� Ȯ��
nlevels(y)

levels(x) # factor level �� Ȯ��
levels(y)

levels(y)[1]

"����" %in% levels(y)
levels(y) %in% "����"
levels(y)[which(levels(y) %in% "����")] <- "�ſ�����" # levels(y)��ġ���� ������ �ִ� �ڸ��� �ſ��������� ����
levels(y)
levels(y)[which(levels(y) %in% "����")] <- "����"
y

levels(y) <- c('good','normal','bad') # factor level �� ������
y

levels(y)[2] <- '����' # normal�� �������� ����(��� normal���� �������� ����)
y

����25] ���Ϳ� �ִ� �� "����", "����", "�׳�", "����", "����", "����" �� factor ������ �����ϼ���. 
�����̸��� x�� �����Ͻð� level��  ����, ����, ���� ������ �����ϼ���.
y <- c('����','����','�׳�','����','����','����')
y
x <- factor(y,levels=c('����','����','����'))
x[is.na(x)]
x[which(is.na(x))] <- '����'
x

[����26] x factor�� ����̸��߿� ������ �ſ��������� �����ϼ���.
levels(x) == '����'
levels(x)[which(levels(x) %in% "����")] <- "�ſ�����"
levels(x)[which(levels(x) =="����")] <- "�ſ�����"

is.factor(x)
is.ordered(x)
x <- as.ordered(x) #���������� �ٲٱ�
is.ordered(x)
x

�ſ� ����, ����, ����

# factor levels ������ �ٲٷ���
1. factor���� vector������ ��ȯ
y <- as.vector(x)
y
str(y)

2.vector ���� factor������ ��ȯ
y <- factor(y,levels=c("�ſ�����","����","����"),ordered=T)
y
is.ordered(y)

�� data frame
- �����ͺ��̽��� table�� �����ϴ�.
- ��� ���� �����Ǿ� �ִ�.
- ���� �ٸ� ������ Ÿ���� ���� 2���� ���̺�(�迭) ����

df <- data.frame(name=c('scott','hraden','curry'), 
           sql=c(90,80,70),
           r=c(80,70,90))
df
str(df)
class(df)
mode(df)
typeof(df)

df$name # Ư���� �÷� Ȯ��
df$sql

dim(df)
df[1,1]  
df[2,1]
df[1,1] <- 'james' # ���� ���� 
#sql 
 update df
 set name = james
 where name = 'scott'

df[1,] # Ư���� ������
df[,1] # Ư���� ������

df[c(1,3),]
df[,'name']
df[,c('name','r')] # sql > select name,r from df;

df[,'name'] # ���� �ϳ� ����� ���� �⺻������ ���� ���� ���, ���ͷ� ���
df[,'name',drop=F] # drop=F�ɼ� ���� ���� ���, ���������������� ���


df[,'name'][2]
class(df[,'name'])
df[,'name',drop=F][2,]
class(df[,'name',drop=F])

names(df) # ���̸� ���
colnames(df) # ���̸� ���
colnames(df) <- c('NAME', 'SQL','R') # ���̸� ����
df

rownames(df)
rownames(df) <- c('���1','���2','���3') # ���̸� ����
df

rownames(df) <- NULL # ���̸� ����
df

'SQL' %in% names(df)
'SQL' %in% colnames(df)

names(df) %in% 'SQL'
colnames(df) %in% 'SQL'

names(df) %in% c('SQL','R')
colnames(df) %in% c('SQL','R')

c('SQL','PYTHON') %in% names(df)
names(df) %in% c('SQL','PYTHON')

df[,'SQL']
df[,c('SQL','R')]
df[,c('SQL','PYTHON')] # ����
df[,names(df) %in% c('SQL','PYTHON','R')] # PYTHON�� ��� TRUE���鸸 ���, Ư���� ���� ����
df[,!names(df) %in% c('SQL','PYTHON','R')] # Ư���� ���� �����ؼ� ����

which(names(df) %in% c('SQL','PYTHON','R')) # SQL,PYTHON,R�� �ִ� ��ġ�� ã�Ƽ� ���
which(!names(df) %in% c('SQL','PYTHON','R')) # SQL,PYTHON,R�� ���� ��ġ�� ã�Ƽ� ���

which(names(df) == c('SQL','PYTHON','R')) # R�ϳ��ۿ� �ȳ��� ����
which(!names(df) == c('SQL','PYTHON','R'))

which(names(df) == 'SQL') | which(names(df) == 'PYTHON') | which(names(df) == 'R') # �ȳ��� 

which(names(df) == 'SQL')
which(names(df) == 'PYTHON')
which(names(df) == 'R')

df$PYTHON <- c(90,70,60) # ���ο� �÷��� �߰�
df

length(df) # �÷��� ��
NROW(df) # ���� ��
nrow(df) # ���� ��
str(df)

df <- data.frame(x=1:100000)
df
head(df,n=10) # �պκ��� �� ����
tail(df,n=10) # �޺κ��� �� ������

[����27] �Ʒ��� ���� ����� ������ �����ϼ���. ���� �̸��� df�� �ϼ���.

<ȭ�����>
  
  name sql  plsql
1  king  96     75
2 smith  82     91
3  jane  78     86


df <- data.frame(name=c('king','smith','jane'),
                sql=c(96,82,78),
                plsql=c(75,91,86))
df

[����28] df������ james, 90, 80 �߰� ���ּ���.
<ȭ�����>
  
  
  name sql plsql
1  king  96    75
2 smith  82    91
3  jane  78    86
4 james  90    80

df[nrow(df)+1,] <- c('james',90,80)
df

[����29] james�� ���� row ������ ����ϼ���.

<ȭ�����>
  
  name sql plsql  
4 james  90    80 

df[df$name == 'james',]
df[which(df$name %in% 'james'),]

[����30] james �̸��� ���� �������ּ���.
df <- df[-which(df$name %in% 'james'),] 
df <- df[!df$name =='james',]
df


# read.csv : csv������ ���������������� �о���̴� �Լ�
employees <- read.csv("c:/data/emp.csv",header = T) # /, \\ �Ѵ� ����
employees
str(employees)
names(employees)
colnames(employees)
head(employees)
tail(employees)

# SQL 
SELECT * FROM employees WHERE employee_id = 100;

# R
employees$EMPLOYEE_ID == 100
employees[employees$EMPLOYEE_ID == 100,] # ���ǿ� �ش��ϴ� �ุ ����

# SQL 
SELECT last_name, salary FROM employees WHERE employee_id = 100;

# R
employees[employees$EMPLOYEE_ID == 100, c('LAST_NAME','SALARY')] # ���ǿ� �ش��ϴ� �ุ ����
employees[which(employees$EMPLOYEE_ID == 100), c('LAST_NAME','SALARY')] # ���ǿ� �ش��ϴ� �ุ ����

# ������������[����������, ������]

[����31] employees ������ �ִ� ������ �߿� �޿��� 3000 �� 
������� last_name, salary�� ����ϼ���. 
�� employees ������ �÷������� Ȯ���Ͻð� �����ϼ���.
#R
employees[employees$SALARY == 3000,c('LAST_NAME','SALARY')]

#SQL
SELECT last_name, salary
FROM employees
WHERE salary = 3000;

[����32] �޿��� 2000 �̻��� ������� last_name, salary�� ����ϼ���.
#R
employees[employees$SALARY >= 2000, c('LAST_NAME','SALARY')]

#SQL
SELECT last_name, salary
FROM employees
WHERE salary >= 2000;

[����33] job�� ST_CLERK�� ������� �̸��� ���ް� ������  ����ϼ���.
#R
employees[employees$JOB_ID =='ST_CLERK', c('LAST_NAME', 'SALARY','JOB_ID')]

#SQL
SELECT last_name, salary, job_id
FROM employees
WHERE job_id = 'ST_CLERK';

[����34] job�� ST_CLERK�� �ƴ� ������� �̸��� ���ް� ������  ����ϼ���.
#R
employees[employees$JOB_ID != 'ST_CLERK', c('LAST_NAME','SALARY','JOB_ID')]

#SQL
SELECT last_name,salary,job_id
FROM employees
WHERE job_id != 'ST_CLERK';

[����35] job�� AD_ASST, MK_MAN �� ������� employee_id,last_name,job_id�� ����ϼ���.
#R
employees[employees$JOB_ID == 'AD_ASST' |employees$JOB_ID == 'MK_MAN', c('EMPLOYEE_ID','LAST_NAME','JOB_ID')]
employees[employees$JOB_ID %in% c('AD_ASST','MK_MAN'),c('EMPLOYEE_ID','LAST_NAME','JOB_ID')]
#SQL
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id = 'AD_ASST'
OR job_id ='MK_MAN';
#job_id in ('AD_ASST','MK_MAN');

[����36] �μ���ȣ�� 20��,30�� ����� �߿� �޿��� 10000�̻��� 
����� last_name, salary, department_id�� ����ϼ���.
#R
employees[(employees$DEPARTMENT_ID ==20 |employees$DEPARTMENT_ID ==30) & employees$SALARY >= 10000, c('LAST_NAME','SALARY','DEPARTMENT_ID')]

employees[employees$DEPARTMENT_ID %in% c(20,30) & employees$SALARY >= 10000, c('LAST_NAME','SALARY','DEPARTMENT_ID')] # &������ �켱������ ���Ƽ�  |���� ��ȣ�� ����

#SQL
SELECT last_name, salary, department_id
FROM employees
WHERE department_id in (20,30)
AND salary >= 10000

text1 <- '2022-01-10'
text2 <- '�����Ϸ絵 �ູ�ϰ� ����'
text3 <- '���⿡�� �� �ູ����'

#paste, paste0 : ������ ������ �ϳ��� ���� �Լ�
paste(text1,text2,text3)
paste(text1,text2,text3,sep=' ') # sep=' ' ���� �ϳ��� ���� �� ���鹮�ڸ� �����ڷ� �Է��ؼ� ���´�
paste(text1,text2,text3,sep=',')
paste(text1,text2,text3,sep='')
paste0(text1,text2,text3) # ���鹮�ڸ� ���ְ� ����

[����37] last_name�� job_id ���� �Ʒ������ ���� ��µǵ����ϼ���. 

King�� ������ AD_PRES�Դϴ�.
....
paste(employees$LAST_NAME,'�� ������ ',employees$JOB_ID,'�Դϴ�.', sep='')
paste0(employees$LAST_NAME,'�� ������ ',employees$JOB_ID,'�Դϴ�.', sep='')

[����38] Grant ����� ������ ������ּ���.

Grant�� ������  SH_CLERK�Դϴ�.

paste0(employees[employees$LAST_NAME =='Grant','LAST_NAME'],'�� ������ ',employees[employees$LAST_NAME =='Grant','JOB_ID'],'�Դϴ�.')
paste(employees[employees$LAST_NAME =='Grant','LAST_NAME'],'�� ������ ',employees[employees$LAST_NAME =='Grant','JOB_ID'],'�Դϴ�.', sep='')

[����39] commission_pct��  NA �� ������� last_name, salary, commission_pct�� ����ϼ���.

employees[is.na(employees$COMMISSION_PCT) == T, c('LAST_NAME', 'SALARY', 'COMMISSION_PCT')]

[����40] department_id�� NA �� ������� last_name, salary, department_id�� ����ϼ���.

employees[is.na(employees$DEPARTMENT_ID) == T, c('LAST_NAME','SALARY','DEPARTMENT_ID')]

[����41] commission_pct��  NA�� �ƴ� ������� last_name, salary, commission_pct�� ����ϼ���.

employees[is.na(employees$COMMISSION_PCT) == F, c('LAST_NAME','SALARY','COMMISSION_PCT')]
employees[!is.na(employees$COMMISSION_PCT),c('LAST_NAME','SALARY','COMMISSION_PCT')]

[����42] 30�� �μ� ������̸鼭 �޿��� 3000�̻��� ������� employee_id, salary, department_id�� ����ϼ���.

employees[employees$DEPARTMENT_ID == 30 & employees$SALARY >= 3000, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')]
#NA���� ������ ���� : 

# na.omit : NA�� �ִ� ���� ����(�����Ͱ� ���ư�, �ʵ尪�� NA�� ������ NA�� �ش��ϴ� �� �������� �� �ϴ� ����) --�����ؼ� ��� 
na.omit(employees[employees$DEPARTMENT_ID == 30 & employees$SALARY >= 3000, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')])

employees[employees$DEPARTMENT_ID %in% 30 & employees$SALARY >= 3000, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')]

[����43] 20���μ� ����̸鼭 �޿��� 10000�� �ʰ��� ��� �Ǵ� �޿��� 2500 �̸��� ������� employee_id, salary, department_id�� ����ϼ���.

employees[employees$DEPARTMENT_ID ==20 & employees$SALARY > 10000 |employees$SALARY < 2500, c('EMPLOYEE_ID','SALARY','DEPARTMENT_ID')]


NROW(employees)
NROW(na.omit(employees)) #na�� �� �ִ� ��� �� �����ϴ� ���ǿ��


