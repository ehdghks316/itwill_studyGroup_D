★ 머신러닝(machine learning)
- 인간의 학습능력과 같은 기능을 컴퓨터가 하게 만드는 기술
- 인공지능(AI) 연구분야의 하나이다
- 인공지능이란 인간이 원래 가지고 있는 지적 능력을 컴퓨터가 하게 만드는 기술
- 분류 : 주어진 데이터 분류
- 예측 : 과거의 수치를 기반으로 미래의 수치 예측
- 군집 : 데이터를 비슷한 집합으로 모으는 작업

지도학습(Supervised learning)
- 레이블(정답)이 달려 있고 정해져 있는 데이터를 가지고 학습
- 이미지학습(개,고양이), 스팸/햄, 긍정/부정, 시험성적예측, 로또예측, 주가예측
- 분류, 예측

비지도학습(unsupervised learning)
- 레이블(정답)이 없는 데이터를 학습을 통해 군집
- (예) 유사한 뉴스를 그룹으로 모으는 학습

문장               레이블(정답)
오늘은 행복하다.      긍정
...

★확률
- 어떤 사건이 발생할 기대값
- 일어날 가능성에 대해서 하는 말을 수치로 표현
- 0 ~ 1 사이를 숫자로 표현한 값
  
#한계확률, 주변확률(marginal probability)
- 아무런 조건이 없는 상태에서 A라는 사건이 발생할 확률
- 행과 열의 합을 빈도 전체합으로 나누면 한계확률을 구할 수 있다.
- P(A)
(예)P(남성) = 0.4
(예)P(만족) = 0.2
<<교차표>>

      만족  보통  불만족   행의합  한계확률
남성    2     1       1       4       0.3                 
여성    0     2       4       6       0.7
열의합  2     3       5  
한계확률0.2   0.6      0.5

# 결합확률(join probability)
- 두개 이상의 사건이 동시에 발생할 가능성을 나타내는 확률
- 사건 A와 사건 B가 동시에 발생할 확률
- P(A∩B) # 남성이면서 만족인 확률...

<<교차표>>

        만족  보통  불만족   행의합  한계확률
남성    2/10  1/10  1/10       4       0.3                 
여성    0     2       4       6       0.7
열의합  2     3       5  DE
한계확률0.2   0.6      0.5


# 조건부확률(conditional probability)
- 이미 하나의 사건이 발생한 상태에서 또 다른 사건이 발생할 확률
- 남성이라는 조건하에서 만족일 확률?
           P(A∩B)
P(A|B) = ----------
            P(B) 

           P(남성|만족)
P(만족|남성) = ----------
            P(남성) 

                  P(여성|불만족)
P(불만족|여성) = ---------------
                   P(여성) 

★ 나이브베이즈(Naive Bayes)
- 데이터를 나이브(단순)하게 독립적인 사건으로 가정하고 이 독립사건들을
베이즈 이론에 대입시켜 가장 높은 확률의 레이블로 분류하는 알고리즘
- 사전에 알고 있는 정보(예측변수)를 바탕으로 어떤 사건(결과변수)이 발생할 확률을 계산
- 사건에 해당하는 결과변수는 범주형변수이어야하며 예측변수는 범주형 변수를 가정한다.

                P(스팸∩복권)
P(스팸|복권) = --------------
                 P(복권)
 
          P(A∩B)
P(A|B) = ----------
            P(B) 

P(A∩B) = P(A|B) * P(B) 

           P(A∩B)
P(B|A) = ----------
            P(A) 

P(B∩A) = P(B|A) * P(A) 

P(A∩B) = P(B∩A)

P(A∩B) = P(B|A) * P(A) = P(A|B) * P(B) 

          P(A∩B)         P(B|A) * P(A)
P(A|B) = ---------- = -------------------
           P(B)              P(B)  
P(B) = P(B|A) * P(A) + P(B|ㄱA) * P(ㄱA)
               P(스팸∩복권)         P(복권|스팸) * 스팸
P(스팸|복권) = -------------- = ----------------------------
                  P(복권)             P(복권)

               우도 * 사전확률
사후확률 = --------------------
                 주변우도
               
P(스팸|복권) : 사후확률, 이벤트가 발생 후 확률
P(복권|스팸) : 우도(likelihood), 가능성(어떤 일이 있을 공산)
p(스팸) : 사전확률, 이벤트가 발생 전 확률
p(복권) : 주변우도(marginal likelihood), 확률변수가 아닌 상수로 고려

<<교차표>>

복권
       yes    no    합
--------------------
스팸    3     19    22
햄      2     76    78
        5     95    100

                 P(스팸∩복권)         P(복권|스팸) * 스팸
P(스팸|복권) =  -------------- = ----------------------------
                    P(복권)             P(복권)

복권이라는 단어가 들어왔을경우 스팸일 확률은?
3/5
P(스팸|복권) = ((3/22) * (22/100)) / (5/100)

P(복권) = P(복권|스팸) * P(스팸) + P(복권|햄) * P(햄)
P(복권) = ((3/22) * (22/100)) + ((2/78) * (78/100)) = 0.05

           복권        백만        수신취소
        yes    no     yes    no   yes    no    합
--------------------------------------------------
스팸    3     19      11    11     13     9    22
햄      2     76      15    63     21     57   78
합      5     95      26    74     34     66  100

복권=yes, 백만=no, 수신취소=yes

ㄱ : 여집합                 P(복권∩ㄱ백만∩수신취소|스팸) * P(스팸)
P(스팸|복권∩ㄱ백만∩수신취소) = -------------------------------
                                   P(복권∩ㄱ백만∩수신취소)

P(복권∩ㄱ백만∩수신취소) = P(복권∩ㄱ백만∩수신취소|스팸) * P(스팸) +
                            P(복권∩ㄱ백만∩수신취소|햄) * P(햄)

(P(복권|스팸) * P(ㄱ백만|스팸) * P(수신취소|스팸) * P(스팸)) +
  (P(복권|햄) * P(ㄱ백만|햄) * P(수신취소|햄) * P(햄))

P(스팸|복권∩ㄱ백만∩수신취소) ∝ P(복권∩ㄱ백만∩수신취소|스팸)
= P(복권|스팸) * P(ㄱ백만|스팸) * P(수신취소|스팸) * P(스팸)
= (3/22) * (11/22) * (13/22) * (22/100) = 0.008863636
  
P(햄|복권∩ㄱ백만∩수신취소) ∝ P(복권∩ㄱ백만∩수신취소|햄)
= P(복권|햄) * P(ㄱ백만|햄) * P(수신취소|햄) * P(햄)
= (2/78) * (63/78) * (21/78) * (78/100) = 0.004349112

                                     0.008863636
P(스팸|복권∩ㄱ백만∩수신취소) = ----------------------
                             0.008863636 + 0.004349112

                                    0.004349112  
P(햄|복권∩ㄱ백만∩수신취소) = ----------------------
                             0.008863636 + 0.004349112

0.008863636/(0.008863636 + 0.004349112) = 0.6708397
0.004349112/(0.008863636 + 0.004349112) = 0.3291603
0.6708397 + 0.3291603 = 1

[문제217]비아그라=YES,돈=NO,식료품=NO,주소삭제=YES일때 스팸일 확률을 구하세요.

         비아그라		돈		식료품	 	주소삭제	합
          YES	NO	YES	NO	YES	NO	  YES	NO
스팸	     4	16	10	10	0	20	    12	8	     20
햄	       1	79	14	66	8	72	    23	57	   80
합	       5	95	24	76	8	92	    35	65	  100
                                 P(비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제|스팸) * P(스팸)
P(스팸|비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제) = -----------------------------------
                                     P(비아그라∩ㄱ돈∩식료품∩주소삭제)

분모 : P(비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제) = P(비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제|스팸) * P(스팸)+
                                  P(비아그라∩ㄱ돈∩식료품∩주소삭제|햄) * P(햄)

분자 :  P(스팸|비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제) ∝ P(비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제|스팸) * P(스팸) = 
  (P(비아그라|스팸) + P(ㄱ돈|스팸) + P(주소삭제|스팸)+  P(ㄱ식료품|스팸) + P(스팸))
(4/20 * 10/20 * 12/20 * 20/20 * 20/100) = 0.012
        P(햄|비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제) ∝ P(비아그라∩ㄱ돈∩ㄱ식료품∩주소삭제|햄) *P(햄)= 
  (P(비아그라|햄) + P(ㄱ돈|햄) + P(주소삭제|햄) +P(ㄱ식료품|햄) + P(햄))
= 1/80 * 66/80 * 72/80 * 80/100 * 23/80 = 0.002134688 

P(스팸|비아그라∩ㄱ돈∩식료품∩주소삭제) = 0.012 / (0.012+0.002134688) = 0.8489752
P(햄|비아그라∩ㄱ돈∩식료품∩주소삭제) = 0.002134688 / (0.012+0.002134688) = 0.1510248


[문제218] 비아그라=YES, 돈=NO, 식료품=YES, 주소삭제=YES 일때 스팸일 확률을 구하세요.
          비아그라		돈		식료품	 	주소삭제	합
         YES	NO	YES	NO	YES	NO	  YES	NO
스팸	     4	16	10	10	0	20	    12	8	     20
햄	       1	79	14	66	8	72	    23	57	   80
합	       5	95	24	76	8	92	    35	65	  100

P(스팸|비아그라∩ㄱ돈∩식료품∩주소삭제) 
 = (P(비아그라∩ㄱ돈∩식료품∩주소삭제|스팸) * P(스팸)) / P(비아그라∩ㄱ돈∩식료품∩주소삭제)
P(A|B) = (P(B|A) * P(B)) / P(B)

분모 : P(비아그라∩ㄱ돈∩식료품∩주소삭제) ∝ P(비아그라∩ㄱ돈∩식료품∩주소삭제|스팸) * P(스팸) +
  P(비아그라∩ㄱ돈∩식료품∩주소삭제|햄) * P(햄)

분자 : P(스팸|비아그라∩ㄱ돈∩식료품∩주소삭제) ∝ P(비아그라∩ㄱ돈∩식료품∩주소삭제|스팸) * P(스팸)
   =(P(비아그라|스팸) + P(ㄱ돈|스팸) + P(주소삭제|스팸)+  P(ㄱ식료품|스팸) + P(스팸))
(햄):P(햄|비아그라∩ㄱ돈∩식료품∩주소삭제) ∝ P(비아그라∩ㄱ돈∩식료품∩주소삭제|햄) * P(햄)
=(P(비아그라|햄) + P(ㄱ돈|햄) + P(주소삭제|햄)+  P(ㄱ식료품|햄) + P(햄))

4/20 * 10/20 * 12/20 * 0/20 * 20/100 =0 (0/20이 0이돼서 0이나옴)
1/80 * 66/80 * 8/80 * 23/80 * 80/100 =0.0002371875
P(스팸|비아그라∩ㄱ돈∩식료품∩주소삭제)  = 0/(0+0.0002371875) = 0

●라플라스 추정치(Laplace estimator)
- 확률값이 0이 나오지 않도록 작은 값으로 보정한다. (보통 1로 보정한다.)

P(스팸|비아그라∩ㄱ돈∩식료품∩주소삭제)
5/24 * 11/24 * 13/24 * 1/24 * 20/100 =0.0004310137 #전체를 빼고 나머지 분자 분모에 1씩 더한다

P(햄|비아그라∩ㄱ돈∩식료품∩주소삭제)
2/84 * 67/84 * 9/84 * 24/84 * 80/100 =0.000465084

P(스팸|비아그라∩ㄱ돈∩식료품∩주소삭제) = 0.0004310137/(0.000465084+0.0004310137) = 0.4809896
P(햄|비아그라∩ㄱ돈∩식료품∩주소삭제) = 0.000465084/(0.000465084+0.0004310137) = 0.5190104

[문제 219] 메일안에 복권이라는 단어가 있을 경우에 스팸일 확률?
                    P(스팸∩복권)         P(복권|스팸) * P(스팸)
  P(스팸|복권) =-------------------- = -------------------
                      P(복권)               P(복권)
  
P(스팸)= 0.22
P(복권|스팸) = 0.136
P(복권|햄) = 0.025

P(스팸|복권) ∝ P(복권|스팸) * P(스팸)
P(햄|복권) ∝ P(복권|햄) * P(햄)

P(복권) = P(복권|스팸)*P(스팸) + P(복권|햄)*P(햄)

P(스팸|복권) = 0.136 * 0.22 / ((0.136 * 0.22)+(0.025 * 0.78)) = 0.6054229

#---------------naiveBayes
install.packages("e1071")
library(e1071)

mail <- read.csv('c:/data/mail.csv',header=T)
str(mail)

nb <- naiveBayes(mail[1:4],mail$분류)

test <- data.frame('NO','NO','NO','YES')
test
names(test) <- names(mail[,1:4])
test

predict(nb,test)

[문제220] 영화장르 분류를 해주세요.
movie <- read.csv('c:/data/movie.csv')
movie

'''
80% 학습데이터로 만들고 일부 20% 테스트데이터로 학습을 해서
실제 정답과 잘 맞는지 확인해서
잘 맞으면 잘 만들어진 모델이 된다.
'''

●랜덤으로 숫자를 넣는 함수 sample ( 복원추출, 비복원추출 )

#학습데이터(80%),테스트데이터(20%) 분리
idx <- sample(2,nrow(movie),replace=T,prob=c(0.8,0.2)) # replace옵션 T는 복원추출, 1부터2까지의 숫자를 nrow(movie)개수만큼, 1은 0.8, 2는0.2만큼
table(idx)

# 학습데이터
movie_train <- movie[idx==1,1:5]
nrow(movie_train)

# test데이터
movie_test <- movie[idx==2,1:5]
nrow(movie_test)

# 학습데이터 정답
movie_train_labels <- movie[idx==1,6]
length(movie_train_labels)

# test데이터 정답
movie_test_labels <- movie[idx==2,6]
length(movie_test_labels)

# naiveBayes
nb <- naiveBayes(movie_train,movie_train_labels,laplace=1) #laplace=1 라플라스
nb

test_predict <- predict(nb,movie_test)
sum(test_predict == movie_test_labels)/length(movie_test_labels)

install.packages('gmodels')
library('gmodels')

gmodels::CrossTable(x=movie_test_labels, y=test_predict,prop.chisq=F,dnn=c('실제','예측'))

gmodels::CrossTable(x=test_predict, y=movie_test_labels,prop.chisq=F,dnn=c('예측','실제'))

#----------------------------------------------------------------------------
[문제221]
spam <- read.csv('c:/data/sms_spam.csv', header=T)
head(spam)
View(spam)
library(tm)
library(stringr)

0. 명사들만 뽑기(전처리) # 일단 있어야 의미가 될 특수문자나 숫자나 불용어도 제거, 대문자일 때 의미 있는 단어들도 그냥 다 소문자로 변경해버리고 수행하고 / 후에 다시 전처리 하기


#말뭉치변환
spam_cor <- VCorpus(VectorSource(spam$text))
inspect(spam_cor)

# 소문자로 변경
spam_cor <- tm_map(spam_cor, content_transformer(tolower))
lapply(spam_cor,content)

# 불용어제거
spam_cor <- tm_map(spam_cor,removeWords,stopwords('smart'))
lapply(spam_cor,content)

'''
# 특수문자 제거
spam_cor <- tm_map(spam_cor,removePunctuation) # 앞뒤문자가 붙어버리는 오류
lapply(spam_cor,content)
'''
# 특수문자 제거
convert <- content_transformer(function(x,pattern){ return(gsub(pattern,' ',x))})
spam_cor <- tm_map(spam_cor,convert,'(http|https)\\S+')
spam_cor <- tm_map(spam_cor,convert,'www\\S+')
spam_cor <- tm_map(spam_cor,convert,'/|:|;|\\.|"|<|>|\\?|!')
spam_cor <- tm_map(spam_cor,convert,"'|%|&|\\^|\\$")
spam_cor <- tm_map(spam_cor,convert,'\\(|\\)|-')

# 숫자제거
spam_cor <- tm_map(spam_cor,removeNumbers)
inspect(spam_cor[[1]])

# ￡,€ 문자 제거
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('￡',' ',x)))
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('€',' ',x)))
lapply(spam_cor,content)

# ’,¨,‘,“,”제거
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('[\\w+]*’[\\w+]*',' ',x)))
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('[¨|‘|“|”]',' ',x)))
lapply(spam_cor,content)
#str_extract_all(spam_cor,'[\\w+]*’[\\w+]*')

# 2개이상 공백 1개로 변경
spam_cor <- tm_map(spam_cor, stripWhitespace)
lapply(spam_cor,content)


1.단어들로 구분하여 밑의 형식처럼 만들기
  collection from Landline ... 등 단어들
1열  yes       no    yes     ...         ,ham
2열  yes       no    yes     ...         ,spam
3열  yes       no    yes     ...         ,spam                                    
...
# dtm 만들기
spam_dtm <- DocumentTermMatrix(spam_cor)
inspect(spam_dtm)

2. 기존 데이터를 학습데이터와 테스트데이터로 나누기

# 학습데이터1, 테스트데이터2로 나누기위해 sample함수를 이용하여 1,2를 spam_dtm길이만큼 각인덱스에 랜덤으로 넣기
idx <- sample(2,NROW(spam_dtm),replace=TRUE,prob=c(0.8,0.2))

# 학습데이터
spam_train <- spam_dtm[idx==1,]
inspect(spam_train)

# 테스트데이터
spam_test <- spam_dtm[idx==2,]

# 학습데이터 정답
spam_train_labels <- spam[idx==1,1]

# 테스트데이터 정답
spam_test_labels <- spam[idx==2,1]

# 범주형 값으로 변경
count <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

spam_train_t <- apply(spam_train,MARGIN=2,count)
spam_train_t[1,]

spam_test_t <- apply(spam_test,MARGIN=2,count)
spam_test_t[1,]

3. naiveBayes
spam_nb <- naiveBayes(spam_train_t,spam_train_labels)
spam_test_predict <- predict(spam_nb,spam_test_t)

4. CrossTable 결과 도출
CrossTable(x=spam_test_labels,y=spam_test_predict)

#--------------------------------------------------- 강사님 답!

library(stringr)
library(tm)
sms <- read.csv('c:/data/sms_spam.csv',header=T)
head(sms)
str(sms)

sms[str_detect(sms$text,'www'),]
sms[grep('www',sms$text),]

sum(str_detect(sms$text,'www'))
length(grep('www',sms$text))

as.vector(na.omit(str_extract(sms$text,'www\\S+'))) # \\S+ 공백이 나오기 전까지 나옴
as.vector(na.omit(str_extract(sms$text,'(http|https)\\S+')))

table(sms[grep('(http|https)\\S+',sms$text),'type'])
table(sms[grep('www\\S+',sms$text),'type'])
'(http|https)\\S+' -> url_unique #url이 구분하는데 영향력이 있는 단어이기 때문에 고유한 이름으로 만들어서 해결해도 됨
'www\\S+' -> urlunique

as.vector(na.omit(str_extract(sms$text,'\\W\\d+')))
as.vector(na.omit(str_extract(sms$text,'(￡|\\$)\\d+')))
table(sms[grep('(￡|\\$)\\d+',sms$text),'type']) #
'(￡|\\$)\\d+' -> price_unique # 영향력있는 단어들이기에 무작정 지우면 안된다.


sms_corpus <- VCorpus(VectorSource(sms$text))
lapply(sms_corpus[1:2],content) #확인

sms_corpus_clean <- tm_map(sms_corpus,content_transformer(tolower)) # 소문자로 변환
lapply(sms_corpus_clean[1:2],content) #확인

convert <- content_transformer(function(x,pattern){ # 똑같은 패턴의 함수들을 사용할 때 값만 바뀌면 이렇게 함수형으로 만들어서 값만 들어가도록 해보자
  return(gsub(pattern,' ',x))
})

sms_corpus_clean <- tm_map(sms_corpus_clean,convert,'(http|https)\\S+')
sms_corpus_clean <- tm_map(sms_corpus_clean,convert,'www\\S+')
sms_corpus_clean <- tm_map(sms_corpus_clean,convert,'/|:|;|\\.|"|<|>|\\?|!')
sms_corpus_clean <- tm_map(sms_corpus_clean,convert,"'|%|&|\\^|\\$")
sms_corpus_clean <- tm_map(sms_corpus_clean,convert,'\\(|\\)')
sms_corpus_clean <- tm_map(sms_corpus_clean,removeWords,tm::stopwords())
sms_corpus_clean <- tm_map(sms_corpus_clean,removeNumbers)
sms_corpus_clean <- tm_map(sms_corpus_clean,stripWhitespace)
lapply(sms_corpus_clean[1:10],content)

sms_dtm <- DocumentTermMatrix(sms_corpus_clean,control=list(wordslengths=c(2,Inf)))
inspect(sms_dtm)
as.matrix(sms_dtm)
sms_dtm #  대부분의 값이 0으로 들어가 있어서 잘 안나올 수가 있다.
nrow(sms_dtm)
idx <- sample(2,nrow(sms_dtm),replace=TRUE,prob=c(0.8,0.2)) # 숫자1,2를 nrow(sms_dtm)만큼 복원추출하여 값을 넣는다. 1은 전체의 80%,2는 전체의 20%만큼 랜던으로 넣는다.
idx

#학습데이터
sms_dtm_train <- sms_dtm[idx==1,]
inspect(sms_dtm_train)

#테스트데이터
sms_dtm_test <- sms_dtm[idx==2,]
inspect(sms_dtm_test)

# 학습데이터 정답
sms_dtm_train_labels <- sms[idx==1,1]
length(sms_dtm_train_labels)

# 테스트데이터 정답 
sms_dtm_test_labels <- sms[idx==2,1]
length(sms_dtm_test_labels)

# 빈도수를 범주형 자료로 수정 0 -> NO, 1이상의 값 -> YES
convert_count <- function(x) {
  x <- ifelse(x > 0,'YES','NO')
}

sms_train <- apply(sms_dtm_train, MARGIN=2, convert_count)
#inspect(sms_train) apply를 수행하고 matrix로 바뀜, 데이터가 망가지지는 않음
class(sms_train)
sms_train[1,]

sms_test <- apply(sms_dtm_test, MARGIN=2, convert_count)
#inspect(sms_train) apply를 수행하고 matrix로 바뀜
class(sms_test)
sms_test[1,]

sms_nb <- naiveBayes(sms_train,sms_dtm_train_labels,laplace=1) # 추정치값이 잘 안나온다 싶을 때 laplace옵션을 넣기

test_predict <- predict(sms_nb,sms_test)

CrossTable(x=sms_dtm_test_labels,y=test_predict)

'''
| test_predict 
sms_dtm_test_labels |       ham |      spam | Row Total | 
  --------------------|-----------|-----------|-----------|
  ham |       935 |        12(오분류) |       947 |                  
  |    16.500 |   105.354 |           | 
  |     0.987 |     0.013 |     0.866 | 
  |     0.989 |     0.081 |           | 
  |     0.855 |     0.011 |           | 
  --------------------|-----------|-----------|-----------|
  spam |        10 |       136(실제와 맞는 것) |       146 | 
  |   107.023 |   683.355 |           | 
  |     0.068 |     0.932 |     0.134 | 
  |     0.011 |     0.919 |           | 
  |     0.009 |     0.124 |           | 
  --------------------|-----------|-----------|-----------|
  Column Total |       945 |       148 |      1093 |          
  |     0.865 |     0.135 |           | 
  --------------------|-----------|-----------|-----------|
  (945+136)/1093 = 0.989021% 정답률
'''
# 새로운 열이 들어왔을 때!
new = 'URGENT! Your Mobile number has been awarded with a $ 2000 prize GUARANTEED'
new_corpus <- VCorpus(VectorSource(new))
lapply(new_corpus,content)
clean <- tm_map(new_corpus,content_transformer(tolower))
convert <- content_transformer(function(x,pattern){ # 똑같은 패턴의 함수들을 사용할 때 값만 바뀌면 이렇게 함수형으로 만들어서 값만 들어가도록 해보자
  return(gsub(pattern,' ',x))
})
clean <- tm_map(clean,convert,'/')
clean <- tm_map(clean,convert,':')
clean <- tm_map(clean,convert,';')
clean <- tm_map(clean,removePunctuation)
clean <- tm_map(clean,removePunctuation)
clean <- tm_map(clean,removeNumbers)
clean <- tm_map(clean,removeWords,stopwords())
clean <- tm_map(clean,stripWhitespace)

new_dtm <- DocumentTermMatrix(clean,list(dictionary=Terms(sms_dtm))) #기존에 만들었떤 sms_dtm단어를 기반으로해서 dtm을 만든다는 옵션

convert_counts <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

new_test <- apply(new_dtm,MARGIN=2, convert_counts) #수행하면 벡터로 바뀜, 벡터는 나이브베이즈를 돌릴 수 없음, 위에서 보면 다 matrix형태
class(new_test)
dim(t(new_test))

predict(sms_nb,t(new_test))
options('scipen'=100) 

predict(sms_nb,t(new_test),type='raw')# 확률값으로 보기위해서 type옵션을 raw로 넣어주기


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!2022/2/18 프로젝트 시작 1주일!!!!!!!!!!!!!!!!!!!!!!!!!!
기획
데이터 어디서 수집할지
필요한 기술들, 함수들
어떻게 해결할지, 어떤 알고리즘사용할 건지
수집된 데이터 
url이 바뀌는지 안바뀌는지 체크

ppt에는 모든 코드가 다 들어갈 필요없고 중요한 부분들만 뽑아서 정리해 넣기

