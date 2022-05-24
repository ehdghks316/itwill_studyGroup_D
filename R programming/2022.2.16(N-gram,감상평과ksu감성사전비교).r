[����215] �̱� ���̵� ����� ���ӻ� �������� ���(NN), �������(NNS), �ܼ�����(NNP),
��������(NNPS),�����(JJ), �񱳱������(JJR), �ֻ�� �����(JJS)  �����ؼ� �ð�ȭ ���ּ���. #���� ��ó���ϴ� �Ͱ� �Ŀ� ��ó���ϴ� ���̺���

library(stringr)
library(tm)
library('rJava')
library('NLP')
library('openNLP')
library(wordcloud)
library(wordcloud2)

# 0. ������ �о����
biden <- readLines('c:/data/biden_raw.txt')
biden
'''
# 1.��ó���۾�
biden_cor <- VCorpus(VectorSource(biden))
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub('<[\\w+\\+]+>',' ',x))) # �ʿ���� <u+812> ���� �����
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub("It��s|That��s",' ',x)))
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub("\\��s",' ',x)))
biden_cor <- tm_map(biden_cor,removePunctuation)
biden_cor <- tm_map(biden_cor,removeWords,stopwords())
biden_cor <- tm_map(biden_cor,stripWhitespace)

str_extract_all(lapply(biden_cor,content),'��s')
lapply(biden_cor,content)
'''

# 2. ǰ���±��۾�

biden_s <- NLP::annotate(biden,openNLP::Maxent_Sent_Token_Annotator()) # annotate����� �� ���̺귯���̸�NLP �Ⱦ��� �������� �� ����
biden_w <- NLP::annotate(biden,openNLP::Maxent_Word_Token_Annotator(),biden_s)
postag <- NLP::annotate(biden,openNLP::Maxent_POS_Tag_Annotator(),biden_w)
head(postag)
tail(postag)

pos_df <-data.frame(postag[postag$type=='word'])
head(pos_df)

# 3. �����۾�
pos_df$features <- unlist(pos_df$features) # features�� ����Ʈ�������� �Ǿ��ֱ� ������ ���������� ����
pos_df2 <- pos_df[pos_df$features %in% c('NN','NNS','NNP','NNPS'),]

word_biden <- c()
for(i in 1:NROW(pos_df2)){
  word_biden <- c(word_biden,substr(biden,pos_df2$start[i],pos_df2$end[i]))
}
head(sort(table(word_biden),decreasing=T))
word_biden_df <- data.frame(table(word_biden))

wordcloud2(text_df)

#-----------           
pos_df3 <- pos_df[pos_df$features %in% c('JJ','JJR','JJS'),]

text2 <- c()
for(i in 1:NROW(pos_df3)){
  text2 <- c(text,substr(biden,pos_df3$start[i],pos_df3$end[i]))
}
head(sort(table(text2),decreasing=T))

#��ó�� �۾�
grep("\\w+\\��s$",word_biden,value=T)
word_biden <- gsub("\\��s$",'',word_biden)

grep("America",word_biden,value=T)
word_biden <- gsub("Americans",'American',word_biden)

#----------------

nn_df <- data.frame(table(word_biden))
jj_df <- data.frame(table(text2))

names(nn_df) <- c('word','freq')
names(jj_df) <- c('word','freq')

nn_df$pos <- 'noun'
jj_df$pos <- 'adjective'

nn_jj_df <- rbind(nn_df,jj_df)
head(nn_jj_df)

library(reshape2)
nn_jj_compar <- acast(nn_jj_df,word~pos,value.var = 'freq',fill=0)

head(nn_jj_compar)
comparison.cloud(nn_jj_compar)
?comparison.cloud

[����216] ������ ����� ���ӻ� �������� ��縸 �����ؼ� �ð�ȭ ���ּ���.
library(rvest)
library(xml2)
html <- read_html('https://www.joongang.co.kr/article/21558717#home')
article <- html_nodes(html,xpath='//*[@id="article_body"]')
#�ʿ���� �±� ����
xml2::xml_remove(article%>%html_nodes(xpath='//*[@id="article_body"]/div[1]'))
xml2::xml_remove(article%>%html_nodes(xpath='//*[@id="article_body"]/p[1]'))
moon <- article%>%html_text()

# \n ����
moon <- str_replace_all(moon,'\n','')
moon <- str_squish(moon)

# �������
library(KoNLP)
useNIADic()


'''
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
'''
library(KoNLP)
#useSejongDic()
useNIADic()

moon_n <- unlist(str_extract_all(SimplePos09(moon),'\\w+/N'))
moon_n <- str_replace_all(moon_n,'/N','')
moon_t <- table(moon_n)

library(wordcloud)
wordcloud(words=names(moon_t),freq=moon_t)

moon_df <- data.frame(moon_t)
moon_df
wordcloud2(moon_df,size=3,minSize = 0,fontFamily = '����',
           backgroundColor = 'black', color = 'white',
           minRotation = pi, shape = 'rectangle')

#-----------------------�����
library('rJava')
library(rvest)
library(KoNLP)
#useSejongDic()
useNIADic()

https://www1.president.go.kr/articles/517
html <- read_html('https://www1.president.go.kr/articles/517')
text <- html_nodes(html,xpath='//*[@id="cont_view"]/div/div/div[1][1]/div[3]/div')%>%
  html_text()
text <- text[text !=""]
text <- paste(text,collapse=' ')  

extractNoun(text)
pos <- SimplePos09(text)
as.vector(na.omit(str_match(pos, '([��-�R]+)/N')[,2]))
as.vector(na.omit(substr(pos,1,str_locate(pos,'/N')-1))) #str_locate ��ġã�°�

nn.words <- function(doc){
  doc <- as.character(doc)
  pos <- SimplePos09(text)
  as.vector(na.omit(str_match(pos,'([��-�R]+)/N')[,2]))
}
word <- nn.words(text)
word[nchar(word)==1]

# �α��� �̻��� �ܾ ����
word[nchar(word)>=2]
word <- Filter(function(x) nchar(x)>=2,word)

grep('�����',word,value=T)
grep('������',word,value=T)

# �ҿ�� �ܾ� ����
stop_words <- c('������','����������','�����','�������','����ɼ���')

word_new <- c()
for(i in word){
  if(! i %in% stop_words){
    word_new <- c(word_new,i)
  }
}
word_new

grep('�����',word_new,value=T)
grep('������',word_new,value=T)

head(sort(7table(word_new),decreasing=T),10)

library(wordcloud2)
wordcloud2(head(sort(table(word_new),decreasing=T),10))

word_text <- paste(word_new,collapse=' ')

#��縦 �������� ����ġ�� �������ּ���
library(tm)
library(NLP)
corpus <- VCorpus(VectorSource(word_text)) # ����ġ ����
inspect(corpus) # Ȯ��
lapply(corpus,content) # Ȯ��2

corpus_dtm <- DocumentTermMatrix(corpus) # document-term matrix ���·� ��ȯ
inspect(corpus_dtm) # Ȯ��

termfreq <- colSums(as.matrix(corpus_dtm)) # dtm���¿����� dataframe���·� ��ȯ���� ���ϱ⿡ matrix���·� ��ȯ�Ͽ� ���� ���Ͽ��ش�.
freq_df <- data.frame(termfreq)
freq_df
head(freq_df)
freq_df$word <- rownames(freq_df)
rownames(freq_df) <- NULL
freq_df <- freq_df[,c(2,1)]

wordcloud2(freq_df)


#-------------------------------
html <- read_html('https://www1.president.go.kr/articles/517')
text <- html_nodes(html,xpath='//*[@id="cont_view"]/div/div/div[1][1]/div[3]/div')%>%
  html_text()
text <- text[text !=""]
text <- paste(text,collapse=' ')  

nn.words <- function(doc){
  doc <- as.character(doc)
  pos <- SimplePos09(text)
  as.vector(na.omit(str_match(pos,'([��-�R]+)/N')[,2]))
  #as.vector(na.omit(substr(pos,1,str_locate(pos,'/N')-1))) #str_locate ��ġã�°�
}

stop_words <- c('������','����������','�����','�������','����ɼ���')

text
moon_corpus <-VCorpus(VectorSource(text))
moon_corpus[[1]]$content
#lapply(moon_corpus,content)
#inspect(moon_corpus[[1]])

moon_dtm <- DocumentTermMatrix(moon_corpus,
                               control = list(tokenize=nn.words,
                                              wordLengths=c(2,Inf),
                                              stopwords=stop_words,
                                              removeNumbers=TRUE,
                                              removePunctuation=TRUE)) # tokenize=����ġ���� ����ġ�������� ��縸 �̾Ƴ��� �ɼ�, wordLengths=c(2,Inf) �ּ� 2���� �̻� �ɼ�, stopwords=�ҿ�� �ҿ�� ���� ���
inspect(moon_dtm)

head(sort(colSums(as.matrix(moon_dtm)),decreasing=T))

Terms(moon_dtm)

moon_termfreq <- colSums(as.matrix(moon_dtm))
moon_df <- data.frame(word=names(moon_termfreq),freq=moon_termfreq)
wordcloud2(moon_df)

pos <- read.csv('c:/data/pos_pol_word.txt',header=F,encoding='UTF-8')
head(pos)
tail(pos)

neg <- read.csv('c:/data/neg_pol_word.txt',header=F,encoding='UTF-8')
head(neg)
tail(neg)

names(pos) <- 'word'
names(neg) <- 'word'

pos$sentiment <- '����'
neg$sentiment <- '����'

head(pos)
head(neg)
k_sentiment_dic <- rbind(pos,neg)
head(k_sentiment_dic)
tail(k_sentiment_dic)

write.csv(k_sentiment_dic,file='c:/data/k_sentiment_dic.txt')

moon_sentiment <- merge(moon_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_sentiment,length)

#�ܾ �������
moon_word_dtm <- DocumentTermMatrix(moon_corpus)
inspect(moon_word_dtm)

moon_wordfreq <- colSums(as.matrix(moon_word_dtm))
moon_word_df <- data.frame(word=names(moon_wordfreq),freq=moon_wordfreq)

moon_word_sentiment <- merge(moon_word_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_word_sentiment,length)

#----------------------------------
�� ngram(s)
- ���̾� ���� n���� �ܾ�
- 1-gram : 1���� �ܾ�
  2-gram : bigram �� �ܾ�
  3-gram : trigram �� �ܾ�
  4-gram
- ���̾� ���Ǵ� �ܾ��� ���� �м�
(��)  �״³� ���� �ϴ��� �췯�� ���� �β����� ���⸦ �ٻ��� �̴� �ٶ����� ���� ���ο� �ߴ�.
�״³� ���� 
���� �ϴ��� 
�ϴ��� �췯��
�췯�� ����
���� �β�����
�β����� ���⸦
���⸦ �ٻ��� 

install.packages('RWeka')
library(RWeka)

Tokenizer <- function(x) RWeka::NGramTokenizer(x,RWeka::Weka_control(min=1,max=2)) 
Tokenizer


moon_word_dtm <- DocumentTermMatrix(moon_corpus,control=list(tokenizer='words'))
inspect(moon_word_dtm)

moon_word_dtm <- DocumentTermMatrix(moon_corpus,control=list(tokenizer=Tokenizer))
inspect(moon_word_dtm)

moon_wordfreq <- colSums(as.matrix(moon_word_dtm))
moon_word_df <- data.frame(word=names(moon_wordfreq),freq=moon_wordfreq)

moon_word_sentiment <- merge(moon_word_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_word_sentiment,length)



�� �����м��� �ܾ��� ���̹���ȭ ������ ������ �ܾ��� ���غ���

library(rvest)
library(stringr)
# 1. ����Ʈ �ּ� �о����
//*[@id="old_content"]/table/tbody

html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=1')

//*[@id="old_content"]/table/tbody/tr[2]/td[2]/div/em
# 2. ����
point <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/div/em')%>%
  html_text()

# 3. ������
comment <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/text()')%>%
  html_text()

comment <- str_trim(comment[!str_trim(comment)==''])

# 4. dataframe�� ����
df <- data.frame(point=point,comment=comment)
df

# 5. 10���������� ����
df <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=',i))
  
  #����
  point <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/div/em')%>%
    html_text()
 
   #������
  comment <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]')%>%
    html_text()

  comment <- str_replace_all(comment,'�ظ� ���Ϳ� �һ��� ����','')
  comment <- str_replace_all(comment,'���� - �� 10�� ��\\d+','')
  comment <- str_replace_all(comment,'�Ű�','')
  comment <- str_replace_all(comment,'\n|\t|\r',' ')
  comment <- str_squish(comment)
  
  #�����������ӿ� ����
  df <- rbind(df,data.frame(point=point,comment=comment))
  
}

View(df)
#-------------------------
6.��� ���� - ��� �ؾ��ϴ���?
library(KoNLP)
movie_word <- lapply(df$comment,function(x) paste(unlist(SimplePos09(x)),collapse=' '))
movie_word <- paste(unlist(movie_word),collapse=' ')
movie_word <- str_match_all(movie_word,'([��-�R]+)/N')
movie_word <- lapply(movie_word,function(x) unlist(x)[,2])
movie_df <- data.frame(table(movie_word))

wordcloud2(movie_df)

# ����ġ
movie <- paste(df$comment,collapse=' ')
movie_cor <- VCorpus(VectorSource(movie))
#movie_cor[[1]]$content

movie_dtm <- DocumentTermMatrix(movie_cor,
                                control=list(removerNumbers=TRUE,
                                             removePunctuation=TRUE))
                                             
movie_df <- data.frame(colSums(as.matrix(movie_dtm))) #���ϱ� �ǹ̰� ������ ���´� �ٸ� �ܾ���� ��û���� �� �������
movie_df$word <- rownames(movie_df)
movie_df <- movie_df[,c(2,1)]
rownames(movie_df) <- NULL

#7. ����, ���� ������

pos <- read.csv('c:/data/pos_pol_word.txt',header=F,encoding='UTF-8')
neg <- read.csv('c:/data/neg_pol_word.txt',header=F,encoding='UTF-8')

names(pos) <- 'word'
names(neg) <- 'word'

pos$sentiment <- '����'
neg$sentiment <- '����'

k_sentiment_dic <- rbind(pos,neg)

movie_sentiment <- merge(movie_df,k_sentiment_dic,by='word') #movie_df�� k_sentiment_dic, word�� �������� ����
head(moon_sentiment)
aggregate(word~sentiment,movie_sentiment,length) #���� Ȯ��


8. ��ȭ�� �� ������� ksu���������� �ܾ ��
#����,���� ������
for(i in 1:NROW(df)){
  ifelse(df$point[i] >= 8, df$sentiment[i] <- '����',df$sentiment[i] <- '����')
}
View(df)

#���� ����
movie_pn <- df[,c(2,3)]
View(movie_pn)

# ��ó��
movie_pn$comment
lapply(SimplePos09(movie_pn$comment),function(x) paste(unlist(x),collapse=' '))
lapply(SimplePos22(movie_pn$comment),function(x) paste(unlist(x),collapse=' '))



