2022.4.16  
파이썬 세미 프로젝트 
R 에서 했던 프로젝트 + 추가 프로젝트 

교보문고 사이트에서 가져온 데이터를 활용하여 도서 분야 예측 시스템 (제목, 소개글 학습)
#-------------------------------------------------------------------------------------------------------------
▶전처리 없이 R프로젝트로 구현했던 교보문고 도서분야 예측시스템 구현

import pandas as pd
from pandas import Series, DataFrame

# 데이터 읽어오기
book = pd.read_csv('c:/data/book_field1.csv',encoding='utf-8')
book

# 데이터 형태소 나누기
from konlpy.tag import Okt
okt = Okt()
def okt_pos(arg): # n-gram 생각해보기, 전처리 작업 여기서
    return okt.morphs(arg)

#CountVectorizer
from sklearn.feature_extraction.text import CountVectorizer

cv = CountVectorizer(tokenizer=okt_pos)
cv.fit(book.text)
cv.vocabulary_
cv.get_feature_names()
cv_trans = cv.transform(book.text)
df = pd.DataFrame(cv_trans.toarray(),columns=cv.get_feature_names())

#tf-idf 변환
from sklearn.feature_extraction.text import TfidfTransformer
tfidf_t = TfidfTransformer()
tf = tfidf_t.fit_transform(cv_trans)
pd.DataFrame(tf.toarray(),columns=cv.get_feature_names())

# 학습데이터 정답라벨 모델 만들기
from sklearn.naive_bayes import MultinomialNB
mn = MultinomialNB()
y_label = book.field
x_label =  cv.transform(book.text)
mn.fit(x_label,y_label)

# 테스트 데이터(정치사회에서 제목과 소개글 가져옴)
x_test = cv.transform(Series(' '.join(okt_pos('가불 선진국, 한국은 전 세계가 놀랄 정도로 가파른 성장을 거듭해오며 선진국 반열에 들어섰다. 그러나 선진국 대한민국의 환호 뒤에는 수많은 사회적·경제적 약자의 희생이 놓여 있다. 문재인 정부의 공직자로 활동한 저자는 ‘사회권 보장’을 통해 그동안 소외돼온 약자층에 진 ‘빚’을 갚아야 한다고 주장한다. 그래야만 선진국 반열에 오르기 위해 ‘가불’했던 ‘빚’을 갚고 지속 가능한 선진국이 될 수 있다.'))))
mn.predict(x_test)

#------------------------------------------------------
▶ 전처리 작업 포함 R프로젝트로 구현했던 교보문고 도서분야 예측시스템 구현
import pandas as pd
from pandas import Series, DataFrame

# 데이터 읽어오기

book = pd.read_csv('c:/data/book_field1.csv',encoding='utf-8')
book

# 데이터 형태소 나누기
def okt_pos(arg):
    token = []
    for j in okt.pos(arg):
        if j[1] in ['Noun','Adjective','Alpha']:  # 명사, 형용사, 영어
            token.append(j[0]) 
    token = [i for i in token if len(i)>=2]
    return token

# 불용어
stopwords = ['지난','이후','독자','작가','있다','같은','이로','인해','있게','누구','있으며']

#CountVectorizer
from sklearn.feature_extraction.text import CountVectorizer

cv = CountVectorizer(tokenizer=okt_pos,stop_words=stopwords)
cv.fit(book.text)
cv.vocabulary_
cv.get_feature_names()
cv_trans = cv.transform(book.text)
df = pd.DataFrame(cv_trans.toarray(),columns=cv.get_feature_names())

#tf-idf 변환
from sklearn.feature_extraction.text import TfidfTransformer
tfidf_t = TfidfTransformer()
tf = tfidf_t.fit_transform(cv_trans)
pd.DataFrame(tf.toarray(),columns=cv.get_feature_names())

# 학습데이터 정답라벨 모델 만들기
from sklearn.naive_bayes import MultinomialNB
mn = MultinomialNB()
y_label = book.field
x_label =  cv.transform(book.text)
mn.fit(x_label,y_label)

# 테스트 데이터
x_test = cv.transform(Series(' '.join(okt_pos('가불 선진국, 한국은 전 세계가 놀랄 정도로 가파른 성장을 거듭해오며 선진국 반열에 들어섰다. 그러나 선진국 대한민국의 환호 뒤에는 수많은 사회적·경제적 약자의 희생이 놓여 있다. 문재인 정부의 공직자로 활동한 저자는 ‘사회권 보장’을 통해 그동안 소외돼온 약자층에 진 ‘빚’을 갚아야 한다고 주장한다. 그래야만 선진국 반열에 오르기 위해 ‘가불’했던 ‘빚’을 갚고 지속 가능한 선진국이 될 수 있다.'))))
mn.predict(x_test) # 일치(정치/사회)
x_test = cv.transform(Series(' '.join(okt_pos('꽃을 보듯 너를 본다,만인의 심금을 울릴 수 있는 서정시의 진수 블랙핑크(BLACKPINK)의 지수와 세계적인 보컬 그룹인 방탄소년단(BTS)의 RM, 송혜교와 박보검 등은 물론 전국민의 애송시인 [풀꽃]이 수록되어있는 나태주 시집 [꽃을 보듯 너를 본다]. “자세히 보아야/ 예쁘다//오래 보아야/사랑스럽다//너도 그렇다.” 나태주 시인의 [풀꽃]은 전국민의 애송시라고 해도 과언이 아니다. 순수하고 꾸밈없는 시어들은 풀꽃의 시처럼 독자들에게 꾸준히 읽히면 더 큰 사랑을 받게 됐다. 평범한 것에 아름다움을 보는 눈, 별 볼일 없다고 생각했던 무언가를 다시보게 하는 힘이 이 시집에 있다.'))))
mn.predict(x_test) # 일치(시/에세이)
x_test = cv.transform(Series(' '.join(okt_pos('나 자신을 알라, 뇌과학으로 다시 태어난 소크라테스의 지혜 2500년 전 소크라테스는 델포이 신전의 어느 돌에 새겨진 “너 자신을 알라!”라는 명제를 철학함의 근본으로 삼았다. 고대 그리스 시대, 인간이 추구해야 할 가장 중요한 과제는 내가 누구인지 아는 것, 즉 자기인식이었다. 자기인식은 “자기 자신과 자신의 행동을 의식적으로 성찰할 수 있는 능력”이다. 자기인식이 발달한 사람은 자신의 상황을 정확히 인식할 수 있을 뿐 아니라 뛰어난 마음읽기 능력을 바탕으로 다른 사람의 처지와 상황, 역량도 제대로 파악한다. 세월이 흘러, 현대 과학은 인간의 뇌가 정확히 자기인식을 수행하게끔 만들어져 있음을 밝혀냈다. 최신 뇌과학 연구에 따르면, 인간의 뇌는 불확실성을 판단하고, 끊임없이 자기 자신의 상태와 행동을 모니터링한다. 이 책은 뇌과학과 심리학을 기반으로 인간의 고유한 능력인 메타인지와 자기인식이란 무엇이며, 그것을 어떻게 활용할 수 있는지를 살펴본다.'))))
mn.predict(x_test) # 일치(인문학)

'''
# 테스트 데이터 추출
from pandas import DataFrame,Series
import pandas as pd
from urllib.request import urlopen
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
url = 'http://www.kyobobook.co.kr/indexKor.laf?mallGb=KOR&orderClick=c1a1'
driver = webdriver.Chrome('c:/data/chromedriver.exe')
driver.get(url)

testdata_df = DataFrame(columns=['field','text'])
for j in range(1,13):
    if j < 5:
        driver.find_element(By.XPATH,'//*[@id="main_snb"]/div[1]/ul[1]/li['+str(j)+']/a').click() # 분야 버튼        
    else:
        driver.find_element(By.XPATH,'//*[@id="main_snb"]/div[1]/ul[2]/li['+str(j-4)+']/a').click() # 다음 칸의 분야 버튼        
    driver.find_element(By.XPATH,'//*[@id="container"]/div[2]/div/div/div[3]/ul/li[3]/a').click() # 신상품 버튼(테스트데이터로 신상품 추출하기위해)
    for i in range(1,10,2):
        driver.find_element(By.XPATH,'//*[@id="prd_list_type1"]/li['+str(i)+']/div/div[1]/div[2]/div[1]/a').click()
        title = driver.find_element(By.XPATH,'//*[@id="container"]/div[2]/form/div[1]/h1/strong').text # 제목
        content = driver.find_element(By.XPATH,'//*[@id="container"]/div[5]/div[1]/div[3]/div[2]').text # 책 소개 내용
        testdata_df = testdata_df.append({'text':title + ',' + content},ignore_index=True)
        time.sleep(2)
        driver.back()
    time.sleep(2)    
    driver.back()
    driver.back()

testdata_df
testdata_df['field']
x=[]
for i in range(len(testdata_df)): 
    if i < 5:
        x.append('novel')
    elif 5 <= i <10:
        x.append('poem_essay')
    elif 10 <= i <15:
        x.append('economy')
    elif 15 <= i <20:
        x.append('selfdevelope')
    elif 20 <= i <25:
        x.append('humanities')
    elif 25 <= i <30:
        x.append('history_culture')
    elif 30 <= i <35:
        x.append('religion')
    elif 35 <= i <40:
        x.append('politics_society')
    elif 40 <= i <45:
        x.append('art_popularculture')
    elif 45 <= i <50:
        x.append('sience')
    elif 50 <= i <55:
        x.append('technology_engineering')
    else:
        x.append('computer_it')
testdata_df['field'] = x

testdata_df.to_csv('c:/data/book_testdata_df.csv') # 저장
'''  


# 분류 클래스
mn.classes_ # 'art_popularculture', 'computer_it', 'economy', 'history_culture','humanities', 'novel', 'poem_essay', 'politics_society', 'religion', 'selfdevelope', 'sience', 'technology_engineering'

# 분류 클래스 갯수
mn.class_count_ 
book['field'].value_counts()

# 사전확률
import numpy as np
np.exp(mn.class_log_prior_) # 긍정 8/15 부정 7/15

# 분류 클래스별 컬럼의 값의 빈도수
mn.feature_count_

pd.DataFrame(mn.feature_count_,columns=cv.get_feature_names(), index=mn.classes_)

# 분류기 모델 객체 저장
import pickle
with open('c:/data/classifier_book.pkl','wb') as file:
    pickle.dump(mn,file)
with open('c:/data/cv_book.pkl','wb') as file:
    pickle.dump(cv,file)
with open('c:/data/classifier_book.pkl','rb') as file:
    classifier1 = pickle.load(file)
classifier1.predict(x_test)

# 전체 테스트----------------------------------------------------------------------------------------
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix,classification_report
import pandas as pd
from pandas import DataFrame,Series
from collections import Counter
from konlpy.tag import Okt
okt = Okt()
# 데이터 읽어오기
book = pd.read_csv('c:/data/book_field1.csv',encoding='utf-8')
book

# 학습, 테스트 데이터, 학습라벨, 테스트라벨 만들기
x_train,x_test,y_train,y_test = train_test_split(book['text'],book['field'],test_size=0.2) # test_size=0.2는 전체의 20%를 test셋으로 만들겠다는 의미, shuffle : default=True split이전에 섞을건지, stratify : target으로 지정하면 각각의 class비율을 train /validation에 유지(한쪽에 쏠려서 분배되는 것을 방지함(default=None ))
Counter(y_train)
Counter(y_test)

# 전처리, 형태소 분석 함수
def okt_pos(arg):
    token = []
    for j in okt.pos(arg):
        if j[1] in ['Noun','Adjective','Alpha']:  # 명사, 형용사, 영어
            token.append(j[0]) 
    token = [i for i in token if len(i)>=2]
    return token

# 불용어
stopwords = ['지난','이후','독자','작가','있다','같은','이로','인해','있게','누구','있으며','있는','통해','있도록','저자']

# 학습데이터 
cv = CountVectorizer(tokenizer=okt_pos,stop_words=stopwords)
x_train = cv.fit_transform(x_train)
cv.get_feature_names()
x_train.toarray()

# 테스트데이터
x_test = cv.transform(x_test)
x_test.toarray()

# 분류기 모델
nb = MultinomialNB()
nb.fit(x_train,y_train)

# 테스트 예측
y_predict = nb.predict(x_test)
sum(y_predict == y_test)/360 # 정답률
accuracy_score(y_test,y_predict)

# 혼동행렬
pd.crosstab(y_test,y_predict)
confusion_matrix(y_test,y_predict)
#pd.set_option('display.max_columns',None)
# 정확도, 정밀도, 재현율, f1-score
print(classification_report(y_test,y_predict))

# 분류 클래스
nb.classes_ # 'art_popularculture', 'computer_it', 'economy', 'history_culture','humanities', 'novel', 'poem_essay', 'politics_society', 'religion', 'selfdevelope', 'sience', 'technology_engineering'

# 분류 클래스 갯수
nb.class_count_ 


# 사전확률
import numpy as np
np.exp(nb.class_log_prior_) 

# 분류 클래스별 컬럼의 값의 빈도수
nb.feature_count_

'''
# 옵션
pd.set_option('display.max_seq_items',None)
pd.set_option('display.max_columns',None) # 컬럼 모두 출력
pd.describe_option() # 출력 옵션 정보
'''

# >각 분야별로 wordcloud 출력
from wordcloud import WordCloud
import matplotlib.pylab as plt

    # 분야별 전처리 된 단어 합치기
book[book['field']=='novel']['text']
df = DataFrame(columns=set(book['field']))
for i in set(book['field']):
    x = []
    for j in book[book['field']==i]['text']:
        ok = okt_pos(j)
        x.append(ok)
    df[i] = x    

#test = book[book['field']=='novel']['text'].apply(lambda x : okt_pos(x)) # apply 방법

df2 =[]
label = []
for k in df.columns:
    y = []
    for i in df[k]:
        for j in i:
            y.append(j)
    df2.append(' '.join(y))
    label.append(k)

result_df = DataFrame({label[0]:df2[0],label[1]:df2[1], label[2]:df2[2], label[3]:df2[3], label[4]:df2[4], label[5]:df2[5],label[6]:df2[6],
           label[7]:df2[7], label[8]:df2[8], label[9]:df2[9], label[10]:df2[10], label[11]:df2[11]},index=[0]) # index=[0] 또는 [df2[위치]]

Counter()
w = WordCloud(font_path='c:/Windows/Fonts/HMKMAMI.TTF',
              background_color='white')
plt.subplot(1,2,1)
w.generate_from_frequencies(Counter(result_df['technology_engineering'][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[0])

plt.subplot(1,2,2)
w.generate_from_frequencies(Counter(result_df[result_df.columns[1]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[1])

plt.subplot(2,1,1)
w.generate_from_frequencies(Counter(result_df[result_df.columns[2]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[2])

plt.subplot(2,1,2)
w.generate_from_frequencies(Counter(result_df[result_df.columns[3]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[3])

plt.subplot(2,1,1)
w.generate_from_frequencies(Counter(result_df[result_df.columns[4]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[4])

plt.subplot(2,1,2)
w.generate_from_frequencies(Counter(result_df[result_df.columns[5]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[5])

plt.subplot(2,1,1)
w.generate_from_frequencies(Counter(result_df[result_df.columns[6]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[6])

plt.subplot(2,1,2)
w.generate_from_frequencies(Counter(result_df[result_df.columns[7]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[7])

plt.subplot(2,1,1)
w.generate_from_frequencies(Counter(result_df[result_df.columns[8]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[8])

plt.subplot(2,1,2)
w.generate_from_frequencies(Counter(result_df[result_df.columns[9]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[9])

plt.subplot(2,1,1)
w.generate_from_frequencies(Counter(result_df[result_df.columns[10]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[10])

plt.subplot(2,1,2)
w.generate_from_frequencies(Counter(result_df[result_df.columns[11]][0].split())) 
plt.imshow(w)
plt.axis('off')
plt.title(result_df.columns[11])



