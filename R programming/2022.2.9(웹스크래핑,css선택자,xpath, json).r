
�� �������� �ٲٴµ� �ּҰ� ������ ���� �� ���ּҷ� ��ũ������ �� �� ���µ� �ٸ� ������ִ�.
f12�� ��Ʈ��ũ�� name,preview���� ã�ƾ��Ѵ�. ã�Ƽ� header�� �ִ� �ּҸ� �����ؼ� ���
�׷��� �������� �����ؼ� ���� �� 1���������� 2������ ���ٰ� �ٽ� 1������ ���� �ּҰ� �ٲ�µ� �� �ּҸ� �������

https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false
https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1

�� css������ �����
library(rvest)
library(stringr)
# �ּҷ� ��û�ϰ� �������
html <- read_html('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1')

# div�±׿� score_repleŬ������ �������µ� text�� ��������
review <- html_nodes(html,'div.score_reple')%>%
  html_text()

# ���� �����(���� �հ� �ڸ� �����)
trimws(review) 
str_trim(review)

#\n\t\r �����
review <- str_trim(review)
#gsub('\n|\t|\r',' ',review)
review <- str_replace_all(review,'\n|\t|\r',' ')

# ���� �տ� �������� ���� �ڿ� �Ű� �ܾ� ����
review <- gsub('^������',' ',review)
review <- gsub('�Ű�$',' ',review)
review <- str_trim(review)

# 2���̻��� ������ �ϳ��� �������� ��ȯ
#gsub('\\s{2,}',' ',review)
review <- str_squish(review)

#���̵� ��¥,�ð� ���� �����ϱ� , ���������
����(lulu****) 2022.01.27 22:36
#str_extract_all(review,'[^[:space:]]\\w+\\(\\w{4}\\*{4}\\) \\d{4}.\\d{2}.\\d{2} \\d{2}:\\d{2}')
x <- str_extract_all(review,'\\w+\\(.+\\)\\s\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}')

id <- str_extract(x,'\\w+\\(.+\\)')
date <- str_extract(x,'\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}')
review <- str_replace_all(review,'\\w+\\(.+\\)\\s\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}','')

# �Ф� , . ! ���� �̷� �͵� �����ϱ�
review <- str_replace_all(review,'[��-����-��\\.,!?]',' ')

#str_replace_all(review,'[^��-�R]',' ') �ѱ��� �ƴ� �� ����

# ���� ����  - div�±׿� star_scoreŬ������ �ִ� em�±׿��� text�� �̱�
point <- html_nodes(html,'div.star_score > em')%>%
  html_text()

View(data.frame(id=id,date=date,point=point,review=review))

#---------------------------------------------------------------



�� xpath ��� ���

html <- read_html('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1')

�� �����θ� �̿��ؼ� �˻� (xpath) , ��Ҽ����ؼ� copy XPath �ٿ��ֱ�

#html_node(html,xpath='/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span') <span>���� span���� ���� ���� </span>
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span')
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[2]/div[2]/dl/dt/em[1]/a/span')
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[3]/div[2]/dl/dt/em[1]/a/span')

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[1]/a/span')%>%
  html_text() #li�ε����� ����� ��� li�� ã�ƿ�(���̵� �� �� ã�ƿ���)

/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span
/html/body/div/div/div[5]/ul/li[5]/div[2]/dl/dt/em[1]/a/span

�� ����θ� �̿��ؼ� �˻�

html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[1]/a/span')%>%
  html_text() # div class�̸��� score_reple�� ���� ã�ڴ� -> div[@class] -> class�� �ƴ� id�� id��


# ��¥ ����

/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[2]
/html/body/div/div/div[5]/ul/li[2]/div[2]/dl/dt/em[2]

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[2]')%>%
  html_text()

html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[2]')%>%
  html_text()

# ���� ����
/html/body/div/div/div[5]/ul/li[1]/div[1]/em
/html/body/div/div/div[5]/ul/li[2]/div[1]/em

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[1]/em')%>%
  html_text()

html_nodes(html,xpath='//div[@class="star_score"]/em')%>%
  html_text()


# ���� ����

  # copy xpath �ߴµ� �����, ���̵� ���� Ʋ��
//*[@id="_unfold_ment0"]/a #ù��° ����
//*[@id="_filtered_ment_1"]/text() # �ι�°����

# ������ (copy full XPath)
/html/body/div/div/div[5]/ul/li[1]/div[2]/p/span[2]/span/a
/html/body/div/div/div[5]/ul/li[2]/div[2]/p/span[2]/text()
/html/body/div/div/div[5]/ul/li[3]/div[2]/p/span[2]/text()

review <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/p/span[2]')%>%
  html_text()

trimws(review)


review <- html_nodes(html,xpath='//div[@class="score_reple"]/p/span[2]')%>%
  html_text()

trimws(review)

[����207] ���̹����� ��ȭ���������� ������ �� ���������������� �������ּ���.
�÷��� id, date, point,comment�� �������ּ���.

html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=3')

(1) xpath�� �̿��ؼ� ������ �����ϼ���.

#�۾��� 
//*[@id="old_content"]/table/tbody/tr[1]/td[3]/a # 1��° �۾���, xpath
//*[@id="old_content"]/table/tbody/tr[2]/td[3]/a # 2��° �۾���, xpath
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[3]/a # 1��° �۾���, full xpath
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[3]/a # 2��° �۾���, full xpath

id <- html_nodes(html,xpath='//td[@class="num"]/a')%>%
  html_text()

# ��¥
//*[@id="old_content"]/table/tbody/tr[1]/td[3]/text()
//*[@id="old_content"]/table/tbody/tr[2]/td[3]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[3]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[3]/text()

date <- html_nodes(html,xpath='//td[@class="num"]/text()')%>%
  html_text()
  
# ������
//*[@id="old_content"]/table/tbody/tr[1]/td[2]/text()
//*[@id="old_content"]/table/tbody/tr[2]/td[2]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[2]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[2]/text()

#html_nodes(html,xpath='//td[@class="title"]/text()')%>% html_text()
#html_nodes(html,xpath='/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr/td[2]/text()')%>%  html_text()

library(xml2)
title <- html_nodes(html,xpath='//td[@class="title"]')
xml2::xml_remove(title%>%html_nodes('a'))
xml2::xml_remove(title%>%html_nodes('div'))
comment <- title%>% html_text()
comment <- str_trim(comment)
comment <- str_replace_all(comment,'\\.|!|~|^',' ')
comment <- str_repalce_all(comment,'[��-����-��]',' ')
comment <- str_replace_all(comment,'//s{2,}',' ')
#str_extract_all(comment,'\\.|\\?')

# ����
//*[@id="old_content"]/table/tbody/tr[1]/td[2]/div/em
//*[@id="old_content"]/table/tbody/tr[2]/td[2]/div/em
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[2]/div/em
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[2]/div/em

point <- html_nodes(html,xpath='//div[@class="list_netizen_score"]/em')%>%
  html_text()

# ������������
View(data.frame(id=id,point=point,comment=comment,date=date))

#--------10���������� 

movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=',i))
  
  id <- html_nodes(html,xpath='//td[@class="num"]/a')%>%
    html_text()   
  
  date <- html_nodes(html,xpath='//td[@class="num"]/text()')%>%
    html_text()
  
  point <- html_nodes(html,xpath='//div[@class="list_netizen_score"]/em')%>%
    html_text()
  
  title <- html_nodes(html,xpath='//td[@class="title"]')
  xml2::xml_remove(title%>%html_nodes('a'))
  xml2::xml_remove(title%>%html_nodes('div'))
  comment <- title%>% html_text()
  comment <- str_trim(comment)
  comment <- str_replace_all(comment,'\\.|!|~|^|,|\\?',' ')
  comment <- str_replace_all(comment,'[��-����-��]',' ')
  comment <- str_replace_all(comment,'//s{2,}',' ')
  
  temp <- data.frame(id=id,point=point,comment=comment,date=date)
  movie <- rbind(movie,temp)
  Sys.sleep(1)
}
View(movie)


(2) ������ ������ ���¼� �м��� �غ�����.
library(KoNLP)
useNIADic()
x <- SimplePos09(movie$comment)
movie$tagging1 <- sapply(x, function(arg){paste(unlist(arg),collapse=' ')})
movie$tagging2 <- sapply(str_match_all(movie$tagging1,'(\\w+)/N'),function(arg){paste(unlist(arg)[,2],collapse=' ')})
View(movie)

(3) ������ �������� 1~4 ����, 5~7 �߸�, 8~10 �������� ���̺��� �������ּ���.
movie$evaluation <- ifelse(movie$point >= 8,'����',ifelse(movie$point>=5,'�߸�','����'))
View(movie)

(4) ���̺��� �������� ��縸compare wordcloud�� �������ּ���.

pos <- movie[movie$evaluation == '����','tagging2']
neg <- movie[movie$evaluation == '����','tagging2']
mid <- movie[movie$evaluation == '�߸�','tagging2']

p <- data.frame(table(unlist(str_split(pos,' '))))
n <- data.frame(table(unlist(str_split(neg,' '))))
m <- data.frame(table(unlist(str_split(mid,' '))))

names(p) <- c('word','freq')
names(n) <- c('word','freq')
names(m) <- c('word','freq')

p$sentiment <- 'positive'
n$sentiment <- 'negative'
m$sentiment <- 'middle'

df <- rbind(p,n,m)
df



library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq', fill=0)
df_compar

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df_compar)


#--------------------------�����
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=',i))
  id <- html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[1]/a/span')%>%
    html_text()
  date <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[2]')%>%
    html_text()
  point <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[1]/em')%>%
    html_text()
  review <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/p/span[2]')%>%
    html_text()
  movie <- rbind(movie,data.frame(id=id,date=date,point=point,review=review))
  Sys.sleep(1)  
}
View(movie)
write.csv(movie,file='c:/data/movie_raw.csv',row.names=F)
movie$review <- str_trim(movie$review)

movie$revie[grep(CG|cg',movie$review')]
unlist(str_extract_all(movie$review,'[��-����-��\\.,!?]'))
unlist(str_extract_all(movie$review,'CG|cg'))

movie$review <- str_replace_all(movie$review,'[��-����-��\\.,!?]',' ')
movie$review <- str_replace_all(movie$review,'CG|cg','�׷���')
movie$review <- str_squish(movie$review)
movie$review

library(KoNLP)
useNIADic()

pos <- SimplePos22(movie$review)
pos

noun <- str_match_all(pos,"([��-�R]+)/NC")
noun[[1]][,2]
movie$review[1]

#�� ����� �� ������ �Ȱ��� �ܾ �ʹ� ���� �� ��ǥ �ܾ�鸸(����ũ�� �ܾ�)�̰ڴ� -> ������ �ϴ� ���� �ƴ� ��Ȳ�� ���� �Ǵ�
noun_unique <- sapply(noun,unique)
noun_unique[[1]][,2]
noun
movie$noun <- sapply(noun,function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse=' ')) # 2���� �̻� �̰ڴ�.
View(movie)

str(movie)
movie$point <- as.integer(movie$point)
str(movie)
movie$evaluation <- ifelse(movie$point>=8,'����',ifelse(movie$point>=5 & movie$point<=7,'�߸�','����'))

positive <- movie[movie$evaluation=='����','noun']
negative <- movie[movie$evaluation=='����','noun']
neutral <- movie[movie$evaluation=='�߸�','noun']

head(sort(table(unlist(strsplit(positive,' '))),decreasing=T))
head(sort(table(unlist(strsplit(negative,' '))),decreasing=T))

positive_df <- data.frame(table(unlist(strsplit(positive,' '))))
negative_df <- data.frame(table(unlist(strsplit(negative,' '))))
neutral_df <- data.frame(table(unlist(strsplit(neutral,' '))))

names(positive_df) <- c('word','freq')
names(negative_df) <- c('word','freq')
names(neutral_df) <- c('word','freq')

positive_df$sentiment <- '����'
negative_df$sentiment <- '����'
neutral_df$sentiment <- '�߸�'

head(positive_df)
head(negative_df)
head(neutral_df)

df <- rbind(positive_df,negative_df,neutral_df)
head(df)
tail(df)

library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq',fill=0) #acast(������,�����ΰ���~���ΰ���,value.var=�� ����,fill=���� ���� �� �� ��)
head(df_compar)
tail(df_compar)

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df_compar,colors=c('red','blue','purple'),
                            title.colors=c('red','blue','purple'),
                            title.bg.colors = 'white',
                            title.size=2,
                            scale = c(2,0.5))


head(sort(table(unlist(strsplit(positive,' '))),decreasing=T))
head(sort(table(unlist(strsplit(negative,' '))),decreasing=T))


library(dplyr)
df%>%
  group_by(sentiment)%>%
  mutate(rank=dense_rank(desc(freq)))%>%
  filter(rank==1)%>%
  arrange(sentiment,rank)

df%>%
  group_by(sentiment)%>%
  slice_max(freq) # slice_max : �󵵼��� ���� ���� ���鸸 ����

df%>%
  group_by(sentiment)%>%
  mutate(rank=dense_rank(freq))%>%
  filter(rank==1)%>%
  arrange(sentiment,rank)%>%
  print(n=1000)

df%>%
  group_by(sentiment)%>%
  slice_min(freq)%>% # slice_max : �󵵼��� ���� ���� ���鸸 ����
  print(n=400)
  
�� JSON(JAVA OBJECT NOTATION)
- �ڹٽ�ũ��Ʈ���� ����ϴ� ��ü ǥ�� ����� ������� �Ѵ�.
- �ؽ�Ʈ �����͸� ������� �Ѵ�.
- �پ��� ����Ʈ����� ���α׷��־��� �����͸� ��ȯ�� �� ���� ���ȴ�.

install.packages('jsonlite')
library(jsonlite)

json1 <- fromJSON('https://comment.daum.net/apis/v1/posts/149671721/comments?parentId=0&offset=0&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j1 <- json[,c('rating','content','createdAt')]

json2 <- fromJSON('https://comment.daum.net/apis/v1/posts/149671721/comments?parentId=0&offset=101&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j2 <-json2[,c('rating','content','createdAt')]

json3 <- fromJSON('https://comment.daum.net/apis/v1/posts/149671721/comments?parentId=0&offset=201&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j3 <-json3[,c('rating','content','createdAt')]

View(rbind(j1,j2,j3))


#-------------------------------------

#daum��ȭ �ظ����� �һ������� json���� ���� �о����

js1 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=0&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j1 <- js1[,c('rating','content','createdAt')]

js2 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=101&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j2 <- js2[,c('rating','content','createdAt')]

js3 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=201&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j3 <- js3[,c('rating','content','createdAt')]

movie_df <- rbind(j1,j2,j3)
View(movie_df)

# content(������/����)�κ� ��ó�� �۾�
movie_df$content

library(stringr)

str_extract_all(movie_df$content,'\n|\r|\t')
movie_df$content <- str_replace_all(movie_df$content,'\n|\r|\t',' ')

str_extract_all(movie_df$content,'[��-����-��\\.!?,^><_;:~/)*(&\\-]')
movie_df$content <- str_replace_all(movie_df$content,'[��-����-��\\.!?,^><_;:~/)*(&\\-]',' ')

movie_df$content <- str_squish(movie_df$content)
movie_df$content

# ��縸 ����
library(KoNLP)
useNIADic()
unlist(str_match_all(a[[1]],'(\\w+)/NC')[,2])
a <- sapply(SimplePos22(movie_df$content),function(x) paste(unlist(x),collapse = ' '))
movie_df$noun <- sapply(str_match_all(a,'(\\w+)/NC'),function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse = ' '))
View(movie_df)

movie_df$evaluation <- ifelse(movie_df$rating>=9,'��������ִ�',ifelse(movie_df$rating>=7,'����ִ�',ifelse(movie_df$rating>=5,'����',ifelse(movie_df$rating>=3,'��̾���','������̾���'))))
View(movie_df)

x1 <- movie_df[movie_df$evaluation=='��������ִ�','noun']
x2 <- movie_df[movie_df$evaluation=='����ִ�','noun']
x3 <- movie_df[movie_df$evaluation=='����','noun']
x4 <- movie_df[movie_df$evaluation=='��̾���','noun']
x5 <- movie_df[movie_df$evaluation=='������̾���','noun']

x1_df <- data.frame(table(str_split(paste(x1,collapse = ' '),' ')))
x2_df <- data.frame(table(str_split(paste(x2,collapse = ' '),' ')))
x3_df <- data.frame(table(str_split(paste(x3,collapse = ' '),' ')))
x4_df <- data.frame(table(str_split(paste(x4,collapse = ' '),' ')))
x5_df <- data.frame(table(str_split(paste(x5,collapse = ' '),' ')))

names(x1_df) <- c('word','freq')
names(x2_df) <- c('word','freq')
names(x3_df) <- c('word','freq')
names(x4_df) <- c('word','freq')
names(x5_df) <- c('word','freq')

x1_df$sentiment <- '��������ִ�'
x2_df$sentiment <- '����ִ�'
x3_df$sentiment <- '����'
x4_df$sentiment <- '��̾���.'
x5_df$sentiment <- '������̾���'

df <- rbind(x1_df,x2_df,x3_df,x4_df,x5_df)
df

library(reshape2)
df <- reshape2::acast(df,word~sentiment,value.var = 'freq',fill=0)

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df)
