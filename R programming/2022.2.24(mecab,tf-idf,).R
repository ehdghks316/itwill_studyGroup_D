install.packages('RmecabKo')
library(RmecabKo)

RmecabKo::install_mecab('c:/mecab')
install.packages('RcppMeCab')
library(RcppMeCab)

#devtools::install_github("junhewk/RmecabKo",INSTALL_opts=c('--no-lock'))
RcppMeCab::pos('한국어 텍스트 형태소 분석을 합니다.')
RcppMeCab::pos(iconv("한국어 텍스트 형태소 분석을 합니다.",to="utf8"))

library(dplyr)
base::enc2utf8('한국어텍스트형태소분석을합니다.')%>%
  RcppMeCab::pos()
library(KoNLP)
SimplePos22('한국어텍스트형태소분석을합니다.')

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
- 특징 추출
- 머신러닝, 딥러닝 학습시에 변수들을 만들 때 텍스트 데이터의 특징을 담아서 학습을 시킬때 사용
- features extraction 기법

TF(Term Frequency)
- 한개 문서 안에서 특정 단어의 등장 빈도를 의미한다.
- 단어의 빈도수를 기반으로 하는 특징 추출 방법
- CountVectorizer
- 문제점은 특징 추출은 조사, 관사 처럼 많이 등장한 단어들을 높게 쳐주기때문에
  유의미한 결과를 얻을 수가 없다.
  
TF-IDF(Term frequency - Inverse Document Frequency)는 countvectorizer의 문제점을 개선해준 기능
즉 여러 문서에서 많이 등장하는 단어들은 일종의 패널티를 주는 방법

DF(Document Frequency)
- 특정 단어가 나타나는 문서의 수
예) Mommy의 DF? 3
  you의 DF? 4
  
IDF(Inverse Document Frequency)
- DF에 역수 변환을 해준 값을 의미
- IDF-SMOOTHING에 따라 달라진다.
IDF = log(n/df+1) # n : 전체문서의 수, df : 특정 단어가 나타나는 문서의 수

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

movie$review <- trimws(gsub('^스포일러가 포함된 감상평입니다. 감상평 보기','',movie$review))

movie <- movie[movie$review !='',]

movie$evaluation <- ifelse(movie$point >= 8, '긍정',ifelse(movie$point >= 5 & movie$point <= 7,'중립','부정'))

movie_data <- movie[,c('review','evaluation')]
View(movie_data)

movie.corpus <- tm::VCorpus(VectorSource(movie_data$review))
movie.corpus[[1]]$content

x <- RcppMeCab::pos(base::enc2utf8(as.character(movie.corpus[[1]]$content)))
str_match_all(x,'[가-힣]+/NNG')

mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  word_noun <- str_match_all(tagging,'([가-힣]+)/NNG')[[1]][,2]
  word_noun
}

mecab.words(movie.corpus[[1]]$content)

x <- RcppMeCab::pos(base::enc2utf8(as.character(movie.corpus[[1]]$content)))
str_match_all(x,'([가-힣]+)(/NNG|NNP|VV|/VA)')

mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  word_noun <- str_match_all(tagging,'([가-힣]+)(/NNG|NNP|VV|/VA)')[[1]][,2]
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

#-0--------------새 데이터 넣을 때
new <- '주인공의 연기가 좋았다'
new.corpus <- VCorpus(VectorSource(new))
mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  word_noun <- str_match_all(tagging,'([가-힣]+)(/NNG|NNP|VV|/VA)')[[1]][,2]
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


# 품사 태깅 정보를 가지고 학습
mecab.words <- function(doc){
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  as.vector(unlist(tagging))
}

mecab.words(new)