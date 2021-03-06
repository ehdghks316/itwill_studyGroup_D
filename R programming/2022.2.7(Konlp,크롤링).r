★ 텍스트 전처리 과정
1. 토큰화(Tokenization) : 텍스트를 정해진 단위로 나누는 작업
- 단어 : 빈칸을 기준으로 나눈다.
- 형태소 : 의미를 가지는 최소단위, 품사를 기준으로 나누는 작업
- 글자 : 한글자기준으로 나누는 작업
- 초송(자음), 중성(모음), 종성(자음)

2. 불용어 처리(stopword)
- 의미없는 단어를 제거하는 작업

3. 의미없는 특수문자, 숫자 제거
s&p - > sandp
sandp -> s&p
...

4. 대소문자 통일
Trump - > Trump_unique
...

5. 어근추출
- 단어 표현에 대한 통일 작업을 해야한다.
예) 놀아요, 놀아, 놀고싶어요, 놀다왔어요 -> 놀다.
- Lemmatization : 사전적으로 표현
- Stemming : 알고리즘을 통해서 기계적으로 변환, 신조어, 은어

6. 텍스트 인코딩 : 텍스트를 벡터로 표현
- Bag of Words, tf-idf

★ KONLP

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

library(KoNLP)
#useSejongDic()
useNIADic()

text <- 'R은 오픈소스로 통계, 기계학습, 금융, 생물정보학, 그래픽스에 이르는 다양한 통계 패키지를 갖추는 좋은 프로그램이다.'

●명사 추출
extractNoun(text)

● 품사태깅
?SimplePos09
SimplePos09(text)

SimplePos22(text)

[문제204] SimplePos22(text) 품사태깅의 보통명사만 추출해주세요.
SimplePos22(text)

library(stringr)

a <- unlist(str_extract_all(SimplePos22(text), '\\w+\\WNC'))
#a <- unlist(str_extract_all(SimplePos22(text), '[가-힣]+/NC'))

gsub('\\WNC','',a)
str_replace_all(a,'\\WNC','')
#str_replace_all(a,'/NC','')

unlist(str_match_all(SimplePos22(text),'[가-힣]+/NC'))
as.vector(na.omit(str_match(SimplePos22(text),'[가-힣]+/NC')))

[문제205]review$tagging 열을 생성해서 감상평에 대한 품사 태깅정보가 입력되도록 하세요.

review <- read.csv('c:/data/review.txt')
review
View(review)
str_extract_all(review$감상평,'\n|\t')
review$감상평 <- str_replace_all(review$감상평,'\n|\t','')
review$감상평 <- str_replace_all(review$감상평,'해적: 도깨비 깃발별점 - 총 10점 중','')
review$감상평
review$점수 <- str_extract_all(review$감상평,'^\\d{1,2}')
review$감상평 <- str_replace_all(review$감상평,'^\\d{1,2}','')
review$감상평 <- gsub('신고$','',review$감상평)
x <- SimplePos22(review$감상평)

paste(unlist(x[1]),collapse=' ')
review$tagging <- sapply(x,function(arg){paste(unlist(arg),collapse=' ')})

View(review)

review$noun <- review$tagging 내용중에 보통명사만 추출해서 새로운 열에 저장
a <- str_extract_all(review$tagging,'[가-힣]+/NC')
review$noun <- sapply(a,function(arg){paste(str_replace_all(arg,'/NC',''),collapse = ' ')})
#review$noun <- sapply(a,function(arg){paste(unlist(arg),collapse = ' ')})
#review$noun <- str_replace_all(review$noun,'/NC','')
View(review)


★ 크롤링(crawling)
- 자동화된 방법으로 웹을 탐색하는 컴퓨터프로그램
- 인터넷 사이트의 웹페이지를 수지해서 분류하는 프로그램


★ 스크래핑(scraping)
- 웹브라우저 화면에 표시되는 html문서에서 사용자가 필요한 정보만 추출하여 수집하는 기술

1. 사용자가 웹브라우저의 주소창에서 url을 입력한다.
2. request : 웹브라우저는 요청한 메시지를 작성해 웹서버로 전송한다. 
3. response : 웹서버는 요청받는 정보를 클라이언트에게 보낸다.(HTML)
4. 웹브라우저는 응답메시지를 해석해 사용자에게 정보를 출력한다.


install.packages('rvest')
library(rvest)

html <- rvest::read_html("https://www.joongang.co.kr/article/25045987")
html

str_extract_all(html,'<title>.+</title>') # 나옴
str_extract_all(html,'<body>.+</body>') # 안나옴

html_node(html,'title') #title이라는 테그 처음으로 나오는 하나만 출력
html_nodes(html,'title') #

html_node(html,'p') # 처음p태그만 찾는다.
html_nodes(html,'p') # p 태그 전부를 찾는다.

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

# 인코딩(encoding) ASCII문자(16진값)
인공지능 -> %EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5 
#ELZHELD (decoding)
인공지능 <- %EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5 

# 특정한 뉴스 기사 검색의 url 수집
html <- rvest::read_html("https://www.joongang.co.kr/search?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5") #웹서버하고 request, response작업
html # r에서 동작(웹서버x)

url <- html_nodes(html,'h2.headline')%>%
  html_nodes('a')%>% #h2태그안에 a라는 테그만 뽑아오기
  html_attr('href') #href라는 속성만 뽑아내기(주소)

length(url)

# 수집된 url을 이용해서 본문 뉴스 내용 수집

news <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  
  temp <- html_nodes(html,'div.article_body.fs3')%>%
    html_text()
  news <- c(news,temp)
  Sys.sleep(2) #웹서버에 부하를 주지 않기위해서 조금씩 뜸을 주기
}

str_trim(news[1])
news

write(str_trim(news),'c:/data/news.txt')

ai_news <- readLines('c:/data/news.txt')
ai_news


[문제206] 동아일보 '인공지능' 뉴스기사 검색을 통해 본문기사 내용을 donga_ai.txt로 저장하고
본문 뉴스 기사 내용을 명사만 추출해서 wrodcloud로 시각화 해주세요. 단 뉴스기사는 5페이지까지
https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=16&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=31&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=46&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=61&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1


html <- read_html('https://www.donga.com/news/search?check_news=1&more=1&sorting=1&range=1&search_date=&v1=&v2=&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5')
html

html_nodes(html,'p.tit')%>%
  html_nodes('a')%>% # pdf파일의 주소까지 가져와버림 거기에도 a테그로 되어있기때문
  html_attr('href')

url <- html_nodes(html,'p.tit')%>%
  html_node('a')%>%
  html_attr('href')

url[1]


웹사이트에서 원하는 페이지에 있는 기사들을 추출하고 싶다. 웹사이트의 주소를 확인 -> 
  주소를 read_html함수를 사용해서 읽어오기 ->
  웹사이트에서 f12번키를 눌러서 기사가 어떤 태그를 사용하여 작성되어있는지 확인 
기사들마다 보통 같은 태그를 이용하기때문에 태그를 확인 

#기사 첫 페이지 읽어와서 html변수에 저장  
html <- read_html('https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')
#기사 나머지2,3,4,5페이지 읽어와서 html변수에 저장
for(i in 1:4){
  html <- c(html,read_html(paste0('https://www.donga.com/news/search?p=',1+i*15,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')))
  Sys.sleep(2)

}

html

# 주소만 추출하는 정제작업
url <- html_nodes(html,'p.tit')%>%
  html_nodes('a')%>%
  html_attr('href')
#url들어가서 맞는지 확인
url[1]

#각 주소별로 기사들 수집하는 작업
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
donga_ai <- str_replace_all(donga_ai,'Copyright ⓒ 동아일보 & donga.com','')
SimplePos22(donga_ai)

write(str_trim(news),'c:/data/donga_ai.txt')
readLines('c:/data/donga_ai.txt')


#------------------------------------------------------------------2022.2.8 /강사님
library(rvest)
url <- c()
for(i in seq(1,61,by=15)){
  url_text <- paste0('https://www.donga.com/news/search?p=',i,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')
  html <- read_html(url_text)
  temp <- html_nodes(html,'p.tit')%>%
    html_node('a')%>%
    html_attr('href')
  
  url <- c(url,temp)
  
  #print(i'개 기사 추출')
  Sys.sleep(1)
}

html <-read_html(url[4])
article <- html_node(html,'div.article_txt') #div.article_txt안에는 잡다한 div,필요없는 광고성 이미지나 글자들이 있다

html_nodes(article,'div')

article%>%html_nodes('div') # 필요없는 테그들

library(stringr)
library(xml2)
●xml2::xml_remove() : 특정한 태그를 제거할 때 사용하는 함수, 제거해서 바로 적용된다.

xml2::xml_remove(article%>%html_nodes('div')) #변수에 저장안해도 바로 적용이됨, xml형식에서 article변수에 있는 필요없는 div테그들 다 삭제
article%>%html_nodes('div')
article%>%html_text()
str_trim(article%>%html_text()) # 공백문자 제거
txt <-str_trim(article%>%html_text())
str_extract_all(txt,'\\[서울=뉴시스\\]')
str_replace_all(txt,'\\[서울=뉴시스\\]','')

txt
"전남혁 기자 forward@donga.com"
"동아닷컴 IT전문 권택경 기자 tikitaka@donga.com"
str_extract_all(txt,'[^\\.]+ [A-z0-9._]+@[A-z0-9._]+')

news <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  article <- html_node(html,'div.article_txt')
  xml2::xml_remove(article%>%html_nodes('div'))
  text <- article%>%html_text()
  text <- str_trim(text)  
  text <- str_replace_all(text,'\\[서울=뉴시스\\]','')
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

str_match(ai_pos,'([가-힣]+)/N') # '[가-힣]+/N', [가-힣]+ -> 괄호를 사용해서 둘다 추출함'/N'을 제거 안해도 됨
word <- str_match(ai_pos,'([가-힣]+)/N')[,2]
word <- word[nchar(word) >= 2]
word_df <- data.frame(table(word))
names(word_df)

library(wordcloud2)
wordcloud2(word_df)


news <- readLines('c:/data/donga_ai.txt')
grep('르완다',,news)


[문제207] 네이버에서 영화리뷰정보를 수집한 후 데이터프레임으로 저장해주세요.
컬럼은 id, date, point,comment로 생성해주세요.
#--------------------1페이지만!!!
html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after')
html <- html_nodes(html,'tbody')%>%
  html_nodes('tr')

# 번호 (id)
id <- html_nodes(html,'td.ac.num')

id <- unlist(str_extract_all(id,'[0-9]+'))

# 평점 (point)
point <- html_nodes(html,'td.title')%>%
  html_nodes('div.list_netizen_score')%>%
  html_nodes('em')

point <- unlist(str_extract_all(point,'[0-9]+'))

# 감상평(comment)????????
html_nodes(html,'td.title')
xml_remove(html_nodes(html,'td.title')%>%html_nodes('a'))
xml_remove(html_nodes(html,'td.title')%>%html_nodes('div'))
comment <- str_trim(html_nodes(html,'td.title')%>%html_text())

# 글쓴이
author <- html_nodes(html,'td.num')%>%
  html_nodes('a.author')

author <- unlist(str_extract_all(author,'\\w{4}\\*{4}'))

# 날짜
date <- html_nodes(html,'td.num')
date <- unlist(str_extract_all(date,'\\d{2}\\.\\d{2}.\\d{2}'))

movie_df <- data.frame(id = id,
           point = point,
           comment=comment,
           author = author,
           date = date)
View(movie_df)

#----------------------------10페이지까지
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after&page=',i))
  # 번호 (id)
  id <- html_nodes(html,'td.ac.num')
  
  id <- unlist(str_extract_all(id,'[0-9]+'))
  
  # 평점 (point)
  point <- html_nodes(html,'td.title')%>%
    html_nodes('div.list_netizen_score')%>%
    html_nodes('em')
  
  point <- unlist(str_extract_all(point,'[0-9]+'))
  
  # 감상평(comment)????????
  #paste(html_nodes(html,'td.title'),collapse = ' ')
  html_nodes(html,'td.title')
  xml_remove(html_nodes(html,'td.title')%>%html_nodes('a'))
  xml_remove(html_nodes(html,'td.title')%>%html_nodes('div'))
  comment <- str_trim(html_nodes(html,'td.title')%>%html_text())
  
  # 글쓴이
  author <- html_nodes(html,'td.num')%>%
    html_nodes('a.author')
  
  author <- unlist(str_extract_all(author,'\\w{4}\\*{4}'))
  
  # 날짜
  date <- html_nodes(html,'td.num')
  date <- unlist(str_extract_all(date,'\\d{2}\\.\\d{2}.\\d{2}'))
  
  movie <- rbind(movie,data.frame(id=id,point=point,comment=comment,author=author,date=date))
}

View(movie)

#--------------------------강사님 답
html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after&page=1')

#id추출
id <- html_nodes(html,'td.num > a')%>%
  html_text()

#날짜 추출
x <- html_nodes(html,'td.num')%>%
  html_text()

date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))

#z <- unlist(str_extract_all(x,'\\w{1,}\\*{1,}\\d{2}\\.\\d{2}\\.\\d{2}'))
#id <- unlist(str_extract_all(z,'\\w{1,}\\*{1,}'))
#date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))

# 평점 추출
point <- html_nodes(html,'div.list_netizen_score > em')%>%
  html_text()

# 감상평 추출
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


#-------------------------1~10페이지 강사님답
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=194204&target=after&page=',i))
  #id추출
  id <- html_nodes(html,'td.num > a')%>%
    html_text()
  
  #날짜 추출
  x <- html_nodes(html,'td.num')%>%
    html_text()
  
  date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))
  
  #z <- unlist(str_extract_all(x,'\\w{1,}\\*{1,}\\d{2}\\.\\d{2}\\.\\d{2}'))
  #id <- unlist(str_extract_all(z,'\\w{1,}\\*{1,}'))
  #date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))
  
  # 평점 추출
  point <- html_nodes(html,'div.list_netizen_score > em')%>%
    html_text()
  
  # 감상평 추출
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

# 긍정,부정, tagging, wordcloud까지 그려보기

movie$evaluation <- ifelse(movie$point >= 8,'긍정','부정')
View(movie)
movie$tagging <- sapply(SimplePos09(movie$comment),
                        function(arg){paste(unlist(arg),collapse=' ')})

x <- str_match(movie$tagging,'([가-힣]+)/N')[,2]
x <- data.frame(table(na.omit(x)))
wordcloud2(x,backgroundColor = 'black')

# 긍정,부정, tagging, wordcloud까지 그려보기 강사님
pos <- SimplePos22(movie$comment)
movie$tagging <- sapply(pos,function(x){paste(unlist(x),collapse=' ')})

noun <- sapply(movie$tagging,function(x){str_match_all(x,'([가-힣]+)/NC')})
movie$noun <- sapply(noun,function(x){paste(unlist(x)[,2],collapse=' ')})

View(movie)

movie$point <- as.integer(movie$point)
movie$evaluation <- ifelse(movie$point >= 8, '긍정','부정')  
View(movie)

positive <- movie[movie$evaluation == '긍정','noun']
negative <- movie[movie$evaluation == '부정','noun']

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
1   간만    1        0
2   감상    1        5   
#위의 데이터를 밑에 처럼 변환
      positive negative
간만      1       9
감상      1       5
강하늘    5       2
      
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
