R-������Ʈ
-���� �о� �����ý���

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܼ���1�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
1. ������ ����
library(rvest) # ������������ html�±׸� �����ϰ� �±��� �پ��� �ɼǵ��� ����� �� �ִ� ���̺귯�� 
library(RSelenium) # ������ ���������� �±׸� ������ �� �ִ� ���̺귯��
#cmdâ���� ���󼭹� ���� : java -Dwebdriver.chromedriver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 7777

#���󼭹��� �����Ͽ� �����ϴ� �Լ��� remdr ������ �ֱ�
remdr <- remoteDriver(remoteServerAddr='localhost',port=7777, browserName='chrome')

# ���ͳ� â ����
remdr$open() 

# �������� ���� Ȩ������ ����
remdr$navigate("http://www.kyobobook.co.kr/index.laf")

# �������� Ŭ��
remdr$findElement(using="xpath",value='//*[@id="header"]/div[3]/ul[1]/li[1]/a')$clickElement()

# ���� �帣���� �Ҽ� Ŭ��
remdr$findElement(using="xpath",value='//*[@id="main_snb"]/div[1]/ul[1]/li[1]/a')$clickElement()
//*[@id="main_snb"]/div[1]/ul[1]/li[1]/a # �Ҽ�
//*[@id="main_snb"]/div[1]/ul[1]/li[2]/a # ��/������
//*[@id="main_snb"]/div[1]/ul[1]/li[3]/a # ����/�濵

# ����Ʈ���� Ŭ��
remdr$findElement(using='xpath',value='//*[@id="container"]/div[2]/div/div/div[3]/ul/li[2]/a')$clickElement()

# å ���� Ŭ��
remdr$findElement(using='xpath',value='//*[@id="prd_list_type1"]/li[1]/div/div[1]/div[2]/div[1]/a/strong')$clickElement()
//*[@id="prd_list_type1"]/li[1]/div/div[1]/div[2]/div[1]/a/strong
//*[@id="prd_list_type1"]/li[3]/div/div[1]/div[2]/div[1]/a/strong

# ������ ������ Ȱ��ȭ
source <- remdr$getPageSource()[[1]]
html <- read_html(source)

# å ���� ����(�� ���̵� ���� ����)
title <- trimws(html_nodes(html,xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                  html_text())

# å �Ұ� ����(�� ���̵� ���� ����)
intro <- trimws(html_nodes(html,'div.box_detail_article')[1]%>%
                  html_text())

# �ڷΰ���
remdr$goBack()

# 12���� �о��� ����Ʈ���� ���� ��� ���� -----------���� �۾����� ����------------
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
    # ������ ������ Ȱ��ȭ
    source <- remdr$getPageSource()[[1]]
    html <- read_html(source)
    
    # ������������ ���� ���� 
    leng <- length(html_nodes(html,'div.prd_list_area > form#frmList > ul.prd_list_type1 > li.id_detailli'))
    
    # ������ å�� url�� ���� å����� å �Ұ� �κ��� �����ؼ� ���ص� ������� ����
    for(j in seq(1,leng*2-1,2)){
      # å ���� Ŭ��
      remdr$findElement(using='xpath',value=paste0('//*[@id="prd_list_type1"]/li[',j,']/div/div[1]/div[2]/div[1]/a/strong'))$clickElement()
      
      # ������ ������ Ȱ��ȭ
      source <- remdr$getPageSource()[[1]]
      html <- read_html(source)
      
      # å ���� ����(�� ���̵� ���� ����)
      title <- trimws(html_nodes(html,xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                        html_text())
      
      # å �Ұ� ����(�� ���̵� ���� ����)
      intro <- trimws(html_nodes(html,'div.box_detail_article')[1]%>%
                        html_text())
      
      # ������ ����
      text <- c(text,paste(title,intro))
      
      # �ڷΰ���
      remdr$goBack()
      
      Sys.sleep(1)
    }
  }
}

# ����� �ֱ�
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

# ����� text ���������������� �����
book <- data.frame(field=field, text=text)
View(book)
write.csv(book,'c:/data/book_field.csv')

# ������ �ҷ�����--------------------------
book <- read.csv('c:/data/book_field.csv',header=T)
book <- book[,c(2,3)]
View(book)


�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܼ���2�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
2. ��ūȭ, ��ó��
library(tm) # VCorpus(����ġ), documentTermMatrix ����� �۾��� �����ϴ� ���̺귯��
library(stringr) # �ܾ� ����,����,����, �������� �� ��ó���۾��� �ַ� ���
library(RcppMeCab) # �Ϻ���, �ѱ��� ǰ�� �±� ���̺귯��(��ó���� ���� �� �����ϰ� ǰ��� ������ ��)

#����ġ�� �����۾�
book_corpus <- tm::VCorpus(VectorSource(book$text))
lapply(book_corpus,content)
#�±�,��ó�� �۾�
#��ū���� ���� �Լ�
mecab_words <- function(doc){
  # �±�
  tagging <- RcppMeCab::pos(base::enc2utf8(as.character(doc)))
  
  # �ʿ��� ǰ�� NNG(�Ϲݸ��), NNP(�������), XR(��� : ���������� �ǹ̸� ��Ÿ���� �߽��� �Ǵ� �κ�), SL(�ܱ���)
  word_noun <- str_match_all(tagging,'(\\w+)(/NNG|/NNP|/XR|/SL)')[[1]][,2] 
  
  # ��ó��
  word_noun <- str_replace_all(word_noun,'C','�����')
  word_noun <- str_replace_all(word_noun,'R','�����α׷���')
  word_noun <- str_replace_all(word_noun,'NFT','������Ƽ')
  word_noun <- str_replace_all(word_noun,'ETF','��Ƽ����')
  word_noun <- str_replace_all(word_noun,'LH','�ѱ��������ð���')
  word_noun <- str_replace_all(word_noun,'IT','����Ƽ')
  word_noun <- str_replace_all(word_noun,'CEO','���̿�')
  word_noun <- str_replace_all(word_noun,'IMF','���̿�����')
  word_noun <- str_replace_all(word_noun,'OECD','�������°��߱ⱸ')
  word_noun <- str_replace_all(word_noun,'HTS','����ġƼ����')
  word_noun <- str_replace_all(word_noun,'Business','�����Ͻ�')
  word_noun <- str_replace_all(word_noun,'DSR','�𿡽���')
  word_noun <- str_replace_all(word_noun,'DTI','��Ƽ����')
  word_noun <- str_replace_all(word_noun,'PER','���̾�')
  word_noun <- str_replace_all(word_noun,'value','����')
  word_noun <- str_replace_all(word_noun,'investing','�κ�����')
  word_noun <- str_replace_all(word_noun,'FIRE','���̾�')
  word_noun <- str_replace_all(word_noun,'Warren','��������')
  word_noun <- str_replace_all(word_noun,'Buffett','��������')
  word_noun <- str_replace_all(word_noun,'IPO','�����ǿ�')
  word_noun <- str_replace_all(word_noun,'PIR','�Ǿ��̾�')
  word_noun <- str_replace_all(word_noun,'tokens','��ū')
  word_noun <- str_replace_all(word_noun,'innovation','����')
  word_noun <- str_replace_all(word_noun,'AI','�ΰ�����')
  word_noun <- str_replace_all(word_noun,'VR','���̾�')
  word_noun <- str_replace_all(word_noun,'AR','���̾�')
  word_noun <- str_replace_all(word_noun,'SF','��������')
  word_noun <- str_replace_all(word_noun,'Java','�ڹ�')
  word_noun <- str_replace_all(word_noun,'AWS','���̴���������')
  word_noun <- str_replace_all(word_noun,'IoT','���̿�Ƽ')
  word_noun <- str_replace_all(word_noun,'programming','���α׷���')
  word_noun <- str_replace_all(word_noun,'network','��Ʈ��ũ')
  word_noun <- str_replace_all(word_noun,'python','���̽�')
  word_noun <- str_replace_all(word_noun,'Apache','����ġ')
  word_noun <- str_replace_all(word_noun,'IP','������')
  word_noun <- str_replace_all(word_noun,'DNS','�𿣿���')
  word_noun <- str_replace_all(word_noun,'Android','�ȵ���̵�')
  word_noun <- str_replace_all(word_noun,'Studio','��Ʃ���')
  word_noun <- str_replace_all(word_noun,'Internet','���ͳ�')
  word_noun <- str_replace_all(word_noun,'GUI','��������')
  word_noun <- str_replace_all(word_noun,'Amazon','�Ƹ���')
  word_noun <- str_replace_all(word_noun,'RDS','�˵𿡽�')
  word_noun <- str_replace_all(word_noun,'AutoCAD','����ĳ��')
  word_noun <- str_replace_all(word_noun,'CAD','ĳ��')
  word_noun <- str_replace_all(word_noun,'API','�����Ǿ���')
  word_noun <- str_replace_all(word_noun,'PyTorch','������ġ')
  word_noun <- str_replace_all(word_noun,'NoSQL','�뿡��ť��')
  word_noun <- str_replace_all(word_noun,'Algorithms','�˰���')
  word_noun <- str_replace_all(word_noun,'Program','���α׷�')
  word_noun <- str_replace_all(word_noun,'Apps','�۽�')
  word_noun <- str_replace_all(word_noun,'JPA','�����ǿ���')
  word_noun <- str_replace_all(word_noun,'CBT','����Ƽ')
  word_noun <- str_replace_all(word_noun,'UI','������')
  word_noun <- str_replace_all(word_noun,'UX','������')
  word_noun <- str_replace_all(word_noun,'DAsP','���̿�����')
  word_noun <- str_replace_all(word_noun,'DAP','������')
  word_noun <- str_replace_all(word_noun,'Data','������')
  word_noun <- str_replace_all(word_noun,'CNN','������')
  word_noun <- str_replace_all(word_noun,'RNN','�˿���')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,' �� ','��$')
  word_noun <- str_replace_all(word_noun,'[\u4E00-\u9FD5��]','') # ��������
  
  word_noun <- str_replace_all(word_noun,'[A-z]+','') # ��������
  
  return(word_noun)
}

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܼ���3�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�

3.�н�������, �׽�Ʈ������ �������

# DocumentTermMatrix ���·� ����(�̸� ��ūȭ�ϴ� �Լ��� �ɼ����� ����)
book_dtm <- DocumentTermMatrix(book_corpus,control=list(tokenize=mecab_words,
                                                        wordLengths=c(2,Inf),
                                                        weighting=weightBin)) #weightBin�� �� ���忡�� �����ϰ� �ݺ��Ǵ� ���� �ϳ��� ī��Ʈ
inspect(book_dtm)

#�н�������, �׽�Ʈ�����͸� ������ �ε��� �����
idx <- sample(2,nrow(book_dtm),replace=TRUE,prob=c(0.9,0.1))

#������ �ε����� ��ġ�� ��ġ�ϴ� book_dtm�� �����͵��� �н�������,�׽�Ʈ������ ������ ����
book_dtm_train <- book_dtm[idx==1,]
book_dtm_test <- book_dtm[idx==2,]

nrow(book_dtm_train) #�н������� ����
nrow(book_dtm_test) #�׽�Ʈ������ ����

''' dtm�� �ɼ����� weightBin�� �� ���� ��
#�󵵼��� 5ȸ �̻��� �ܾ��� ���� (������ ���� ������ �ܾ���� ����ŭ ���� ���� �����ϹǷ� �𵨿� ������ ��ġ�� ���������θ� ����)
freq_words <- findFreqTerms(book_dtm_train,5)
train <- book_dtm_train[,freq_words]
test <- book_dtm_test[,freq_words]
'''

#�н�������, �׽�Ʈ�������� �����('field') �� �ε����� �´� ������ ������ ����
book_dtm_train_labels <- book[idx==1,'field'] 
book_dtm_test_labels <- book[idx==2,'field']

length(book_dtm_train_labels) #�н��������� ���� ���� ���� Ȯ�� (�н��������� ������ ��ġ�ؾ���)
length(book_dtm_test_labels) #�׽�Ʈ�������� ���� ���� ���� Ȯ��

#�󵵼� ���ڸ� �̺й����� �з��ϱ� 
convert_counts <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

book_train <- apply(book_dtm_train,MARGIN=2,convert_counts)
book_test <- apply(book_dtm_test,MARGIN=2,convert_counts)
book_train[1,]
book_test[1,]

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܼ���4�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
4. naiveBayes�� ����, ����
library(e1071)# naiveBayes���� ����� �� �ִ� ���̺귯��
book_classifier <- naiveBayes(book_train,book_dtm_train_labels)
book_test_predict <- predict(book_classifier,book_test) #predict(���̺꺣�����,������ �׽�Ʈ��)

# CrossTable ��� ���� ǥ
library(gmodels) # �� ���� ���� �ڷ� ���� ���ü��� ����ǥ�� ��Ÿ���� �� �ִ� �Լ� CrossTable�� ����� �� �ִ� ���̺귯��
CrossTable(book_test_predict,book_dtm_test_labels)
CrossTable(book_dtm_test_labels,book_test_predict)

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܰ��1�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
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
  ������ : (8+9+6+12+7+16+12+10+11+10+11+23)/192

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܰ��2�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
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
  ������ : (9+16+17+9+2+11+7+15+16+9+13+15)/185 = 0.7513514 ���ö�0, �󵵼� 5�̻�

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܰ��3�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
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
  ������ : (9+15+16+9+0+10+7+15+17+7+12+15)/185 = 0.7135135 ���ö�1, �󵵼�5�̻� 

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܰ��4�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
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
  ������ : (22+9+14+19+11+12+11+6+6+12+16+10)/207 = 0.7149758 ���ö�0,weightBin�ɼ�o

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܼ���5�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
5. ���ο� ������ �Է�
library(rvest)
#��1.'���� �Ųٷ� �д� �׸��� �θ���', �帣�� ���� (����, �Ұ� ���� �����ؼ� new������ ����)
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9791130679945&orderClick=sbb',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#��2. '��ü ��뼳��', �帣�� �ι���
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=05131301&barcode=9791192128085',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#��3. '�ھƹ߰߰� ����Ž��', �帣�� �ڱ���
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=150101&barcode=9788963248394',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#��4. '�¾��� ���� ���� ����', �帣�� ��/������
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=030701&barcode=9791170400752',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#��5. '���ֳ���(���蹮ȭ����) ��Ʈ', �帣�� ����
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=19&barcode=9791190841825',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#��6. '����, ����ü, ������ü �ϳ���', �帣�� ����
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=21030301&barcode=9788932819143',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))
#��6. 'õ��', �帣�� ��ġ/��ȸ
html <- read_html('http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=05131511&barcode=9791190944618',encoding='EUC-KR')
new <- paste(trimws(html_nodes(html, xpath='//*[@id="container"]/div[2]/form/div[1]/h1/strong')%>%
                      html_text()),
             trimws(html_nodes(html, 'div.box_detail_article')[1]%>%
                      html_text()))



#����� �߰�
new <- data.frame(field='poem_essay',text=new)

# ����ġ ��ȯ
new_corpus <- VCorpus(VectorSource(new$text))

# ������ �����ߴ� �ܾ���� �������� ������ ����� ���� words��� ������ ����
words <- Terms(book_dtm) 
tail(words,6000)

# ������ ��ūȭ �ϴ� �Լ�mecab_words�� �Ȱ��� �����ϰ�, ������ �����ߴ� �ܾ���� �������� ����� ������ �ִ� �ܾ���� �������� dtm�� �����
new_dtm <- DocumentTermMatrix(new_corpus,control=list(tokenize=mecab_words,
                                                      dictionary=words)) 
inspect(new_dtm)
#�󵵼� ǥ�� ��� yes�� no�� �̺�ȭ
new_dtm_test <- apply(new_dtm,MARGIN=2,convert_counts) 

#���� 
predict(book_classifier,t(new_dtm_test)) #��°�� : 1. history_culture(���� ����) // 2. religion (���� ����) //3. computer_it(���� ����)

�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܼ���6�ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
6. �ð�ȭ

#������ ��ūȭ�� �Լ��� �����Ͽ� �ܾ� ����
content <- lapply(book$text,mecab_words)

# �α��� �̻� ����
content <- lapply(content,function(x) x[nchar(x)>=2])

# �� ����Ʈ���� ���������� �ܾ� ��ġ��
content <- sapply(content,function(x) paste(x,collapse=' '))

# ������������ �������� �����
book_field_df <- data.frame(field=book$field,word=content)

# �оߺ��� ������
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

#�оߺ� table�Լ��� �ܾ� �󵵼� ���ϱ�
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

# rbind�� ����
book_field_total <- rbind(novel_t,poem_essay_t,economy_t,selfdevelope_t,humanities_t,history_culture_t,
      religion_t,politics_society_t,art_popularculture_t,sience_t,technology_engineering_t,computer_it_t)

#wordcloud�� ����� ���� �������� ����
book_field_total <- acast(book_field_total,word~field,value.var = 'freq',fill=0)
book_field_total

# �оߺ� �ܾ� �󵵼� �� ��ǥ
windows(width=20,height=12)
wordcloud::comparison.cloud(book_field_total, 
                            title.bg.colors = rainbow(ncol(book_field_total)),
                            colors = rainbow(ncol(book_field_total)),
                            title.size=2, rot.per=0.01)



