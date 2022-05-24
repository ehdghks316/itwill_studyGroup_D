★다나와 apple 노트북 이름 정보 가격 추출 해서 데이터프레임에 넣기
메모리 사양 별로 따로 가격은 추출하기

0. 환경설정
#가상서버 열기, 필요한 라이브러리 가져오기
#cmd창에서 실행 : java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777
library(RSelenium)
library(rvest)
library(dplyr)
library(stringr)

1. 다나와 사이트에 노트북카테고리들어가기. 상세검색란에 제조사별에 더보기 버튼 
클릭 후 apple체크박스를 체크하기(동적)
#remoteDriver을 이용하여 가상서버에 접속하고 다나와 노트북카테고리 페이지에 접속하도록 한다.
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')

'''
#제조사별 더보기 버튼의 xpath를 추출하여 click하는 작업을 수행
//*[@id="dlMaker_extend"]/dd/div[2]/button[1] # 제조사별 더보기 버튼
'''
#xpath로 실행이 안되는 오류가 있어서 버튼의 class 이름으로 클릭작업 수행,css선택자사용
remdr$findElement(using='class',value='btn_spec_view')$clickElement()

#apple이라는 체크박스를 클릭하는 작업 수행 css선택자사용(위랑 똑같이 xpath는 안됨?왜안되지? )
//*[@id="searchMaker1452"]
/html/body/div[2]/div[2]/div[5]/div[2]/div[2]/form/div[2]/div[2]/div[1]/div[2]/div[2]/div/dl[1]/dd/ul[2]/li[17]/label/input
remdr$findElement(using='id',value='searchMaker1452')$clickElement()

#동적으로 변환시킨 페이지 가져와서 html로 변환
source <- remdr$getPageSource()[[1]] 
html <- read_html(source)

2. 노트북 이름, 정보, ssd사양, 가격 가져오기
● 문제점  
    (1)이름과 정보는 하나인데 사양과 가격은 같은 이름에 여러개
          - 해결책 1 : 이름과 사양가격은 한번에 같이 뽑아보기 
          - 해결책 2 : 전체 html과 이름이랑 사양,가격을 조인?(너무 복잡한 느낌?)
    (2)31번의 노트북은 웹사이트에서는 보이지 않고 다른 노트북들과 똑같은 태그를 가지고 있음 다른 점은 id가 없음

#노트북 이름 css선택자를 이용
name <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
  html_text()
name <- str_trim(name)

# 노트북 정보
info <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
  html_text()
info <- str_trim(info)

# ssd 사양, 가격
price <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li > p.price_sect >a ')%>%
  html_text())
memory <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li > div.over_preview > p.memory_sect')%>%
  html_text())


3. 다른 페이지의 노트북도 가져오기(동적)
#첫번째 페이지에 있는 apple노트북은 div4에 있다. 두번째 세번째 페이지에 있는 apple
#노트북은 div3에 있다.
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[1]/div/div[2]/p
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[2]/div/div[2]/p

/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[1]/div/div[2]/p/a
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[2]/div/div[2]/p/a

/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[1]/div/div[2]/p

#javascript로 동작하는 onclick='javascript:movePage(2)'을 executeScript를 사용하여 수행할 수 있다.
remdr$executeScript('javascript:movePage(2)') #2page로 이동
  #동적으로 변환시킨 페이지 가져와서 html로 변환
source <- remdr$getPageSource()[[1]] 
html <- read_html(source)

#1,2,3페이지 모두 태그는 같음
html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
  html_text()



#---------------------------------------------종합

remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')

remdr$findElement(using='class',value='btn_spec_view')$clickElement()
remdr$findElement(using='id',value='searchMaker1452')$clickElement()

notebook <- data.frame()
p1 <- c()
p2 <- c()
p3 <- c()
for(i in 1:3){
  if(i >= 2){
    remdr$executeScript(paste0('javascript:movePage(',i,')'))
  }
  source <- remdr$getPageSource()[[1]] 
  html <- read_html(source)
  #노트북 이름 css선택자를 이용
  name <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
    html_text()
  name <- str_trim(name)
  
  # 노트북 정보
  info <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
    html_text()
  info <- str_trim(info)
  
  # ssd 사양, 가격
  price <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li > p.price_sect >a ')%>%
                      html_text())
  memory <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li > div.over_preview > p.memory_sect')%>%
                       html_text())
  
  n <- c(name,info,price,memory)
  
  if(i==1){
    p1 <- n
  }else if(i==2){
    p2 <- n
  }else {
    p3 <- n
  }
  Sys.sleep(1)
}
p1
p2
p3

● 문제점  
(1)이름과 정보는 하나인데 사양과 가격은 같은 이름에 여러개
(2)31번의 노트북은 웹사이트에서는 보이지 않고 다른 노트북들과 똑같은 태그를 가지고 있음 다른 점은 id가 없음


#for(i in 1:length(li))
html <- read_html('http://prod.danawa.com/list/?cate=112758&15main_11_02')
str_trim(html_nodes(html,xpath='/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[1]/div/div[3]/ul')%>%
  html_nodes('li')%>%
  html_text())
html_nodes <-
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[1]/div/div[2]/p/a
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[2]/div/div[2]/p/a
for(i in 1:length())

#-----------------------------------------강사님 힌트
//*[@id="productListArea"]/div[5]/div/div/a[1]
//*[@id="productListArea"]/div[5]/div/div/a[2]
//*[@id="productListArea"]/div[4]/div/div/a[3]
  
for(page in 1:3){
  remdr$findElement(using='xpath',
                    value=paste0('//*[@id="productListArea"]/div[5]/div/div/a[',page+1,']'))$clickElement()
  Sys.sleep(3)
}

오류나옴 : Selenium message:no such element: Unable to locate element: {"method":"xpath","selector":"//*[@id="productListArea"]/div[5]/div/div/a[3]"}


for(i in 1:3){
  remdr$findElement(using='css',value=paste0('div.number_wrap > a:nth-child(',i,')'))$clickElement()
  source <- remdr$getPageSource()[[1]] 
  html <- read_html(source)
                    
}

/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[1]/div/div[2]/p/a
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[2]/div/div[2]/p/a

html <- read_html('http://prod.danawa.com/list/?cate=112758&15main_11_02')
name <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
  html_text())

str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li')%>%
  html_text())



str_trim(html_nodes(h,'div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
  html_text())


price_memory <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li')%>%
                           html_text())
노트북 별로 li에 들어가서 각각의 div와 일치하는 정보, 가격, 메모리를 데이터프레임에 넣는 구조

#--------------------------------------- 종합

1. 
remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')

remdr$findElement(using='class',value='btn_spec_view')$clickElement()
remdr$findElement(using='id',value='searchMaker1452')$clickElement()

df <- data.frame()

for(k in 1:3){
  remdr$findElement(using='css',value=paste0('div.number_wrap > a:nth-child(',k,')'))$clickElement()
  source <- remdr$getPageSource()[[1]] 
  html <- read_html(source)

    for(i in 1:31){
    h <- html_nodes(html,paste0('div.main_prodlist > ul.product_list >li.prod_item'))[i] #각 노트북의 li태그를 가져와서 h변수에 저장
    name <- str_trim(html_nodes(h,'div.prod_main_info > div.prod_info > p.prod_name > a')%>%
                       html_text())
    info <- str_trim(html_nodes(h,'div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
                       html_text())
    pm <- str_squish(str_replace_all(html_nodes(h,'ul > li')%>% html_text(), '\n|\t',' '))  # 각 li태그(각 노트북)안에 ul태그안에 li를 추출
    for(j in 1:length(pm)){
      df <- rbind(df,data.frame(name=name,info=info,
                                pm=pm[j]))
      
    }
  }
  Sys.sleep(2)  
}

View(df)

#price와 memory 전처리작업
str_extract_all(df$pm,'\\w+몰 상품비교')
str_extract_all(df$pm,'가격정보 더보기')
df$pm <- str_replace_all(df$pm,'\\w+몰 상품비교','')
df$pm <- str_replace_all(df$pm,'가격정보 더보기','')
df$pm
View(df)

#apple이 없는 행이 웹창에 안 뜨는 것들 
df <- df[substr(df$name,1,5)=='APPLE',] #name의 값중 1~5번째 값이 apple인 행만 추출
View(df)

#-----------------------------------------------------경민누나답

remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758')
remdr$findElement(using='class',value='spec_opt_view')$clickElement()
remdr$findElement(using='xpath',value='//*[@id="searchMaker1452"]')$clickElement()

apple<-data.frame()
memnpri<-NULL
a_spec<-NULL
a_name<-NULL
id<-NULL
for (i in 1:6){
  #페이지이동 - 3,4페이지가 다르므로 xpath 사용 불가
  #remdr$findElement(using='xpath',value='//*[@id="productListArea"]/div[5]/div/div/a[1]')$clickElement()
  #페이지이동
  remdr$findElement(using='css',value=paste0('div.number_wrap > a:nth-child(',i,')'))$clickElement()
  Sys.sleep(2)
  html <- read_html(remdr$getPageSource()[[1]])
  id_tmp<-as.character(na.omit(html_nodes(html,'div.main_prodlist.main_prodlist_list>ul.product_list>li')%>%html_attr('id')))
  id<-c(id,id_tmp)
  for (j in 1:length(id)){
    id_info <- html_nodes(html,paste0('li#',id[j]))
    name<-html_nodes(id_info,'p.prod_name')%>%html_text()%>%str_trim%>%str_remove_all('인기\\s+순위\\d{1,2}')%>%str_trim
    spec <- html_nodes(id_info,'div.spec_list')%>%html_text()%>%str_trim
    p_id<-html_nodes(id_info,'div.prod_pricelist>ul>li')%>%html_attr('id')
    a_name <- c(a_name,name)
    a_spec<- c(a_spec,spec)
    m_p<-NULL
    for (k in 1:length(p_id)){
      memory <- html_nodes(html,xpath=paste0('//*[@id="',p_id[k],'"]//div/p'))%>%html_text()%>%str_trim
      price <- html_nodes(html,xpath=paste0('//*[@id="',p_id[k],'"]/p[2]/a'))%>%html_text()%>%str_trim
      m_p<-str_trim(paste(m_p,paste(memory,price,sep='/'),sep='       '))
      if (k==length(p_id)){
        memnpri <-c(memnpri,m_p)
      }
    }
  }
  apple <- rbind(apple,cbind(a_name,a_spec,memnpri))
}
names(apple)<-c('노트북명','스펙','가격')
View(apple)


#---------------------------------------------------------------강사님 답


library(RSelenium)
library(xml2)
library(rvest)

#cmd에서 접속
java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777

#
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()


0. 다나와 노트북사이트 주소
http://prod.danawa.com/list/?cate=112758&15main_11_02

remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')

1. 노트북 브랜드 더보기 버튼 xpath
//*[@id="dlMaker_simple"]/dd/div[2]/button[1]
remdr$findElement(using='xpath',value='//*[@id="dlMaker_simple"]/dd/div[2]/button[1]')$clickElement()

2. apple 체크박스 xpath
//*[@id="searchMaker1452"]
remdr$findElement(using='xpath',value='//*[@id="searchMaker1452"]')$clickElement()

source <- remdr$getPageSource()[[1]]
html <- read_html(source)

3.한 페이지의 전체 apple노트북 태그(웹페이지에 안나오는 li는 제거)
#xpath
#ul <- html_node(html,xpath='//*[@id="productListArea"]/div[4]/ul')
#css 선택자
ul <- html_node(html,'div#productListArea > div.main_prodlist.main_prodlist_list > ul.product_list ') #클래스나 아이디 이름이 두개 있을 때 둘 다 써도 상관없다.

html_node(ul,'li.product-pot')%>% html_text()
xml_remove(ul%>%html_nodes('li.product-pot'))

4. 제품이름
prod_name <- html_nodes(ul,'li > div > div.prod_info > p > a')%>% html_text()
prod_name <- trimws(prod_name)

5. 제품정보
prod_info <- html_nodes(ul,'div.spec_list')%>% html_text()
prod_info <- gsub('/',',',trimws(prod_info))

View(data.frame(prod_name=prod_name,prod_info=prod_info))

6. 제품가격
price_ul <- html_nodes(ul,'div.prod_pricelist > ul')
price_ul[1]

lst <- list()
for(j in price_ul){
  price_li <- html_nodes(j,'li')
  temp <- c()
  for(i in price_li){
    spec <-  html_nodes(i,'div > p.memory_sect')%>% html_text()
    spec <- trimws(spec)
    price <- html_nodes(i,'p.price_sect > a > strong')%>% html_text()
    temp <- c(temp,paste('스펙 : ', spec, '가격: ',price))
  }
  lst <- append(lst,list(temp))
}
lst[[2]]

spec_price <- sapply(lst,function(x) paste(x,collapse = ' / '))

[[1]] # 벡터로 하면 나중에 구분이 안되니까 list형식에 넣기(하나의 노트북에 두개 이상의 가격 ..)
[1] a b

[[2]]
[1] a b c d e


spec_price

'a / b' 'a / b / c / d / e'
...
<ul>
  <li>...</li>
  <li>...</li>
  
  <ul>
  <li>...</li>
  <li>...</li>
  <li>...</li>
  <li>...</li>
  <li>...</li>
  
  <ul>
  <li>...</li>
  <li>...</li>
  <li>...</li>
  <li>...</li>

7. 합치기
apple <- data.frame()
apple <- rbind(apple,data.frame(prod_name=prod_name,prod_info=prod_info,prod_price=spec_price))
View(apple)


8. 다른 페이지까지 가져오기 (동적)- 종합
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')
remdr$findElement(using='xpath',value='//*[@id="dlMaker_simple"]/dd/div[2]/button[1]')$clickElement()
remdr$findElement(using='xpath',value='//*[@id="searchMaker1452"]')$clickElement()

apple <- data.frame()
for(page in 1:3){
  source <- remdr$getPageSource()[[1]]
  html <- read_html(source)
  
  ul <- html_node(html,'div#productListArea > div.main_prodlist.main_prodlist_list > ul.product_list ') #클래스나 아이디 이름이 두개 있을 때 둘 다 써도 상관없다.

  xml_remove(ul%>%html_nodes('li.product-pot'))

  prod_name <- html_nodes(ul,'li > div > div.prod_info > p > a')%>% html_text()
  prod_name <- trimws(prod_name)

  prod_info <- html_nodes(ul,'div.spec_list')%>% html_text()
  prod_info <- gsub('/',',',trimws(prod_info))
  
  price_ul <- html_nodes(ul,'div.prod_pricelist > ul')

  lst <- list()
  for(j in price_ul){
    price_li <- html_nodes(j,'li')
    temp <- c()
    for(i in price_li){
      spec <-  html_nodes(i,'div > p.memory_sect')%>% html_text()
      spec <- trimws(spec)
      price <- html_nodes(i,'p.price_sect > a > strong')%>% html_text()
      temp <- c(temp,paste('스펙 : ', spec, '가격: ',price))
    }
    lst <- append(lst,list(temp))
  }

  spec_price <- sapply(lst,function(x) paste(x,collapse = ' / '))

  apple <- rbind(apple,data.frame(prod_name=prod_name,prod_info=prod_info,prod_price=spec_price))
  remdr$findElement(using='css',value=paste0('div.number_wrap > a:nth-child(',page+1,')'))$clickElement()
  
  Sys.sleep(2)
}

remdr$close()
View(apple)
