
● 페이지를 바꾸는데 주소가 변하지 않을 때 그주소로 스크래핑을 할 수 없는데 다른 방법이있다.
f12에 네트워크에 name,preview에서 찾아야한다. 찾아서 header에 있는 주소를 복사해서 사용
그런데 웹페이지 복사해서 들어갔을 때 1페이지에서 2페이지 갔다가 다시 1페이지 가면 주소가 바뀌는데 그 주소를 사용하자

https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false
https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1

★ css선택자 사용방법
library(rvest)
library(stringr)
# 주소로 요청하고 응답받음
html <- read_html('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1')

# div태그에 score_reple클래스를 가져오는데 text만 가져오기
review <- html_nodes(html,'div.score_reple')%>%
  html_text()

# 공백 지우기(제일 앞과 뒤를 지우기)
trimws(review) 
str_trim(review)

#\n\t\r 지우기
review <- str_trim(review)
#gsub('\n|\t|\r',' ',review)
review <- str_replace_all(review,'\n|\t|\r',' ')

# 제일 앞에 관람객과 제일 뒤에 신고 단어 삭제
review <- gsub('^관람객',' ',review)
review <- gsub('신고$',' ',review)
review <- str_trim(review)

# 2개이상의 공백을 하나의 공백으로 변환
#gsub('\\s{2,}',' ',review)
review <- str_squish(review)

#아이디 날짜,시간 전부 수집하기 , 감상평까지
룰루비(lulu****) 2022.01.27 22:36
#str_extract_all(review,'[^[:space:]]\\w+\\(\\w{4}\\*{4}\\) \\d{4}.\\d{2}.\\d{2} \\d{2}:\\d{2}')
x <- str_extract_all(review,'\\w+\\(.+\\)\\s\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}')

id <- str_extract(x,'\\w+\\(.+\\)')
date <- str_extract(x,'\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}')
review <- str_replace_all(review,'\\w+\\(.+\\)\\s\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}','')

# ㅠㅠ , . ! ㅎㅎ 이런 것들 제거하기
review <- str_replace_all(review,'[ㄱ-ㅎㅏ-ㅣ\\.,!?]',' ')

#str_replace_all(review,'[^가-힣]',' ') 한글이 아닌 것 제거

# 평점 수집  - div태그에 star_score클래스에 있는 em태그에서 text만 뽑기
point <- html_nodes(html,'div.star_score > em')%>%
  html_text()

View(data.frame(id=id,date=date,point=point,review=review))

#---------------------------------------------------------------



★ xpath 사용 방법

html <- read_html('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1')

● 절대경로를 이용해서 검색 (xpath) , 요소선택해서 copy XPath 붙여넣기

#html_node(html,xpath='/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span') <span>앞의 span까지 나옴 주의 </span>
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span')
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[2]/div[2]/dl/dt/em[1]/a/span')
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[3]/div[2]/dl/dt/em[1]/a/span')

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[1]/a/span')%>%
  html_text() #li인덱스를 지우면 모든 li를 찾아옴(아이디 값 다 찾아오기)

/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span
/html/body/div/div/div[5]/ul/li[5]/div[2]/dl/dt/em[1]/a/span

● 상대경로를 이용해서 검색

html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[1]/a/span')%>%
  html_text() # div class이름이 score_reple인 것을 찾겠다 -> div[@class] -> class가 아닌 id면 id로


# 날짜 추출

/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[2]
/html/body/div/div/div[5]/ul/li[2]/div[2]/dl/dt/em[2]

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[2]')%>%
  html_text()

html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[2]')%>%
  html_text()

# 평점 추출
/html/body/div/div/div[5]/ul/li[1]/div[1]/em
/html/body/div/div/div[5]/ul/li[2]/div[1]/em

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[1]/em')%>%
  html_text()

html_nodes(html,xpath='//div[@class="star_score"]/em')%>%
  html_text()


# 리뷰 추출

  # copy xpath 했는데 상대경로, 아이디 값도 틀림
//*[@id="_unfold_ment0"]/a #첫번째 리뷰
//*[@id="_filtered_ment_1"]/text() # 두번째리뷰

# 절대경로 (copy full XPath)
/html/body/div/div/div[5]/ul/li[1]/div[2]/p/span[2]/span/a
/html/body/div/div/div[5]/ul/li[2]/div[2]/p/span[2]/text()
/html/body/div/div/div[5]/ul/li[3]/div[2]/p/span[2]/text()

review <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/p/span[2]')%>%
  html_text()

trimws(review)


review <- html_nodes(html,xpath='//div[@class="score_reple"]/p/span[2]')%>%
  html_text()

trimws(review)

[문제207] 네이버에서 영화리뷰정보를 수집한 후 데이터프레임으로 저장해주세요.
컬럼은 id, date, point,comment로 생성해주세요.

html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=3')

(1) xpath를 이용해서 데이터 수집하세요.

#글쓴이 
//*[@id="old_content"]/table/tbody/tr[1]/td[3]/a # 1번째 글쓴이, xpath
//*[@id="old_content"]/table/tbody/tr[2]/td[3]/a # 2번째 글쓴이, xpath
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[3]/a # 1번째 글쓴이, full xpath
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[3]/a # 2번째 글쓴이, full xpath

id <- html_nodes(html,xpath='//td[@class="num"]/a')%>%
  html_text()

# 날짜
//*[@id="old_content"]/table/tbody/tr[1]/td[3]/text()
//*[@id="old_content"]/table/tbody/tr[2]/td[3]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[3]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[3]/text()

date <- html_nodes(html,xpath='//td[@class="num"]/text()')%>%
  html_text()
  
# 감상평
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
comment <- str_repalce_all(comment,'[ㄱ-ㅎㅏ-ㅣ]',' ')
comment <- str_replace_all(comment,'//s{2,}',' ')
#str_extract_all(comment,'\\.|\\?')

# 평점
//*[@id="old_content"]/table/tbody/tr[1]/td[2]/div/em
//*[@id="old_content"]/table/tbody/tr[2]/td[2]/div/em
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[2]/div/em
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[2]/div/em

point <- html_nodes(html,xpath='//div[@class="list_netizen_score"]/em')%>%
  html_text()

# 데이터프레임
View(data.frame(id=id,point=point,comment=comment,date=date))

#--------10페이지까지 

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
  comment <- str_replace_all(comment,'[ㄱ-ㅎㅏ-ㅣ]',' ')
  comment <- str_replace_all(comment,'//s{2,}',' ')
  
  temp <- data.frame(id=id,point=point,comment=comment,date=date)
  movie <- rbind(movie,temp)
  Sys.sleep(1)
}
View(movie)


(2) 수집한 내용을 형태소 분석을 해보세요.
library(KoNLP)
useNIADic()
x <- SimplePos09(movie$comment)
movie$tagging1 <- sapply(x, function(arg){paste(unlist(arg),collapse=' ')})
movie$tagging2 <- sapply(str_match_all(movie$tagging1,'(\\w+)/N'),function(arg){paste(unlist(arg)[,2],collapse=' ')})
View(movie)

(3) 평점을 기준으로 1~4 부정, 5~7 중립, 8~10 긍정으로 레이블을 생성해주세요.
movie$evaluation <- ifelse(movie$point >= 8,'긍정',ifelse(movie$point>=5,'중립','부정'))
View(movie)

(4) 레이블을 기준으로 명사만compare wordcloud를 생성해주세요.

pos <- movie[movie$evaluation == '긍정','tagging2']
neg <- movie[movie$evaluation == '부정','tagging2']
mid <- movie[movie$evaluation == '중립','tagging2']

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


#--------------------------강사님
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
unlist(str_extract_all(movie$review,'[ㄱ-ㅎㅏ-ㅣ\\.,!?]'))
unlist(str_extract_all(movie$review,'CG|cg'))

movie$review <- str_replace_all(movie$review,'[ㄱ-ㅎㅏ-ㅣ\\.,!?]',' ')
movie$review <- str_replace_all(movie$review,'CG|cg','그래픽')
movie$review <- str_squish(movie$review)
movie$review

library(KoNLP)
useNIADic()

pos <- SimplePos22(movie$review)
pos

noun <- str_match_all(pos,"([가-힣]+)/NC")
noun[[1]][,2]
movie$review[1]

#한 사람이 쓴 감상평에 똑같은 단어가 너무 많을 때 대표 단어들만(유니크한 단어)뽑겠다 -> 무조건 하는 것은 아님 상황에 따라 판단
noun_unique <- sapply(noun,unique)
noun_unique[[1]][,2]
noun
movie$noun <- sapply(noun,function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse=' ')) # 2글자 이상만 뽑겠다.
View(movie)

str(movie)
movie$point <- as.integer(movie$point)
str(movie)
movie$evaluation <- ifelse(movie$point>=8,'긍정',ifelse(movie$point>=5 & movie$point<=7,'중립','부정'))

positive <- movie[movie$evaluation=='긍정','noun']
negative <- movie[movie$evaluation=='부정','noun']
neutral <- movie[movie$evaluation=='중립','noun']

head(sort(table(unlist(strsplit(positive,' '))),decreasing=T))
head(sort(table(unlist(strsplit(negative,' '))),decreasing=T))

positive_df <- data.frame(table(unlist(strsplit(positive,' '))))
negative_df <- data.frame(table(unlist(strsplit(negative,' '))))
neutral_df <- data.frame(table(unlist(strsplit(neutral,' '))))

names(positive_df) <- c('word','freq')
names(negative_df) <- c('word','freq')
names(neutral_df) <- c('word','freq')

positive_df$sentiment <- '긍정'
negative_df$sentiment <- '부정'
neutral_df$sentiment <- '중립'

head(positive_df)
head(negative_df)
head(neutral_df)

df <- rbind(positive_df,negative_df,neutral_df)
head(df)
tail(df)

library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq',fill=0) #acast(데이터,행으로갈거~열로갈거,value.var=들어갈 값들,fill=값이 없을 때 들어갈 값)
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
  slice_max(freq) # slice_max : 빈도수가 제일 높은 값들만 추출

df%>%
  group_by(sentiment)%>%
  mutate(rank=dense_rank(freq))%>%
  filter(rank==1)%>%
  arrange(sentiment,rank)%>%
  print(n=1000)

df%>%
  group_by(sentiment)%>%
  slice_min(freq)%>% # slice_max : 빈도수가 제일 낮은 값들만 추출
  print(n=400)
  
★ JSON(JAVA OBJECT NOTATION)
- 자바스크립트에서 사용하는 객체 표기 방법을 기반으로 한다.
- 텍스트 데이터를 기반으로 한다.
- 다양한 소프트웨어와 프로그래밍언어끼리 데이터를 교환할 때 많이 사용된다.

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

#daum영화 해리포터 불사조기사단 json으로 리뷰 읽어오기

js1 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=0&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j1 <- js1[,c('rating','content','createdAt')]

js2 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=101&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j2 <- js2[,c('rating','content','createdAt')]

js3 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=201&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j3 <- js3[,c('rating','content','createdAt')]

movie_df <- rbind(j1,j2,j3)
View(movie_df)

# content(감상평/리뷰)부분 전처리 작업
movie_df$content

library(stringr)

str_extract_all(movie_df$content,'\n|\r|\t')
movie_df$content <- str_replace_all(movie_df$content,'\n|\r|\t',' ')

str_extract_all(movie_df$content,'[ㄱ-ㅎㅏ-ㅣ\\.!?,^><_;:~/)*(&\\-]')
movie_df$content <- str_replace_all(movie_df$content,'[ㄱ-ㅎㅏ-ㅣ\\.!?,^><_;:~/)*(&\\-]',' ')

movie_df$content <- str_squish(movie_df$content)
movie_df$content

# 명사만 추출
library(KoNLP)
useNIADic()
unlist(str_match_all(a[[1]],'(\\w+)/NC')[,2])
a <- sapply(SimplePos22(movie_df$content),function(x) paste(unlist(x),collapse = ' '))
movie_df$noun <- sapply(str_match_all(a,'(\\w+)/NC'),function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse = ' '))
View(movie_df)

movie_df$evaluation <- ifelse(movie_df$rating>=9,'아주재미있다',ifelse(movie_df$rating>=7,'재미있다',ifelse(movie_df$rating>=5,'보통',ifelse(movie_df$rating>=3,'재미없다','아주재미없다'))))
View(movie_df)

x1 <- movie_df[movie_df$evaluation=='아주재미있다','noun']
x2 <- movie_df[movie_df$evaluation=='재미있다','noun']
x3 <- movie_df[movie_df$evaluation=='보통','noun']
x4 <- movie_df[movie_df$evaluation=='재미없다','noun']
x5 <- movie_df[movie_df$evaluation=='아주재미없다','noun']

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

x1_df$sentiment <- '아주재미있다'
x2_df$sentiment <- '재미있다'
x3_df$sentiment <- '보통'
x4_df$sentiment <- '재미없다.'
x5_df$sentiment <- '아주재미없다'

df <- rbind(x1_df,x2_df,x3_df,x4_df,x5_df)
df

library(reshape2)
df <- reshape2::acast(df,word~sentiment,value.var = 'freq',fill=0)

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df)
