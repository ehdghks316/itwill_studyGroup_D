R-프로젝트
-도서 분야 예측시스템

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●순서1●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
1. 데이터 수집
library(rvest) # 웹페이지에서 html태그를 추출하고 태그의 다양한 옵션들을 사용할 수 있는 라이브러리 
library(RSelenium) # 동적인 웹페이지의 태그를 추출할 수 있는 라이브러리
#cmd창에서 가상서버 열기 : java -Dwebdriver.chromedriver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777

#가상서버에 접속하여 조종하는 함수를 remdr 변수에 넣기
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777, browserName='chrome')

# 인터넷 창 오픈
remdr$open() 

# 교보문고 메인 홈페이지 접속
remdr$navigate("http://www.kyobobook.co.kr/index.laf")

# 국내도서 클릭
remdr$findElement(using="xpath",value='//*[@id="header"]/div[3]/ul[1]/li[1]/a')$clickElement()

# 왼쪽 장르에서 소설 클릭
remdr$findElement(using="xpath",value='//*[@id="main_snb"]/div[1]/ul[1]/li[1]/a')$clickElement()
//*[@id="main_snb"]/div[1]/ul[1]/li[1]/a # 소설
//*[@id="main_snb"]/div[1]/ul[1]/li[2]/a # 시/에세이
//*[@id="main_snb"]/div[1]/ul[1]/li[3]/a # 경제/경영

# 베스트셀러 클릭
remdr$findElement(using='xpath',value='//*[@id="container"]/div[2]/div/div/div[3]/ul/li[2]/a')$clickElement()

# 책 제목 클릭
remdr$findElement(using='xpath',value='//*[@id="prd_list_type1"]/li[1]/div/div[1]/div[2]/div[1]/a/strong')$clickElement()
//*[@id="prd_list_type1"]/li[1]/div/div[1]/div[2]/div[1]/a/strong
//*[@id="prd_list_type1"]/li[3]/div/div[1]/div[2]/div[1]/a/strong

# 동적인 페이지 활성화
source <- remdr$getPageSource()[[1]]
html <- read_html(source)

# 책 제목 추출(양 사이드 공백 제거)
title <- trimws(html_nodes(html,xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                  html_text())

# 책 소개 추출(양 사이드 공백 제거)
intro <- trimws(html_nodes(html,'div.box_detail_article')[1]%>%
                  html_text())

# 뒤로가기
remdr$goBack()

# 12개의 분야의 베스트셀러 도서 모두 추출 -----------위의 작업들을 종합------------
text <- c()
for(k in 1:12){
  if(k==1){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=01&menuCode=002')
  }else if(k==2){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=03&menuCode=002')
  }else if(k==3){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=13&menuCode=002')
  }else if(k==4){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=15&menuCode=002')
  }else if(k==5){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=05&menuCode=002')
  }else if(k==6){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=19&menuCode=002')
  }else if(k==7){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=21&menuCode=002')
  }else if(k==8){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=17&menuCode=002')
  }else if(k==9){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=23&menuCode=002')
  }else if(k==10){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=29&menuCode=002')
  }else if(k==11){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=26&menuCode=002')
  }else if(k==12){
    remdr$navigate('http://www.kyobobook.co.kr/categoryRenewal/categoryMain.laf?perPage=20&mallGb=KOR&linkClass=33&menuCode=002')
  }
  
  for(i in 1:8){
    if(i>1){
      remdr$findElement(using='xpath',value=paste0('//*[@id="eventPaging"]/div/ul/li[',i,']/a'))$clickElement()
    }
    # 동적인 페이지 활성화
    source <- remdr$getPageSource()[[1]]
    html <- read_html(source)
    
    # 현재페이지의 도서 개수 
    leng <- length(html_nodes(html,'div.prd_list_area > form#frmList > ul.prd_list_type1 > li.id_detailli'))
    
    # 각각의 책의 url을 들어가서 책제목과 책 소개 부분을 추출해서 업앤드 방식으로 저장
    for(j in seq(1,leng*2-1,2)){
      # 책 제목 클릭
      remdr$findElement(using='xpath',value=paste0('//*[@id="prd_list_type1"]/li[',j,']/div/div[1]/div[2]/div[1]/a/strong'))$clickElement()
      
      # 동적인 페이지 활성화
      source <- remdr$getPageSource()[[1]]
      html <- read_html(source)
      
      # 책 제목 추출(양 사이드 공백 제거)
      title <- trimws(html_nodes(html,xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                        html_text())
      
      # 책 소개 추출(양 사이드 공백 제거)
      intro <- trimws(html_nodes(html,'div.box_detail_article')[1]%>%
                        html_text())
      
      # 데이터 저장
      text <- c(text,paste(title,intro))
      
      # 뒤로가기
      remdr$goBack()
      
      Sys.sleep(1)
    }
  }
}

# 정답라벨 넣기
field <- c()
for(i in 1:1800){
  if(i <= 150){
    field <- c(field,'novel')
  }else if(i >=151 & i <= 300){
    field <- c(field,'pome_essay')
  }else if(i >=301 & i <= 450){
    field <- c(field,'economy')
  }else if(i >=451 & i <= 600){
    field <- c(field,'selfdevelope')
  }else if(i >=751 & i <= 900){
    field <- c(field,'humanities')
  }else if(i >=901 & i <= 1050){
    field <- c(field,'history_culture')
  }else if(i >=1051 & i <= 1200){
    field <- c(field,'religion')
  }else if(i >=1201 & i <= 1350){
    field <- c(field,'art_popularculture')
  }else if(i >=1351 & i <= 1500){
    field <- c(field,'sience')
  }else if(i >=1501 & i <= 1650){
    field <- c(field,'technology_engineering')
  }else if(i >=1651 & i <= 1800){
    field <- c(field,'computer_it')
  }
}

# 정답과 text 데이터프레임으로 만들기
book <- data.frame(field=field, text=text)
View(book)
write.csv(book,'c:/data/book_field.csv')

# 데이터 불러오기--------------------------
book <- read.csv('c:/data/book_field.csv',header=T)
book <- book[,c(2,3)]
View(book)


●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●순서2●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
2. 토큰화, 전처리
library(tm) # VCorpus(말뭉치), documentTermMatrix 만드는 작업을 수행하는 라이브러리
library(stringr) # 단어 추출,변경,제거, 공백제거 등 전처리작업에 주로 사용
library(RcppMeCab) # 일본어, 한국어 품사 태깅 라이브러리(전처리를 조금 더 수월하게 품사로 나누는 것)

#말뭉치로 변형작업
book_corpus <- tm::VCorpus(VectorSource(book$text))
lapply(book_corpus,content)
#태깅,전처리 작업
#토큰으로 만들 함수
mecab_words <- function(doc){
  # 태깅
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  
  # 필요한 품사 NNG(일반명사), NNP(고유명사), XR(어근 : 실질적으로 의미를 나타내는 중심이 되는 부분), SL(외국어)
  word_noun <- str_match_all(tagging,'(\\w+)(/NNG|/NNP|/XR|/SL)')[[1]][,2] 
  
  # 전처리
  word_noun <- str_replace_all(word_noun,'C','씨언어')
  word_noun <- str_replace_all(word_noun,'R','알프로그래밍')
  word_noun <- str_replace_all(word_noun,'NFT','엔에프티')
  word_noun <- str_replace_all(word_noun,'ETF','이티에프')
  word_noun <- str_replace_all(word_noun,'LH','한국토지주택공사')
  word_noun <- str_replace_all(word_noun,'IT','아이티')
  word_noun <- str_replace_all(word_noun,'CEO','씨이오')
  word_noun <- str_replace_all(word_noun,'IMF','아이엠에프')
  word_noun <- str_replace_all(word_noun,'OECD','경제협력개발기구')
  word_noun <- str_replace_all(word_noun,'HTS','에이치티에스')
  word_noun <- str_replace_all(word_noun,'Business','비지니스')
  word_noun <- str_replace_all(word_noun,'DSR','디에스알')
  word_noun <- str_replace_all(word_noun,'DTI','디티아이')
  word_noun <- str_replace_all(word_noun,'PER','피이알')
  word_noun <- str_replace_all(word_noun,'value','벨류')
  word_noun <- str_replace_all(word_noun,'investing','인베스팅')
  word_noun <- str_replace_all(word_noun,'FIRE','파이어')
  word_noun <- str_replace_all(word_noun,'Warren','워렌버핏')
  word_noun <- str_replace_all(word_noun,'Buffett','워렌버핏')
  word_noun <- str_replace_all(word_noun,'IPO','아이피오')
  word_noun <- str_replace_all(word_noun,'PIR','피아이알')
  word_noun <- str_replace_all(word_noun,'tokens','토큰')
  word_noun <- str_replace_all(word_noun,'innovation','혁신')
  word_noun <- str_replace_all(word_noun,'AI','인공지능')
  word_noun <- str_replace_all(word_noun,'VR','브이알')
  word_noun <- str_replace_all(word_noun,'AR','에이알')
  word_noun <- str_replace_all(word_noun,'SF','에스에프')
  word_noun <- str_replace_all(word_noun,'Java','자바')
  word_noun <- str_replace_all(word_noun,'AWS','에이더블유에스')
  word_noun <- str_replace_all(word_noun,'IoT','아이오티')
  word_noun <- str_replace_all(word_noun,'programming','프로그래밍')
  word_noun <- str_replace_all(word_noun,'network','네트워크')
  word_noun <- str_replace_all(word_noun,'python','파이썬')
  word_noun <- str_replace_all(word_noun,'Apache','아파치')
  word_noun <- str_replace_all(word_noun,'IP','아이피')
  word_noun <- str_replace_all(word_noun,'DNS','디엔에스')
  word_noun <- str_replace_all(word_noun,'Android','안드로이드')
  word_noun <- str_replace_all(word_noun,'Studio','스튜디오')
  word_noun <- str_replace_all(word_noun,'Internet','인터넷')
  word_noun <- str_replace_all(word_noun,'GUI','쥐유아이')
  word_noun <- str_replace_all(word_noun,'Amazon','아마존')
  word_noun <- str_replace_all(word_noun,'RDS','알디에스')
  word_noun <- str_replace_all(word_noun,'AutoCAD','오토캐드')
  word_noun <- str_replace_all(word_noun,'CAD','캐드')
  word_noun <- str_replace_all(word_noun,'API','에이피아이')
  word_noun <- str_replace_all(word_noun,'PyTorch','파이토치')
  word_noun <- str_replace_all(word_noun,'NoSQL','노에스큐엘')
  word_noun <- str_replace_all(word_noun,'Algorithms','알고리즘')
  word_noun <- str_replace_all(word_noun,'Program','프로그램')
  word_noun <- str_replace_all(word_noun,'Apps','앱스')
  word_noun <- str_replace_all(word_noun,'JPA','제이피에이')
  word_noun <- str_replace_all(word_noun,'CBT','씨비티')
  word_noun <- str_replace_all(word_noun,'UI','유아이')
  word_noun <- str_replace_all(word_noun,'UX','유엑스')
  word_noun <- str_replace_all(word_noun,'DAsP','디에이에스피')
  word_noun <- str_replace_all(word_noun,'DAP','디에이피')
  word_noun <- str_replace_all(word_noun,'Data','데이터')
  word_noun <- str_replace_all(word_noun,'CNN','씨엔엔')
  word_noun <- str_replace_all(word_noun,'RNN','알엔엔')
  word_noun <- str_replace_all(word_noun,' 돈 ','돈$')
  word_noun <- str_replace_all(word_noun,' 삶 ','삶$')
  word_noun <- str_replace_all(word_noun,' 차 ','차$')
  word_noun <- str_replace_all(word_noun,' 법 ','법$')
  word_noun <- str_replace_all(word_noun,' 배 ','배$')
  word_noun <- str_replace_all(word_noun,' 억 ','억$')
  word_noun <- str_replace_all(word_noun,' 조 ','조$')
  word_noun <- str_replace_all(word_noun,' 부 ','부$')
  word_noun <- str_replace_all(word_noun,' 일 ','일$')
  word_noun <- str_replace_all(word_noun,' 집 ','집$')
  word_noun <- str_replace_all(word_noun,' 만 ','만$')
  word_noun <- str_replace_all(word_noun,' 땅 ','땅$')
  word_noun <- str_replace_all(word_noun,' 주 ','주$')
  word_noun <- str_replace_all(word_noun,' 왕 ','왕$')
  word_noun <- str_replace_all(word_noun,' 꿈 ','왕$')
  word_noun <- str_replace_all(word_noun,'[\u4E00-\u9FD5○]','') # 한자제거
  
  word_noun <- str_replace_all(word_noun,'[A-z]+','') # 영어제거
  
  return(word_noun)
}

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●순서3●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

3.학습데이터, 테스트데이터 나누기●

# DocumentTermMatrix 형태로 변형(미리 토큰화하는 함수를 옵션으로 넣음)
book_dtm <- DocumentTermMatrix(book_corpus,control=list(tokenize=mecab_words,
                                                        wordLengths=c(2,Inf),
                                                        weighting=weightBin)) #weightBin은 한 문장에서 동일하게 반복되는 말을 하나만 카운트
inspect(book_dtm)

#학습데이터, 테스트데이터를 구분할 인덱스 만들기
idx <- sample(2,nrow(book_dtm),replace=TRUE,prob=c(0.9,0.1))

#구분할 인덱스의 위치와 일치하는 book_dtm의 데이터들을 학습데이터,테스트데이터 변수에 저장
book_dtm_train <- book_dtm[idx==1,]
book_dtm_test <- book_dtm[idx==2,]

nrow(book_dtm_train) #학습데이터 개수
nrow(book_dtm_test) #테스트데이터 개수

''' dtm의 옵션으로 weightBin을 안 썼을 때
#빈도수가 5회 이상인 단어들로 제한 (제한을 하지 않으면 단어들의 수만큼 열의 수가 증가하므로 모델에 영향을 미치지 않을정도로만 제한)
freq_words <- findFreqTerms(book_dtm_train,5)
train <- book_dtm_train[,freq_words]
test <- book_dtm_test[,freq_words]
'''

#학습데이터, 테스트데이터의 정답라벨('field') 각 인덱스에 맞는 값들을 변수에 저장
book_dtm_train_labels <- book[idx==1,'field'] 
book_dtm_test_labels <- book[idx==2,'field']

length(book_dtm_train_labels) #학습데이터의 정답 라벨의 개수 확인 (학습데이터의 개수와 일치해야함)
length(book_dtm_test_labels) #테스트데이터의 정답 라벨의 개수 확인

#빈도수 숫자를 이분법으로 분류하기 
convert_counts <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

book_train <- apply(book_dtm_train,MARGIN=2,convert_counts)
book_test <- apply(book_dtm_test,MARGIN=2,convert_counts)
book_train[1,]
book_test[1,]

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●순서4●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
4. naiveBayes모델 적용, 예측
library(e1071)# naiveBayes모델을 사용할 수 있는 라이브러리
book_classifier <- naiveBayes(book_train,book_dtm_train_labels)
book_test_predict <- predict(book_classifier,book_test) #predict(나이브베이즈모델,예측할 테스트셋)

# CrossTable 결과 예측 표
library(gmodels) # 두 개의 질적 자료 간의 관련성을 교차표로 나타내줄 수 있는 함수 CrossTable을 사용할 수 있는 라이브러리
CrossTable(book_test_predict,book_dtm_test_labels)
CrossTable(book_dtm_test_labels,book_test_predict)

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●결과1●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
| book_dtm_test_labels 
book_test_predict |     art_popularculture |            computer_it |                economy |        history_culture |             humanities |                  novel |             poem_essay |       politics_society |               religion |           selfdevelope |                 sience | technology_engineering |              Row Total | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  art_popularculture |                      8 |                      1 |                      0 |                      0 |                      1 |                      1 |                      1 |                      0 |                      1 |                      0 |                      2 |                      1 |                     16 | 
  |                 61.633 |                  0.050 |                  0.583 |                  1.417 |                  0.167 |                  0.215 |                  0.050 |                  1.083 |                  0.050 |                  1.417 |                  0.110 |                  0.694 |                        | 
  |                  0.500 |                  0.062 |                  0.000 |                  0.000 |                  0.062 |                  0.062 |                  0.062 |                  0.000 |                  0.062 |                  0.000 |                  0.125 |                  0.062 |                  0.083 | 
  |                  0.800 |                  0.067 |                  0.000 |                  0.000 |                  0.056 |                  0.053 |                  0.067 |                  0.000 |                  0.067 |                  0.000 |                  0.105 |                  0.037 |                        | 
  |                  0.042 |                  0.005 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.005 |                  0.000 |                  0.005 |                  0.000 |                  0.010 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  computer_it |                      0 |                      9 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      1 |                      2 |                      1 |                     14 | 
  |                  0.729 |                 57.151 |                  0.510 |                  1.240 |                  0.074 |                  1.385 |                  1.094 |                  0.948 |                  1.094 |                  0.046 |                  0.273 |                  0.477 |                        | 
  |                  0.000 |                  0.643 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.143 |                  0.071 |                  0.073 | 
  |                  0.000 |                  0.600 |                  0.000 |                  0.000 |                  0.056 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.059 |                  0.105 |                  0.037 |                        | 
  |                  0.000 |                  0.047 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.010 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  economy |                      0 |                      1 |                      6 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      1 |                      8 | 
  |                  0.417 |                  0.225 |                111.720 |                  0.708 |                  0.750 |                  0.792 |                  0.625 |                  0.542 |                  0.625 |                  0.708 |                  0.792 |                  0.014 |                        | 
  |                  0.000 |                  0.125 |                  0.750 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.125 |                  0.042 | 
  |                  0.000 |                  0.067 |                  0.857 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.037 |                        | 
  |                  0.000 |                  0.005 |                  0.031 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  history_culture |                      0 |                      0 |                      0 |                     12 |                      2 |                      0 |                      0 |                      2 |                      0 |                      0 |                      0 |                      0 |                     16 | 
  |                  0.833 |                  1.250 |                  0.583 |                 79.064 |                  0.167 |                  1.583 |                  1.250 |                  0.776 |                  1.250 |                  1.417 |                  1.583 |                  2.250 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.750 |                  0.125 |                  0.000 |                  0.000 |                  0.125 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.083 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.706 |                  0.111 |                  0.000 |                  0.000 |                  0.154 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.062 |                  0.010 |                  0.000 |                  0.000 |                  0.010 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  humanities |                      0 |                      0 |                      0 |                      0 |                      7 |                      0 |                      1 |                      0 |                      1 |                      3 |                      1 |                      0 |                     13 | 
  |                  0.677 |                  1.016 |                  0.474 |                  1.151 |                 27.424 |                  1.286 |                  0.000 |                  0.880 |                  0.000 |                  2.970 |                  0.064 |                  1.828 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.538 |                  0.000 |                  0.077 |                  0.000 |                  0.077 |                  0.231 |                  0.077 |                  0.000 |                  0.068 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.389 |                  0.000 |                  0.067 |                  0.000 |                  0.067 |                  0.176 |                  0.053 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.036 |                  0.000 |                  0.005 |                  0.000 |                  0.005 |                  0.016 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  novel |                      1 |                      0 |                      0 |                      1 |                      0 |                     16 |                      0 |                      0 |                      0 |                      1 |                      1 |                      0 |                     20 | 
  |                  0.002 |                  1.562 |                  0.729 |                  0.336 |                  1.875 |                 99.327 |                  1.562 |                  1.354 |                  1.562 |                  0.336 |                  0.484 |                  2.812 |                        | 
  |                  0.050 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.800 |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.050 |                  0.000 |                  0.104 | 
  |                  0.100 |                  0.000 |                  0.000 |                  0.059 |                  0.000 |                  0.842 |                  0.000 |                  0.000 |                  0.000 |                  0.059 |                  0.053 |                  0.000 |                        | 
  |                  0.005 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.083 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  poem_essay |                      1 |                      0 |                      0 |                      0 |                      1 |                      2 |                     12 |                      0 |                      1 |                      1 |                      0 |                      0 |                     18 | 
  |                  0.004 |                  1.406 |                  0.656 |                  1.594 |                  0.280 |                  0.027 |                 79.806 |                  1.219 |                  0.117 |                  0.221 |                  1.781 |                  2.531 |                        | 
  |                  0.056 |                  0.000 |                  0.000 |                  0.000 |                  0.056 |                  0.111 |                  0.667 |                  0.000 |                  0.056 |                  0.056 |                  0.000 |                  0.000 |                  0.094 | 
  |                  0.100 |                  0.000 |                  0.000 |                  0.000 |                  0.056 |                  0.105 |                  0.800 |                  0.000 |                  0.067 |                  0.059 |                  0.000 |                  0.000 |                        | 
  |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.010 |                  0.062 |                  0.000 |                  0.005 |                  0.005 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  politics_society |                      0 |                      1 |                      0 |                      2 |                      0 |                      0 |                      0 |                     10 |                      0 |                      0 |                      0 |                      1 |                     14 | 
  |                  0.729 |                  0.008 |                  0.510 |                  0.466 |                  1.312 |                  1.385 |                  1.094 |                 86.442 |                  1.094 |                  1.240 |                  1.385 |                  0.477 |                        | 
  |                  0.000 |                  0.071 |                  0.000 |                  0.143 |                  0.000 |                  0.000 |                  0.000 |                  0.714 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.073 | 
  |                  0.000 |                  0.067 |                  0.000 |                  0.118 |                  0.000 |                  0.000 |                  0.000 |                  0.769 |                  0.000 |                  0.000 |                  0.000 |                  0.037 |                        | 
  |                  0.000 |                  0.005 |                  0.000 |                  0.010 |                  0.000 |                  0.000 |                  0.000 |                  0.052 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  religion |                      0 |                      0 |                      0 |                      2 |                      2 |                      0 |                      1 |                      0 |                     11 |                      0 |                      0 |                      0 |                     16 | 
  |                  0.833 |                  1.250 |                  0.583 |                  0.240 |                  0.167 |                  1.583 |                  0.050 |                  1.083 |                 76.050 |                  1.417 |                  1.583 |                  2.250 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.125 |                  0.125 |                  0.000 |                  0.062 |                  0.000 |                  0.688 |                  0.000 |                  0.000 |                  0.000 |                  0.083 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.118 |                  0.111 |                  0.000 |                  0.067 |                  0.000 |                  0.733 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.010 |                  0.010 |                  0.000 |                  0.005 |                  0.000 |                  0.057 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  selfdevelope |                      0 |                      2 |                      1 |                      0 |                      2 |                      0 |                      0 |                      0 |                      0 |                     10 |                      0 |                      0 |                     15 | 
  |                  0.781 |                  0.585 |                  0.375 |                  1.328 |                  0.251 |                  1.484 |                  1.172 |                  1.016 |                  1.172 |                 56.622 |                  1.484 |                  2.109 |                        | 
  |                  0.000 |                  0.133 |                  0.067 |                  0.000 |                  0.133 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.667 |                  0.000 |                  0.000 |                  0.078 | 
  |                  0.000 |                  0.133 |                  0.143 |                  0.000 |                  0.111 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.588 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.010 |                  0.005 |                  0.000 |                  0.010 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.052 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  sience |                      0 |                      0 |                      0 |                      0 |                      2 |                      0 |                      0 |                      0 |                      1 |                      1 |                     11 |                      0 |                     15 | 
  |                  0.781 |                  1.172 |                  0.547 |                  1.328 |                  0.251 |                  1.484 |                  1.172 |                  1.016 |                  0.025 |                  0.081 |                 61.000 |                  2.109 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.133 |                  0.000 |                  0.000 |                  0.000 |                  0.067 |                  0.067 |                  0.733 |                  0.000 |                  0.078 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.111 |                  0.000 |                  0.000 |                  0.000 |                  0.067 |                  0.059 |                  0.579 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.010 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.057 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  technology_engineering |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                      2 |                     23 |                     27 | 
  |                  1.406 |                  0.583 |                  0.984 |                  2.391 |                  2.531 |                  2.672 |                  2.109 |                  0.375 |                  2.109 |                  2.391 |                  0.169 |                 97.122 |                        | 
  |                  0.000 |                  0.037 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.037 |                  0.000 |                  0.000 |                  0.074 |                  0.852 |                  0.141 | 
  |                  0.000 |                  0.067 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.077 |                  0.000 |                  0.000 |                  0.105 |                  0.852 |                        | 
  |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.010 |                  0.120 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  Column Total |                     10 |                     15 |                      7 |                     17 |                     18 |                     19 |                     15 |                     13 |                     15 |                     17 |                     19 |                     27 |                    192 | 
  |                  0.052 |                  0.078 |                  0.036 |                  0.089 |                  0.094 |                  0.099 |                  0.078 |                  0.068 |                  0.078 |                  0.089 |                  0.099 |                  0.141 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  예측률 : (8+9+6+12+7+16+12+10+11+10+11+23)/192

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●결과2●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
| book_dtm_test_labels 
book_test_predict |     art_popularculture |            computer_it |                economy |        history_culture |             humanities |                  novel |             poem_essay |       politics_society |               religion |           selfdevelope |                 sience | technology_engineering |              Row Total | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  art_popularculture |                      9 |                      2 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      1 |                      0 |                      0 |                      0 |                     13 | 
  |                 78.901 |                  0.331 |                  1.405 |                  0.843 |                  0.984 |                  0.914 |                  0.126 |                  1.335 |                  0.032 |                  0.984 |                  1.195 |                  1.265 |                        | 
  |                  0.692 |                  0.154 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.077 |                  0.000 |                  0.077 |                  0.000 |                  0.000 |                  0.000 |                  0.070 | 
  |                  0.750 |                  0.105 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.100 |                  0.000 |                  0.059 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.049 |                  0.011 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  computer_it |                      1 |                     16 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      1 |                     20 | 
  |                  0.068 |                 94.686 |                  2.162 |                  1.297 |                  0.174 |                  1.405 |                  1.081 |                  2.054 |                  1.838 |                  0.174 |                  1.838 |                  0.460 |                        | 
  |                  0.050 |                  0.800 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.050 |                  0.108 | 
  |                  0.083 |                  0.842 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.056 |                        | 
  |                  0.005 |                  0.086 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  economy |                      0 |                      1 |                     17 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                     20 | 
  |                  1.297 |                  0.541 |                101.825 |                  1.297 |                  0.174 |                  1.405 |                  1.081 |                  2.054 |                  1.838 |                  0.174 |                  1.838 |                  1.946 |                        | 
  |                  0.000 |                  0.050 |                  0.850 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.108 | 
  |                  0.000 |                  0.053 |                  0.850 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.005 |                  0.092 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  history_culture |                      0 |                      0 |                      0 |                      9 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                     10 | 
  |                  0.649 |                  1.027 |                  1.081 |                107.524 |                  0.757 |                  0.703 |                  0.541 |                  0.001 |                  0.919 |                  0.757 |                  0.919 |                  0.973 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.900 |                  0.000 |                  0.000 |                  0.000 |                  0.100 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.054 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.750 |                  0.000 |                  0.000 |                  0.000 |                  0.053 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.049 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  humanities |                      0 |                      0 |                      0 |                      0 |                      2 |                      1 |                      0 |                      0 |                      0 |                      1 |                      2 |                      2 |                      8 | 
  |                  0.519 |                  0.822 |                  0.865 |                  0.519 |                  3.213 |                  0.341 |                  0.432 |                  0.822 |                  0.735 |                  0.257 |                  2.176 |                  1.917 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.250 |                  0.125 |                  0.000 |                  0.000 |                  0.000 |                  0.125 |                  0.250 |                  0.250 |                  0.043 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.143 |                  0.077 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.118 |                  0.111 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.011 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.011 |                  0.011 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  novel |                      0 |                      0 |                      0 |                      0 |                      1 |                     11 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                     12 | 
  |                  0.778 |                  1.232 |                  1.297 |                  0.778 |                  0.009 |                122.337 |                  0.649 |                  1.232 |                  1.103 |                  0.908 |                  1.103 |                  1.168 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.917 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.065 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.846 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.059 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  poem_essay |                      0 |                      0 |                      0 |                      0 |                      2 |                      0 |                      7 |                      0 |                      0 |                      0 |                      0 |                      0 |                      9 | 
  |                  0.584 |                  0.924 |                  0.973 |                  0.584 |                  2.554 |                  0.632 |                 87.209 |                  0.924 |                  0.827 |                  0.681 |                  0.827 |                  0.876 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.222 |                  0.000 |                  0.778 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.049 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.143 |                  0.000 |                  0.700 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.011 |                  0.000 |                  0.038 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  politics_society |                      0 |                      0 |                      0 |                      1 |                      1 |                      1 |                      1 |                     15 |                      0 |                      1 |                      0 |                      0 |                     20 | 
  |                  1.297 |                  2.054 |                  2.162 |                  0.068 |                  0.174 |                  0.117 |                  0.006 |                 81.594 |                  1.838 |                  0.174 |                  1.838 |                  1.946 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.050 |                  0.050 |                  0.050 |                  0.750 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.108 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.071 |                  0.077 |                  0.100 |                  0.789 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.005 |                  0.005 |                  0.081 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  religion |                      0 |                      0 |                      0 |                      0 |                      2 |                      0 |                      1 |                      0 |                     16 |                      0 |                      1 |                      0 |                     20 | 
  |                  1.297 |                  2.054 |                  2.162 |                  1.297 |                  0.156 |                  1.405 |                  0.006 |                  2.054 |                109.132 |                  1.514 |                  0.382 |                  1.946 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.100 |                  0.000 |                  0.050 |                  0.000 |                  0.800 |                  0.000 |                  0.050 |                  0.000 |                  0.108 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.143 |                  0.000 |                  0.100 |                  0.000 |                  0.941 |                  0.000 |                  0.059 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.011 |                  0.000 |                  0.005 |                  0.000 |                  0.086 |                  0.000 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  selfdevelope |                      0 |                      0 |                      1 |                      0 |                      2 |                      0 |                      0 |                      0 |                      0 |                      9 |                      0 |                      0 |                     12 | 
  |                  0.778 |                  1.232 |                  0.068 |                  0.778 |                  1.313 |                  0.843 |                  0.649 |                  1.232 |                  1.103 |                 72.105 |                  1.103 |                  1.168 |                        | 
  |                  0.000 |                  0.000 |                  0.083 |                  0.000 |                  0.167 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.750 |                  0.000 |                  0.000 |                  0.065 | 
  |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.143 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.643 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.011 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.049 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  sience |                      1 |                      0 |                      1 |                      1 |                      2 |                      0 |                      0 |                      2 |                      0 |                      1 |                     13 |                      0 |                     21 | 
  |                  0.096 |                  2.157 |                  0.711 |                  0.096 |                  0.106 |                  1.476 |                  1.135 |                  0.011 |                  1.930 |                  0.218 |                 63.507 |                  2.043 |                        | 
  |                  0.048 |                  0.000 |                  0.048 |                  0.048 |                  0.095 |                  0.000 |                  0.000 |                  0.095 |                  0.000 |                  0.048 |                  0.619 |                  0.000 |                  0.114 | 
  |                  0.083 |                  0.000 |                  0.050 |                  0.083 |                  0.143 |                  0.000 |                  0.000 |                  0.105 |                  0.000 |                  0.071 |                  0.765 |                  0.000 |                        | 
  |                  0.005 |                  0.000 |                  0.005 |                  0.005 |                  0.011 |                  0.000 |                  0.000 |                  0.011 |                  0.000 |                  0.005 |                  0.070 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  technology_engineering |                      1 |                      0 |                      1 |                      1 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                      1 |                     15 |                     20 | 
  |                  0.068 |                  2.054 |                  0.625 |                  0.068 |                  1.514 |                  1.405 |                  1.081 |                  0.541 |                  1.838 |                  1.514 |                  0.382 |                 87.571 |                        | 
  |                  0.050 |                  0.000 |                  0.050 |                  0.050 |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.050 |                  0.750 |                  0.108 | 
  |                  0.083 |                  0.000 |                  0.050 |                  0.083 |                  0.000 |                  0.000 |                  0.000 |                  0.053 |                  0.000 |                  0.000 |                  0.059 |                  0.833 |                        | 
  |                  0.005 |                  0.000 |                  0.005 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.005 |                  0.081 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  Column Total |                     12 |                     19 |                     20 |                     12 |                     14 |                     13 |                     10 |                     19 |                     17 |                     14 |                     17 |                     18 |                    185 | 
  |                  0.065 |                  0.103 |                  0.108 |                  0.065 |                  0.076 |                  0.070 |                  0.054 |                  0.103 |                  0.092 |                  0.076 |                  0.092 |                  0.097 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  예측률 : (9+16+17+9+2+11+7+15+16+9+13+15)/185 = 0.7513514 라플라스0, 빈도수 5이상

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●결과3●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
| book_dtm_test_labels 
book_test_predict |     art_popularculture |            computer_it |                economy |        history_culture |             humanities |                  novel |             poem_essay |       politics_society |               religion |           selfdevelope |                 sience | technology_engineering |              Row Total | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  art_popularculture |                      9 |                      1 |                      1 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      0 |                     12 | 
  |                 86.841 |                  0.044 |                  0.068 |                  0.778 |                  0.908 |                  0.843 |                  0.190 |                  1.232 |                  1.103 |                  0.908 |                  1.103 |                  1.168 |                        | 
  |                  0.750 |                  0.083 |                  0.083 |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.065 | 
  |                  0.750 |                  0.053 |                  0.050 |                  0.000 |                  0.000 |                  0.000 |                  0.100 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.049 |                  0.005 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  computer_it |                      1 |                     15 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      2 |                     20 | 
  |                  0.068 |                 81.594 |                  2.162 |                  1.297 |                  0.174 |                  1.405 |                  1.081 |                  2.054 |                  1.838 |                  0.174 |                  1.838 |                  0.002 |                        | 
  |                  0.050 |                  0.750 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.100 |                  0.108 | 
  |                  0.083 |                  0.789 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.111 |                        | 
  |                  0.005 |                  0.081 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.011 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  economy |                      0 |                      1 |                     16 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                     19 | 
  |                  1.232 |                  0.464 |                 94.686 |                  1.232 |                  0.133 |                  1.335 |                  1.027 |                  1.951 |                  1.746 |                  0.133 |                  1.746 |                  1.849 |                        | 
  |                  0.000 |                  0.053 |                  0.842 |                  0.000 |                  0.053 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.053 |                  0.000 |                  0.000 |                  0.103 | 
  |                  0.000 |                  0.053 |                  0.800 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.005 |                  0.086 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  history_culture |                      0 |                      0 |                      0 |                      9 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                     10 | 
  |                  0.649 |                  1.027 |                  1.081 |                107.524 |                  0.757 |                  0.703 |                  0.541 |                  0.001 |                  0.919 |                  0.757 |                  0.919 |                  0.973 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.900 |                  0.000 |                  0.000 |                  0.000 |                  0.100 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.054 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.750 |                  0.000 |                  0.000 |                  0.000 |                  0.053 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.049 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  humanities |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      1 |                      2 |                      1 |                      4 | 
  |                  0.259 |                  0.411 |                  0.432 |                  0.259 |                  0.303 |                  0.281 |                  0.216 |                  0.411 |                  0.368 |                  1.606 |                  7.250 |                  0.959 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.250 |                  0.500 |                  0.250 |                  0.022 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.118 |                  0.056 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.011 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  novel |                      0 |                      0 |                      0 |                      0 |                      1 |                     10 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                     11 | 
  |                  0.714 |                  1.130 |                  1.189 |                  0.714 |                  0.034 |                110.144 |                  0.595 |                  1.130 |                  1.011 |                  0.832 |                  1.011 |                  1.070 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.091 |                  0.909 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.059 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.769 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.054 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  poem_essay |                      0 |                      0 |                      0 |                      0 |                      2 |                      0 |                      7 |                      0 |                      0 |                      1 |                      0 |                      0 |                     10 | 
  |                  0.649 |                  1.027 |                  1.081 |                  0.649 |                  2.042 |                  0.703 |                 77.191 |                  1.027 |                  0.919 |                  0.078 |                  0.919 |                  0.973 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.200 |                  0.000 |                  0.700 |                  0.000 |                  0.000 |                  0.100 |                  0.000 |                  0.000 |                  0.054 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.143 |                  0.000 |                  0.700 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.011 |                  0.000 |                  0.038 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  politics_society |                      0 |                      0 |                      0 |                      1 |                      1 |                      1 |                      1 |                     15 |                      0 |                      1 |                      0 |                      0 |                     20 | 
  |                  1.297 |                  2.054 |                  2.162 |                  0.068 |                  0.174 |                  0.117 |                  0.006 |                 81.594 |                  1.838 |                  0.174 |                  1.838 |                  1.946 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.050 |                  0.050 |                  0.050 |                  0.750 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.108 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.071 |                  0.077 |                  0.100 |                  0.789 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.005 |                  0.005 |                  0.081 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  religion |                      1 |                      0 |                      1 |                      0 |                      5 |                      2 |                      1 |                      1 |                     17 |                      1 |                      1 |                      0 |                     30 | 
  |                  0.460 |                  3.081 |                  1.552 |                  1.946 |                  3.282 |                  0.006 |                  0.238 |                  1.406 |                 73.590 |                  0.711 |                  1.120 |                  2.919 |                        | 
  |                  0.033 |                  0.000 |                  0.033 |                  0.000 |                  0.167 |                  0.067 |                  0.033 |                  0.033 |                  0.567 |                  0.033 |                  0.033 |                  0.000 |                  0.162 | 
  |                  0.083 |                  0.000 |                  0.050 |                  0.000 |                  0.357 |                  0.154 |                  0.100 |                  0.053 |                  1.000 |                  0.071 |                  0.059 |                  0.000 |                        | 
  |                  0.005 |                  0.000 |                  0.005 |                  0.000 |                  0.027 |                  0.011 |                  0.005 |                  0.005 |                  0.092 |                  0.005 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  selfdevelope |                      0 |                      0 |                      1 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      7 |                      0 |                      0 |                      9 | 
  |                  0.584 |                  0.924 |                  0.001 |                  0.584 |                  0.149 |                  0.632 |                  0.486 |                  0.924 |                  0.827 |                 58.626 |                  0.827 |                  0.876 |                        | 
  |                  0.000 |                  0.000 |                  0.111 |                  0.000 |                  0.111 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.778 |                  0.000 |                  0.000 |                  0.049 | 
  |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.500 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.038 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  sience |                      0 |                      0 |                      0 |                      1 |                      2 |                      0 |                      0 |                      0 |                      0 |                      1 |                     12 |                      0 |                     16 | 
  |                  1.038 |                  1.643 |                  1.730 |                  0.001 |                  0.514 |                  1.124 |                  0.865 |                  1.643 |                  1.470 |                  0.037 |                 75.411 |                  1.557 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.062 |                  0.125 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.062 |                  0.750 |                  0.000 |                  0.086 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.143 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.706 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.011 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.065 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  technology_engineering |                      1 |                      2 |                      1 |                      1 |                      0 |                      0 |                      0 |                      2 |                      0 |                      0 |                      2 |                     15 |                     24 | 
  |                  0.199 |                  0.088 |                  0.980 |                  0.199 |                  1.816 |                  1.686 |                  1.297 |                  0.088 |                  2.205 |                  1.816 |                  0.019 |                 68.689 |                        | 
  |                  0.042 |                  0.083 |                  0.042 |                  0.042 |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.000 |                  0.000 |                  0.083 |                  0.625 |                  0.130 | 
  |                  0.083 |                  0.105 |                  0.050 |                  0.083 |                  0.000 |                  0.000 |                  0.000 |                  0.105 |                  0.000 |                  0.000 |                  0.118 |                  0.833 |                        | 
  |                  0.005 |                  0.011 |                  0.005 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.011 |                  0.000 |                  0.000 |                  0.011 |                  0.081 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  Column Total |                     12 |                     19 |                     20 |                     12 |                     14 |                     13 |                     10 |                     19 |                     17 |                     14 |                     17 |                     18 |                    185 | 
  |                  0.065 |                  0.103 |                  0.108 |                  0.065 |                  0.076 |                  0.070 |                  0.054 |                  0.103 |                  0.092 |                  0.076 |                  0.092 |                  0.097 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  예측률 : (9+15+16+9+0+10+7+15+17+7+12+15)/185 = 0.7135135 라플라스1, 빈도수5이상 

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●결과4●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
| book_dtm_test_labels 
book_test_predict |     art_popularculture |            computer_it |                economy |        history_culture |             humanities |                  novel |             poem_essay |       politics_society |               religion |           selfdevelope |                 sience | technology_engineering |              Row Total | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  art_popularculture |                     10 |                      0 |                      0 |                      0 |                      2 |                      1 |                      0 |                      0 |                      0 |                      1 |                      1 |                      0 |                     15 | 
  |                 95.870 |                  1.522 |                  1.014 |                  0.870 |                  0.957 |                  0.007 |                  1.087 |                  1.159 |                  1.667 |                  0.364 |                  0.022 |                  1.739 |                        | 
  |                  0.667 |                  0.000 |                  0.000 |                  0.000 |                  0.133 |                  0.067 |                  0.000 |                  0.000 |                  0.000 |                  0.067 |                  0.067 |                  0.000 |                  0.072 | 
  |                  0.833 |                  0.000 |                  0.000 |                  0.000 |                  0.143 |                  0.067 |                  0.000 |                  0.000 |                  0.000 |                  0.040 |                  0.062 |                  0.000 |                        | 
  |                  0.048 |                  0.000 |                  0.000 |                  0.000 |                  0.010 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  computer_it |                      0 |                     16 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      1 |                      1 |                      1 |                     19 | 
  |                  1.101 |                102.740 |                  1.285 |                  1.101 |                  1.285 |                  1.377 |                  1.377 |                  1.469 |                  2.111 |                  0.730 |                  0.150 |                  0.657 |                        | 
  |                  0.000 |                  0.842 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.053 |                  0.053 |                  0.053 |                  0.092 | 
  |                  0.000 |                  0.762 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.040 |                  0.062 |                  0.042 |                        | 
  |                  0.000 |                  0.077 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  economy |                      0 |                      2 |                     12 |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      1 |                      0 |                      1 |                     17 | 
  |                  0.986 |                  0.044 |                102.393 |                  0.986 |                  1.150 |                  1.232 |                  1.232 |                  0.075 |                  1.889 |                  0.540 |                  1.314 |                  0.478 |                        | 
  |                  0.000 |                  0.118 |                  0.706 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.059 |                  0.000 |                  0.059 |                  0.000 |                  0.059 |                  0.082 | 
  |                  0.000 |                  0.095 |                  0.857 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.062 |                  0.000 |                  0.040 |                  0.000 |                  0.042 |                        | 
  |                  0.000 |                  0.010 |                  0.058 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.005 |                  0.000 |                  0.005 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  history_culture |                      0 |                      0 |                      0 |                      6 |                      2 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                      0 |                      9 | 
  |                  0.522 |                  0.913 |                  0.609 |                 57.522 |                  3.180 |                  0.652 |                  0.652 |                  0.133 |                  1.000 |                  1.087 |                  0.696 |                  1.043 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.667 |                  0.222 |                  0.000 |                  0.000 |                  0.111 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.043 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.500 |                  0.143 |                  0.000 |                  0.000 |                  0.062 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.029 |                  0.010 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  humanities |                      0 |                      0 |                      1 |                      1 |                      6 |                      0 |                      1 |                      3 |                      2 |                      3 |                      1 |                      0 |                     18 | 
  |                  1.043 |                  1.826 |                  0.039 |                  0.002 |                 18.789 |                  1.304 |                  0.071 |                  1.860 |                  0.000 |                  0.314 |                  0.110 |                  2.087 |                        | 
  |                  0.000 |                  0.000 |                  0.056 |                  0.056 |                  0.333 |                  0.000 |                  0.056 |                  0.167 |                  0.111 |                  0.167 |                  0.056 |                  0.000 |                  0.087 | 
  |                  0.000 |                  0.000 |                  0.071 |                  0.083 |                  0.429 |                  0.000 |                  0.067 |                  0.188 |                  0.087 |                  0.120 |                  0.062 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.029 |                  0.000 |                  0.005 |                  0.014 |                  0.010 |                  0.014 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  novel |                      1 |                      0 |                      0 |                      0 |                      0 |                     11 |                      2 |                      0 |                      1 |                      0 |                      0 |                      0 |                     15 | 
  |                  0.020 |                  1.522 |                  1.014 |                  0.870 |                  1.014 |                 90.407 |                  0.767 |                  1.159 |                  0.267 |                  1.812 |                  1.159 |                  1.739 |                        | 
  |                  0.067 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.733 |                  0.133 |                  0.000 |                  0.067 |                  0.000 |                  0.000 |                  0.000 |                  0.072 | 
  |                  0.083 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.733 |                  0.133 |                  0.000 |                  0.043 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.053 |                  0.010 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  poem_essay |                      1 |                      0 |                      0 |                      1 |                      2 |                      2 |                     12 |                      0 |                      0 |                      3 |                      0 |                      0 |                     21 | 
  |                  0.039 |                  2.130 |                  1.420 |                  0.039 |                  0.237 |                  0.150 |                 72.150 |                  1.623 |                  2.333 |                  0.085 |                  1.623 |                  2.435 |                        | 
  |                  0.048 |                  0.000 |                  0.000 |                  0.048 |                  0.095 |                  0.095 |                  0.571 |                  0.000 |                  0.000 |                  0.143 |                  0.000 |                  0.000 |                  0.101 | 
  |                  0.083 |                  0.000 |                  0.000 |                  0.083 |                  0.143 |                  0.133 |                  0.800 |                  0.000 |                  0.000 |                  0.120 |                  0.000 |                  0.000 |                        | 
  |                  0.005 |                  0.000 |                  0.000 |                  0.005 |                  0.010 |                  0.010 |                  0.058 |                  0.000 |                  0.000 |                  0.014 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  politics_society |                      0 |                      0 |                      0 |                      1 |                      1 |                      1 |                      0 |                     11 |                      0 |                      1 |                      1 |                      0 |                     16 | 
  |                  0.928 |                  1.623 |                  1.082 |                  0.006 |                  0.006 |                  0.022 |                  1.159 |                 77.077 |                  1.778 |                  0.450 |                  0.045 |                  1.855 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.062 |                  0.062 |                  0.062 |                  0.000 |                  0.688 |                  0.000 |                  0.062 |                  0.062 |                  0.000 |                  0.077 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.083 |                  0.071 |                  0.067 |                  0.000 |                  0.688 |                  0.000 |                  0.040 |                  0.062 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.005 |                  0.000 |                  0.053 |                  0.000 |                  0.005 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  religion |                      0 |                      0 |                      0 |                      0 |                      1 |                      0 |                      0 |                      0 |                     19 |                      0 |                      0 |                      0 |                     20 | 
  |                  1.159 |                  2.029 |                  1.353 |                  1.159 |                  0.092 |                  1.449 |                  1.449 |                  1.546 |                126.672 |                  2.415 |                  1.546 |                  2.319 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.050 |                  0.000 |                  0.000 |                  0.000 |                  0.950 |                  0.000 |                  0.000 |                  0.000 |                  0.097 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.071 |                  0.000 |                  0.000 |                  0.000 |                  0.826 |                  0.000 |                  0.000 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.000 |                  0.000 |                  0.000 |                  0.092 |                  0.000 |                  0.000 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  selfdevelope |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                     14 |                      1 |                      0 |                     15 | 
  |                  0.870 |                  1.522 |                  1.014 |                  0.870 |                  1.014 |                  1.087 |                  1.087 |                  1.159 |                  1.667 |                 82.004 |                  0.022 |                  1.739 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.933 |                  0.067 |                  0.000 |                  0.072 | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.560 |                  0.062 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.068 |                  0.005 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  sience |                      0 |                      0 |                      1 |                      3 |                      0 |                      0 |                      0 |                      0 |                      1 |                      1 |                      9 |                      0 |                     15 | 
  |                  0.870 |                  1.522 |                  0.000 |                  5.220 |                  1.014 |                  1.087 |                  1.087 |                  1.159 |                  0.267 |                  0.364 |                 53.022 |                  1.739 |                        | 
  |                  0.000 |                  0.000 |                  0.067 |                  0.200 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.067 |                  0.067 |                  0.600 |                  0.000 |                  0.072 | 
  |                  0.000 |                  0.000 |                  0.071 |                  0.250 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.043 |                  0.040 |                  0.562 |                  0.000 |                        | 
  |                  0.000 |                  0.000 |                  0.005 |                  0.014 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.005 |                  0.005 |                  0.043 |                  0.000 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  technology_engineering |                      0 |                      3 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      0 |                      2 |                     22 |                     27 | 
  |                  1.565 |                  0.025 |                  1.826 |                  1.565 |                  1.826 |                  1.957 |                  1.957 |                  2.087 |                  3.000 |                  3.261 |                  0.004 |                113.742 |                        | 
  |                  0.000 |                  0.111 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.074 |                  0.815 |                  0.130 | 
  |                  0.000 |                  0.143 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.125 |                  0.917 |                        | 
  |                  0.000 |                  0.014 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.000 |                  0.010 |                  0.106 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  Column Total |                     12 |                     21 |                     14 |                     12 |                     14 |                     15 |                     15 |                     16 |                     23 |                     25 |                     16 |                     24 |                    207 | 
  |                  0.058 |                  0.101 |                  0.068 |                  0.058 |                  0.068 |                  0.072 |                  0.072 |                  0.077 |                  0.111 |                  0.121 |                  0.077 |                  0.116 |                        | 
  -----------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|------------------------|
  예측률 : (22+9+14+19+11+12+11+6+6+12+16+10)/207 = 0.7149758 라플라스0,weightBin옵션o

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●순서5●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
5. 새로운 데이터 입력
library(rvest)
#예1.'신작 거꾸로 읽는 그리스 로마사', 장르는 역사 (제목, 소개 내용 추출해서 new변수에 저장)
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9791130679945&orderClick=sbb',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#예2. '니체 사용설명서', 장르는 인문학
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=05131301&barcode=9791192128085',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#예3. '자아발견과 비전탐색', 장르는 자기계발
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=150101&barcode=9788963248394',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#예4. '태양의 저쪽 밤의 이쪽', 장르는 시/에세이
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=030701&barcode=9791170400752',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#예5. '경주남산(세계문화유산) 세트', 장르는 역사
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=19&barcode=9791190841825',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#예6. '예배, 공동체, 삼위일체 하나님', 장르는 종교
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=21030301&barcode=9788932819143',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#예6. '천하', 장르는 정치/사회
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=05131511&barcode=9791190944618',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))



#정답라벨 추가
new <- data.frame(field='poem_essay',text=new)

# 말뭉치 변환
new_corpus <- VCorpus(VectorSource(new$text))

# 기존에 추출했던 단어들을 기준으로 사전을 만들기 위해 words라는 변수에 저장
words <- Terms(book_dtm) 
tail(words,6000)

# 기존에 토큰화 하는 함수mecab_words를 똑같이 적용하고, 기존에 추출했던 단어들을 사전으로 만들고 사전에 있는 단어들을 기준으로 dtm을 만든다
new_dtm <- DocumentTermMatrix(new_corpus,control=list(tokenize=mecab_words,
                                                      dictionary=words)) 
inspect(new_dtm)
#빈도수 표시 대신 yes와 no로 이분화
new_dtm_test <- apply(new_dtm,MARGIN=2,convert_counts) 

#예측 
predict(book_classifier,t(new_dtm_test)) #출력결과 : 1. history_culture(예측 성공) // 2. religion (예측 실패) //3. computer_it(예측 실패)

●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●순서6●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
6. 시각화

#기존의 토큰화한 함수를 적용하여 단어 추출
content <- lapply(book$text,mecab_words)

# 두글자 이상만 추출
content <- lapply(content,function(x) x[nchar(x)>=2])

# 각 리스트마다 벡터형으로 단어 합치기
content <- sapply(content,function(x) paste(x,collapse=' '))

# 데이터프레임 형식으로 만들기
book_field_df <- data.frame(field=book$field,word=content)

# 분야별로 나누기
novel <- book_field_df[book_field_df$field=='novel',]
poem_essay <- book_field_df[book_field_df$field=='poem_essay',]
economy <- book_field_df[book_field_df$field=='economy',]
selfdevelope <- book_field_df[book_field_df$field=='selfdevelope',]
humanities <- book_field_df[book_field_df$field=='humanities',]
history_culture <- book_field_df[book_field_df$field=='history_culture',]
religion <- book_field_df[book_field_df$field=='religion',]
politics_society <- book_field_df[book_field_df$field=='politics_society',]
art_popularculture <- book_field_df[book_field_df$field=='art_popularculture',]
sience <- book_field_df[book_field_df$field=='sience',]
technology_engineering <- book_field_df[book_field_df$field=='technology_engineering',]
computer_it <- book_field_df[book_field_df$field=='computer_it',]

#분야별 table함수로 단어 빈도수 구하기
novel_t <- data.frame(table(str_split(paste(novel$word,collapse = ' '),' ')))
names(novel_t) <- c('word','freq')
novel_t$field <- 'novel'

poem_essay_t <- data.frame(table(str_split(paste(poem_essay$word,collapse = ' '),' ')))
names(poem_essay_t) <- c('word','freq')
poem_essay_t$field <- 'poem_essay'

economy_t <- data.frame(table(str_split(paste(economy$word,collapse = ' '),' ')))
names(economy_t) <- c('word','freq')
economy_t$field <- 'economy'

selfdevelope_t <- data.frame(table(str_split(paste(selfdevelope$word,collapse = ' '),' ')))
names(selfdevelope_t) <- c('word','freq')
selfdevelope_t$field <- 'selfdevelope'

humanities_t <- data.frame(table(str_split(paste(humanities$word,collapse = ' '),' ')))
names(humanities_t) <- c('word','freq')
humanities_t$field <- 'humanities'

history_culture_t <- data.frame(table(str_split(paste(history_culture$word,collapse = ' '),' ')))
names(history_culture_t) <- c('word','freq')
history_culture_t$field <- 'history_culture'

religion_t <- data.frame(table(str_split(paste(religion$word,collapse = ' '),' ')))
names(religion_t) <- c('word','freq')
religion_t$field <- 'religion'

politics_society_t <- data.frame(table(str_split(paste(politics_society$word,collapse = ' '),' ')))
names(politics_society_t) <- c('word','freq')
politics_society_t$field <- 'politics_society'

art_popularculture_t <- data.frame(table(str_split(paste(art_popularculture$word,collapse = ' '),' ')))
names(art_popularculture_t) <- c('word','freq')
art_popularculture_t$field <- 'art_popularculture'

sience_t <- data.frame(table(str_split(paste(sience$word,collapse = ' '),' ')))
names(sience_t) <- c('word','freq')
sience_t$field <- 'sience'

technology_engineering_t <- data.frame(table(str_split(paste(technology_engineering$word,collapse = ' '),' ')))
names(technology_engineering_t) <- c('word','freq')
technology_engineering_t$field <- 'technology_engineering'

computer_it_t <- data.frame(table(str_split(paste(computer_it$word,collapse = ' '),' ')))
names(computer_it_t) <- c('word','freq')
computer_it_t$field <- 'computer_it'
unique(book_field_df$field)

# rbind로 통합
book_field_total <- rbind(novel_t,poem_essay_t,economy_t,selfdevelope_t,humanities_t,history_culture_t,
      religion_t,politics_society_t,art_popularculture_t,sience_t,technology_engineering_t,computer_it_t)

#wordcloud를 만들기 위한 형식으로 변경
book_field_total <- acast(book_field_total,word~field,value.var = 'freq',fill=0)
book_field_total

# 분야별 단어 빈도수 비교 도표
windows(width=20,height=12)
wordcloud::comparison.cloud(book_field_total, 
                            title.bg.colors = rainbow(ncol(book_field_total)),
                            colors = rainbow(ncol(book_field_total)),
                            title.size=2, rot.per=0.01)



