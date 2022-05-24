★ selenium
- 웹브라우저를 컨트롤하여 웹을 자동화하는 프로그램

1.chromdriver 다운로드
크롬 들어가서 -> 오른쪽위에 있는 설정에 도움말들어가서 chrome정보들어가기
Chrome이 최신 버전입니다.
버전 98.0.4758.82(공식 빌드) (64비트)
이거랑 비슷한 걸로 밑에 사이트에서 다운

https://chromedriver.storage.googleapis.com/index.html?path=98.0.4758.80/ # 여기서 win32로 다운


2. selenium jar file

selenium-server-standlone-4.0.0-alpha-1.jar

3. 
install.packages('RSelenium')
library(RSelenium)

4. cmd 창에서 수행

java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777


5. 4에서 가상서버가 열린 상태에서 진행
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open() # 크롬창 열기
remdr$navigate('https://daum.net/')
remdr$navigate('https://naver.com/')
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end'))
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='home'))
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='down_arrow'))
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='up_arrow'))

remdr$navigate('https://search.naver.com/search.naver?where=image')
id <- remdr$findElement(using = 'id',value = 'nx_query')
id$setElementAttribute('value','강아지')

btn <- remdr$findElement(using = 'class',value = 'bt_search')
btn$clickElement()

for(i in 1:5){
  remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end'))
  Sys.sleep(2)
}


#remdr$screenshot(display=T) # 스크린샷
#remdr$close() # 창 닫기,서버는 안 꺼짐


#----------------------------------혼자 실습
다음 이미지 사이트 : https://search.daum.net/search?w=img
remdr$open()
remdr$navigate('https://search.daum.net/search?w=img')
id <- remdr$findElement(using='class',value='tf_keyword')
id$setElementAttribute('value','강아지')

btn <- remdr$findElement(using = 'id',value = 'daumBtnSearch')
btn$clickElement()

for(i in 1:5){
  remdr$findElement(using='css',value='body')$sendKeysToElement(list(key='end'))
  Sys.sleep(2)
}
#-------------------------------------

●●이미지 가져오기 위한 작업

library(rvest)
html <- read_html('https://search.naver.com/search.naver?sm=tab_hty.top&where=image&query=%EA%B0%95%EC%95%84%EC%A7%80&oquery=%EB%A7%90%ED%8B%B0%ED%91%B8&tqi=hle9nwprvmsss6XmZTZssssss4C-482558')
html

●#----- 이미지 따로 한개씩 가져오기
html <- read_html('https://movie.naver.com/movie/bi/mi/basic.naver?code=191547')

img <- html_nodes(html,xpath='//*[@id="content"]/div[1]/div[2]/div[2]/a/img')%>%
  html_attr('src')
img

download.file(img,destfile='c:/data/1.jpg',mode='wb')


img <- html_nodes(html,'div.poster >a > img')%>% #xpath사용 없이
  html_attr('src')
img

download.file(img[1],destfile='c:/data/1.jpg',mode='wb')
download.file(img[2],destfile='c:/data/2.jpg',mode='wb')


●#------ 동적인 페이지에서 이미지 가져오기
#xpath로 각 이미지 태그 가져와보기
//*[@id="main_pack"]/section[2]/div/div[1]/div[1]/div[1]/div/div[1]/a/img
//*[@id="main_pack"]/section[2]/div/div[1]/div[1]/div[2]/div/div[1]/a/img
//*[@id="main_pack"]/section[2]/div/div[1]/div[1]/div[7]/div/div[1]/a/img

#selenium을 이용해서 네이버 이미지 검색을 한 후 다운로드

remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open() # 크롬창 열기
remdr$navigate('https://search.naver.com/search.naver?where=image')
id <- remdr$findElement(using = 'id',value = 'nx_query')
id$setElementAttribute('value','강아지')

btn <- remdr$findElement(using = 'class',value = 'bt_search')
btn$clickElement()

for(i in 1:5){
  remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end'))
  Sys.sleep(2)
}

source <- remdr$getPageSource()[[1]] #동적으로 페이지를 가져오기
html <- read_html(source) #다시 html로 변환작업
remdr$close() 
html
img <- html_nodes(html,xpath='//*[@id="main_pack"]/section[2]/div/div[1]/div[1]/div/div/div[1]/a/img')%>%
  html_attr('src')
img[1:5]

for(i in 1:10){
  download.file(img[i],destfile=paste0('c:/img/dog_',i,'.jpg'),mode='wb')
}

#----------------------------------------------
★ try
예외사항
- 실행 중에 발생한 오류
- 예외사항이 발생했을 때 처리하는 기능

lst <- list(x=10,y='20',z=30)
lst
for(i in lst){
  print(100/i)
}

for(i in lst){
  try(print(100/i))
}

for(i in lst){
  try(print(100/i),silent=T) #silent=T : 에러가 났을때 에러메시지를 출력하지 않고 다음 진행
}

x <- img[1:5]

for(i in 1:10){
  try(download.file(x[i],destfile=paste0('c:/img/dog_',i,'.jpg'),mode='wb'),silent=T)
}

x <- img[1:5]
x

error_files <- c()
for(i in 1:10){
  tryCatch(download.file(x[i],destfile=paste0('c:/img/dog_',i,'.jpg'),mode='wb'),
           error=function(arg) error_files <<- c(error_files,x[i])) #<<-를 사용하는 이유는 글로벌변수에 저장하기위한 작업, 에러인 것을 찾기위해
}

error_files 


img
error_files <- c()
for(i in 1:length(img)){
  tryCatch(download.file(x[i],destfile=paste0('c:/img/dog_',i,'.jpg'),mode='wb'),
           error=function(arg) error_files <<- c(error_files,img[i])) #<<-를 사용하는 이유는 글로벌변수에 저장하기위한 작업, 에러인 것을 찾기위해
}

error_files

[문제208] 다음이미지사이트에서 검색어를 입력한 후 이미지 url수집하고 이미지 파일을 저장해주세요.

remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
html <- read_html('https://search.daum.net/search?nil_suggest=btn&w=img&DA=SBC&q=%EA%B0%95%EC%95%84%EC%A7%80')
remdr$open()
remdr$navigate('https://search.daum.net/search?w=img')

#검색창에 입력
id <- remdr$findElement(using='class',value='tf_keyword')
id$setElementAttribute('value','강아지')

# 찾는 버튼 클릭
btn <- remdr$findElement(using = 'id',value='daumBtnSearch')
btn$clickElement()

# 스크롤 내리기(스코롤을 안 내릴 시 현재 페이지에 있는 사진들만 가져오는 제한이 있다)
for(i in 1:5){
  remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end'))
  Sys.sleep(2)
}
//*[@id="imgList"]/div[1]/a/img
//*[@id="imgList"]/div[5]/a/img

#페이지 소스를 읽어오기, 소스를 html로 변환하기(source를 html로 읽어오기)
source <- remdr$getPageSource()[[1]]
html <- read_html(source)

# xpath를 이용하여 이미지의 src(주소)만 가져오기
img <- html_nodes(html,xpath='//*[@id="imgList"]/div/a/img')%>%
  html_attr('src')
img

# 이미지 저장하기, tryCatch문을 사용하여 오류가 있는 주소는 따로 error_files에 주소를 저장하고 다음 주소로 넘어가서 이미지다운
error_files <- 0
for(i in 1:length(img)){
  tryCatch(download.file(img[i],destfile=paste0('c:/img/ddog',i,'.jpg'),mode='wb'),
           error=function(x) error_files <<- c(error_files,img[i]))
}
error_files

#----------------------------------------------------강사님 답

remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open() # 크롬창 열기
remdr$navigate('https://search.daum.net/search?w=img')
id <- remdr$findElement(using = 'id',value = 'q')
id$setElementAttribute('value','고양이')

btn <- remdr$findElement(using = 'id',value = 'daumBtnSearch')
btn$clickElement()

'''
for(i in 1:5){
  remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end'))
  Sys.sleep(2)
}
'''

for(i in 1:5){
  webelem <- remdr$findElement(using = 'xpath',value='//*[@id="imgColl"]/div[5]/a[1]')
  webelem$clickElement()
  Sys.sleep(2)
}

source <- remdr$getPageSource()[[1]] #동적으로 페이지를 가져오기
html <- read_html(source) #다시 html로 변환작업
remdr$close() 

//*[@id="imgList"]/div[1]/a/img
//*[@id="imgList"]/div[2]/a/img

img <- html_nodes(html,xpath='//*[@id="imgList"]/div/a/img')%>%
  html_attr('src')

error_files <- c()
for(i in 1:length(img)){
  tryCatch(download.file(img[i],destfile=paste0('c:/img/cat_',i,'.jpg'),mode='wb'),
           error=function(x) error_files <<- c(error_files,img[i]))
}
error_files


#----------------------------------
[문제209] 중앙일보에서 "인공지능" 뉴스기사에 대한 데이터 url수집을 해주세요.
#중앙일보 인공지능 뉴스기사 url
https://www.joongang.co.kr/search/news?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5

remdr$open()
remdr$navigate('https://www.joongang.co.kr/search/news?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5')

#더보기 버튼
//*[@id="container"]/section/div/section/div/a

for(i in 1:5){
  remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end')) #스크롤 내리기 마지막으로
  thebtn <- remdr$findElement(using='xpath',value='//*[@id="container"]/section/div/section/div/a') #스크롤을 내리지 않으면 더보기 버튼은 처음 실행때만 클릭된다. 따라서 바로 위의 줄에서 스코롤을 내려준다
  thebtn$clickElement()
  
  Sys.sleep(2)
}

source <- remdr$getPageSource()[[1]]
html <- read_html(source)
url <- html_nodes(html,'h2.headline > a')%>%
  html_attr('href')


#-------------------------------------------강사님 답
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open() # 크롬창 열기

remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='end'))
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='home'))
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='down_arrow'))
remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='up_arrow'))

remdr$navigate('https://www.joongang.co.kr/search/news?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5')

for(j in 1:5){
  for(i in 1:80){
  remdr$findElement(using = 'css',value='body')$sendKeysToElement(list(key='down_arrow'))

  }
  remdr$findElement(using = 'xpath',value = '//*[@id="container"]/section/div/section/div/a')$clickElement()
}

source <- remdr$getPageSource()[[1]]
html <- read_html(source)

//*[@id="container"]/section/div/section/ul/li[4]/div[2]/h2/a
//*[@id="container"]/section/div/section/ul/li[5]/div[2]/h2/a

url <- html_nodes(html,xpath='//*[@id="container"]/section/div/section/ul/li/div[2]/h2/a')%>%
  html_attr('href')
url

#---------------------------------------------------------실습해보기
동일한 키워드(인공지능)를 가지고 동아일보와 중앙일보 기사 차이를 보기, 두기사의 단어빈도를 wordcloud로 표현
● 중앙일보
# 중앙일보 인공지능 검색 url
https://www.joongang.co.kr/search/news?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5
remdr$open()
remdr$navigate('https://www.joongang.co.kr/search/news?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5')

# 더보기 클릭하기, 5페이지
for(i in 1:5){
  for(j in 1:80){
    remdr$findElement(using='css',value='body')$sendKeysToElement(list(key='down_arrow'))
  }
  remdr$findElement(using='xpath',value='//*[@id="container"]/section/div/section/div/a')$clickElement()
}

# 각 기사들의 url을 가져오기, xpath사용
//*[@id="container"]/section/div/section/ul/li[1]/div[2]/h2/a
//*[@id="container"]/section/div/section/ul/li[2]/div[2]/h2/a
source <- remdr$getPageSource()[[1]] #페이지 읽어오기 , 이 함수를 사용하지않으면 동적페이지를 읽어올 수 없다.
html <- read_html(source)
url <- html_nodes(html,xpath='//*[@id="container"]/section/div/section/ul/li/div[2]/h2/a')%>%
  html_attr('href')

#각 기사들 읽어오기
  #library(stringr)
url
article <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  text <- html_nodes(html,'div#article_body > p')%>% 
    html_text() # div태그의 id=article_body 안에  p태그들이 여러개 있고 하나의 기사 내용들이 여러개의 p태그로 되어있어서 나뉘어서 여러개의 벡터로들어감
  article <- c(article,str_replace_all(paste(text,collapse = ' '),'\\s{2,}',' ')) # p태그가 여러개로 이루어져있어서 기사내용들이 각각의 벡터에 들어감 따라서 각 값들을 paste함수를 사용하여 하나의 벡터로 만든다. 그리고 공백이 2개 이상인 값들은 1개로 변경한다.
  
}
article

#전처리 작업
str_extract_all(article,'[[:punct:]]') # 특수문자들 찾기
article <- str_replace_all(article,'[[:punct:]]',' ')
article <- str_squish(article)

# 명사만 추출, 데이터프레임으로 만들기
library(KoNLP)
useNIADic()

n <- sapply(SimplePos22(article),function(x) paste(unlist(x),collapse = ' ')) #SimplePos22함수를 사용하여 품사별로 나눔, 리스트로 출력되므로 리스트별로 벡터형으로 변경하고 합치기
nc <- str_match_all(n,'(\\w+)/NC') # NC(명사)만 추출 리스트로 출력
nc <- sapply(nc,function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse=' ')) # 각 리스트를 벡터형으로 변경하는데 각 리스트안에서 같은 단어가 없도록 unique함수를 사용하고 단어의 길이가 2 이상인 값들만 추출하고 합치기
nc_df <- data.frame(table(str_split(paste(nc,collapse=' '),' '))) # nc에 각각의 기사를 하나로 합치고 table함수를 사용하여 단어별로 빈도수를 구하고 dataframe으로 만들기

nc_df

#wordcloud2로 시각화
library(wordcloud2)
wordcloud2(nc_df)

● 동아일보
#동아일보 인공지능 검색 url , 1,2,3페이지별로 어디가 바뀌는지 확인(첫페이지들어갔을 때는 다음페이지 갔다가 다시 1페이로 돌아오면 비슷하게 나옴)
https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=16&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=31&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1

# 6페이지까지의 기사들의 url 추출하기
library(rvest)
//*[@id="content"]/div[3]/div[1]/div[1]/div[2]/p[1]/a # 1번기사
//*[@id="content"]/div[3]/div[1]/div[2]/div[2]/p[1]/a # 2번기사
//*[@id="content"]/div[3]/div[1]/div[7]/div/p[1]/a[1] #7번기사 div옆에[2]가 없는 xpath는 기사 옆에 이미지가 없기 때문인데 이미지는 src이고 기사 text의 주소는 href로 되어있기 때문에 div로 가져오면된다.(div[2]이렇게 안 써도 href만 가져오면되기 때문)

url <- c()
for(i in seq(1,76,15)){
  html <- read_html(paste0('https://www.donga.com/news/search?p=',i,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1'))
  url_p <- html_nodes(html,xpath='//*[@id="content"]/div[3]/div[1]/div/div/p[1]/a[1]')%>%
    html_attr('href')
  url <- c(url,url_p)
  
}
url

#기사별로 기사내용 추출하기
library(xml2)
article <- c()
for(i in 1:90){
  html <- read_html(url[i])
  art_text <- html_nodes(html,xpath='//*[@id="content"]/div/div[1]')
  
  xml2::xml_remove(art_text%>%html_nodes('div')) # 기사내용 빼고 다른 광고, 이미지 등 제거
  art_text <- art_text%>%html_text()
  article <- c(article,art_text)
}
article

#전처리작업
article <- str_trim(article) #앞뒤 공백제거

str_extract_all(article,'[^\\.]+ \\w+@\\w+.com')
article <- str_replace_all(article,'[^\\.]+ \\w+@\\w+.com','')# 기자이름, 이메일 제거

str_extract_all(article,'\\[\\w+\\=\\w+\\]')
article <- str_replace_all(article,'\\[\\w+\\=\\w+\\]','') #[서울=뉴시스] 이 패턴 다 제거

str_extract_all(article,'\\W')
article <- str_replace_all(article,'\\W',' ') #특수문자 제거
article <- str_squish(article) # 공백두칸이상 한칸으로 변경

#명사 추출
library(KoNLP)
SimplePos22(article)
'''
nc <- RcppMeCab::pos(base::enc2utf8(article))
nc2 <- str_match_all(nc,'(\\w+)(/NNG|/NNP|/XR|/SL)') 
nc3 <- sapply(nc2,function(x) paste(unlist(x[,2]),collapse = ' '))
'''
n <- sapply(SimplePos22(article),function(x) paste(unlist(x),collapse=' '))
nc <- str_match_all(n,'(\\w+)/NC')
nc <- sapply(nc,function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse=' '))

nc_df2 <- data.frame(table(str_split(paste(nc3,collapse=' '),' ')))
nc_df2      

● 중앙일보, 동아일보 비교하기

names(nc_df) <- c('word','freq')
names(nc_df2) <- c('word','freq')
nc_df$sentiment <- '중앙일보'
nc_df2$sentiment <- '동아일보'

df <- rbind(nc_df,nc_df2)
df <- df[df$freq>=2,]
library(reshape2)
df <- acast(df,word~sentiment,value.var = 'freq',fill=0)

windows(width=10,height=10)
wordcloud::comparison.cloud(df,scale=c(2.5,0.5),
                            colors=c('purple','orange'),
                            title.size = 3,
                            title.bg.colors = 'white',
                            title.colors = 'red')

comparison.cloud(term.matrix,scale=c(4,.5), max.words=300,
                 random.order=FALSE, rot.per=.1,
                 colors=brewer.pal(max(3,ncol(term.matrix)),"Dark2"),
                 use.r.layout=FALSE, title.size=3,
                 title.colors=NULL, match.colors=FALSE,
                 title.bg.colors="grey90", ...)


wordcloud2(a, size = 2, fontFamily = "????????????", color = "random-light", backgroundColor = "grey")
wordcloud2(a, size = 2.3, minRotation = -pi/6, maxRotation = -pi/6, rotateRatio = 1)
letterCloud( demoFreq, word = "R", color='red' , backgroundColor="green")

