★ data mining
수많은 데이터 중 의미있는 정보를 추출해 내는 분석과정

★ text mining
텍스트로부터 의미있는 정보를 추출하는 데이터 분석 기법으로 text analytics, text analysis라고 한다.

활용
- 문서분류
- 문서나 단어 간의 연관성 분석
- 감성 분석

★ corpus(말뭉치)
- 언어 연구를 위해 텍스트를 컴퓨터가 읽을 수 있는 형태로 모아 놓은 언어집합

★ 텍스트 마이닝을 하기위한 단계
문서(비정형데이터) -> corpus -> 구조화된 문서 -> 분석

install.packages("tm")
library(tm)

data <- readLines('c:/data/Mommy_I_love_you.txt')
data

class(data)
mode(data)

#character(vector) -> corpus 변환
corp1 <- VCorpus(VectorSource(data))
class(corp1)

# 코퍼스 요약정보
corp1
inspect(corp1) #리스트도 같이 가지고 있음
inspect(corp1[1])  #공백포함 글자 개수까지 알려주고 문서내용은x
inspect(corp1[[1]]) #미리보기 처럼 문서내용까지 볼 수 있음

# 문서확인
as.character(inspect(corp1[[1]]))
as.character(inspect(corp1[[2]]))
lapply(corp1,as.character)
sapply(corp1,as.character)

corp1[[1]]$content
lapply(corp1,content)
sapply(corp1,content)

as.vector(unlist(lapply(corp1,content)))
as.vector(sapply(corp1,content))

paste(as.vector(sapply(corp1,content)),collapse = ' ') # 개별을 하나의 문장으로 변환

# 메타정보 확인
corp1[[1]]$meta
meta(corp1[[1]])
lapply(corp1,meta)
sapply(corp1,meta)

meta(corp1[[1]],tag='author')
meta(corp1[[1]],tag='id')
meta(corp1[[1]],tag='datetimestamp')

meta(corp1[[1]],tag='author', type = 'local') <- 'james'
meta(corp1[[1]],tag='author')

lapply(corp1,meta)
meta(corp1,tag='author',type='local') <- paste0(1:9,'문서')
lapply(corp1,meta)

meta(corp1,tag='author',type='local') <- NA # NA로 수정
lapply(corp1,meta)

meta(corp1,tag='author',type='local') <- NULL #항목삭제
lapply(corp1,meta)

meta(corp1,tag='author',type='local') <- paste0(1:9,'문서') # 다시 항목 생성(새로운이름으로)
lapply(corp1,meta)

# tm 패키지에서 제공하는 정제작업에서 사용되는 함수
getTransformations()
removeNumbers - 숫자제거
removePunctuation - 특수문자 제거
removeWords - 불용어제거(의미없는 단어들 제거)
stemDocument - 어근 통합
stripWhitespace - 연속되는 2개이상의 공백을 하나의 공백으로 변환하는 함수

corp1[[1]]$content

# stripWhitespace - 연속되는 2개이상의 공백을 하나의 공백으로 변환하는 함수
corp2 <- tm_map(corp1,stripWhitespace)
corp1[[1]]$content
corp2[[1]]$content
lapply(corp2,content)

# removePunctuation - 특수문자 제거
corp2 <- tm_map(corp2,removePunctuation)
lapply(corp2,content)

# removeNumbers - 숫자제거
corp2 <- tm_map(corp2,removeNumbers)
lapply(corp2,content)

# 일반함수를 tm_map에서 사용할 때는 content_transformer 함께 사용해야 한다.

corp2 <-tm_map(corp2,content_transformer(tolower))
lapply(corp2,content)

corp2 <-tm_map(corp2,content_transformer(trimws))
lapply(corp2,content)

# 불용어
tm::stopwords()
tm::stopwords('english')
tm::stopwords('en')
tm::stopwords('smart') # 좀 더 많은 불용어들이 있음

tm::stopwords()[tm::stopwords()=='me']
tm::stopwords()[tm::stopwords()=='makes']

stopword2 <- c(tm::stopwords(),'makes','want')
stopword2

# removeWords : 단어를 제거하는 함수
tm_map(corp2,removeWords,tm::stopwords())
corp2 <- tm_map(corp2,removeWords,stopword2)
lapply(corp2,content)

# 어근통일화(stemming)
install.packages("SnowballC")
library(SnowballC)
corp2 <- tm_map(corp2,stemDocument)
lapply(corp2,content)

mommi -> mommy 수정
#gsub('mommi','mommy',원시데이터변수)

corp2 <- tm_map(corp2,content_transformer(function(x) gsub('mommi','mommy',x)))
lapply(corp2,content)

★ 텍스트 구조화
- Bag-of-word (단어 주머니)에 의한 텍스트 구조화
- 텍스트를 단어의 집합으로 표현
- 단어의 순서나 문법은 무시되고 단어 빈도수만을 이용
- 문서-용어 행렬(Document - Term Matrix)은 단어주머니로부터 비구조화된 텍스트를 구조화된 데이터로 변환

      mommy love want say thank happy everyday give ...
문서1   1     1   0    1    1     0       0      0 
문서2   0     1   0    0    1     0       1      1 

# corpus -> 문서-용어행렬로 변환
corp1_dtm <- DocumentTermMatrix(corp1)
corp1_dtm
'''
<<DocumentTermMatrix (documents: 9, terms: 40)>> #360개의 셀
Non-/sparse entries: 57/303 #57개의 셀만 빈도수가 채워져있고 나머지303개는 0으로 채워져있다.
Sparsity           : 84% # 84(퍼센트)가 0으로 채워져있다.
Maximal term length: 10 #가장 긴 글자길이는 10글자
Weighting          : term frequency (tf)
'''
inspect(corp1_dtm) # 확인하기

corp2_dtm <- DocumentTermMatrix(corp2)
corp2_dtm
inspect(corp2_dtm)

# 단어수
nTerms(corp2_dtm)
nTerms(corp1_dtm)

# 단어
Terms(corp2_dtm)
Terms(corp1_dtm)

# 문서의 수 
nDocs(corp2_dtm)

# 문서의 이름
Docs(corp2_dtm)
rownames(corp2_dtm)

# 일부분만 확인
inspect(corp2_dtm)
inspect(corp2_dtm[1:3,1:5])

termfreq <- colSums(as.matrix(corp2_dtm)) #table함수처럼 결과가 나옴
termfreq
names(termfreq)

library(wordcloud) #wordcloud2는 데이터프레임으로 변환작업해야 사용가능
wordcloud(words=names(termfreq),freq=termfreq,
          min.freq=1, random.order=F,random.color=T,
          colors=brewer.pal(9,'Blues'))

termfreq_df <- data.frame(word=names(termfreq),freq=termfreq)
library(wordcloud2)
wordcloud2(termfreq_df)

library(ggplot2)
ggplot(data=termfreq_df,aes(x=reorder(word,freq),y=freq,fill=word))+
  geom_col(show.legend=F)+
  coord_flip()

[문제211] 미국 바이든 대통령 취임사 전문을 수집하셔서 말뭉치로 변환한 후 
정제작업을 통해 document-term matrix를 생성한 후 시각화 해주세요.

#-----------------------------첫번째 웹에서 불러와서 바로 실험
1. 웹에서 스크랩해오기 
library(rvest)
library(xml2)
html <-read_html('https://news.mt.co.kr/mtview.php?no=2021012104568299464',encoding='EUC-KR')
html
text <- html_nodes(html,'div#textBody')
xml2::xml_remove(text%>%html_nodes('table.article_photo')) # 이미지가 있는 table태그 제거
text <- text%>%html_text()

2. 말뭉치로 변환하기
corp <- VCorpus(VectorSource(text))
corp

corp[[1]]$meta
meta(corp[[1]],tag='author') <- 'biden'
meta(corp[[1]])
inspect(corp)
inspect(corp[1])
inspect(corp[[1]]) # 글내용, 글자개수 보여주기

3. 정제작업
library(stringr)
getTransformations()

#한글제거
corp1 <- tm_map(corp,content_transformer(function(x) str_replace_all(x,'[가-힣]+',' '))) 
inspect(corp1[[1]]) #확인
corp1[[1]]$content #확인

# 숫자제거
corp1 <- tm_map(corp1,removeNumbers)
corp1[[1]]$content

# 특수문자제거
corp1 <- tm_map(corp1,removePunctuation)
corp1[[1]]$content

corp1 <- tm_map(corp1,content_transformer(function(x) str_replace_all(x,'\n',' ')))
corp1[[1]]$content

corp1 <- tm_map(corp1,removeWords,'DC') #필요없는 단어 DC제거

# 공백제거
corp1 <- tm_map(corp1,content_transformer(trimws))
corp1[[1]]$content

# 모두 소문자로 변경
corp1 <- tm_map(corp1,content_transformer(tolower))
corp1[[1]]$content

# 둘 이상 공백 하나의 공백으로
corp1 <- tm_map(corp1,stripWhitespace)
corp1[[1]]$content

# 불용어 제거
corp2 <- tm_map(corp1,removeWords,tm::stopwords())
corp2[[1]]$content

# 둘 이상 공백 하나의 공백으로
corp2 <- tm_map(corp2,stripWhitespace)
corp2[[1]]$content

''' 안 바뀌어도 될 단어들이 너무 많이 바뀜
# 어근통일화
corp2 <- tm_map(corp2,stemDocument)
corp2[[1]]$content
'''

# document-term matrix로 변환
corp2_m <- DocumentTermMatrix(corp2)
inspect(corp2_m)

nTerms(corp2_m)
Terms(corp2_m)

# wordcloud
corpfreq <- colSums(as.matrix(corp2_m)) # corpus형태에서는 wordcloud를 만들 수 없기에 matrix형태로 변환
wordcloud(words=names(corpfreq),freq=corpfreq)

# wordcloud2
df <- data.frame(word=names(corpfreq),freq=corpfreq)
wordcloud2(df)

# barplot
ggplot(data=df,aes(x=df$word,y=df$freq))+
  geom_col()+
  coord_flip()

#------------- 두번째 txt로 data폴더에 저장하고 불러와서 실험하기
html <- read_html('https://news.mt.co.kr/mtview.php?no=2021012104568299464',encoding = 'EUC-KR')
text <- html_nodes(html,'div#textBody')
xml_remove(text%>%html_nodes('table.article_photo'))
xml_remove(text%>%html_nodes('div.util_box'))
text <- text%>%html_text()

write.csv(text,file='c:/data/biden_talking.csv',row.names = F )

biden <- readLines('c:/data/biden_talking.csv')

# 말뭉치
corp <- VCorpus(VectorSource(biden))
corp
corp[[10]]
inspect(corp[[10]])

# 정제작업
corp_t <- tm_map(corp,content_transformer(function(x) str_replace_all(x,'[가-힣]+','')))
lapply(corp_t,content)
sapply(corp_t,content)

corp_t <- tm_map(corp_t,removeNumbers)
lapply(corp_t,content)

corp_t <- tm_map(corp_t,removePunctuation)
lapply(corp_t,content)

corp_t <- tm_map(corp_t,removeWords,c('x','DC'))
lapply(corp_t,content)

corp_t<- tm_map(corp_t,content_transformer(trimws))
lapply(corp_t,content)

corp_t <- tm_map(corp_t,content_transformer(tolower))
lapply(corp_t,content)

corp_t <- tm_map(corp_t,removeWords,tm::stopwords('smart'))
lapply(corp_t,content)

corp_t <- tm_map(corp_t,stripWhitespace)
lapply(corp_t,content)

corp_t<- tm_map(corp_t,content_transformer(trimws))
lapply(corp_t,content)

'''
corp_t2 <- tm_map(corp_t,stemDocument)
lapply(corp_t2,content)
'''

corp_dtm <- DocumentTermMatrix(corp_t)
inspect(corp_dtm)

corp_dtm2 <- colSums(as.matrix(corp_dtm))
names(corp_dtm2)

wordcloud(words=names(corp_dtm2), freq=corp_dtm2)

df <- data.frame(word=names(corp_dtm2),freq=corp_dtm2)
df
wordcloud2(df)

#------------------------------------------r강사님
library(tm)
library(rvest)
library(stringr)

html <- read_html('https://www.whitehouse.gov/briefing-room/speeches-remarks/2021/01/20/inaugural-address-by-president-joseph-r-biden-jr/')
html

biden <- html_nodes(html,xpath='//*[@id="content"]/article/section/div/div/p')%>%
  html_text()

biden <- biden[c(-1,-2,-211,-212)]
head(biden)
tail(biden)

biden <- paste(biden,collapse=' ')
biden

write(biden,file='c:/data/biden_raw.txt')
readLines('c:/data/biden_raw.txt')

corpus.biden <- VCorpus(VectorSource(biden))
inspect(corpus.biden)
str(corpus.biden)

lapply(corpus.biden,content)

# 코퍼스 파일 저장
writeCorpus(corpus.biden,path='c:/data',filenames='corpus_biden.txt')

# 특정한 디렉토리에 있는 파일 조회
list.files(path='c:/data',pattern = '\\.txt')

#파일을 코퍼스로 읽어오는 방법
biden_corpus <- Corpus(URISource('c:/data/biden_raw.txt'))
biden_corpus
lapply(biden_corpus,content)

# 소문자변환
tm_map(biden_corpus,content_transformer(tolower)) # corpus에서 제공하는 메서드 외에 다른 메서드(함수)를 사용할 때 content_transformer(적용할함수) 사용
lapply(biden_corpus,content)

# 특수문자 오른쪽과 왼쪽의 문자들 체크
"i'm"
lapply(tm_map(biden_corpus,
              content_transformer(function(x) str_extract_all(x,'[A-z]+[[:punct:]]+[A-z]+'))),content) # 보기 불편함

lapply(biden_corpus,function(x) str_extract_all(x$content,'[A-z]+[[:punct:]]+[A-z]+')) # 보기 좋음

# 불용어 제거

biden_corpus <- tm_map(biden_corpus,removeWords,stopwords())
lapply(biden_corpus,function(x) str_extract_all(x$content,'[A-z]+[[:punct:]]+[A-z]+')) # 보기 좋음

tm::stopwords()[tm::stopwords() == "don't"]
tm::stopwords()[tm::stopwords() == "can’t"]

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("doesn’t | don’t | can’t",' ',x)))

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("co-workers",'coworkers',x)))

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("’s",' ',x)))

lapply(biden_corpus,function(x) str_extract_all(x$content,'[A-z]+[[:punct:]]+[A-z]+')) # 보기 좋음

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("[[:punct:]]",' ',x)))

lapply(biden_corpus,function(x) str_extract_all(x$content,'[[:punct:]]+')) 

# 숫자체크
lapply(biden_corpus,function(x) str_extract_all(x$content,'[^0-9\\s]*\\d+\\W\\d*')) 
<U+2013>
lapply(biden_corpus,function(x) str_extract_all(x$content,'<[A-z0-9\\+]+>'))   

# <U+2013> 형식 제거
biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub('<[A-z0-9\\+]+>',' ',x)))
lapply(biden_corpus,function(x) str_extract_all(x$content,'<[A-z0-9\\+]+>')) 

#biden_corpus <- tm_map(biden_corpus,removeNumbers) 숫자 전부제거(의미있는 숫자까지 전부)

# 연속되는 2개 이상의 공백을 하나의 공백으로 변환
biden_corpus <- tm_map(biden_corpus,stripWhitespace)
lapply(biden_corpus,content)

biden_dtm <- DocumentTermMatrix(biden_corpus)
biden_dtm
inspect(biden_dtm)
termfreq <- colSums(as.matrix(biden_dtm))

library(wordcloud)
wordcloud(words=names(termfreq),freq=termfreq)

library(wordcloud2)
termfreq_df <- data.frame(word=names(termfreq),freq=termfreq)
wordcloud2(df)

library(ggplot2)

top_50 <- head(termfreq_df[order(termfreq_df$freq,decreasing=T),],n=50)
top_50

ggplot(data=top_50,aes(x=reorder(word,freq),y=freq,fill=word))+
  geom_col(show.legend=F)+
  coord_flip()

Terms(biden_dtm) #단어추출

#최소 빈도수가 10 이상인 단어들만 추출
termfreq_df[termfreq_df$freq>=10,'word']

#lowfreq : 최소 이상 출현 횟수(빈도수)
tm::findFreqTerms(biden_dtm,lowfreq=10)

# highfreq : 최대 이하 빈도수
termfreq_df[termfreq_df$freq<10,'word']
tm::findFreqTerms(biden_dtm,highfreq=10)

termfreq_df[termfreq_df$freq>=10 & termfreq_df$freq<=15,]

tm::findFreqTerms(biden_dtm,lowfreq=10, highfreq=15)


★ 감성분석
감성분석(sentiment analysis) 또는 opinion mining은 텍스트에 내재 되어 있는
감정적 상태나 주관적 평가를 식별하고 추출하는 텍스트 분석 기법

install.packages("tidytext")
install.packages("textdata")
library(tidytext)
library(textdata)

# bing
tidytext::sentiments%>%
  head()

tidytext::sentiments%>%
  tail()

#bing
#positive, negative 분류
get_sentiments('bing')

get_sentiments('bing')$word
unique(get_sentiments('bing')$sentiment)

# afinn -5점(부정) ~ +5점(긍정)의 범위를 갖는 점수로 표현
get_sentiments('afinn')
get_sentiments('afinn')$word
unique(get_sentiments('afinn')$value)

# nrc
# 10개의 감성 상태 분류
#"trust"        "fear"         "negative"     "sadness"     "anger"        "surprise"     "positive"     "disgust"     "joy"          "anticipation"
get_sentiments('nrc')
get_sentiments('nrc')$word
unique(get_sentiments('nrc')$sentiment)

# loughran
# 6개의 감성 상태 분류, 금융분야의 텍스트에 적합
# "negative"     "positive"     "uncertainty"  "litigious"   "constraining" "superfluous"
get_sentiments('loughran')
get_sentiments('loughran')$word
unique(get_sentiments('loughran')$sentiment)

biden_sentiment <- merge(termfreq_df,get_sentiments('bing'),by='word')
head(biden_sentiment)
aggregate(word ~ sentiment,biden_sentiment,length)


biden_sentiment <- merge(termfreq_df,get_sentiments('nrc'),by='word')
head(biden_sentiment)
aggregate(word ~ sentiment,biden_sentiment,length)


[문제 212] 미국 트럼프 대통령 취임사 전문을 수집하셔서 말뭉치로 변환한 후 
정제 작업을 통해 document-term matrix를 생성한 후 시각화 하고 감성분석도 수행해보세요.

library(xml2)

1. 전문 수집(스크랩)
html <- read_html('https://www.joongang.co.kr/article/21157192#home')
trump <- html_nodes(html,xpath='//*[@id="article_body"]')%>%
  html_text()

# txt파일로 저장
write(trump,file='c:/data/trump_raw.txt')
trump <- readLines('c:/data/trump_raw.txt')
trump <- paste(trump,collapse=' ')

2. 말뭉치변환
trump_cor <- VCorpus(VectorSource(trump))

inspect(trump_cor)#확인
inspect(trump_cor[[1]])#내용확인

3. 전처리 작업
#한글 제거
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('[가-힣]+','',x)))
inspect(trump_cor[[1]])

#괄호안에 문자들이 있는 형식 제거
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('<[0-9A-z+\\+]+>','',x)))
inspect(trump_cor[[1]])

#이메일 제거
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('[a-z]+.[a-z]+@[a-z]+.[a-z]+','',x)))

#필요없는 앞 단락에 단어 제거
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('FTA','',x)))
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('US','',x)))

#숫자 제거
trump_cor <- tm_map(trump_cor,removeNumbers)
inspect(trump_cor[[1]])

# 불용어 제거
trump_cor <- tm_map(trump_cor,removeWords,tm::stopwords())
inspect(trump_cor[[1]])

trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub("It\\'s" ,'',x)))
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub("\\'s" ,'',x)))

lapply(trump_cor,function(x) str_extract_all(x$content,"\\w+\\'s ")) #확인하기

#특수문자제거
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('[[:punct:]]',' ',x)))
inspect(trump_cor[[1]])

#공백 2개이상을 하나의 공백으로 변환
trump_cor <- tm_map(trump_cor,stripWhitespace)
inspect(trump_cor[[1]])

#소문자로 변환
trump_cor <- tm_map(trump_cor,content_transformer(tolower))
inspect(trump_cor[[1]])

4. document-term matrix 변환
trump_dtm <- DocumentTermMatrix(trump_cor)
inspect(trump_dtm)

5. 시각화 
trump_dtm <- colSums(as.matrix(trump_dtm)) # matrix형태로 변환해야 wordcloud생성 가능

wordcloud(word=names(trump_dtm),freq=trump_dtm,
          random.order = F, random.color = T,
          colors = rainbow(length(trump_dtm)))

trump_df <- data.frame(word=names(trump_dtm),freq=trump_dtm)
wordcloud2(trump_df)

library(dplyr)
trump_df2 <- trump_df%>%
  arrange(desc(freq))%>%
  filter(freq>=6)

ggplot(data=trump_df2,aes(x=reorder(word,freq),y=freq,fill=word))+
  geom_col(show.legend=F)+
  coord_flip()

6. 감성분석
trump_sentiment <- merge(trump_df,get_sentiments('bing'),by='word')
aggregate(word ~ sentiment,trump_sentiment,length)


[문제213] 트럼프, 바이든 긍정단어를 이용해서 compare wordcloud 생성해주세요.
biden_sentiment
trump_sentiment

          biden  trump
긍정단어 빈도수 빈도수
# 각 데이터프레임에서 긍정만 추출
biden_p <- biden_sentiment[biden_sentiment$sentiment=='positive',]
trump_p <- trump_sentiment[trump_sentiment$sentiment=='positive',]

#겹치지 않도록 freq 열의 이름을 변경
names(biden_p)[2] <- 'biden'
names(trump_p)[2] <- 'trump'

# merge함수로 조인
#merge(biden_p,trump_p,by=c('sentiment','word')) 이렇게 조인하면 나머지 긍정단어들이 안나옴
biden_trump <- merge(biden_p,trump_p,by=c('sentiment','word'),all.x = T,all.y = T)
biden_trump[is.na(biden_trump$biden),'biden'] <- 0 #na값은 0으로 변환
biden_trump[is.na(biden_trump$trump),'trump'] <- 0 #na값은 0으로 변환

biden_trump <- biden_trump[,c('word','biden','trump')]
biden_trump

# word가 행이름으로 가도록 하기 (compare wordcloud생성하기위한 구조)
rownames(biden_trump) <- biden_trump$word
biden_trump <- biden_trump[,c('biden','trump')]
biden_trump

#compare wordcloud 생성
windows(width = 13,height=13)
wordcloud::comparison.cloud(biden_trump, random.order = F,
                            colors=brewer.pal(3,"Set1"),
                            title.colors = 'black',
                            title.bg.colors = 'white',
                            scale = c(3,0.5),
                            rot.per=0.001)

#-----------------------트럼프대통령의 연설 원문만 write 하기 버전

html <- read_html('https://www.joongang.co.kr/article/21157192#home')
html_nodes(html,'div.article_body')

#연설 내용 원문,한글버전에서 원문만 스크랩하기
trump_test <- c()
for(i in 27:54){
  trump_test <- c(trump_test,html_nodes(html,xpath=paste0('//*[@id="article_body"]/p[',i,']'))%>%
    html_text()) #p태그 1~26까지는 원문 해석본, 27~54까지 원문
}
trump_test

trump_test <- paste(trump_test,collapse=' ')
trump_test
write(trump_test,file='c:/data/trump_talking.txt')
trump_test <-readLines('c:/data/trump_talking.txt')

#말뭉치 변환
trump_corpus <- VCorpus(VectorSource(trump_test))
inspect(trump_corpus[[1]])

# 숫자 제거
trump_corpus <- tm_map(trump_corpus,removeNumbers)
trump_corpus[[1]]$content

# 불용어 제거
trump_corpus <- tm_map(trump_corpus,removeWords,stopwords())
trump_corpus[[1]]$content

# 's 제거------------------------진행중
tm_map(trump_corpus,content_transformer(function(x) gsub()))

# 특수문자 제거
trump_corpus <- tm_map(trump_corpus,removePunctuation)
trump_corpus[[1]]$content

[문제213 다시] 트럼프, 바이든 긍정단어를 이용해서 compare wordcloud 생성해주세요. 다시
d <- rbind()
biden_p$sentiment <- 'biden'
trump_p$sentiment <- 'trump'
names(biden_p)[2] <- 'freq'
names(trump_p)[2] <- 'freq'
biden_trump2 <- rbind(biden_p,trump_p)
biden_trump2 <- acast(biden_trump2,word~sentiment,value.var='freq',fill=0)

wordcloud::comparison.cloud(biden_trump2)

.



                            
'''
if(require(tm)){
  data(SOTU)
  corp <- SOTU
  corp <- tm_map(corp, removePunctuation)
  corp <- tm_map(corp, content_transformer(tolower))
  corp <- tm_map(corp, removeNumbers)
  corp <- tm_map(corp, function(x)removeWords(x,stopwords()))
  
  term.matrix <- TermDocumentMatrix(corp)
  term.matrix <- as.matrix(term.matrix)
  colnames(term.matrix) <- c("SOTU 2010","SOTU 2011")
  comparison.cloud(term.matrix,max.words=40,random.order=FALSE)
  comparison.cloud(term.matrix,max.words=40,random.order=FALSE,
                   title.colors=c("red","blue"),title.bg.colors=c("grey40","grey70"))
  comparison.cloud(term.matrix,max.words=40,random.order=FALSE,
                   match.colors=TRUE)
  
}
'''

#-----------------------------------강사님
//*[@id="main"]/div[2]/div/article/div[1]/section[2]/div/div

html <- read_html('https://www.politico.com/story/2017/01/full-text-donald-trump-inauguration-speech-transcript-233907')
trump <- html_nodes(html,xpath='//*[@id="main"]/div[2]/div/article/div[1]/section[2]/div/div/p')%>%
  html_text()
trump <- paste(trump,collapse=' ')

trump_corpus <- VCorpus(VectorSource(trump))
lapply(trump_corpus,content)

# 소문자 변환
trump_corpus <- tm_map(trump_corpus,content_transformer(tolower))
lapply(trump_corpus,content)

# 불용어 제거
trump_corpus <- tm_map(trump_corpus,removeWords,stopwords())
lapply(trump_corpus,content)

# 특수문자 제거
trump_corpus <- tm_map(trump_corpus,removePunctuation)
lapply(trump_corpus,content)

# 숫자 제거
trump_corpus <- tm_map(trump_corpus,removeNumbers)
lapply(trump_corpus,content)

# 공백 조절
trump_corpus <- tm_map(trump_corpus,stripWhitespace)

trump_dtm <- DocumentTermMatrix(trump_corpus)
trump_freq <- colSums(as.matrix(trump_dtm))

trump_df <- data.frame(word=names(trump_freq),freq=trump_freq)

trump_sentiment <- merge(trump_df,get_sentiments('bing'),by='word')

#compare wordcloud

head(biden_sentiment)
head(trump_sentiment)

trump_df <- trump_sentiment[trump_sentiment$sentiment=='positive',]
biden_df <- biden_sentiment[biden_sentiment$sentiment=='positive',]

trump_df
biden_df

trump_df$president <- 'trump'
biden_df$president <- 'biden'

trump_df$sentiment <- NULL # 열삭제
biden_df$sentiment <- NULL

trump_biden <- rbind(trump_df,biden_df)
trump_biden

trump_biden <- acast(trump_biden,word~president,value.var = 'freq',fill=0)

wordcloud::comparison.cloud(trump_biden,
                            colors=c('blue','red'),
                            title.bg.colors = 'white',
                            title.size = 3,
                            title.colors = c('blue','red'),
                            scale = c(2,0.5))

#--------------------------------------------------------

Sys.getenv('JAVA_HOME')
library(rJava)

install.packages("openNLP")
library(openNLP)
library(NLP)

text <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing."
text
nchar(text)

# NLP::annotate() : 텍스트 데이터에 주석 작업을 수행하는 함수
# openNLP::Maxent_Sent_Token_Annotator() : 문장단위 주석작업을 하는 함수
# openNLP::Maxent_Word_Token_Annotator() : 단어단위 주석작업을 하는 함수
# openNLP::Maxent_POS_Tag_Annotator() : 품사태깅하는 함수

text_sent <- NLP::annotate(text, openNLP::Maxent_Sent_Token_Annotator())
text_word <- NLP::annotate(text, openNLP::Maxent_Word_Token_Annotator(),text_sent)
postag <- NLP::annotate(text,openNLP::Maxent_POS_Tag_Annotator(),text_word)


id type     start end features
1 sentence     1 153 constituents=<<integer,23>>
  2 word         1   1 POS=NN #1번째 인덱스, 단수명사
3 word         3   4 POS=VBZ #3인칭 현재형 단수동사
4 word         6   6 POS=DT # 한정사
5 word         8  18 POS=NN
6 word        20  27 POS=NN
7 word        29  31 POS=CC # 등위접속사
8 word        33  36 POS=JJ # 형용사
9 word        38  45 POS=NN
10 word        47  57 POS=NN
11 word        59  61 POS=IN # 전치사
12 word        63  73 POS=JJ
13 word        75  83 POS=NN
14 word        85  87 POS=CC
15 word        89  96 POS=NNS # 복수명사
16 word        98 106 POS=VBN # 과거진행형
17 word       108 109 POS=IN
18 word       111 113 POS=DT
19 word       115 115 POS=NN
20 word       117 126 POS=NNP #단수대명사
21 word       128 130 POS=IN
22 word       132 142 POS=NNP
23 word       144 152 POS=NNP
24 word       153 153 POS=.

NNPS : 복수대명사
NNP : 단수대명사
JJR : 비교급 형용사
JJS : 최상급 형용사
MD : 조동사
...

[문제214] text변수에 있는 문장에서 명사(NN), 복수명사(NNS), 단수대명사(NNP)를 추출해주세요.
class(postag)

postag_df <- data.frame(postag[postag$type=='word'])
str(postag_df)
postag_df$features <- unlist(postag_df$features)
postag_df

pos_nn <- postag_df[postag_df$features %in% c('NN','NNS','NNP'),]

p <- c()
for(i in 1:nrow(pos_nn)){
  p <- c(p, substr(text,pos_nn$start[i],pos_nn$end[i]))
}
p

