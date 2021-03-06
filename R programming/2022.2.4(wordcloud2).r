[문제199] 전화번호를 추출해주세요.

message = '안녕하세요. 전화번호는 02-123-4567 입니다.
문의사항이 있으면 031-1234-0000 으로 연락주시기 바랍니다.
폰 번호는 010-1234-1004 고객센터 전화번호 1588-3600  대표전화 : 031)777-1140'

library(stringr)
str_extract_all(message,'(\\d+\\W|)\\d+\\W\\d+')

#--------------------------강사님
str_extract_all(message,'(\\d{2,3})?(-|\\))?\\W\\d{3,4}-\\d{4}')

[문제200] 이메일 주소를 추출해주세요.

message = '담당자 이메일주소는 webmaster@itwill.co.kr  
           이메일 주소는 happy.o@gmail.com   
           이메일 주소는 happy123@naver.com 입니다. info_search@joins.com'

str_extract_all(message,'(\\w+|\\w+\\W\\w+)\\@(\\w+.\\w+|\\w+.\\w+.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+\\W\\w)\\@(\\w+\\.\\w+|\\w+\\.\\w+\\.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+\\W\\w+)\\@(\\w+\\.\\w+\\.\\w+|\\w+\\.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+[[:punct:]]\\w+)\\@(\\w+\\.\\w+\\.\\w+|\\w+\\.\\w+)')
#--------------------------강사님
str_extract_all(message,'[\\w.]+@[\\w.]+') 
str_extract_all(message,'[A-z0-9.]+@[A-z.]+') # _ 표시는 A-z에도 포함이 된다?

[문제201] seoul.txt 파일을 날짜를 추출해서 월별 빈도수를 확인 하고 시각화 해주세요.
seoul <- readLines('c:/data/seoul.txt')
seoul

data <- str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')
df <- data.frame(table(as.integer(format(as.Date(unlist(data)),'%m'))))
library(wordcloud)
wordcloud(df$Var1,df$Freq,
          colors=rainbow(NROW(df)),
          random.order=F)


#_-------------------------------강사님
str_extract(seoul,'\\d{4}-\\d{2}-\\d{2}')
text_date <- as.Date(unlist(str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')))
class(text_date)
library(lubridate)
month_freq <- data.frame(table(lubridate::month(text_date)))
names(month_freq) <- c('month','cnt')
str(month_freq)
month_freq$month <- factor(month_freq$month)

library(ggplot2)
ggplot(data=month_freq,aes(x=as.integer(month),y=cnt))+
  geom_bar(stat='identity',fill=rainbow(nrow(month_freq)))+
  scale_x_continuous(breaks=c(1:9),labels=paste0(month_freq$month,'월'))


[문제202] seoul.txt 파일을 단어별 빈도수를 확인 하고 시각화 해주세요.

word <- str_extract_all(seoul,'[가-힣]+') # 한글 추출

df_word <- data.frame(table(unlist(word)))
wordcloud(df_word$Var1,df_word$Freq,
          colors = rainbow(NROW(df_word)),
          max.words = 50,
          random.order = F)

df_word
seoul
str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')
str_extract_all(seoul,'\\d+[[:space:]]')
seoul

seoul1 <- gsub('\\d{4}-\\d{2}-\\d{2}','',seoul)

str_extract_all(seoul1,'[[:space:]][[:space:]]\\d+')
seoul2 <- gsub('[[:space:]][[:space:]]\\d+','',seoul1)
str_extract_all(seoul2,'\\d+[[:space:]]')
seoul3 <- gsub('\\d+[[:space:]]','',seoul2)

#-------------------------강사님                
  #날짜정보 제거
str_extract(seoul,'\\d{4}-\\d{2}-\\d{2}')
data <- str_replace(seoul,'\\d{4}-\\d{2}-\\d{2}','')
data

  #문장 앞에 숫자 제거
str_extract(data,'^\\d{1,3}')
data <- str_replace(data,'^\\d{1,3}','')

  #문장 앞 뒤 공백문자제거
data <- str_trim(data)

  #문장 맨 뒤에 숫자 제거
str_extract(data,'\\d{1,3}$')
data <- str_replace(data,'\\d{1,3}$','')


  #문장 앞 뒤 공백문자제거
data <- str_trim(data)
data

  #[]문자 추출
x <- str_extract(data,'\\[\\w+\\]')
x[!is.na(x)]

unlist(str_extract_all(data,'\\[\\w+\\]'))

grep('\\[\\w+\\]',data,value=T)

data <- str_replace(data,'(\\[|\\])','')

grep('\\[|\\]',data,value=T)

  #()문자 추출
x <- str_extract(data,'\\(\\w+\\)')
x[!is.na(x)]

unlist(str_extract_all(data,'\\(\\w+\\)'))

grep('\\(\\w+\\)',data,value=T)

data <- str_replace(data,'(\\(|\\))',' ')
data

##
grep('O+',data,value=T)
unlist(str_extract_all(data,'O+'))

# OOOOO OO OOO 제거
data <- str_replace_all(data,'O+','')
data
grep('O+',data,value=T)

data <- paste(data,collapse = ' ') # collapse=' ' 공백문자로 각 문자를 합하여 준다.
word_cnt <- data.frame(table(str_split(data,' ')))
head(word_cnt)

library(wordcloud)
wordcloud(word_cnt$Var1,word_cnt$Freq,min.freq=2)

install.packages('wordcloud2')
library(wordcloud2)
wordcloud2(word_cnt,col='random-light',
           backgroundColor = 'black',
           shape='star')

?wordcloud2

wordcloud2(word_cnt)

[문제203] review.txt파일 전처리 작업을 수행해주세요.
library(stringr)
readLines('c:/data/review.txt')
review <- read.csv('c:/data/review.txt')
View(review)

review[1,2]
review$point <- 평점만 들어가도록
review$감상평 <- 감상평만
review$글쓴이 <- 글쓴이만
review$날짜 <- 날짜만

# 감상평의 포맷문자들 다 제거
str_extract_all(review[,2],'\\\n+|\\\t')
review$감상평 <- str_replace_all(review[,2],'\\\n+|\\\t+','')
review

# 평점만 추출하여 새로운 열에 삽입 (참고사항 : '중'오른쪽 숫자, 평점과 함께 붙어있는 숫자 구분(26행,97행에서 평점옆에 1편이 붙어있음))
unlist(str_extract_all(review[,2],'중\\d{1,2}')) # 평점 추출하기위해 옆에 중까지 추출
review$poing <- gsub('중','',unlist(str_extract_all(review[,2],'중\\d{1,2}'))) #'중'을 없애기
review$poing <- as.integer(review$poing) # integer형으로 변환 10점보다 큰 수(평점과 같이 붙어서 들어온 숫자 없애기위한 작업1)
review$poing <- ifelse(review$poing > 10, review$poing%%10,review$poing) 

# 감상평의 필요없는 문자들 제거
str_extract_all(review$감상평,'해적: 도깨비 깃발별점 - 총 10점 중\\d') # 필요없는 앞부분 추출
review$감상평 <- str_replace_all(review$감상평,'해적: 도깨비 깃발별점 - 총 10점 중\\d','') # 필요없는 앞부분 제거(10점짜리 평점들은 0이 남음, 숫자로 시작하는 감상평이 있기때문)
str_extract_all(review$감상평,'^0') # 감상평에 맨앞에 평점 10점들의 남은 0들 추출
review$감상평 <- str_replace_all(review$감상평,'^0','') # 남은 0들 제거
str_extract_all(review$감상평,'신고$')
review$감상평 <- str_trim(str_replace_all(review$감상평,'신고$','')) # 맨뒤의 필요없는 글자 신고 제거하고 마지막에 공백부분 제거

# 글쓴이랑 날짜 서로 다른열로 분리하기
review$글쓴이.날짜
review$글쓴이 <- str_extract_all(review$글쓴이.날짜,'\\w+\\*+') # 글쓴이 추출
review$날짜 <- str_extract_all(review$글쓴이.날짜,'\\d{2}.\\d{2}.\\d{2}') # 날짜 추출
review <- review[,c('번호','감상평','poing','글쓴이','날짜')] 

#---감상평 더 보고 wordcloud2그리기
review$감상평
str_extract_all(review$감상평,'\\W')
str_extract_all(review$감상평,'[[:space:]]{2}')
str_replace_all(review$감상평,'[[:space:]]{2}',' ')
str_extract_all(review$감상평,'[ㄱ-ㅣ]')
str_extract_all(review$감상평,'[A-z]')
str_extract_all(review$감상평,'[A-z]+')


test <- paste(review$감상평,collapse=' ')
test <- strsplit(test,split=' ')
test <- data.frame(table(test))
wordcloud2(test)
?wordcloud2

wordcloud2(test, color = ifelse(test[,2] > 5,'red','skyblue'))



#-------------------------------- 강사님 

review <- read.csv('c:/data/review.txt')

# \n \t 제거
review$감상평[1]
grep('\n',review$감상평,value=T)
str_extract_all(review$감상평,'\n|\t')
sum(str_count(review$감상평,'\n|\t'))

review$감상평 <- gsub('\n',' ',review$감상평)
review$감상평 <- gsub('\t',' ',review$감상평)
review$감상평[1]

# 두 개 이상의 공백문자를 한 개 공백문자로 변경
grep('\\s{2,}',review$감상평,value=T)
str_extract_all(review$감상평,'\\s{2,}')

# review$감상평 <- gsub('\\s{2,}',' ', review$감상평)
review$감상평 <- str_squish(review$감상평) # 두개 이상의 공백을 하나의 공백으로 변경하는 함수 str_squish
review$감상평[1]

# 불필요한 글자 지우기
str_extract_all(review$감상평,'해적: 도깨비 깃발 별점 - 총 10점 중')
str_extract_all(review$감상평,'신고$')
review$감상평 <- gsub('해적: 도깨비 깃발 별점 - 총 10점 중','',review$감상평)
review$감상평 <- gsub('신고$','',review$감상평)

review$감상평[1]

View(review)

review$point <- as.integer(str_extract(review$감상평,'^\\d{1,2}'))
str(review)
boxplot(review$point)

review$감상평 <- str_replace(review$감상평,'^\\d{1,2}','')
View(review)

review[1:10,3]

review$id <- str_extract(review$글쓴이.날짜,'\\w{1,}\\*{1,}')
review$date <- str_extract(review$글쓴이.날짜,'\\d{2}\\.\\d{2}\\.\\d{2}')
View(review)

review$evaluation <- ifelse(review$point>=8, '긍정','부정')
View(review)

positive <- paste(review[review$evaluation=='긍정','감상평'],collapse=' ')
negative <- paste(review[review$evaluation=='부정','감상평'],collapse=' ')

positive <- data.frame(table(str_split(positive,' ')))
negative <- data.frame(table(str_split(negative,' ')))

wordcloud2(positive)
wordcloud2(negative)

