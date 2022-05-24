[¹®Á¦215] ¹Ì±¹ ¹ÙÀÌµç ´ëÅë·É ÃëÀÓ»ç Àü¹®¿¡¼­ ¸í»ç(NN), º¹¼ö¸í»ç(NNS), ´Ü¼ö´ë¸í»ç(NNP),
º¹¼ö´ë¸í»ç(NNPS),Çü¿ë»ç(JJ), ºñ±³±ŞÇü¿ë»ç(JJR), ÃÖ»ó±Ş Çü¿ë»ç(JJS)  ÃßÃâÇØ¼­ ½Ã°¢È­ ÇØÁÖ¼¼¿ä. #¸ÕÀú ÀüÃ³¸®ÇÏ´Â °Í°ú ÈÄ¿¡ ÀüÃ³¸®ÇÏ´Â Â÷ÀÌº¸±â

library(stringr)
library(tm)
library('rJava')
library('NLP')
library('openNLP')
library(wordcloud)
library(wordcloud2)

# 0. µ¥ÀÌÅÍ ÀĞ¾î¿À±â
biden <- readLines('c:/data/biden_raw.txt')
biden
'''
# 1.ÀüÃ³¸®ÀÛ¾÷
biden_cor <- VCorpus(VectorSource(biden))
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub('<[\\w+\\+]+>',' ',x))) # ÇÊ¿ä¾ø´Â <u+812> Çü½Ä Áö¿ì±â
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub("It¡¯s|That¡¯s",' ',x)))
biden_cor <- tm_map(biden_cor,content_transformer(function(x) gsub("\\¡¯s",' ',x)))
biden_cor <- tm_map(biden_cor,removePunctuation)
biden_cor <- tm_map(biden_cor,removeWords,stopwords())
biden_cor <- tm_map(biden_cor,stripWhitespace)

str_extract_all(lapply(biden_cor,content),'¡¯s')
lapply(biden_cor,content)
'''

# 2. Ç°»çÅÂ±ëÀÛ¾÷

biden_s <- NLP::annotate(biden,openNLP::Maxent_Sent_Token_Annotator()) # annotate»ç¿ëÇÒ ¶§ ¶óÀÌºê·¯¸®ÀÌ¸§NLP ¾È¾²¸é ¿À·ù³ª¿Ã ¼ö ÀÖÀ½
biden_w <- NLP::annotate(biden,openNLP::Maxent_Word_Token_Annotator(),biden_s)
postag <- NLP::annotate(biden,openNLP::Maxent_POS_Tag_Annotator(),biden_w)
head(postag)
tail(postag)

pos_df <-data.frame(postag[postag$type=='word'])
head(pos_df)

# 3. ÃßÃâÀÛ¾÷
pos_df$features <- unlist(pos_df$features) # features´Â ¸®½ºÆ®Çü½ÄÀ¸·Î µÇ¾îÀÖ±â ¶§¹®¿¡ º¤ÅÍÇüÀ¸·Î º¯°æ
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

#ÀüÃ³¸® ÀÛ¾÷
grep("\\w+\\¡¯s$",word_biden,value=T)
word_biden <- gsub("\\¡¯s$",'',word_biden)

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

[¹®Á¦216] ¹®ÀçÀÎ ´ëÅë·É ÃëÀÓ»ç Àü¹®¿¡¼­ ¸í»ç¸¸ ÃßÃâÇØ¼­ ½Ã°¢È­ ÇØÁÖ¼¼¿ä.
library(rvest)
library(xml2)
html <- read_html('https://www.joongang.co.kr/article/21558717#home')
article <- html_nodes(html,xpath='//*[@id="article_body"]')
#ÇÊ¿ä¾ø´Â ÅÂ±× Á¦°Å
xml2::xml_remove(article%>%html_nodes(xpath='//*[@id="article_body"]/div[1]'))
xml2::xml_remove(article%>%html_nodes(xpath='//*[@id="article_body"]/p[1]'))
moon <- article%>%html_text()

# \n Á¦°Å
moon <- str_replace_all(moon,'\n','')
moon <- str_squish(moon)

# ¸í»çÃßÃâ
library(KoNLP)
useNIADic()


'''
1. JAVA_HOME À§Ä¡È®ÀÎ
Sys.getenv('JAVA_HOME')
# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_271')

2. rJava ¼³Ä¡
install.packages('rJava')
library(rJava)

3. konlp ÇÁ·Î±×·¥°ú °ü·ÃÀÖ´Â ÇÁ·Î±×·¥À» ¼³Ä¡
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages('remotes')

4. konlp ¼³Ä¡
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
wordcloud2(moon_df,size=3,minSize = 0,fontFamily = '¹ÙÅÁ',
           backgroundColor = 'black', color = 'white',
           minRotation = pi, shape = 'rectangle')

#-----------------------°­»ç´Ô
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
as.vector(na.omit(str_match(pos, '([°¡-ÆR]+)/N')[,2]))
as.vector(na.omit(substr(pos,1,str_locate(pos,'/N')-1))) #str_locate À§Ä¡Ã£´Â°Í

nn.words <- function(doc){
  doc <- as.character(doc)
  pos <- SimplePos09(text)
  as.vector(na.omit(str_match(pos,'([°¡-ÆR]+)/N')[,2]))
}
word <- nn.words(text)
word[nchar(word)==1]

# µÎ±ÛÀÚ ÀÌ»óÀÎ ´Ü¾î¸¸ ÃßÃâ
word[nchar(word)>=2]
word <- Filter(function(x) nchar(x)>=2,word)

grep('´ëÅë·É',word,value=T)
grep('¹®ÀçÀÎ',word,value=T)

# ºÒ¿ë¾î ´Ü¾î Á¦¿Ü
stop_words <- c('¹®ÀçÀÎ','¹®ÀçÀÎÁ¤ºÎ','´ëÅë·É','´ëÅë·ÉÀÇ','´ëÅë·É¼±°Å')

word_new <- c()
for(i in word){
  if(! i %in% stop_words){
    word_new <- c(word_new,i)
  }
}
word_new

grep('´ëÅë·É',word_new,value=T)
grep('¹®ÀçÀÎ',word_new,value=T)

head(sort(7table(word_new),decreasing=T),10)

library(wordcloud2)
wordcloud2(head(sort(table(word_new),decreasing=T),10))

word_text <- paste(word_new,collapse=' ')

#¸í»ç¸¦ ±âÁØÀ¸·Î ¸»¹¶Ä¡¸¦ »ı¼ºÇØÁÖ¼¼¿ä
library(tm)
library(NLP)
corpus <- VCorpus(VectorSource(word_text)) # ¸»¹¶Ä¡ »ı¼º
inspect(corpus) # È®ÀÎ
lapply(corpus,content) # È®ÀÎ2

corpus_dtm <- DocumentTermMatrix(corpus) # document-term matrix ÇüÅÂ·Î º¯È¯
inspect(corpus_dtm) # È®ÀÎ

termfreq <- colSums(as.matrix(corpus_dtm)) # dtmÇüÅÂ¿¡¼­´Â dataframeÇüÅÂ·Î º¯È¯ÇÏÁö ¸øÇÏ±â¿¡ matrixÇüÅÂ·Î º¯È¯ÇÏ¿© ¿­·Î ÇÕÇÏ¿©ÁØ´Ù.
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
  as.vector(na.omit(str_match(pos,'([°¡-ÆR]+)/N')[,2]))
  #as.vector(na.omit(substr(pos,1,str_locate(pos,'/N')-1))) #str_locate À§Ä¡Ã£´Â°Í
}

stop_words <- c('¹®ÀçÀÎ','¹®ÀçÀÎÁ¤ºÎ','´ëÅë·É','´ëÅë·ÉÀÇ','´ëÅë·É¼±°Å')

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
                                              removePunctuation=TRUE)) # tokenize=¸»¹¶Ä¡º¯¼ö ¸»¹¶Ä¡º¯¼ö¿¡¼­ ¸í»ç¸¸ »Ì¾Æ³»´Â ¿É¼Ç, wordLengths=c(2,Inf) ÃÖ¼Ò 2±ÛÀÚ ÀÌ»ó ¿É¼Ç, stopwords=ºÒ¿ë¾î ºÒ¿ë¾î Á¦°Å ±â´É
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

pos$sentiment <- '±àÁ¤'
neg$sentiment <- 'ºÎÁ¤'

head(pos)
head(neg)
k_sentiment_dic <- rbind(pos,neg)
head(k_sentiment_dic)
tail(k_sentiment_dic)

write.csv(k_sentiment_dic,file='c:/data/k_sentiment_dic.txt')

moon_sentiment <- merge(moon_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_sentiment,length)

#´Ü¾î¸¦ ±â¹İÀ¸·Î
moon_word_dtm <- DocumentTermMatrix(moon_corpus)
inspect(moon_word_dtm)

moon_wordfreq <- colSums(as.matrix(moon_word_dtm))
moon_word_df <- data.frame(word=names(moon_wordfreq),freq=moon_wordfreq)

moon_word_sentiment <- merge(moon_word_df,k_sentiment_dic,by='word')
head(moon_sentiment)
aggregate(word~sentiment,moon_word_sentiment,length)

#----------------------------------
¡Ú ngram(s)
- ¿¬ÀÌ¾î »ç¿ëµÈ n°³ÀÇ ´Ü¾î
- 1-gram : 1°³ÀÇ ´Ü¾î
  2-gram : bigram µÎ ´Ü¾î
  3-gram : trigram ¼¼ ´Ü¾î
  4-gram
- ¿¬ÀÌ¾î »ç¿ëµÇ´Â ´Ü¾îÀÇ ½ÖÀ» ºĞ¼®
(¿¹)  Á×´Â³¯ ±îÁö ÇÏ´ÃÀ» ¿ì·¯·¯ ÇÑÁ¡ ºÎ²ô·³ÀÌ ¾ø±â¸¦ ÀÙ»õ¿¡ ÀÌ´Â ¹Ù¶÷¿¡µµ ³ª´Â ±«·Î¿ö Çß´Ù.
Á×´Â³¯ ±îÁö 
±îÁö ÇÏ´ÃÀ» 
ÇÏ´ÃÀ» ¿ì·¯·¯
¿ì·¯·¯ ÇÑÁ¡
ÇÑÁ¡ ºÎ²ô·³ÀÌ
ºÎ²ô·³ÀÌ ¾ø±â¸¦
¾ø±â¸¦ ÀÙ»õ¿¡ 

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



¡Ü °¨¼ººĞ¼®ÀÇ ´Ü¾îµé°ú ³×ÀÌ¹ö¿µÈ­ ÆòÁ¡ÀÇ ¸®ºäÀÇ ´Ü¾îµé°ú ºñ±³ÇØº¸±â

library(rvest)
library(stringr)
# 1. »çÀÌÆ® ÁÖ¼Ò ÀĞ¾î¿À±â
//*[@id="old_content"]/table/tbody

html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=1')

//*[@id="old_content"]/table/tbody/tr[2]/td[2]/div/em
# 2. ÆòÁ¡
point <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/div/em')%>%
  html_text()

# 3. °¨»óÆò
comment <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/text()')%>%
  html_text()

comment <- str_trim(comment[!str_trim(comment)==''])

# 4. dataframe¿¡ ÀúÀå
df <- data.frame(point=point,comment=comment)
df

# 5. 10ÆäÀÌÁö±îÁö ÀúÀå
df <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=',i))
  
  #ÆòÁ¡
  point <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]/div/em')%>%
    html_text()
 
   #°¨»óÆò
  comment <- html_nodes(html,xpath='//*[@id="old_content"]/table/tbody/tr/td[2]')%>%
    html_text()

  comment <- str_replace_all(comment,'ÇØ¸® Æ÷ÅÍ¿Í ºÒ»çÁ¶ ±â»ç´Ü','')
  comment <- str_replace_all(comment,'º°Á¡ - ÃÑ 10Á¡ Áß\\d+','')
  comment <- str_replace_all(comment,'½Å°í','')
  comment <- str_replace_all(comment,'\n|\t|\r',' ')
  comment <- str_squish(comment)
  
  #µ¥ÀÌÅÍÇÁ·¹ÀÓ¿¡ ÀúÀå
  df <- rbind(df,data.frame(point=point,comment=comment))
  
}

View(df)
#-------------------------
6.¸í»ç ÃßÃâ - ¾î¶»°Ô ÇØ¾ßÇÏ´õ¶ó?
library(KoNLP)
movie_word <- lapply(df$comment,function(x) paste(unlist(SimplePos09(x)),collapse=' '))
movie_word <- paste(unlist(movie_word),collapse=' ')
movie_word <- str_match_all(movie_word,'([°¡-ÆR]+)/N')
movie_word <- lapply(movie_word,function(x) unlist(x)[,2])
movie_df <- data.frame(table(movie_word))

wordcloud2(movie_df)

# ¸»¹¶Ä¡
movie <- paste(df$comment,collapse=' ')
movie_cor <- VCorpus(VectorSource(movie))
#movie_cor[[1]]$content

movie_dtm <- DocumentTermMatrix(movie_cor,
                                control=list(removerNumbers=TRUE,
                                             removePunctuation=TRUE))
                                             
movie_df <- data.frame(colSums(as.matrix(movie_dtm))) #º¸´Ï±î ÀÇ¹Ì°¡ °°Àºµ¥ ÇüÅÂ´Â ´Ù¸¥ ´Ü¾îµéÀÌ ¾öÃ»¸¹À½ ¼Õ ºÁÁà¾ßÇÔ
movie_df$word <- rownames(movie_df)
movie_df <- movie_df[,c(2,1)]
rownames(movie_df) <- NULL

#7. ±àÁ¤, ºÎÁ¤ ³ª´©±â

pos <- read.csv('c:/data/pos_pol_word.txt',header=F,encoding='UTF-8')
neg <- read.csv('c:/data/neg_pol_word.txt',header=F,encoding='UTF-8')

names(pos) <- 'word'
names(neg) <- 'word'

pos$sentiment <- '±àÁ¤'
neg$sentiment <- 'ºÎÁ¤'

k_sentiment_dic <- rbind(pos,neg)

movie_sentiment <- merge(movie_df,k_sentiment_dic,by='word') #movie_df¿Í k_sentiment_dic, word¸¦ ±âÁØÀ¸·Î Á¶ÀÎ
head(moon_sentiment)
aggregate(word~sentiment,movie_sentiment,length) #°³¼ö È®ÀÎ


8. ¿µÈ­ÀÇ °¢ °¨»óÆò°ú ksu°¨¼º»çÀüÀÇ ´Ü¾î¸¦ ºñ±³
#±àÁ¤,ºÎÁ¤ ³ª´©±â
for(i in 1:NROW(df)){
  ifelse(df$point[i] >= 8, df$sentiment[i] <- '±àÁ¤',df$sentiment[i] <- 'ºÎÁ¤')
}
View(df)

#ÆòÁ¡ Á¦°Å
movie_pn <- df[,c(2,3)]
View(movie_pn)

# ÀüÃ³¸®
movie_pn$comment
lapply(SimplePos09(movie_pn$comment),function(x) paste(unlist(x),collapse=' '))
lapply(SimplePos22(movie_pn$comment),function(x) paste(unlist(x),collapse=' '))



