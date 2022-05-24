install.packages('RmecabKo')
library(RmecabKo)

RmecabKo::install_mecab('c:/mecab')
install.packages('RcppMeCab')
library(RcppMeCab)

#devtools::install_github("junhewk/RmecabKo",INSTALL_opts=c('--no-lock'))
RcppMeCab::pos('ÇÑ±¹¾î ÅØ½ºÆ® ÇüÅÂ¼Ò ºÐ¼®À» ÇÕ´Ï´Ù.')
RcppMeCab::pos(iconv("ÇÑ±¹¾î ÅØ½ºÆ® ÇüÅÂ¼Ò ºÐ¼®À» ÇÕ´Ï´Ù.",to="utf8"))

library(dplyr)
base::enc2utf8('ÇÑ±¹¾îÅØ½ºÆ®ÇüÅÂ¼ÒºÐ¼®À»ÇÕ´Ï´Ù.')%>%
  RcppMeCab::pos()
library(KoNLP)
SimplePos22('ÇÑ±¹¾îÅØ½ºÆ®ÇüÅÂ¼ÒºÐ¼®À»ÇÕ´Ï´Ù.')

data <- c('Mommy  I love you And I want to say thank you',
          'I am happy  everyday for the love you give to me',
          'Sometimes I am sad Sometimes I do cry',
          'Then I just remember  Mommy how much you love me',
          'Mommy you take care of me you help me to be strong')
data

library(tm)
corpus <- VCorpus(VectorSource(data))
inspect(corpus)
lapply(corpus,content)

corpus.dtm <- DocumentTermMatrix(corpus,control=list(wordLengths=c(1,Inf)))
corpus.dtm
inspect(corpus.dtm)

Terms(corpus.dtm)

TF-IDF(Term frequency - Inverse Document Frequency)
- Æ¯Â¡ ÃßÃâ
- ¸Ó½Å·¯´×, µö·¯´× ÇÐ½À½Ã¿¡ º¯¼öµéÀ» ¸¸µé ¶§ ÅØ½ºÆ® µ¥ÀÌÅÍÀÇ Æ¯Â¡À» ´ã¾Æ¼­ ÇÐ½ÀÀ» ½ÃÅ³¶§ »ç¿ë
- features extraction ±â¹ý

TF(Term Frequency)
- ÇÑ°³ ¹®¼­ ¾È¿¡¼­ Æ¯Á¤ ´Ü¾îÀÇ µîÀå ºóµµ¸¦ ÀÇ¹ÌÇÑ´Ù.
- ´Ü¾îÀÇ ºóµµ¼ö¸¦ ±â¹ÝÀ¸·Î ÇÏ´Â Æ¯Â¡ ÃßÃâ ¹æ¹ý
- CountVectorizer
- ¹®Á¦Á¡Àº Æ¯Â¡ ÃßÃâÀº Á¶»ç, °ü»ç Ã³·³ ¸¹ÀÌ µîÀåÇÑ ´Ü¾îµéÀ» ³ô°Ô ÃÄÁÖ±â¶§¹®¿¡
  À¯ÀÇ¹ÌÇÑ °á°ú¸¦ ¾òÀ» ¼ö°¡ ¾ø´Ù.
  
TF-IDF(Term frequency - Inverse Document Frequency)´Â countvectorizerÀÇ ¹®Á¦Á¡À» °³¼±ÇØÁØ ±â´É
Áï ¿©·¯ ¹®¼­¿¡¼­ ¸¹ÀÌ µîÀåÇÏ´Â ´Ü¾îµéÀº ÀÏÁ¾ÀÇ ÆÐ³ÎÆ¼¸¦ ÁÖ´Â ¹æ¹ý

DF(Document Frequency)
- Æ¯Á¤ ´Ü¾î°¡ ³ªÅ¸³ª´Â ¹®¼­ÀÇ ¼ö
¿¹) MommyÀÇ DF? 3
  youÀÇ DF? 4
  
IDF(Inverse Document Frequency)
- DF¿¡ ¿ª¼ö º¯È¯À» ÇØÁØ °ªÀ» ÀÇ¹Ì
- IDF-SMOOTHING¿¡ µû¶ó ´Þ¶óÁø´Ù.
IDF = log(n/df+1) # n : ÀüÃ¼¹®¼­ÀÇ ¼ö, df : Æ¯Á¤ ´Ü¾î°¡ ³ªÅ¸³ª´Â ¹®¼­ÀÇ ¼ö

log(5/4)
log(5/1)

TF-IDF = TF * IDF

corpus.dtm <- DocumentTermMatrix(corpus,
                                 control=list(wordLengths=c(1,Inf),
                                              weighting=weightTfIdf))
corpus.dtm
inspect(corpus.dtm)
Terms(corpus.dtm)
as.matrix(corpus.dtm)

#----------------------------------------------------------------------------------

library(tm)
library(stringr)
library(RcppMeCab)

movie <- read.csv('c:/data/movie_raw.csv')
View(movie)
str(movie)
movie$review

movie$review <- trimws(gsub('^½ºÆ÷ÀÏ·¯°¡ Æ÷ÇÔµÈ °¨»óÆòÀÔ´Ï´Ù. °¨»óÆò º¸±â','',movie$review))

movie <- movie[movie$review !='',]

movie$evaluation <- ifelse(movie$point >= 8, '±àÁ¤',ifelse(movie$point >= 5 & movie$point <= 7,'Áß¸³','ºÎÁ¤'))

movie_data <- movie[,c('review','evaluation')]
View(movie_data)

movie.corpus <- tm::VCorpus(VectorSource(movie_data$review))
movie.corpus[[1]]$content

x <- RcppMeCab::pos(base::enc2utf8(as.character(movie.corpus[[1]]$content)))
str_match_all(x,'[°¡-ÆR]+/NNG')

mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  word_noun <- str_match_all(tagging,'([°¡-ÆR]+)/NNG')[[1]][,2]
  word_noun
}

mecab.words(movie.corpus[[1]]$content)

x <- RcppMeCab::pos(base::enc2utf8(as.character(movie.corpus[[1]]$content)))
str_match_all(x,'([°¡-ÆR]+)(/NNG|NNP|VV|/VA)')

mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  word_noun <- str_match_all(tagging,'([°¡-ÆR]+)(/NNG|NNP|VV|/VA)')[[1]][,2]
  word_noun
}

data.dtm <- DocumentTermMatrix(movie.corpus,control=list(tokenize=mecab.words))
data.dtm
inspect(data.dtm)
as.matrix(data.dtm)

idx <- sample(2,nrow(data.dtm),replace=TRUE,prob=c(0.8,0.2))
prop.table(table(idx))
data.dtm.train <- data.dtm[idx==1,]
data.dtm.test <- data.dtm[idx==2,]

nrow(data.dtm.train)
nrow(data.dtm.test)

data.dtm.train.labels <- movie_data[idx==1,'evaluation']
data.dtm.test.labels <- movie_data[idx==2,'evaluation']

length(data.dtm.train.labels)
length(data.dtm.test.labels)

as.matrix(data.dtm.train)

convert_counts <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

data.train <- apply(data.dtm.train,MARGIN=2,convert_counts)
data.train[1,]
data.test <- apply(data.dtm.test,MARGIN=2,convert_counts)
data.test[1,]

library(e1071)
data.classifier <- naiveBayes(data.train,data.dtm.train.labels,laplace=1)
data.test.predict <- predict(data.classifier,data.test)
data.test.predict == data.dtm.test.labels
table(data.test.predict,data.dtm.test.labels)

library(gmodels)
CrossTable(data.test.predict,data.dtm.test.labels)
CrossTable(data.dtm.test.labels,data.test.predict)

#-0--------------»õ µ¥ÀÌÅÍ ³ÖÀ» ¶§
new <- 'ÁÖÀÎ°øÀÇ ¿¬±â°¡ ÁÁ¾Ò´Ù'
new.corpus <- VCorpus(VectorSource(new))
mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  word_noun <- str_match_all(tagging,'([°¡-ÆR]+)(/NNG|NNP|VV|/VA)')[[1]][,2]
  word_noun
}

words <- Terms(data.dtm)
new.dtm <- DocumentTermMatrix(new.corpus,control=list(tokenize=mecab.words,
                                                       dictionary=words))
new.dtm

convert_counts <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

new.test <- apply(new.dtm,MARGIN = 2,convert_counts)
new.test

predict(data.classifier,t(new.test))
predict(data.classifier,t(new.test),type='raw')


# Ç°»ç ÅÂ±ë Á¤º¸¸¦ °¡Áö°í ÇÐ½À
mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  as.vector(unlist(tagging))
}

mecab.words(new)