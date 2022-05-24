�ڴٳ��� apple ��Ʈ�� �̸� ���� ���� ���� �ؼ� �����������ӿ� �ֱ�
�޸� ��� ���� ���� ������ �����ϱ�

0. ȯ�漳��
#���󼭹� ����, �ʿ��� ���̺귯�� ��������
#cmdâ���� ���� : java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777
library(RSelenium)
library(rvest)
library(dplyr)
library(stringr)

1. �ٳ��� ����Ʈ�� ��Ʈ��ī�װ�����. �󼼰˻����� �����纰�� ������ ��ư 
Ŭ�� �� appleüũ�ڽ��� üũ�ϱ�(����)
#remoteDriver�� �̿��Ͽ� ���󼭹��� �����ϰ� �ٳ��� ��Ʈ��ī�װ� �������� �����ϵ��� �Ѵ�.
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')

'''
#�����纰 ������ ��ư�� xpath�� �����Ͽ� click�ϴ� �۾��� ����
//*[@id="dlMaker_extend"]/dd/div[2]/button[1] # �����纰 ������ ��ư
'''
#xpath�� ������ �ȵǴ� ������ �־ ��ư�� class �̸����� Ŭ���۾� ����,css�����ڻ��
remdr$findElement(using='class',value='btn_spec_view')$clickElement()

#apple�̶�� üũ�ڽ��� Ŭ���ϴ� �۾� ���� css�����ڻ��(���� �Ȱ��� xpath�� �ȵ�?�־ȵ���? )
//*[@id="searchMaker1452"]
/html/body/div[2]/div[2]/div[5]/div[2]/div[2]/form/div[2]/div[2]/div[1]/div[2]/div[2]/div/dl[1]/dd/ul[2]/li[17]/label/input
remdr$findElement(using='id',value='searchMaker1452')$clickElement()

#�������� ��ȯ��Ų ������ �����ͼ� html�� ��ȯ
source <- remdr$getPageSource()[[1]] 
html <- read_html(source)

2. ��Ʈ�� �̸�, ����, ssd���, ���� ��������
�� ������  
    (1)�̸��� ������ �ϳ��ε� ���� ������ ���� �̸��� ������
          - �ذ�å 1 : �̸��� ��簡���� �ѹ��� ���� �̾ƺ��� 
          - �ذ�å 2 : ��ü html�� �̸��̶� ���,������ ����?(�ʹ� ������ ����?)
    (2)31���� ��Ʈ���� ������Ʈ������ ������ �ʰ� �ٸ� ��Ʈ�ϵ�� �Ȱ��� �±׸� ������ ���� �ٸ� ���� id�� ����

#��Ʈ�� �̸� css�����ڸ� �̿�
name <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
  html_text()
name <- str_trim(name)

# ��Ʈ�� ����
info <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
  html_text()
info <- str_trim(info)

# ssd ���, ����
price <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li > p.price_sect >a ')%>%
  html_text())
memory <- str_trim(html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_pricelist > ul > li > div.over_preview > p.memory_sect')%>%
  html_text())


3. �ٸ� �������� ��Ʈ�ϵ� ��������(����)
#ù��° �������� �ִ� apple��Ʈ���� div4�� �ִ�. �ι�° ����° �������� �ִ� apple
#��Ʈ���� div3�� �ִ�.
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[1]/div/div[2]/p
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[2]/div/div[2]/p

/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[1]/div/div[2]/p/a
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[2]/div/div[2]/p/a

/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[3]/ul/li[1]/div/div[2]/p

#javascript�� �����ϴ� onclick='javascript:movePage(2)'�� executeScript�� ����Ͽ� ������ �� �ִ�.
remdr$executeScript('javascript:movePage(2)') #2page�� �̵�
  #�������� ��ȯ��Ų ������ �����ͼ� html�� ��ȯ
source <- remdr$getPageSource()[[1]] 
html <- read_html(source)

#1,2,3������ ��� �±״� ����
html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
  html_text()



#---------------------------------------------����

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
  #��Ʈ�� �̸� css�����ڸ� �̿�
  name <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > p.prod_name > a')%>%
    html_text()
  name <- str_trim(name)
  
  # ��Ʈ�� ����
  info <- html_nodes(html,'div.main_prodlist > ul.product_list > li.prod_item > div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
    html_text()
  info <- str_trim(info)
  
  # ssd ���, ����
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

�� ������  
(1)�̸��� ������ �ϳ��ε� ���� ������ ���� �̸��� ������
(2)31���� ��Ʈ���� ������Ʈ������ ������ �ʰ� �ٸ� ��Ʈ�ϵ�� �Ȱ��� �±׸� ������ ���� �ٸ� ���� id�� ����


#for(i in 1:length(li))
html <- read_html('http://prod.danawa.com/list/?cate=112758&15main_11_02')
str_trim(html_nodes(html,xpath='/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[1]/div/div[3]/ul')%>%
  html_nodes('li')%>%
  html_text())
html_nodes <-
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[1]/div/div[2]/p/a
/html/body/div[2]/div[2]/div[5]/div[2]/div[6]/div/div[2]/div[4]/ul/li[2]/div/div[2]/p/a
for(i in 1:length())

#-----------------------------------------����� ��Ʈ
//*[@id="productListArea"]/div[5]/div/div/a[1]
//*[@id="productListArea"]/div[5]/div/div/a[2]
//*[@id="productListArea"]/div[4]/div/div/a[3]
  
for(page in 1:3){
  remdr$findElement(using='xpath',
                    value=paste0('//*[@id="productListArea"]/div[5]/div/div/a[',page+1,']'))$clickElement()
  Sys.sleep(3)
}

�������� : Selenium message:no such element: Unable to locate element: {"method":"xpath","selector":"//*[@id="productListArea"]/div[5]/div/div/a[3]"}


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
��Ʈ�� ���� li�� ���� ������ div�� ��ġ�ϴ� ����, ����, �޸𸮸� �����������ӿ� �ִ� ����

#--------------------------------------- ����

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
    h <- html_nodes(html,paste0('div.main_prodlist > ul.product_list >li.prod_item'))[i] #�� ��Ʈ���� li�±׸� �����ͼ� h������ ����
    name <- str_trim(html_nodes(h,'div.prod_main_info > div.prod_info > p.prod_name > a')%>%
                       html_text())
    info <- str_trim(html_nodes(h,'div.prod_main_info > div.prod_info > dl.prod_spec_set > dd > div.spec_list')%>%
                       html_text())
    pm <- str_squish(str_replace_all(html_nodes(h,'ul > li')%>% html_text(), '\n|\t',' '))  # �� li�±�(�� ��Ʈ��)�ȿ� ul�±׾ȿ� li�� ����
    for(j in 1:length(pm)){
      df <- rbind(df,data.frame(name=name,info=info,
                                pm=pm[j]))
      
    }
  }
  Sys.sleep(2)  
}

View(df)

#price�� memory ��ó���۾�
str_extract_all(df$pm,'\\w+�� ��ǰ��')
str_extract_all(df$pm,'�������� ������')
df$pm <- str_replace_all(df$pm,'\\w+�� ��ǰ��','')
df$pm <- str_replace_all(df$pm,'�������� ������','')
df$pm
View(df)

#apple�� ���� ���� ��â�� �� �ߴ� �͵� 
df <- df[substr(df$name,1,5)=='APPLE',] #name�� ���� 1~5��° ���� apple�� �ุ ����
View(df)

#-----------------------------------------------------��δ�����

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
  #�������̵� - 3,4�������� �ٸ��Ƿ� xpath ��� �Ұ�
  #remdr$findElement(using='xpath',value='//*[@id="productListArea"]/div[5]/div/div/a[1]')$clickElement()
  #�������̵�
  remdr$findElement(using='css',value=paste0('div.number_wrap > a:nth-child(',i,')'))$clickElement()
  Sys.sleep(2)
  html <- read_html(remdr$getPageSource()[[1]])
  id_tmp<-as.character(na.omit(html_nodes(html,'div.main_prodlist.main_prodlist_list>ul.product_list>li')%>%html_attr('id')))
  id<-c(id,id_tmp)
  for (j in 1:length(id)){
    id_info <- html_nodes(html,paste0('li#',id[j]))
    name<-html_nodes(id_info,'p.prod_name')%>%html_text()%>%str_trim%>%str_remove_all('�α�\\s+����\\d{1,2}')%>%str_trim
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
names(apple)<-c('��Ʈ�ϸ�','����','����')
View(apple)


#---------------------------------------------------------------����� ��


library(RSelenium)
library(xml2)
library(rvest)

#cmd���� ����
java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777

#
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()


0. �ٳ��� ��Ʈ�ϻ���Ʈ �ּ�
http://prod.danawa.com/list/?cate=112758&15main_11_02

remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')

1. ��Ʈ�� �귣�� ������ ��ư xpath
//*[@id="dlMaker_simple"]/dd/div[2]/button[1]
remdr$findElement(using='xpath',value='//*[@id="dlMaker_simple"]/dd/div[2]/button[1]')$clickElement()

2. apple üũ�ڽ� xpath
//*[@id="searchMaker1452"]
remdr$findElement(using='xpath',value='//*[@id="searchMaker1452"]')$clickElement()

source <- remdr$getPageSource()[[1]]
html <- read_html(source)

3.�� �������� ��ü apple��Ʈ�� �±�(���������� �ȳ����� li�� ����)
#xpath
#ul <- html_node(html,xpath='//*[@id="productListArea"]/div[4]/ul')
#css ������
ul <- html_node(html,'div#productListArea > div.main_prodlist.main_prodlist_list > ul.product_list ') #Ŭ������ ���̵� �̸��� �ΰ� ���� �� �� �� �ᵵ �������.

html_node(ul,'li.product-pot')%>% html_text()
xml_remove(ul%>%html_nodes('li.product-pot'))

4. ��ǰ�̸�
prod_name <- html_nodes(ul,'li > div > div.prod_info > p > a')%>% html_text()
prod_name <- trimws(prod_name)

5. ��ǰ����
prod_info <- html_nodes(ul,'div.spec_list')%>% html_text()
prod_info <- gsub('/',',',trimws(prod_info))

View(data.frame(prod_name=prod_name,prod_info=prod_info))

6. ��ǰ����
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
    temp <- c(temp,paste('���� : ', spec, '����: ',price))
  }
  lst <- append(lst,list(temp))
}
lst[[2]]

spec_price <- sapply(lst,function(x) paste(x,collapse = ' / '))

[[1]] # ���ͷ� �ϸ� ���߿� ������ �ȵǴϱ� list���Ŀ� �ֱ�(�ϳ��� ��Ʈ�Ͽ� �ΰ� �̻��� ���� ..)
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

7. ��ġ��
apple <- data.frame()
apple <- rbind(apple,data.frame(prod_name=prod_name,prod_info=prod_info,prod_price=spec_price))
View(apple)


8. �ٸ� ���������� �������� (����)- ����
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777,browserName='chrome')
remdr$open()
remdr$navigate('http://prod.danawa.com/list/?cate=112758&15main_11_02')
remdr$findElement(using='xpath',value='//*[@id="dlMaker_simple"]/dd/div[2]/button[1]')$clickElement()
remdr$findElement(using='xpath',value='//*[@id="searchMaker1452"]')$clickElement()

apple <- data.frame()
for(page in 1:3){
  source <- remdr$getPageSource()[[1]]
  html <- read_html(source)
  
  ul <- html_node(html,'div#productListArea > div.main_prodlist.main_prodlist_list > ul.product_list ') #Ŭ������ ���̵� �̸��� �ΰ� ���� �� �� �� �ᵵ �������.

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
      temp <- c(temp,paste('���� : ', spec, '����: ',price))
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
