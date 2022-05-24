�� �ӽŷ���(machine learning)
- �ΰ��� �н��ɷ°� ���� ����� ��ǻ�Ͱ� �ϰ� ����� ���
- �ΰ�����(AI) �����о��� �ϳ��̴�
- �ΰ������̶� �ΰ��� ���� ������ �ִ� ���� �ɷ��� ��ǻ�Ͱ� �ϰ� ����� ���
- �з� : �־��� ������ �з�
- ���� : ������ ��ġ�� ������� �̷��� ��ġ ����
- ���� : �����͸� ����� �������� ������ �۾�

�����н�(Supervised learning)
- ���̺�(����)�� �޷� �ְ� ������ �ִ� �����͸� ������ �н�
- �̹����н�(��,�����), ����/��, ����/����, ���輺������, �ζǿ���, �ְ�����
- �з�, ����

�������н�(unsupervised learning)
- ���̺�(����)�� ���� �����͸� �н��� ���� ����
- (��) ������ ������ �׷����� ������ �н�

����               ���̺�(����)
������ �ູ�ϴ�.      ����
...

��Ȯ��
- � ����� �߻��� ��밪
- �Ͼ ���ɼ��� ���ؼ� �ϴ� ���� ��ġ�� ǥ��
- 0 ~ 1 ���̸� ���ڷ� ǥ���� ��
  
#�Ѱ�Ȯ��, �ֺ�Ȯ��(marginal probability)
- �ƹ��� ������ ���� ���¿��� A��� ����� �߻��� Ȯ��
- ��� ���� ���� �� ��ü������ ������ �Ѱ�Ȯ���� ���� �� �ִ�.
- P(A)
(��)P(����) = 0.4
(��)P(����) = 0.2
<<����ǥ>>

      ����  ����  �Ҹ���   ������  �Ѱ�Ȯ��
����    2     1       1       4       0.3                 
����    0     2       4       6       0.7
������  2     3       5  
�Ѱ�Ȯ��0.2   0.6      0.5

# ����Ȯ��(join probability)
- �ΰ� �̻��� ����� ���ÿ� �߻��� ���ɼ��� ��Ÿ���� Ȯ��
- ��� A�� ��� B�� ���ÿ� �߻��� Ȯ��
- P(A��B) # �����̸鼭 ������ Ȯ��...

<<����ǥ>>

        ����  ����  �Ҹ���   ������  �Ѱ�Ȯ��
����    2/10  1/10  1/10       4       0.3                 
����    0     2       4       6       0.7
������  2     3       5  DE
�Ѱ�Ȯ��0.2   0.6      0.5


# ���Ǻ�Ȯ��(conditional probability)
- �̹� �ϳ��� ����� �߻��� ���¿��� �� �ٸ� ����� �߻��� Ȯ��
- �����̶�� �����Ͽ��� ������ Ȯ��?
           P(A��B)
P(A|B) = ----------
            P(B) 

           P(����|����)
P(����|����) = ----------
            P(����) 

                  P(����|�Ҹ���)
P(�Ҹ���|����) = ---------------
                   P(����) 

�� ���̺꺣����(Naive Bayes)
- �����͸� ���̺�(�ܼ�)�ϰ� �������� ������� �����ϰ� �� ������ǵ���
������ �̷п� ���Խ��� ���� ���� Ȯ���� ���̺�� �з��ϴ� �˰���
- ������ �˰� �ִ� ����(��������)�� �������� � ���(�������)�� �߻��� Ȯ���� ���
- ��ǿ� �ش��ϴ� ��������� �����������̾���ϸ� ���������� ������ ������ �����Ѵ�.

                P(���ԡ�����)
P(����|����) = --------------
                 P(����)
 
          P(A��B)
P(A|B) = ----------
            P(B) 

P(A��B) = P(A|B) * P(B) 

           P(A��B)
P(B|A) = ----------
            P(A) 

P(B��A) = P(B|A) * P(A) 

P(A��B) = P(B��A)

P(A��B) = P(B|A) * P(A) = P(A|B) * P(B) 

          P(A��B)         P(B|A) * P(A)
P(A|B) = ---------- = -------------------
           P(B)              P(B)  
P(B) = P(B|A) * P(A) + P(B|��A) * P(��A)
               P(���ԡ�����)         P(����|����) * ����
P(����|����) = -------------- = ----------------------------
                  P(����)             P(����)

               �쵵 * ����Ȯ��
����Ȯ�� = --------------------
                 �ֺ��쵵
               
P(����|����) : ����Ȯ��, �̺�Ʈ�� �߻� �� Ȯ��
P(����|����) : �쵵(likelihood), ���ɼ�(� ���� ���� ����)
p(����) : ����Ȯ��, �̺�Ʈ�� �߻� �� Ȯ��
p(����) : �ֺ��쵵(marginal likelihood), Ȯ�������� �ƴ� ����� ���

<<����ǥ>>

����
       yes    no    ��
--------------------
����    3     19    22
��      2     76    78
        5     95    100

                 P(���ԡ�����)         P(����|����) * ����
P(����|����) =  -------------- = ----------------------------
                    P(����)             P(����)

�����̶�� �ܾ ��������� ������ Ȯ����?
3/5
P(����|����) = ((3/22) * (22/100)) / (5/100)

P(����) = P(����|����) * P(����) + P(����|��) * P(��)
P(����) = ((3/22) * (22/100)) + ((2/78) * (78/100)) = 0.05

           ����        �鸸        �������
        yes    no     yes    no   yes    no    ��
--------------------------------------------------
����    3     19      11    11     13     9    22
��      2     76      15    63     21     57   78
��      5     95      26    74     34     66  100

����=yes, �鸸=no, �������=yes

�� : ������                 P(���ǡ����鸸���������|����) * P(����)
P(����|���ǡ����鸸���������) = -------------------------------
                                   P(���ǡ����鸸���������)

P(���ǡ����鸸���������) = P(���ǡ����鸸���������|����) * P(����) +
                            P(���ǡ����鸸���������|��) * P(��)

(P(����|����) * P(���鸸|����) * P(�������|����) * P(����)) +
  (P(����|��) * P(���鸸|��) * P(�������|��) * P(��))

P(����|���ǡ����鸸���������) �� P(���ǡ����鸸���������|����)
= P(����|����) * P(���鸸|����) * P(�������|����) * P(����)
= (3/22) * (11/22) * (13/22) * (22/100) = 0.008863636
  
P(��|���ǡ����鸸���������) �� P(���ǡ����鸸���������|��)
= P(����|��) * P(���鸸|��) * P(�������|��) * P(��)
= (2/78) * (63/78) * (21/78) * (78/100) = 0.004349112

                                     0.008863636
P(����|���ǡ����鸸���������) = ----------------------
                             0.008863636 + 0.004349112

                                    0.004349112  
P(��|���ǡ����鸸���������) = ----------------------
                             0.008863636 + 0.004349112

0.008863636/(0.008863636 + 0.004349112) = 0.6708397
0.004349112/(0.008863636 + 0.004349112) = 0.3291603
0.6708397 + 0.3291603 = 1

[����217]��Ʊ׶�=YES,��=NO,�ķ�ǰ=NO,�ּһ���=YES�϶� ������ Ȯ���� ���ϼ���.

         ��Ʊ׶�		��		�ķ�ǰ	 	�ּһ���	��
          YES	NO	YES	NO	YES	NO	  YES	NO
����	     4	16	10	10	0	20	    12	8	     20
��	       1	79	14	66	8	72	    23	57	   80
��	       5	95	24	76	8	92	    35	65	  100
                                 P(��Ʊ׶�����������ķ�ǰ���ּһ���|����) * P(����)
P(����|��Ʊ׶�����������ķ�ǰ���ּһ���) = -----------------------------------
                                     P(��Ʊ׶���������ķ�ǰ���ּһ���)

�и� : P(��Ʊ׶�����������ķ�ǰ���ּһ���) = P(��Ʊ׶�����������ķ�ǰ���ּһ���|����) * P(����)+
                                  P(��Ʊ׶���������ķ�ǰ���ּһ���|��) * P(��)

���� :  P(����|��Ʊ׶�����������ķ�ǰ���ּһ���) �� P(��Ʊ׶�����������ķ�ǰ���ּһ���|����) * P(����) = 
  (P(��Ʊ׶�|����) + P(����|����) + P(�ּһ���|����)+  P(���ķ�ǰ|����) + P(����))
(4/20 * 10/20 * 12/20 * 20/20 * 20/100) = 0.012
        P(��|��Ʊ׶�����������ķ�ǰ���ּһ���) �� P(��Ʊ׶�����������ķ�ǰ���ּһ���|��) *P(��)= 
  (P(��Ʊ׶�|��) + P(����|��) + P(�ּһ���|��) +P(���ķ�ǰ|��) + P(��))
= 1/80 * 66/80 * 72/80 * 80/100 * 23/80 = 0.002134688 

P(����|��Ʊ׶���������ķ�ǰ���ּһ���) = 0.012 / (0.012+0.002134688) = 0.8489752
P(��|��Ʊ׶���������ķ�ǰ���ּһ���) = 0.002134688 / (0.012+0.002134688) = 0.1510248


[����218] ��Ʊ׶�=YES, ��=NO, �ķ�ǰ=YES, �ּһ���=YES �϶� ������ Ȯ���� ���ϼ���.
          ��Ʊ׶�		��		�ķ�ǰ	 	�ּһ���	��
         YES	NO	YES	NO	YES	NO	  YES	NO
����	     4	16	10	10	0	20	    12	8	     20
��	       1	79	14	66	8	72	    23	57	   80
��	       5	95	24	76	8	92	    35	65	  100

P(����|��Ʊ׶���������ķ�ǰ���ּһ���) 
 = (P(��Ʊ׶���������ķ�ǰ���ּһ���|����) * P(����)) / P(��Ʊ׶���������ķ�ǰ���ּһ���)
P(A|B) = (P(B|A) * P(B)) / P(B)

�и� : P(��Ʊ׶���������ķ�ǰ���ּһ���) �� P(��Ʊ׶���������ķ�ǰ���ּһ���|����) * P(����) +
  P(��Ʊ׶���������ķ�ǰ���ּһ���|��) * P(��)

���� : P(����|��Ʊ׶���������ķ�ǰ���ּһ���) �� P(��Ʊ׶���������ķ�ǰ���ּһ���|����) * P(����)
   =(P(��Ʊ׶�|����) + P(����|����) + P(�ּһ���|����)+  P(���ķ�ǰ|����) + P(����))
(��):P(��|��Ʊ׶���������ķ�ǰ���ּһ���) �� P(��Ʊ׶���������ķ�ǰ���ּһ���|��) * P(��)
=(P(��Ʊ׶�|��) + P(����|��) + P(�ּһ���|��)+  P(���ķ�ǰ|��) + P(��))

4/20 * 10/20 * 12/20 * 0/20 * 20/100 =0 (0/20�� 0�̵ż� 0�̳���)
1/80 * 66/80 * 8/80 * 23/80 * 80/100 =0.0002371875
P(����|��Ʊ׶���������ķ�ǰ���ּһ���)  = 0/(0+0.0002371875) = 0

�ܶ��ö� ����ġ(Laplace estimator)
- Ȯ������ 0�� ������ �ʵ��� ���� ������ �����Ѵ�. (���� 1�� �����Ѵ�.)

P(����|��Ʊ׶���������ķ�ǰ���ּһ���)
5/24 * 11/24 * 13/24 * 1/24 * 20/100 =0.0004310137 #��ü�� ���� ������ ���� �и� 1�� ���Ѵ�

P(��|��Ʊ׶���������ķ�ǰ���ּһ���)
2/84 * 67/84 * 9/84 * 24/84 * 80/100 =0.000465084

P(����|��Ʊ׶���������ķ�ǰ���ּһ���) = 0.0004310137/(0.000465084+0.0004310137) = 0.4809896
P(��|��Ʊ׶���������ķ�ǰ���ּһ���) = 0.000465084/(0.000465084+0.0004310137) = 0.5190104

[���� 219] ���Ͼȿ� �����̶�� �ܾ ���� ��쿡 ������ Ȯ��?
                    P(���ԡ�����)         P(����|����) * P(����)
  P(����|����) =-------------------- = -------------------
                      P(����)               P(����)
  
P(����)= 0.22
P(����|����) = 0.136
P(����|��) = 0.025

P(����|����) �� P(����|����) * P(����)
P(��|����) �� P(����|��) * P(��)

P(����) = P(����|����)*P(����) + P(����|��)*P(��)

P(����|����) = 0.136 * 0.22 / ((0.136 * 0.22)+(0.025 * 0.78)) = 0.6054229

#---------------naiveBayes
install.packages("e1071")
library(e1071)

mail <- read.csv('c:/data/mail.csv',header=T)
str(mail)

nb <- naiveBayes(mail[1:4],mail$�з�)

test <- data.frame('NO','NO','NO','YES')
test
names(test) <- names(mail[,1:4])
test

predict(nb,test)

[����220] ��ȭ�帣 �з��� ���ּ���.
movie <- read.csv('c:/data/movie.csv')
movie

'''
80% �н������ͷ� ����� �Ϻ� 20% �׽�Ʈ�����ͷ� �н��� �ؼ�
���� ����� �� �´��� Ȯ���ؼ�
�� ������ �� ������� ���� �ȴ�.
'''

�ܷ������� ���ڸ� �ִ� �Լ� sample ( ��������, �񺹿����� )

#�н�������(80%),�׽�Ʈ������(20%) �и�
idx <- sample(2,nrow(movie),replace=T,prob=c(0.8,0.2)) # replace�ɼ� T�� ��������, 1����2������ ���ڸ� nrow(movie)������ŭ, 1�� 0.8, 2��0.2��ŭ
table(idx)

# �н�������
movie_train <- movie[idx==1,1:5]
nrow(movie_train)

# test������
movie_test <- movie[idx==2,1:5]
nrow(movie_test)

# �н������� ����
movie_train_labels <- movie[idx==1,6]
length(movie_train_labels)

# test������ ����
movie_test_labels <- movie[idx==2,6]
length(movie_test_labels)

# naiveBayes
nb <- naiveBayes(movie_train,movie_train_labels,laplace=1) #laplace=1 ���ö�
nb

test_predict <- predict(nb,movie_test)
sum(test_predict == movie_test_labels)/length(movie_test_labels)

install.packages('gmodels')
library('gmodels')

gmodels::CrossTable(x=movie_test_labels, y=test_predict,prop.chisq=F,dnn=c('����','����'))

gmodels::CrossTable(x=test_predict, y=movie_test_labels,prop.chisq=F,dnn=c('����','����'))

#----------------------------------------------------------------------------
[����221]
spam <- read.csv('c:/data/sms_spam.csv', header=T)
head(spam)
View(spam)
library(tm)
library(stringr)

0. ���鸸 �̱�(��ó��) # �ϴ� �־�� �ǹ̰� �� Ư�����ڳ� ���ڳ� �ҿ� ����, �빮���� �� �ǹ� �ִ� �ܾ�鵵 �׳� �� �ҹ��ڷ� �����ع����� �����ϰ� / �Ŀ� �ٽ� ��ó�� �ϱ�


#����ġ��ȯ
spam_cor <- VCorpus(VectorSource(spam$text))
inspect(spam_cor)

# �ҹ��ڷ� ����
spam_cor <- tm_map(spam_cor, content_transformer(tolower))
lapply(spam_cor,content)

# �ҿ������
spam_cor <- tm_map(spam_cor,removeWords,stopwords('smart'))
lapply(spam_cor,content)

'''
# Ư������ ����
spam_cor <- tm_map(spam_cor,removePunctuation) # �յڹ��ڰ� �پ������ ����
lapply(spam_cor,content)
'''
# Ư������ ����
convert <- content_transformer(function(x,pattern){ return(gsub(pattern,' ',x))})
spam_cor <- tm_map(spam_cor,convert,'(http|https)\\S+')
spam_cor <- tm_map(spam_cor,convert,'www\\S+')
spam_cor <- tm_map(spam_cor,convert,'/|:|;|\\.|"|<|>|\\?|!')
spam_cor <- tm_map(spam_cor,convert,"'|%|&|\\^|\\$")
spam_cor <- tm_map(spam_cor,convert,'\\(|\\)|-')

# ��������
spam_cor <- tm_map(spam_cor,removeNumbers)
inspect(spam_cor[[1]])

# ��,�� ���� ����
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('��',' ',x)))
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('��',' ',x)))
lapply(spam_cor,content)

# ��,��,��,��,������
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('[\\w+]*��[\\w+]*',' ',x)))
spam_cor <- tm_map(spam_cor, content_transformer(function(x) gsub('[��|��|��|��]',' ',x)))
lapply(spam_cor,content)
#str_extract_all(spam_cor,'[\\w+]*��[\\w+]*')

# 2���̻� ���� 1���� ����
spam_cor <- tm_map(spam_cor, stripWhitespace)
lapply(spam_cor,content)


1.�ܾ��� �����Ͽ� ���� ����ó�� �����
  collection from Landline ... �� �ܾ��
1��  yes       no    yes     ...         ,ham
2��  yes       no    yes     ...         ,spam
3��  yes       no    yes     ...         ,spam                                    
...
# dtm �����
spam_dtm <- DocumentTermMatrix(spam_cor)
inspect(spam_dtm)

2. ���� �����͸� �н������Ϳ� �׽�Ʈ�����ͷ� ������

# �н�������1, �׽�Ʈ������2�� ���������� sample�Լ��� �̿��Ͽ� 1,2�� spam_dtm���̸�ŭ ���ε����� �������� �ֱ�
idx <- sample(2,NROW(spam_dtm),replace=TRUE,prob=c(0.8,0.2))

# �н�������
spam_train <- spam_dtm[idx==1,]
inspect(spam_train)

# �׽�Ʈ������
spam_test <- spam_dtm[idx==2,]

# �н������� ����
spam_train_labels <- spam[idx==1,1]

# �׽�Ʈ������ ����
spam_test_labels <- spam[idx==2,1]

# ������ ������ ����
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

4. CrossTable ��� ����
CrossTable(x=spam_test_labels,y=spam_test_predict)

#--------------------------------------------------- ����� ��!

library(stringr)
library(tm)
sms <- read.csv('c:/data/sms_spam.csv',header=T)
head(sms)
str(sms)

sms[str_detect(sms$text,'www'),]
sms[grep('www',sms$text),]

sum(str_detect(sms$text,'www'))
length(grep('www',sms$text))

as.vector(na.omit(str_extract(sms$text,'www\\S+'))) # \\S+ ������ ������ ������ ����
as.vector(na.omit(str_extract(sms$text,'(http|https)\\S+')))

table(sms[grep('(http|https)\\S+',sms$text),'type'])
table(sms[grep('www\\S+',sms$text),'type'])
'(http|https)\\S+' -> url_unique #url�� �����ϴµ� ������� �ִ� �ܾ��̱� ������ ������ �̸����� ���� �ذ��ص� ��
'www\\S+' -> urlunique

as.vector(na.omit(str_extract(sms$text,'\\W\\d+')))
as.vector(na.omit(str_extract(sms$text,'(��|\\$)\\d+')))
table(sms[grep('(��|\\$)\\d+',sms$text),'type']) #
'(��|\\$)\\d+' -> price_unique # ������ִ� �ܾ���̱⿡ ������ ����� �ȵȴ�.


sms_corpus <- VCorpus(VectorSource(sms$text))
lapply(sms_corpus[1:2],content) #Ȯ��

sms_corpus_clean <- tm_map(sms_corpus,content_transformer(tolower)) # �ҹ��ڷ� ��ȯ
lapply(sms_corpus_clean[1:2],content) #Ȯ��

convert <- content_transformer(function(x,pattern){ # �Ȱ��� ������ �Լ����� ����� �� ���� �ٲ�� �̷��� �Լ������� ���� ���� ������ �غ���
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
sms_dtm #  ��κ��� ���� 0���� �� �־ �� �ȳ��� ���� �ִ�.
nrow(sms_dtm)
idx <- sample(2,nrow(sms_dtm),replace=TRUE,prob=c(0.8,0.2)) # ����1,2�� nrow(sms_dtm)��ŭ ���������Ͽ� ���� �ִ´�. 1�� ��ü�� 80%,2�� ��ü�� 20%��ŭ �������� �ִ´�.
idx

#�н�������
sms_dtm_train <- sms_dtm[idx==1,]
inspect(sms_dtm_train)

#�׽�Ʈ������
sms_dtm_test <- sms_dtm[idx==2,]
inspect(sms_dtm_test)

# �н������� ����
sms_dtm_train_labels <- sms[idx==1,1]
length(sms_dtm_train_labels)

# �׽�Ʈ������ ���� 
sms_dtm_test_labels <- sms[idx==2,1]
length(sms_dtm_test_labels)

# �󵵼��� ������ �ڷ�� ���� 0 -> NO, 1�̻��� �� -> YES
convert_count <- function(x) {
  x <- ifelse(x > 0,'YES','NO')
}

sms_train <- apply(sms_dtm_train, MARGIN=2, convert_count)
#inspect(sms_train) apply�� �����ϰ� matrix�� �ٲ�, �����Ͱ� ���������� ����
class(sms_train)
sms_train[1,]

sms_test <- apply(sms_dtm_test, MARGIN=2, convert_count)
#inspect(sms_train) apply�� �����ϰ� matrix�� �ٲ�
class(sms_test)
sms_test[1,]

sms_nb <- naiveBayes(sms_train,sms_dtm_train_labels,laplace=1) # ����ġ���� �� �ȳ��´� ���� �� laplace�ɼ��� �ֱ�

test_predict <- predict(sms_nb,sms_test)

CrossTable(x=sms_dtm_test_labels,y=test_predict)

'''
| test_predict 
sms_dtm_test_labels |       ham |      spam | Row Total | 
  --------------------|-----------|-----------|-----------|
  ham |       935 |        12(���з�) |       947 |                  
  |    16.500 |   105.354 |           | 
  |     0.987 |     0.013 |     0.866 | 
  |     0.989 |     0.081 |           | 
  |     0.855 |     0.011 |           | 
  --------------------|-----------|-----------|-----------|
  spam |        10 |       136(������ �´� ��) |       146 | 
  |   107.023 |   683.355 |           | 
  |     0.068 |     0.932 |     0.134 | 
  |     0.011 |     0.919 |           | 
  |     0.009 |     0.124 |           | 
  --------------------|-----------|-----------|-----------|
  Column Total |       945 |       148 |      1093 |          
  |     0.865 |     0.135 |           | 
  --------------------|-----------|-----------|-----------|
  (945+136)/1093 = 0.989021% �����
'''
# ���ο� ���� ������ ��!
new = 'URGENT! Your Mobile number has been awarded with a $ 2000 prize GUARANTEED'
new_corpus <- VCorpus(VectorSource(new))
lapply(new_corpus,content)
clean <- tm_map(new_corpus,content_transformer(tolower))
convert <- content_transformer(function(x,pattern){ # �Ȱ��� ������ �Լ����� ����� �� ���� �ٲ�� �̷��� �Լ������� ���� ���� ������ �غ���
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

new_dtm <- DocumentTermMatrix(clean,list(dictionary=Terms(sms_dtm))) #������ ������� sms_dtm�ܾ ��������ؼ� dtm�� ����ٴ� �ɼ�

convert_counts <- function(x){
  x <- ifelse(x>0,'YES','NO')
}

new_test <- apply(new_dtm,MARGIN=2, convert_counts) #�����ϸ� ���ͷ� �ٲ�, ���ʹ� ���̺꺣��� ���� �� ����, ������ ���� �� matrix����
class(new_test)
dim(t(new_test))

predict(sms_nb,t(new_test))
options('scipen'=100) 

predict(sms_nb,t(new_test),type='raw')# Ȯ�������� �������ؼ� type�ɼ��� raw�� �־��ֱ�


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!2022/2/18 ������Ʈ ���� 1����!!!!!!!!!!!!!!!!!!!!!!!!!!
��ȹ
������ ��� ��������
�ʿ��� �����, �Լ���
��� �ذ�����, � �˰������� ����
������ ������ 
url�� �ٲ���� �ȹٲ���� üũ

ppt���� ��� �ڵ尡 �� �� �ʿ���� �߿��� �κе鸸 �̾Ƽ� ������ �ֱ�

