[����199] ��ȭ��ȣ�� �������ּ���.

message = '�ȳ��ϼ���. ��ȭ��ȣ�� 02-123-4567 �Դϴ�.
���ǻ����� ������ 031-1234-0000 ���� �����ֽñ� �ٶ��ϴ�.
�� ��ȣ�� 010-1234-1004 ������ ��ȭ��ȣ 1588-3600  ��ǥ��ȭ : 031)777-1140'

library(stringr)
str_extract_all(message,'(\\d+\\W|)\\d+\\W\\d+')

#--------------------------�����
str_extract_all(message,'(\\d{2,3})?(-|\\))?\\W\\d{3,4}-\\d{4}')

[����200] �̸��� �ּҸ� �������ּ���.

message = '����� �̸����ּҴ� webmaster@itwill.co.kr  
           �̸��� �ּҴ� happy.o@gmail.com   
           �̸��� �ּҴ� happy123@naver.com �Դϴ�. info_search@joins.com'

str_extract_all(message,'(\\w+|\\w+\\W\\w+)\\@(\\w+.\\w+|\\w+.\\w+.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+\\W\\w)\\@(\\w+\\.\\w+|\\w+\\.\\w+\\.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+\\W\\w+)\\@(\\w+\\.\\w+\\.\\w+|\\w+\\.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+[[:punct:]]\\w+)\\@(\\w+\\.\\w+\\.\\w+|\\w+\\.\\w+)')
#--------------------------�����
str_extract_all(message,'[\\w.]+@[\\w.]+') 
str_extract_all(message,'[A-z0-9.]+@[A-z.]+') # _ ǥ�ô� A-z���� ������ �ȴ�?

[����201] seoul.txt ������ ��¥�� �����ؼ� ���� �󵵼��� Ȯ�� �ϰ� �ð�ȭ ���ּ���.
seoul <- readLines('c:/data/seoul.txt')
seoul

data <- str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')
df <- data.frame(table(as.integer(format(as.Date(unlist(data)),'%m'))))
library(wordcloud)
wordcloud(df$Var1,df$Freq,
          colors=rainbow(NROW(df)),
          random.order=F)


#_-------------------------------�����
str_extract(seoul,'\\d{4}-\\d{2}-\\d{2}')
text_date <- as.Date(unlist(str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')))
class(text_date)
library(lubridate)
month_freq <- data.frame(table(lubridate::month(text_date)))
names(month_freq) <- c('month','cnt')
str(month_freq)
month_freq$month <- factor(month_freq$month)

library(ggplot2)
ggplot(data=month_freq,aes(x=as.integer(month),y=cnt))+
  geom_bar(stat='identity',fill=rainbow(nrow(month_freq)))+
  scale_x_continuous(breaks=c(1:9),labels=paste0(month_freq$month,'��'))


[����202] seoul.txt ������ �ܾ �󵵼��� Ȯ�� �ϰ� �ð�ȭ ���ּ���.

word <- str_extract_all(seoul,'[��-�R]+') # �ѱ� ����

df_word <- data.frame(table(unlist(word)))
wordcloud(df_word$Var1,df_word$Freq,
          colors = rainbow(NROW(df_word)),
          max.words = 50,
          random.order = F)

df_word
seoul
str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')
str_extract_all(seoul,'\\d+[[:space:]]')
seoul

seoul1 <- gsub('\\d{4}-\\d{2}-\\d{2}','',seoul)

str_extract_all(seoul1,'[[:space:]][[:space:]]\\d+')
seoul2 <- gsub('[[:space:]][[:space:]]\\d+','',seoul1)
str_extract_all(seoul2,'\\d+[[:space:]]')
seoul3 <- gsub('\\d+[[:space:]]','',seoul2)

#-------------------------�����                
  #��¥���� ����
str_extract(seoul,'\\d{4}-\\d{2}-\\d{2}')
data <- str_replace(seoul,'\\d{4}-\\d{2}-\\d{2}','')
data

  #���� �տ� ���� ����
str_extract(data,'^\\d{1,3}')
data <- str_replace(data,'^\\d{1,3}','')

  #���� �� �� ���鹮������
data <- str_trim(data)

  #���� �� �ڿ� ���� ����
str_extract(data,'\\d{1,3}$')
data <- str_replace(data,'\\d{1,3}$','')


  #���� �� �� ���鹮������
data <- str_trim(data)
data

  #[]���� ����
x <- str_extract(data,'\\[\\w+\\]')
x[!is.na(x)]

unlist(str_extract_all(data,'\\[\\w+\\]'))

grep('\\[\\w+\\]',data,value=T)

data <- str_replace(data,'(\\[|\\])','')

grep('\\[|\\]',data,value=T)

  #()���� ����
x <- str_extract(data,'\\(\\w+\\)')
x[!is.na(x)]

unlist(str_extract_all(data,'\\(\\w+\\)'))

grep('\\(\\w+\\)',data,value=T)

data <- str_replace(data,'(\\(|\\))',' ')
data

##
grep('O+',data,value=T)
unlist(str_extract_all(data,'O+'))

# OOOOO OO OOO ����
data <- str_replace_all(data,'O+','')
data
grep('O+',data,value=T)

data <- paste(data,collapse = ' ') # collapse=' ' ���鹮�ڷ� �� ���ڸ� ���Ͽ� �ش�.
word_cnt <- data.frame(table(str_split(data,' ')))
head(word_cnt)

library(wordcloud)
wordcloud(word_cnt$Var1,word_cnt$Freq,min.freq=2)

install.packages('wordcloud2')
library(wordcloud2)
wordcloud2(word_cnt,col='random-light',
           backgroundColor = 'black',
           shape='star')

?wordcloud2

wordcloud2(word_cnt)

[����203] review.txt���� ��ó�� �۾��� �������ּ���.
library(stringr)
readLines('c:/data/review.txt')
review <- read.csv('c:/data/review.txt')
View(review)

review[1,2]
review$point <- ������ ������
review$������ <- ������
review$�۾��� <- �۾��̸�
review$��¥ <- ��¥��

# �������� ���˹��ڵ� �� ����
str_extract_all(review[,2],'\\\n+|\\\t')
review$������ <- str_replace_all(review[,2],'\\\n+|\\\t+','')
review

# ������ �����Ͽ� ���ο� ���� ���� (������� : '��'������ ����, ������ �Բ� �پ��ִ� ���� ����(26��,97�࿡�� �������� 1���� �پ�����))
unlist(str_extract_all(review[,2],'��\\d{1,2}')) # ���� �����ϱ����� ���� �߱��� ����
review$poing <- gsub('��','',unlist(str_extract_all(review[,2],'��\\d{1,2}'))) #'��'�� ���ֱ�
review$poing <- as.integer(review$poing) # integer������ ��ȯ 10������ ū ��(������ ���� �پ ���� ���� ���ֱ����� �۾�1)
review$poing <- ifelse(review$poing > 10, review$poing%%10,review$poing) 

# �������� �ʿ���� ���ڵ� ����
str_extract_all(review$������,'����: ������ ��ߺ��� - �� 10�� ��\\d') # �ʿ���� �պκ� ����
review$������ <- str_replace_all(review$������,'����: ������ ��ߺ��� - �� 10�� ��\\d','') # �ʿ���� �պκ� ����(10��¥�� �������� 0�� ����, ���ڷ� �����ϴ� �������� �ֱ⶧��)
str_extract_all(review$������,'^0') # ������ �Ǿտ� ���� 10������ ���� 0�� ����
review$������ <- str_replace_all(review$������,'^0','') # ���� 0�� ����
str_extract_all(review$������,'�Ű�$')
review$������ <- str_trim(str_replace_all(review$������,'�Ű�$','')) # �ǵ��� �ʿ���� ���� �Ű� �����ϰ� �������� ����κ� ����

# �۾��̶� ��¥ ���� �ٸ����� �и��ϱ�
review$�۾���.��¥
review$�۾��� <- str_extract_all(review$�۾���.��¥,'\\w+\\*+') # �۾��� ����
review$��¥ <- str_extract_all(review$�۾���.��¥,'\\d{2}.\\d{2}.\\d{2}') # ��¥ ����
review <- review[,c('��ȣ','������','poing','�۾���','��¥')] 

#---������ �� ���� wordcloud2�׸���
review$������
str_extract_all(review$������,'\\W')
str_extract_all(review$������,'[[:space:]]{2}')
str_replace_all(review$������,'[[:space:]]{2}',' ')
str_extract_all(review$������,'[��-��]')
str_extract_all(review$������,'[A-z]')
str_extract_all(review$������,'[A-z]+')


test <- paste(review$������,collapse=' ')
test <- strsplit(test,split=' ')
test <- data.frame(table(test))
wordcloud2(test)
?wordcloud2

wordcloud2(test, color = ifelse(test[,2] > 5,'red','skyblue'))



#-------------------------------- ����� 

review <- read.csv('c:/data/review.txt')

# \n \t ����
review$������[1]
grep('\n',review$������,value=T)
str_extract_all(review$������,'\n|\t')
sum(str_count(review$������,'\n|\t'))

review$������ <- gsub('\n',' ',review$������)
review$������ <- gsub('\t',' ',review$������)
review$������[1]

# �� �� �̻��� ���鹮�ڸ� �� �� ���鹮�ڷ� ����
grep('\\s{2,}',review$������,value=T)
str_extract_all(review$������,'\\s{2,}')

# review$������ <- gsub('\\s{2,}',' ', review$������)
review$������ <- str_squish(review$������) # �ΰ� �̻��� ������ �ϳ��� �������� �����ϴ� �Լ� str_squish
review$������[1]

# ���ʿ��� ���� �����
str_extract_all(review$������,'����: ������ ��� ���� - �� 10�� ��')
str_extract_all(review$������,'�Ű�$')
review$������ <- gsub('����: ������ ��� ���� - �� 10�� ��','',review$������)
review$������ <- gsub('�Ű�$','',review$������)

review$������[1]

View(review)

review$point <- as.integer(str_extract(review$������,'^\\d{1,2}'))
str(review)
boxplot(review$point)

review$������ <- str_replace(review$������,'^\\d{1,2}','')
View(review)

review[1:10,3]

review$id <- str_extract(review$�۾���.��¥,'\\w{1,}\\*{1,}')
review$date <- str_extract(review$�۾���.��¥,'\\d{2}\\.\\d{2}\\.\\d{2}')
View(review)

review$evaluation <- ifelse(review$point>=8, '����','����')
View(review)

positive <- paste(review[review$evaluation=='����','������'],collapse=' ')
negative <- paste(review[review$evaluation=='����','������'],collapse=' ')

positive <- data.frame(table(str_split(positive,' ')))
negative <- data.frame(table(str_split(negative,' ')))

wordcloud2(positive)
wordcloud2(negative)

