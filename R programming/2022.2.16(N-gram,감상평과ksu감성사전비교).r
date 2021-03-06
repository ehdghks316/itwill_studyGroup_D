[문제215] 미국 바이든 대통령 취임사 전문에서 명사(NN), 복수명사(NNS), 단수대명사(NNP),
복수대명사(NNPS),형용사(JJ), 비교급형용사(JJR), 최상급 형용사(JJS)  추출해서 시각화 해주세요. #먼저 전처리하는 것과 후에 전처리하는 차이보기

library(stringr)
library(tm)
library('rJava')
library('NLP')
library('openNLP')
library(wordcloud)
library(wordcloud2)

# 0. 데이터 읽어오기
biden <- readLines('c:/data/biden_raw.txt')
biden
'''
# 1.전처리작업
biden_cor <- VCorpus(VectorSource(biden))
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub('<[\\w+\\+]+>',' ',x))) # 필요없는 <u+812> 형식 지우기
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub("It’s|That’s",' ',x)))
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub("\\’s",' ',x)))
biden_cor <- tm_map(biden_cor,removePunctuation)
biden_cor <- tm_map(biden_cor,removeWords,stopwords())
biden_cor <- tm_map(biden_cor,stripWhitespace)

str_extract_all(lapply(biden_cor,content),'’s')
lapply(biden_cor,content)
'''

# 2. 품사태깅작업

biden_s <- NLP::annotate(biden,openNLP::Maxent_Sent_Token_Annotator()) # annotate사용할 때 라이브러리이름NLP 안쓰면 오류나올 수 있음
biden_w <- NLP::annotate(biden,openNLP::Maxent_Word_Token_Annotator(),biden_s)
postag <- NLP::annotate(biden,openNLP::Maxent_POS_Tag_Annotator(),biden_w)
head(postag)
tail(postag)

pos_df <-data.frame(postag[postag$type=='word'])
head(pos_df)

# 3. 추출작업
pos_df$features <- unlist(pos_df$features) # features는 리스트형식으로 되어있기 때문에 벡터형으로 변경
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

#전처리 작업
grep("\\w+\\’s$",word_biden,value=T)
word_biden <- gsub("\\’s$",'',word_biden)

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

[문제216] 문재인 대통령 취임사 전문에서 명사만 추출해서 시각화 해주세요.
library(rvest)
library(xml2)
html <- read_html('https://www.joongang.co.kr/article/21558717#home')
article <- html_nodes(html,xpath='//*[@id="article_body"]')
#필요없는 태그 제거
xml2::xml_remove(article%>%html_nodes(xpath='//*[@id="article_body"]/div[1]'))
xml2::xml_remove(article%>%html_nodes(xpath='//*[@id="article_body"]/p[1]'))
moon <- article%>%html_text()

# \n 제거
moon <- str_replace_all(moon,'\n','')
moon <- str_squish(moon)

# 명사추출
library(KoNLP)
useNIADic()


'''
1. JAVA_HOME 위치확인
Sys.getenv('JAVA_HOME')
# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_271')

2. rJava 설치
install.packages('rJava')
library(rJava)

3. konlp 프로그램과 관련있는 프로그램을 설치
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages('remotes')

4. konlp 설치
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
wordcloud2(moon_df,size=3,minSize = 0,fontFamily = '바탕',
           backgroundColor = 'black', color = 'white',
           minRotation = pi, shape = 'rectangle')

#-----------------------강사님
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
as.vector(na.omit(str_match(pos, '([가-힣]+)/N')[,2]))
as.vector(na.omit(substr(pos,1,str_locate(pos,'/N')-1))) #str_locate 위치찾는것

nn.words <- function(doc){
  doc <- as.character(doc)
  pos <- SimplePos09(text)
  as.vector(na.omit(str_match(pos,'([가-힣]+)/N')[,2]))
}
word <- nn.words(text)
word[nchar(word)==1]

# 두글자 이상인 단어만 추출
word[nchar(word)>=2]
word <- Filter(function(x) nchar(x)>=2,word)

grep('대통령',word,value=T)
grep('문재인',word,value=T)

# 불용어 단어 제외
stop_words <- c('문재인','문재인정부','대통령','대통령의','대통령선거')

word_new <- c()
for(i in word){
  if(! i %in% stop_words){
    word_new <- c(word_new,i)
  }
}
word_new

grep('대통령',word_new,value=T)
grep('문재인',word_new,value=T)

head(sort(7table(word_new),decreasing=T),10)

library(wordcloud2)
wordcloud2(head(sort(table(word_new),decreasing=T),10))

word_text <- paste(word_new,collapse=' ')

#명사를 기준으로 말뭉치를 생성해주세요
library(tm)
library(NLP)
corpus <- VCorpus(VectorSource(word_text)) # 말뭉치 생성
inspect(corpus) # 확인
lapply(corpus,content) # 확인2

corpus_dtm <- DocumentTermMatrix(corpus) # document-term matrix 형태로 변환
inspect(corpus_dtm) # 확인

termfreq <- colSums(as.matrix(corpus_dtm)) # dtm형태에서는 dataframe형태로 변환하지 못하기에 matrix형태로 변환하여 열로 합하여준다.
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
  as.vector(na.omit(str_match(pos,'([가-힣]+)/N')[,2]))
  #as.vector(na.omit(substr(pos,1,str_locate(pos,'/N')-1))) #str_locate 위치찾는것
}

stop_words <- c('문재인','문재인정부','대통령','대통령의','대통령선거')

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
                                              removePunctuation=TRUE)) # tokenize=말뭉치변수 말뭉치변수에서 명사만 뽑아내는 옵션, wordLengths=c(2,Inf) 최소 2글자 이상 옵션, stopwords=불용어 불용어 제거 기능
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

pos$sentiment <- '긍정'
neg$sentiment <- '부정'

head(pos)
head(neg)
k_sentiment_dic <- rbind(pos,neg)
head(k_sentiment_dic)
tail(k_sentiment_dic)

write.csv(k_sentiment_dic,file='c:/data/k_sentiment_dic.txt')

moon_sentiment <- merge(moon_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_sentiment,length)

#단어를 기반으로
moon_word_dtm <- DocumentTermMatrix(moon_corpus)
inspect(moon_word_dtm)

moon_wordfreq <- colSums(as.matrix(moon_word_dtm))
moon_word_df <- data.frame(word=names(moon_wordfreq),freq=moon_wordfreq)

moon_word_sentiment <- merge(moon_word_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_word_sentiment,length)

#----------------------------------
★ ngram(s)
- 연이어 사용된 n개의 단어
- 1-gram : 1개의 단어
  2-gram : bigram 두 단어
  3-gram : trigram 세 단어
  4-gram
- 연이어 사용되는 단어의 쌍을 분석
(예)  죽는날 까지 하늘을 우러러 한점 부끄럼이 없기를 잎새에 이는 바람에도 나는 괴로워 했다.
죽는날 까지 
까지 하늘을 
하늘을 우러러
우러러 한점
한점 부끄럼이
부끄럼이 없기를
없기를 잎새에 

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



● 감성분석의 단어들과 네이버영화 평점의 리뷰의 단어들과 비교해보기

library(rvest)
library(stringr)
# 1. 사이트 주소 읽어오기
//*[@id="old_content"]/table/tbody

html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=1')

//*[@id="old_content"]/table/tbody/tr[2]/td[2]/div/em
# 2. 평점
point <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/div/em')%>%
  html_text()

# 3. 감상평
comment <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/text()')%>%
  html_text()

comment <- str_trim(comment[!str_trim(comment)==''])

# 4. dataframe에 저장
df <- data.frame(point=point,comment=comment)
df

# 5. 10페이지까지 저장
df <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=',i))
  
  #평점
  point <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/div/em')%>%
    html_text()
 
   #감상평
  comment <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]')%>%
    html_text()

  comment <- str_replace_all(comment,'해리 포터와 불사조 기사단','')
  comment <- str_replace_all(comment,'별점 - 총 10점 중\\d+','')
  comment <- str_replace_all(comment,'신고','')
  comment <- str_replace_all(comment,'\n|\t|\r',' ')
  comment <- str_squish(comment)
  
  #데이터프레임에 저장
  df <- rbind(df,data.frame(point=point,comment=comment))
  
}

View(df)
#-------------------------
6.명사 추출 - 어떻게 해야하더라?
library(KoNLP)
movie_word <- lapply(df$comment,function(x) paste(unlist(SimplePos09(x)),collapse=' '))
movie_word <- paste(unlist(movie_word),collapse=' ')
movie_word <- str_match_all(movie_word,'([가-힣]+)/N')
movie_word <- lapply(movie_word,function(x) unlist(x)[,2])
movie_df <- data.frame(table(movie_word))

wordcloud2(movie_df)

# 말뭉치
movie <- paste(df$comment,collapse=' ')
movie_cor <- VCorpus(VectorSource(movie))
#movie_cor[[1]]$content

movie_dtm <- DocumentTermMatrix(movie_cor,
                                control=list(removerNumbers=TRUE,
                                             removePunctuation=TRUE))
                                             
movie_df <- data.frame(colSums(as.matrix(movie_dtm))) #보니까 의미가 같은데 형태는 다른 단어들이 엄청많음 손 봐줘야함
movie_df$word <- rownames(movie_df)
movie_df <- movie_df[,c(2,1)]
rownames(movie_df) <- NULL

#7. 긍정, 부정 나누기

pos <- read.csv('c:/data/pos_pol_word.txt',header=F,encoding='UTF-8')
neg <- read.csv('c:/data/neg_pol_word.txt',header=F,encoding='UTF-8')

names(pos) <- 'word'
names(neg) <- 'word'

pos$sentiment <- '긍정'
neg$sentiment <- '부정'

k_sentiment_dic <- rbind(pos,neg)

movie_sentiment <- merge(movie_df,k_sentiment_dic,by='word') #movie_df와 k_sentiment_dic, word를 기준으로 조인
head(moon_sentiment)
aggregate(word~sentiment,movie_sentiment,length) #개수 확인


8. 영화의 각 감상평과 ksu감성사전의 단어를 비교
#긍정,부정 나누기
for(i in 1:NROW(df)){
  ifelse(df$point[i] >= 8, df$sentiment[i] <- '긍정',df$sentiment[i] <- '부정')
}
View(df)

#평점 제거
movie_pn <- df[,c(2,3)]
View(movie_pn)

# 전처리
movie_pn$comment
lapply(SimplePos09(movie_pn$comment),function(x) paste(unlist(x),collapse=' '))
lapply(SimplePos22(movie_pn$comment),function(x) paste(unlist(x),collapse=' '))



