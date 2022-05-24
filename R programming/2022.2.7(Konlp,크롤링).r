�� �ؽ�Ʈ ��ó�� ����
1. ��ūȭ(Tokenization) : �ؽ�Ʈ�� ������ ������ ������ �۾�
- �ܾ� : ��ĭ�� �������� ������.
- ���¼� : �ǹ̸� ������ �ּҴ���, ǰ�縦 �������� ������ �۾�
- ���� : �ѱ��ڱ������� ������ �۾�
- �ʼ�(����), �߼�(����), ����(����)

2. �ҿ�� ó��(stopword)
- �ǹ̾��� �ܾ �����ϴ� �۾�

3. �ǹ̾��� Ư������, ���� ����
s&p - > sandp
sandp -> s&p
...

4. ��ҹ��� ����
Trump - > Trump_unique
...

5. �������
- �ܾ� ǥ���� ���� ���� �۾��� �ؾ��Ѵ�.
��) ��ƿ�, ���, ���;��, ��ٿԾ�� -> ���.
- Lemmatization : ���������� ǥ��
- Stemming : �˰����� ���ؼ� ��������� ��ȯ, ������, ����

6. �ؽ�Ʈ ���ڵ� : �ؽ�Ʈ�� ���ͷ� ǥ��
- Bag of Words, tf-idf

�� KONLP

1. JAVA_HOME ��ġȮ��
Sys.getenv('JAVA_HOME')
# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_271')

2. rJava ��ġ
install.packages('rJava')
library(rJava)

3. konlp ���α׷��� �����ִ� ���α׷��� ��ġ
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages('remotes')

4. konlp ��ġ
remotes::install_github('haven-jeon/KoNLP', upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))

library(KoNLP)
#useSejongDic()
useNIADic()

text <- 'R�� ���¼ҽ��� ���, ����н�, ����, ����������, �׷��Ƚ��� �̸��� �پ��� ��� ��Ű���� ���ߴ� ���� ���α׷��̴�.'

�ܸ�� ����
extractNoun(text)

�� ǰ���±�
?SimplePos09
SimplePos09(text)

SimplePos22(text)

[����204] SimplePos22(text) ǰ���±��� �����縸 �������ּ���.
SimplePos22(text)

library(stringr)

a <- unlist(str_extract_all(SimplePos22(text), '\\w+\\WNC'))
#a <- unlist(str_extract_all(SimplePos22(text), '[��-�R]+/NC'))

gsub('\\WNC','',a)
str_replace_all(a,'\\WNC','')
#str_replace_all(a,'/NC','')

unlist(str_match_all(SimplePos22(text),'[��-�R]+/NC'))
as.vector(na.omit(str_match(SimplePos22(text),'[��-�R]+/NC')))

[����205]review$tagging ���� �����ؼ� ������ ���� ǰ�� �±������� �Էµǵ��� �ϼ���.

review <- read.csv('c:/data/review.txt')
review
View(review)
str_extract_all(review$������,'\n|\t')
review$������ <- str_replace_all(review$������,'\n|\t','')
review$������ <- str_replace_all(review$������,'����: ������ ��ߺ��� - �� 10�� ��','')
review$������
review$���� <- str_extract_all(review$������,'^\\d{1,2}')
review$������ <- str_replace_all(review$������,'^\\d{1,2}','')
review$������ <- gsub('�Ű�$','',review$������)
x <- SimplePos22(review$������)

paste(unlist(x[1]),collapse=' ')
review$tagging <- sapply(x,function(arg){paste(unlist(arg),collapse=' ')})

View(review)

review$noun <- review$tagging �����߿� �����縸 �����ؼ� ���ο� ���� ����
a <- str_extract_all(review$tagging,'[��-�R]+/NC')
review$noun <- sapply(a,function(arg){paste(str_replace_all(arg,'/NC',''),collapse = ' ')})
#review$noun <- sapply(a,function(arg){paste(unlist(arg),collapse = ' ')})
#review$noun <- str_replace_all(review$noun,'/NC','')
View(review)


�� ũ�Ѹ�(crawling)
- �ڵ�ȭ�� ������� ���� Ž���ϴ� ��ǻ�����α׷�
- ���ͳ� ����Ʈ�� ���������� �����ؼ� �з��ϴ� ���α׷�


�� ��ũ����(scraping)
- �������� ȭ�鿡 ǥ�õǴ� html�������� ����ڰ� �ʿ��� ������ �����Ͽ� �����ϴ� ���

1. ����ڰ� ���������� �ּ�â���� url�� �Է��Ѵ�.
2. request : ���������� ��û�� �޽����� �ۼ��� �������� �����Ѵ�. 
3. response : �������� ��û�޴� ������ Ŭ���̾�Ʈ���� ������.(HTML)
4. ���������� ����޽����� �ؼ��� ����ڿ��� ������ ����Ѵ�.


install.packages('rvest')
library(rvest)

html <- rvest::read_html("https://www.joongang.co.kr/article/25045987")
html

str_extract_all(html,'<title>.+</title>') # ����
str_extract_all(html,'<body>.+</body>') # �ȳ���

html_node(html,'title') #title�̶�� �ױ� ó������ ������ �ϳ��� ���
html_nodes(html,'title') #

html_node(html,'p') # ó��p�±׸� ã�´�.
html_nodes(html,'p') # p �±� ���θ� ã�´�.

html_node(html,'h1')
html_nodes(html,'h1')%>%
  html_text()

html_nodes(html,'div#article_body') #id #, class .
html_nodes(html,'div#article_body')%>%
  html_text()

html_nodes(html,'div.article_body.fs3')%>%
  html_text()

html <- rvest::read_html("https://www.joongang.co.kr/article/25045958")

html_nodes(html,'div.article_body.fs3')%>%
  html_text()

# ���ڵ�(encoding) ASCII����(16����)
�ΰ����� -> %EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5 
#ELZHELD (decoding)
�ΰ����� <- %EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5 

# Ư���� ���� ��� �˻��� url ����
html <- rvest::read_html("https://www.joongang.co.kr/search?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5") #�������ϰ� request, response�۾�
html # r���� ����(������x)

url <- html_nodes(html,'h2.headline')%>%
  html_nodes('a')%>% #h2�±׾ȿ� a��� �ױ׸� �̾ƿ���
  html_attr('href') #href��� �Ӽ��� �̾Ƴ���(�ּ�)

length(url)

# ������ url�� �̿��ؼ� ���� ���� ���� ����

news <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  
  temp <- html_nodes(html,'div.article_body.fs3')%>%
    html_text()
  news <- c(news,temp)
  Sys.sleep(2) #�������� ���ϸ� ���� �ʱ����ؼ� ���ݾ� ���� �ֱ�
}

str_trim(news[1])
news

write(str_trim(news),'c:/data/news.txt')

ai_news <- readLines('c:/data/news.txt')
ai_news


[����206] �����Ϻ� '�ΰ�����' ������� �˻��� ���� ������� ������ donga_ai.txt�� �����ϰ�
���� ���� ��� ������ ��縸 �����ؼ� wrodcloud�� �ð�ȭ ���ּ���. �� �������� 5����������
https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=16&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=31&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=46&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=61&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1


html <- read_html('https://www.donga.com/news/search?check_news=1&more=1&sorting=1&range=1&search_date=&v1=&v2=&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5')
html

html_nodes(html,'p.tit')%>%
  html_nodes('a')%>% # pdf������ �ּұ��� �����͹��� �ű⿡�� a�ױ׷� �Ǿ��ֱ⶧��
  html_attr('href')

url <- html_nodes(html,'p.tit')%>%
  html_node('a')%>%
  html_attr('href')

url[1]


������Ʈ���� ���ϴ� �������� �ִ� ������ �����ϰ� �ʹ�. ������Ʈ�� �ּҸ� Ȯ�� -> 
  �ּҸ� read_html�Լ��� ����ؼ� �о���� ->
  ������Ʈ���� f12��Ű�� ������ ��簡 � �±׸� ����Ͽ� �ۼ��Ǿ��ִ��� Ȯ�� 
���鸶�� ���� ���� �±׸� �̿��ϱ⶧���� �±׸� Ȯ�� 

#��� ù ������ �о�ͼ� html������ ����  
html <- read_html('https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')
#��� ������2,3,4,5������ �о�ͼ� html������ ����
for(i in 1:4){
  html <- c(html,read_html(paste0('https://www.donga.com/news/search?p=',1+i*15,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')))
  Sys.sleep(2)

}

html

# �ּҸ� �����ϴ� �����۾�
url <- html_nodes(html,'p.tit')%>%
  html_nodes('a')%>%
  html_attr('href')
#url���� �´��� Ȯ��
url[1]

#�� �ּҺ��� ���� �����ϴ� �۾�
news <- c()
for (i in 1:length(url)){
  html <- read_html(url[i])
  
  temp <- html_nodes(html,'div.article_txt')%>%
          html_text()
  news <- c(news,temp)
  Sys.sleep(2)
}

donga_ai <- str_trim(str_replace_all(news,'\n|\r|\t',' '))
donga_ai
donga_ai <- str_squish(donga_ai)
donga_ai <- str_replace_all(donga_ai,'Copyright �� �����Ϻ� & donga.com','')
SimplePos22(donga_ai)

write(str_trim(news),'c:/data/donga_ai.txt')
readLines('c:/data/donga_ai.txt')


#------------------------------------------------------------------2022.2.8 /�����
library(rvest)
url <- c()
for(i in seq(1,61,by=15)){
  url_text <- paste0('https://www.donga.com/news/search?p=',i,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')
  html <- read_html(url_text)
  temp <- html_nodes(html,'p.tit')%>%
    html_node('a')%>%
    html_attr('href')
  
  url <- c(url,temp)
  
  #print(i'�� ��� ����')
  Sys.sleep(1)
}

html <-read_html(url[4])
article <- html_node(html,'div.article_txt') #div.article_txt�ȿ��� ����� div,�ʿ���� ���� �̹����� ���ڵ��� �ִ�

html_nodes(article,'div')

article%>%html_nodes('div') # �ʿ���� �ױ׵�

library(stringr)
library(xml2)
��xml2::xml_remove() : Ư���� �±׸� ������ �� ����ϴ� �Լ�, �����ؼ� �ٷ� ����ȴ�.

xml2::xml_remove(article%>%html_nodes('div')) #������ ������ص� �ٷ� �����̵�, xml���Ŀ��� article������ �ִ� �ʿ���� div�ױ׵� �� ����
article%>%html_nodes('div')
article%>%html_text()
str_trim(article%>%html_text()) # ���鹮�� ����
txt <-str_trim(article%>%html_text())
str_extract_all(txt,'\\[����=���ý�\\]')
str_replace_all(txt,'\\[����=���ý�\\]','')

txt
"������ ���� forward@donga.com"
"���ƴ��� IT���� ���ð� ���� tikitaka@donga.com"
str_extract_all(txt,'[^\\.]+ [A-z0-9._]+@[A-z0-9._]+')

news <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  article <- html_node(html,'div.article_txt')
  xml2::xml_remove(article%>%html_nodes('div'))
  text <- article%>%html_text()
  text <- str_trim(text)  
  text <- str_replace_all(text,'\\[����=���ý�\\]','')
  text <- str_replace_all(text,'[^\\.]+ [A-z0-9._]+@[A-z0-9._]+','')
  news <- c(news,text)
  Sys.sleep(1)
}
news[1]
length(news)

write(news,'c:/data/donga_ai.txt')
ai <- readLines('c:/data/donga_ai.txt')
length(ai)

ai <- paste(ai,collapse=' ')
length(ai)
ai

library(KoNLP)

ai_pos <- SimplePos09(ai)
ai_pos

str_match(ai_pos,'([��-�R]+)/N') # '[��-�R]+/N', [��-�R]+ -> ��ȣ�� ����ؼ� �Ѵ� ������'/N'�� ���� ���ص� ��
word <- str_match(ai_pos,'([��-�R]+)/N')[,2]
word <- word[nchar(word) >= 2]
word_df <- data.frame(table(word))
names(word_df)

library(wordcloud2)
wordcloud2(word_df)


news <- readLines('c:/data/donga_ai.txt')
grep('���ϴ�',,news)


[����207] ���̹����� ��ȭ���������� ������ �� ���������������� �������ּ���.
�÷��� id, date, point,comment�� �������ּ���.
#--------------------1��������!!!
html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after')
html <- html_nodes(html,'tbody')%>%
  html_nodes('tr')

# ��ȣ (id)
id <- html_nodes(html,'td.ac.num')

id <- unlist(str_extract_all(id,'[0-9]+'))

# ���� (point)
point <- html_nodes(html,'td.title')%>%
  html_nodes('div.list_netizen_score')%>%
  html_nodes('em')

point <- unlist(str_extract_all(point,'[0-9]+'))

# ������(comment)????????
html_nodes(html,'td.title')
xml_remove(html_nodes(html,'td.title')%>%html_nodes('a'))
xml_remove(html_nodes(html,'td.title')%>%html_nodes('div'))
comment <- str_trim(html_nodes(html,'td.title')%>%html_text())

# �۾���
author <- html_nodes(html,'td.num')%>%
  html_nodes('a.author')

author <- unlist(str_extract_all(author,'\\w{4}\\*{4}'))

# ��¥
date <- html_nodes(html,'td.num')
date <- unlist(str_extract_all(date,'\\d{2}\\.\\d{2}.\\d{2}'))

movie_df <- data.frame(id = id,
           point = point,
           comment=comment,
           author = author,
           date = date)
View(movie_df)

#----------------------------10����������
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after&page=',i))
  # ��ȣ (id)
  id <- html_nodes(html,'td.ac.num')
  
  id <- unlist(str_extract_all(id,'[0-9]+'))
  
  # ���� (point)
  point <- html_nodes(html,'td.title')%>%
    html_nodes('div.list_netizen_score')%>%
    html_nodes('em')
  
  point <- unlist(str_extract_all(point,'[0-9]+'))
  
  # ������(comment)????????
  #paste(html_nodes(html,'td.title'),collapse = ' ')
  html_nodes(html,'td.title')
  xml_remove(html_nodes(html,'td.title')%>%html_nodes('a'))
  xml_remove(html_nodes(html,'td.title')%>%html_nodes('div'))
  comment <- str_trim(html_nodes(html,'td.title')%>%html_text())
  
  # �۾���
  author <- html_nodes(html,'td.num')%>%
    html_nodes('a.author')
  
  author <- unlist(str_extract_all(author,'\\w{4}\\*{4}'))
  
  # ��¥
  date <- html_nodes(html,'td.num')
  date <- unlist(str_extract_all(date,'\\d{2}\\.\\d{2}.\\d{2}'))
  
  movie <- rbind(movie,data.frame(id=id,point=point,comment=comment,author=author,date=date))
}

View(movie)

#--------------------------����� ��
html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after&page=1')

#id����
id <- html_nodes(html,'td.num > a')%>%
  html_text()

#��¥ ����
x <- html_nodes(html,'td.num')%>%
  html_text()

date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))

#z <- unlist(str_extract_all(x,'\\w{1,}\\*{1,}\\d{2}\\.\\d{2}\\.\\d{2}'))
#id <- unlist(str_extract_all(z,'\\w{1,}\\*{1,}'))
#date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))

# ���� ����
point <- html_nodes(html,'div.list_netizen_score > em')%>%
  html_text()

# ������ ����
comment <- html_nodes(html,'td.title')
#comment%>%html_nodes('a')
#comment%>%html_nodes('div')

library(xml2)
xml_remove(comment%>%html_nodes('a'))  
xml_remove(comment%>%html_nodes('div'))
comment <- comment%>%html_text()
comment <- str_trim(comment)
.

View(data.frame(id=id,date=date,point=point, comment=comment))


#-------------------------1~10������ ����Դ�
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=194204&target=after&page=',i))
  #id����
  id <- html_nodes(html,'td.num > a')%>%
    html_text()
  
  #��¥ ����
  x <- html_nodes(html,'td.num')%>%
    html_text()
  
  date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))
  
  #z <- unlist(str_extract_all(x,'\\w{1,}\\*{1,}\\d{2}\\.\\d{2}\\.\\d{2}'))
  #id <- unlist(str_extract_all(z,'\\w{1,}\\*{1,}'))
  #date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))
  
  # ���� ����
  point <- html_nodes(html,'div.list_netizen_score > em')%>%
    html_text()
  
  # ������ ����
  comment <- html_nodes(html,'td.title')
  #comment%>%html_nodes('a')
  #comment%>%html_nodes('div')
  #library(xml2)
  xml_remove(comment%>%html_nodes('a'))  
  xml_remove(comment%>%html_nodes('div'))
  comment <- comment%>%html_text()
  comment <- str_trim(comment)
  
  
  movie <- rbind(movie,data.frame(id=id,date=date,point=point,comment=comment))
  Sys.sleep(1)
  
}

View(movie)

# ����,����, tagging, wordcloud���� �׷�����

movie$evaluation <- ifelse(movie$point >= 8,'����','����')
View(movie)
movie$tagging <- sapply(SimplePos09(movie$comment),
                        function(arg){paste(unlist(arg),collapse=' ')})

x <- str_match(movie$tagging,'([��-�R]+)/N')[,2]
x <- data.frame(table(na.omit(x)))
wordcloud2(x,backgroundColor = 'black')

# ����,����, tagging, wordcloud���� �׷����� �����
pos <- SimplePos22(movie$comment)
movie$tagging <- sapply(pos,function(x){paste(unlist(x),collapse=' ')})

noun <- sapply(movie$tagging,function(x){str_match_all(x,'([��-�R]+)/NC')})
movie$noun <- sapply(noun,function(x){paste(unlist(x)[,2],collapse=' ')})

View(movie)

movie$point <- as.integer(movie$point)
movie$evaluation <- ifelse(movie$point >= 8, '����','����')  
View(movie)

positive <- movie[movie$evaluation == '����','noun']
negative <- movie[movie$evaluation == '����','noun']

library(wordcloud2)
wordcloud2(data.frame(table(unlist(strsplit(positive,' ')))))
wordcloud2(data.frame(table(unlist(strsplit(negative,' ')))))

p <- data.frame(table(unlist(strsplit(positive,' '))))
n <- data.frame(table(unlist(strsplit(negative,' '))))

head(p)
head(n)

names(p) <- c('word','freq')
names(n) <- c('word','freq')

p$sentiment <- 'positive'
n$sentiment <- 'negative'

head(p)
head(n)

df <- rbind(p,n)
head(df)
tail(df)

    word positive negative
1   ����    1        0
2   ����    1        5   
#���� �����͸� �ؿ� ó�� ��ȯ
      positive negative
����      1       9
����      1       5
���ϴ�    5       2
      
library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq', fill=0)
df_compar

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df_compar,colors=c('red','blue'),
                            title.colors = c('red','blue'),
                            title.bg.colors='white',
                            title.size=2,
                            scale=c(2,0.5))
