employees <- read.csv("c:/data/employees.csv",header = T) # ���� �о�����

str(employees)
length(employees)
NROW(employees)

�� �����Լ�
1. nchar
- ���ڼ��� �����ϴ� �Լ�

nchar('R Dveloper') #���鹮�ڱ��� ����
nchar('R Developer', type='chars')
nchar('R Developer', type='bytes')

nchar('������', type='chars') # ������ ��
nchar('������', type='bytes') # ������ byte
nchar(names(df))
x <- c('R', 'Developer')
length(x) # ���⼭�� ������ ����
nchar(x) # �渶�� ������ ���̸� ����
nchar(x)[1]
nchar((x)[1])
nchar(x)[2] # ��� ���� �� ������� �ι�°�� ����
nchar((x)[2]) # ó������ �ι�° ���� ���� ����

2. strsplit
- �κй��ڷ� �и��ϴ� �Լ�

strsplit('R Developer', split=' ') # ���鹮�ڸ� �������� �и�,  ����Ʈ������ ���
strsplit('R Developer', split=' ')[[1]][1] # ù��° ���� ù��° ���� ���
strsplit('R Developer', split=' ')[[1]][2] # ù��° ���� �ι�° ���� ���
strsplit('R,Developer', split=',') # �ĸ��� �������� �и�
strsplit('R Developer', split='') # �ѱ��� �� �и�
strsplit('R,Developer', split=character(0)) # �ѱ��� �� �и�2

as.vector(strsplit('R Developer', split=' ')) #���ͷ� ������ �ʴ´�

# unlist : list�ڷ����� vector�ڷ������� ��ȯ�ϴ� �Լ�
unlist(strsplit('R Developer', split=' '))

x <- strsplit('R Developer', split=' ')

paste(x[[1]]) # ���� ������������
paste(x[[1]][1], x[[1]][2]) # ������ �и���Ű�� ��������.
paste(x[[1]], collapse = ' ') # collapse�ɼ��� ���� ��ĥ �� �ִ�.

y <- c('a','b','c')
paste(y[1],y[2],y[3]) 
paste0(y[1],y[2],y[3]) 
paste(y, collapse=' ')
paste(y, collapse=',')
strsplit(paste(y, collapse=','),split=',') # ���ƴٰ� �ٽ� �и�

3. toupper
- �빮�ڷ� ��ȯ�ϴ� �Լ�
toupper('r developer')

4. tolower
- �ҹ��ڷ� ��ȯ�ϴ� �Լ�
tolower('R DEVELOPER')

5.substr
- ���ڸ� �����ϴ� �Լ�
substr('R Developer',1,1) # substr(���ڿ�,�̾Ƴ���ġ,ó�������ؼ� �̾Ƴ� ���� ��)
substr('R Developer',1,5)
substr('R Developer',3,3) # �� D �ϳ��� ���ñ�? R�����ڰ� �׷��� ����������, ������ �ھ���� ���� �� ����
substr('R Developer',2,4) 

6. sub
- ù ��° ��ġ�ϴ� ���ڸ� �ٲٴ� �Լ�
sub('R','Python','R Programmer R Developer') #ó������ ������ R�� Python���� ����
# sub(ã������,�ٲܹ���,���ڿ�)

6. gsub
- ��ġ�ϴ� ��� ���ڸ� �ٲٴ� �Լ�
gsub('R','Python','R Programmer R Developer') # R�� ��� ã�Ƽ�  Python���� ����

[����44] x������ ���߿� ���� �ڿ� �α��ڸ� �������ּ���.
x <- 'developer'
substr(x,nchar(x)-1,nchar(x))
sub(x,nchar(x)-1) # �� ���� �������� �ʾұ� ������ �����߻�
substring(x,nchar(x)-1)
substr(x,1,4)
substr(x,2,5)
substr(x,3,4)
substr(x,1:3,4:5) # �����̽����� ������� �ʰ� ������1,����4������ ����� ���(����x)
substring(x,1:3,4:5) # ??������� ����� �Ǵ°���?
substirng(x,3,5)

substring(x,1:nchar(x),3:nchar(x)) # �ϳ��� �ܾ 3���ھ� ���ó�� ���� n-gram

[����45] last_name�� ������ ���� 10�̻��� ����� employee_id, last_name ����ϼ���.

employees[nchar(employees$LAST_NAME) >= 10, c('EMPLOYEE_ID', 'LAST_NAME')]

[����46] last_name, last_name�� ù��° ö�ں��� ����° ö�ڱ��� �Բ� ����ϼ���.

substr(employees$LAST_NAME,1,3)

[����47] developer ���ڸ� ù���� �빮��, �ޱ��ڴ� �ҹ��ڷ� ��ȯ�ϼ���.
x <- 'developer'

paste0(toupper(substr(x,1,1)), tolower(substr(x,2,nchar(x))))
paste0(toupper(substr(x,1,1)),tolower(substring(x,2)))

library(tools)
tools::toTitleCase(x) # ù���� �빮�� �ޱ��� �ҹ��ڷ� ��ȯ�ϴ� �Լ�
#ó�� ����� �� ������ tools:: ����, �⺻������ ����Ǿ����� �ʴ� Ư���� ���̺귯���� ����� �� ������ tools::��� ǥ��
toTitleCase(x)

[����48] last_name, salary���� ȭ�鿡 ����Ҷ� 0�� * �� ����ϼ���.

gsub(0,'*',paste(employees$LAST_NAME,employees$SALARY))
paste(employees$LAST_NAME, gsub(0,'*',employees$SALARY))
paste(employees$LAST_NAME, gsub('0','*',as.character(employees$SALARY)))
data.frame(name = employees$LAST_NAME,
           sal = gsub('0','*',as.character(employees$SALARY)))

[����49] last_name�� �ι�° ö�ڰ� m �Ǵ� b �� ������� last_name, salary�� ����ϼ���.

employees[substr(employees$LAST_NAME,2,2) %in% c('m','b'), c('LAST_NAME','SALARY')]

[����50] last_name�� ���� �ޱ��ڸ� �빮�� �ձ��ڵ��� �ҹ��ڷ� ����ϼ���.
paste0(tolower(substr(employees$LAST_NAME,1,nchar(employees$LAST_NAME)-1)),
      toupper(substr(employees$LAST_NAME,nchar(employees$LAST_NAME),nchar(employees$LAST_NAME))))


�� �����Լ�
1. round 
- ���ڸ� ������ �������� �������� �ݿø�
 45.926
-10 123 <- ��ġ
round(45.926)
round(45.926,0) # �⺻��
round(45.926,1)
round(45.926,2)
round(45.926,-1)
round(45.926,-2)
round(55.926,-2)

2. signif
- �տ������� ��ġ�� �ݿø�
45.926
12 345 <- ��ġ
signif(45.926,4) # == round(45.926,2)
signif(45.926,3) # == round(45.926,1)
signif(45.926,2) # == round(45.926,0)
signif(45.926,1) # == round(45.926,-1)

3. ceiling(x)
- x���� ũ�ų� ���� ����, �ø�
ceiling(45.0)
ceiling(45.01)
ceiling(45.0000000001) 

4. trunc
- �Ҽ����� �����ϴ� �Լ�
trunc(45.926)
trunc(45.926,1) # �ڸ����� �Է��ص� �ǹ̰� ����, ������ �����
trunc(45.926,2)

5. floor(x)
- x���� ���� ���߿� ���� ū ������ ��Ÿ���� �Լ�, ����
floor(45.926)
floor(45.0)
floor(-10.0)
floor(-10.0001)

6. ������
sqrt(16)

7. ���밪
abs(-1)

8. factorial
factorial(3)
factorial(5)
�� ��¥�Լ�
1. ���糯¥, �ð�
Sys.Date()
Sys.time()
date()

2. as.Date()
- ��������¥�� ��¥������ ��ȯ�ϴ� �Լ�
class('2022-01-11')
class(as.Date('2022-01-11'))  
class(as.Date('2022/01/11'))  
class(as.Date('20220111'))  
as.Date('2022-01-11')
as.Date('20220111',format='%Y%m%d')
as.Date('2022.01.11',format='%Y.%m.%d')
#sql
to_date('20220111','yyyymmdd')
class(as.Date('20220111'))

# format : ��¥�𵨿��
%Y : �⵵ 4�ڸ�(��������)
%y : �⵵ 2�ڸ�(���������)
%m : ���ڴ�
%B : ���ڴ�
%b : ���ڴ� ���
%d : ��
%A : ����
%a : ������ ���
%u : ���ڿ��� 1~7, ������ 1
%w : ���ڿ��� 0~6, �Ͽ��� 0
%H : ��
%M : ��
%S : ��
%z : timezone �ð�
%Z : timezone �̸�

as.Date('2022�� 1�� 11��', format='%Y�� %m�� %d��')
as.Date('2022�� 1�� 11��', format='%Y�� %B %d��')

as.Date('2022�� JANUARY 11��', format='%Y�� %B %d��') #na�� ����
Sys.getlocale()
Sys.setlocale("LC_ALL","English") # ���� ������ ����� �ٲٱ�
Sys.getlocale()

as.Date('2022�� JANUARY 11��', format='%Y�� %B %d��')
as.Date('2022�� 1�� 11��', format='%Y�� %B %d��') #na
as.Date('2022�� 1�� 11��', format='%Y�� %m�� %d��') 

Sys.getlocale()
Sys.setlocale() # �⺻���������� ����
Sys.getlocale()
as.Date('2022�� 1�� 11��', format='%Y�� %B %d��')

3. format �Լ�
- ��¥�� ���������� ��ȯ�ϴ� �Լ�

Sys.Date()
format(Sys.Date(),'%Y%m%d')
mode(format(Sys.Date(),'%Y%m%d'))
format(Sys.Date(),'%B')

Sys.setlocale("LC_ALL","English") # ���� ������ ����� �ٲٱ�
Sys.getlocale()
format(Sys.Date(),'%B')
format(Sys.Date(),'%b')
format(Sys.Date(),'%A')

Sys.setlocale() # �⺻���������� ����
Sys.getlocale()
format(Sys.Date(),'%B')
format(Sys.Date(),'%b')
format(Sys.Date(),'%A')

format(Sys.Date(),'%u') # 1~7 �� 1
format(Sys.Date(),'%w') # 0~6 �� 0 

format(Sys.time(),'%H')
format(Sys.time(),'%M')
format(Sys.time(),'%S')

format(Sys.time(),'%z') # Ÿ������ ��
format(Sys.time(),'%Z') # ǥ�ؽ�

4. weekdays
- ������ ����ϴ� �Լ�
format(Sys.Date(),'%A')
weekdays(Sys.Date())

5. ��¥ ���
Sys.Date() + 129
Sys.Date() - 30

as.Date('2022-01-11', format='%Y-%m-%d') + 129
as.Date('2022-01-11') + 129

as.Date('2021-12-16') - Sys.Date()

as.numeric(Sys.Date() - as.Date('2021-12-16'))

6. difftime 
- �� ��¥���� �ϼ��� �����ϴ� �Լ�
difftime(as.Date('2021-12-16'), Sys.Date())
as.integer(difftime(as.Date('2021-12-16'), Sys.Date()))
as.numeric(difftime(Sys.Date(),as.Date('2021-12-16')))

7. as.difftime() 
- �ð����� ���� ��ȯ�ϴ� �Լ�, �ð��� ���̸� ��Ÿ���� �Լ�
as.difftime('18:30:00') - as.difftime('09:30:00')


employees <- read.csv("c:/data/employees.csv",header = T) # ���� �о�����, sqldeveloper���� �ٽ� ��¥������ yyyy-mm-dd�� �ٲ㼭 csv���Ϸ�

str(employees)

[����51]2002-06-07�� �Ի��� ������� last_name, hire_date��  ����ϼ���.

employees[as.Date(employees$HIRE_DATE, format = '%Y-%m-%d') == as.Date('2002-06-07'), c('LAST_NAME','HIRE_DATE')]
#-----------�����
employees[employees$HIRE_DATE == as.Date('2002-06-07'),c('LAST_NAME','HIRE_DATE')]
mode(employees$HIRE_DATE)
employees$HIRE_DATE <- as.Date(employees$HIRE_DATE, format = '%Y-%m-%d')
mode(employees$HIRE_DATE)
str(employees)
employees[employees$HIRE_DATE == as.Date('2002-06-07'),c('LAST_NAME','HIRE_DATE')]
#employees[employees$HIRE_DATE == as.Date('20020607',format='%Y%m%d'),c('LAST_NAME','HIRE_DATE')]

[����52]����� last_name, �ٹ��ϼ��� ����ϼ���.
data.frame(last_name = employees$LAST_NAME,
           date =Sys.Date() - as.Date(employees$HIRE_DATE, format = '%Y-%m-%d'))
#---------�����
data.frame(name = employees$LAST_NAME,
           working_days = as.integer(Sys.Date() - employees$HIRE_DATE))

[����53]����� last_name, �Ի��� ������ ����ϼ���.
data.frame(last_name=employees$LAST_NAME,
           day=format(as.Date(employees$HIRE_DATE, format = '%Y-%m-%d'),'%A'))

#---------�����
data.frame(name = employees$LAST_NAME,
           day_1 = weekdays(employees$HIRE_DATE),
           day_2 = format(employees$HIRE_DATE,'%A'))
           
[����54]�ٹ������� 15�� �̻��� ������� last_name, hire_date, �ٹ������� ������ּ���.
employees[as.numeric(format(Sys.Date(),'%y')) - as.numeric(format(as.Date(employees$HIRE_DATE,format='%Y-%m-%d'), '%y')) >= 15,c('LAST_NAME','HIRE_DATE')] # Ʋ��
#---------�����
years <- as.integer(Sys.Date() - employees$HIRE_DATE)/365
x <- employees[years >= 15, c('LAST_NAME','HIRE_DATE')]
x$working_years <- as.integer(Sys.Date() - x$HIRE_DATE)/365
x
nrow(x)

�� lubricate
library(lubridate)
install.packages("lubridate") #������ �������� �����ؼ� ��ġ
.libPaths()

lubridate::today()
today()

lubridate::now()
now()

# ��¥ -> ���������� ����
format(Sys.Date(), '%Y')
class(format(Sys.Date(),'%Y'))


# ��¥ -> ��ġ������ ���� lubridate::year �⵵�� ��ġ������ �����ϴ� �Լ�
lubridate::year(Sys.Date())
lubridate::year(Sys.time())
class(lubridate::year(Sys.Date()))
lubridate::year(today())
lubridate::year(now())

# �� ����
format(Sys.Date(),'%m') # ���ڴ� ����
lubridate::month(Sys.Date()) # ���ڴ� ����
lubridate::month(lubridate::today())
lubridate::month(lubridate::now()) 

# �� ����
format(Sys.Date(), '%d') # ������ ����

lubridate::day(Sys.Date()) # �������� ����
lubridate::day(lubridate::today())
lubridate::day(lubridate::now()) 

# ���� ����
format(Sys.Date(), '%A') # ���� ���� ����
format(Sys.Date(), '%a') 
format(Sys.Date(), '%u') # ������ ���� ���� 1~7 ������ 1
format(Sys.Date(), '%w') # ������ ���� ���� 0~6 �Ͽ��� 0
weekdays(Sys.Date())

lubridate::wday(Sys.Date(),week_start = 1) # 1~7������ ����, ���ڷ� ���
lubridate::wday(Sys.Date(),week_start = 7) # 1~7�Ͽ��� ����, ���ڷ� ���

lubridate::wday(Sys.Date(),week_start = 1, label = T) # label=T ���ڿ��� ���(factor������ ���)
lubridate::wday(Sys.Date(),week_start = 1, label = F) # label=F �⺻��, ���ڿ���

lubridate::wday(Sys.Date(),week_start = 7, label = T) # label=T ���ڿ��� ���(factor������ ���)
lubridate::wday(Sys.Date(),week_start = 7, label = F) # label=F �⺻��, ���ڿ���

as.vector(lubridate::wday(Sys.Date(),week_start = 7, label = T))

Sys.Date() + 3650

# lubridate::years ���� ���� ���ϰų� �� �� ���
Sys.Date() + lubridate::years(10)

Sys.Date() - lubridate::years(10)
Sys.Date() + lubridate::years(-10)

lubridate::now() - lubridate::years(10)
lubridate::now() + lubridate::years(-10)

?months(lubridate �ƴ�, base�� ����Ǿ�����)
# months ���� ���� ���ϰų� �� �� ���
Sys.Date() + base::months(5)
Sys.Date() + base::months(-5)

Sys.Date() + lubridate::years(10) + base::months(2)
#SQL : select sysdate + to_yminterval('10-02') from dual;

# lubridate::days() �ϼ��� ���ϰų� ���� �Լ�
Sys.Date() + 100
Sys.Date() + lubridate::days(100)
Sys.Date() + lubridate::days(-100)

# lubridate::hours() �ð��� ���ϰų� ���� �Լ�
Sys.time() + lubridate::hours(2)
Sys.time() + lubridate::hours(-100)

#lubridate::minutes() ���� ���ϰų� ���� �Լ�
Sys.time() + lubridate::minutes(30)
Sys.time() + lubridate::minutes(-30)

#lubridate::seconds() �ʸ� ���ϰų� ���� �Լ�
Sys.time() + lubridate::seconds(3600)
Sys.time() + lubridate::seconds(-3600)

Sys.time() + lubridate::days(100) + lubridate::hours(10) + lubridate::minutes(30) + seconds(50)

#SQL : select localtimestamp + to_dsinterval('100 10:30:50') from dual;

Sys.time() + lubridate::hours(2) + lubridate::minutes(30) + lubridate::seconds(50)
Sys.time() + lubridate::hms('02:30:50')

x <- lubridate::now()
x
lubridate::year(x) <- 2000 #������ ����
lubridate::month(x) <- 2 # �� ����
lubridate::day(x) <- 1 #  �� ����
lubridate::hour(x) <- 12 # �ð�����
lubridate::minute(x) <- 0 # �м���
lubridate::second(x) <-0 # �ʼ���
x
Sys.Date() + 100
lubridate::now() + 100 # ������ �ȵȴ�.
lubridate::now() + lubridate::days(100)
x+100
x+ days(100)
class(lubridate::now())
class(Sys.Date())
# �б� lubridate::quarter
lubridate::quarter(lubridate::now())

lubridate::quarter(lubridate::now() + days(200)) #���糯¥�� 200�� ���ϱ�
lubridate::quarter(Sys.Date()+200) #���糯¥�� 200�� ���ϱ�

# �б� base::quarters
base::quarters(Sys.Date()) # �б�
base::quarters(Sys.Date() + 200)

