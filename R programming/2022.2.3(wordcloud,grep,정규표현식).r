install.packages('wordcloud')
library(wordcloud)

word <- c('건강','취업','비전','희망','비전','공부','열정','행복','결혼','쇼핑','주식','로또')
freq <- c(100,200,300,340,500,300,200,100,50,250,350,20)
length(word)
length(freq)

wordcloud(word,freq,colors = rainbow(length(word)),
          random.order = F, # T는 랜덤배치, F는 빈도수가 큰 단어를 중앙에 배치
          scale = c(5,2), # 크기 정하기
          min.freq = 300, #300이상만 출력 
          max.words = 100) #단어 수를 조정


[문제182] 공백문자를 기준으로 분리 한 후 단어의 빈도수를 구하고 wordcloud를 이용해서 시각화 해주세요.
data <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity;[9] as of January 2021, R ranks 9th in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] the official R software environment is written primarily in C, Fortran, and R itself[12] (thus, it is partially self-hosting) and is freely available under the GNU General Public License. Pre-compiled executables are provided for various operating systems. Although R has a command line interface, there are several third-party graphical user interfaces, such as RStudio, an integrated development environment, and Jupyter, a notebook interface.[13][14]"
data

data1 <- strsplit(data,' ')
length(data1[[1]])
data2 <- data.frame(data1)
names(data2) <- 'word'

library(dplyr)

data3 <- data2%>%
  group_by(word)%>%
  dplyr::summarise(cnt = length(word))

wordcloud(data3$word,data3$cnt,colors=rainbow(NROW(data3)),
          random.order=F,
          scale = c(3,1),
          min.freq = 1,
          max.words = 50)

#_------------------------------------ 강사님
word <- strsplit(data," ")
df <- data.frame(table(word))
str(df)

wordcloud(df$word,df$Freq,
          scale = c(2,0.5),
          min.freq = 1,
          colors=brewer.pal(9,'Set1'),
          random.order=F,
          max.words = 50)

?wordcloud

★ grep
- 동일한 문자열을 벡터에서 찾아서 인덱스번호, 문자열을 리턴하는 함수

text <- c('a','ab','acb','accb','acccb','accccb')
'a' %in% text
text %in% 'a'
text[text %in% 'a']
text[which(text %in% 'a')]

grep('a',text)
grep('ab',text)
grep('acb',text)
text[grep('c',text)]
grep('c',text,value=T) # value=T c라는 글자가 있는 인덱스를 찾아서 단어를 보여줌

★ 정규표현식(Regular Expression)

* -> 적어도 0번 이상의 패턴을 찾는다.
grep('ac*b',text,value=T) #ab는 무조건 있는데 c는 올 수도 있고 안 올수도 있다

+ -> 적어도 1번 이상의 패턴을 찾는다.
grep('ac+b',text,value=T)

? -> 0번 또는 1번의 패턴을 찾는다.
grep('ac?b',text,value=T)

{n} -> n번의 패턴을 찾는다.
grep('ac{2}b',text,value=T)
grep('ac{0}b',text,value=T)
grep('ac{3}b',text,value=T)

{n,} -> n번 이상의 패턴을 찾는다.
grep('ac{2,}b',text,value=T)

{n,m} -> n번부터 m번까지의 패턴을 찾는다.
grep('ac{2,3}b',text,value=T)

text <- c('abcd','cdab','cabd','c abd')
grep('ab',text,value=T)

^ -> 시작, 시작되는 문자를 찾는다.
grep('^ab',text,value=T)

$ -> 끝, 끝나는 문자를 찾는다.
grep('ab$',text,value=T)

\\b -> 시작되는 문자를 찾는데 빈문자열 뒤에 시작되는 문자도 찾는다.
grep('\\bab',text,value=T)

text <- c('^ab','ab','abc','abd','abe','ab 12','$ab','ca^bd','ab','abcd','abcfd','abfd')

\\*,\\+,\\?,\\^,\\$ -> 순수한 문자로 표현할 때 사용
grep('\\^ab',text,value=T)  #문자의 의미로 ^를 찾을때 \\를 사용

. -> 어떤 문자 하나를 의미한다.
grep('.',text,value=T)
grep('ab.',text,value=T) # ab. 점은 이상의 의미
grep('ab..',text,value=T) # ab.. ab포함 4글자 이상
grep('ab...',text,value=T) # ab... ab포함 5글자 이상

grep('abc',text,value=T)
grep('^abc$',text,value=T)

grep('abc',text,value=T)

[...] -> 리스트 안에 있는 문자패턴을 찾는다.
grep('ab[c,d]',text,value=T) # ab다음에 c 또는 d가 있는 값을 찾겠다.


[n-m] -> 리스트 안에 n부터 m까지 문자 패턴을 찾는다.
grep('ab[c-e]',text,value=T)

[^] -> 리스트 안에 있는 ^는 not을 의미한다.
grep('ab[^c]', text,value=T) # ab뒤에 c가 아닌 값만 추출

grep('ab[^c,d,e]',text,value=T) # ab뒤에 c,d,e가 나오지 않는 값만 추출

text <- c('sql','SQL','Sql100','PLSQL','plsql','R','r','r0','python','PYTHON','pyth0n',
          'python#','100','*100','*','$','^','!','@','#','$','%','(',')','~','?','행복',
          'ㅋㅋㅋㅋ','ㅜㅜㅜㅜ')
text

# 숫자를 찾는 방법
grep('[0-9]',text,value=T)
grep('\\d',text,value=T)
grep('[[:digit:]]',text,value=T)

# 대문자를 찾는 방법
grep('[A-Z]',text,value=T)
grep('[[:upper:]]',text,value=T)

# 소문자를 찾는 방법
grep('[a-z]',text,value=T)
grep('[[:lower:]]',text,value=T)

# 대소문자 다 찾기
grep('[A-Za-z]',text,value=T)
grep('[A-z]',text,value=T) # 특수문자 ^포함해서 찾는다.
grep('[A-Za-z\\^]',text,value=T)# 특수문자 ^포함해서 찾는다.

# 한글을 찾는다
grep('[가-힣]',text,value=T)
grep('[ㄱ-ㅣ]',text,value=T) # 자음부터 모음만 추출
grep('[가-힣ㄱ-ㅣ]',text,value=T)

grep('[A-Za-z가-힣ㄱ-ㅣ]',text,value=T)
grep('[[:alpha:]]',text,value=T)

# 문자, 숫자가 있는 문자 패턴을 찾는 방법
grep('[A-Za-z가-힣ㄱ-ㅣ0-9]',text,value=T)
grep('[[:alnum:]]',text,value=T)
grep('\\w',text,value=T)

# 특수문자가 있는 문자 패턴을 찾는 방법
grep('\\W',text,value=T)
grep('[[:punct:]]',text,value=T)

# 숫자제외
grep('[^0-9]',text,value=T) # 숫자만 들어있는 값들 제외 , 문자+숫자는 추출됨
grep('\\D',text,value=T)
grep('[^[:digit:]]',text,value=T)

employees <- read.csv('c:/data/employees.csv',header=T)
employees[employees$FIRST_NAME=='Steven','FIRST_NAME']
employees[employees$FIRST_NAME=='Stephen','FIRST_NAME']

grep('Steven',employees$FIRST_NAME,value=T)
grep('Stephen',employees$FIRST_NAME,value=T)

| -> 또는 의미
grep('Steven|Stephen',employees$FIRST_NAME,value=T)
name <- c('Steven','Stephen')
grep(name,employees$FIRST_NAME,value=T)

grep(paste(name,collapse='|'),employees$FIRST_NAME,value=T)

(글자1|글자2) -> 글자1 또는 글자2의 문자패턴을 찾는 방법
grep('Ste(v|ph)en',employees$FIRST_NAME,value=T)


data <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity;[9] as of January 2021, R ranks 9th in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] the official R software environment is written primarily in C, Fortran, and R itself[12] (thus, it is partially self-hosting) and is freely available under the GNU General Public License. Pre-compiled executables are provided for various operating systems. Although R has a command line interface, there are several third-party graphical user interfaces, such as RStudio, an integrated development environment, and Jupyter, a notebook interface.[13][14]"

data <- strsplit(data,split=' ')
data <- data.frame(table(data))
data <- data[,-2]

x <- unlist(strsplit(data,split=' '))
x
[문제183] 첫문자가 대문자로 시작되는 단어를 찾으세요.

data[grep('[A-Z]',substr(data,1,1))]

#----------강사님
grep('^[A-Z]{1,}',x,value=T)
grep('^[[:upper:]]{1,}',x,value=T)

[문제184] 숫자가 있는 단어를 찾아주세요.

grep('\\d',data,value=T)
grep('[[:digit:]]',data,value=T)
grep('[0-9]',data,value=T)

[문제185] 특수문자가 있는 단어를 찾아주세요.

grep('\\W',data,value=T)
grep('[[:punct:]]',data,value=T)

[문제186] [숫자]가 있는 단어를 찾아주세요.
grep('\\[\\d+\\]',data,value=T)
grep('\\[\\d{1,}\\]',data,value=T)


#----------------------------------------------

text <- c('sql','SQL','Sql100','PLSQL','plsql','R','r','r0','python','PYTHON','pyth0n',
          'python#','100','*100','*','$','^','!','@','#','$','%','(',')','~','?','행복',
          'ㅋㅋㅋㅋ','ㅜㅜㅜㅜ')
text
library(stringr)
text %in% 'SQL'

grep('SQL',text,value=T)

#str_detect : 특정한 문자가 있는지 검사해서 TRUE,FALSE를 리턴하는 함수
str_detect(text,'SQL')
text[str_detect(text,'SQL')]

grep('^S',text,value=T)
text[str_detect(text,'^S')]

grep('^s',text,value=T)
text[str_detect(text,'^s')]

grep('^[Ss]',text,value=T)
text[str_detect(text,'^[Ss]')]

grep('[Ss]',text,value=T)
text[str_detect(text,'[Ss]')]

grep('[Nn]',text,value=T)
text[str_detect(text,'[Nn]')]

grep('[Nn]$',text,value=T)
text[str_detect(text,'[Nn]$')]

text <- c('sqlsql','ssqls','SQLs')

# str_count : 주어진 단어에서 해당 글자가 몇번 나오는지를 리턴하는 함수
str_count(text,'s')
str_count(text,'S')
str_count(text,'sql')

# str_c : 문자열을 합쳐서 출력하는 함수
paste('R','빅데이터분석')
paste('R','빅데이터분석',sep='')
paste0('R','빅데이터분석')
str_c('R','빅데이터분석')

paste('R','빅데이터분석',sep=',')
str_c('R','빅데이터분석',sep=',')
x <- c('R','빅데이터분석')
x
paste(x[1],x[2],sep=' ') # sep=' ' 기본값
str_c(x[1],x[2],sep='') # sep='' 기본값

paste(x,collapse= ' ')
str_c(x,collapse= ' ')

# str_dup : 주어진 문자열을 주어진 횟수만큼 반복해서 출력하는 함수
str_dup('파도 소리 돋고 싶다.',10)

# str_length : 주어진 문자열의 길이를 리턴하는 함수
nchar('해운대 가고 싶다')
str_length('해운대 가고 싶다')

# str_locate : 주어진 문자열에서 특정한 문자가 처음으로 나오는 위치를 리턴하는 함수
str_locate('january','an')

# str_locate_all : 주어진 문자열에서 특정한 문자가 나오는 모든 위치를 리턴하는 함수
str_locate_all('january','a')
str_locate_all('january','a')[[1]][1]
str_locate_all('january','a')[[1]][2]

str_locate_all('january','a')[[1]][1,][1]
str_locate_all('january','a')[[1]][2,][1]

# str_replace : 주어진 문자열에서 문자를 새로운 문자로 바꾸는 함수, 첫번째 일치하는 문자만 바꾼다.
sub('a','*','banana')
str_replace('banana','a','*')

# str_replace_all : 주어진 문자열에서 문자를 새로운 문자로 바꾸는 함수, 일치하는 모든 문자를 바꾼다.
gsub('a','*','banana')
str_replace_all('banana','a','*')

# str_split : 주어진 문자열에서 지정된 문자를 기준으로 분리하는 함수
strsplit('R,Developer',split=',')
str_split('R,Developer',',')

strsplit('R Developer',split=' ')
str_split('R Developer',' ')

# str_sub :  주어진 문자열에서 지정된 시작인덱스부터 끝인덱스까지 문자를 추출하는 함수
substr('RDeveloper',1,1)
str_sub('RDeveloper',1,1)
str_sub('RDeveloper',start=1,end=1)
str_sub('RDeveloper',start=1,end=5)

substr('RDeveloper',2,nchar('RDeveloper')) # 시작과 끝을 필수적으로 적어야함
substring('RDeveloper',2)
str_sub('RDeveloper',start=2) # 시작점만 적어도 추출됨

# 문자열에서 뒤에 글자를 추출하는 방법
substr('RDeveloper',nchar('RDeveloper')-1,nchar('RDeveloper'))
str_sub('RDeveloper',start=-2)

# str_trim : 접두, 접미부분에 연속되는 공백문자를 제거하는 함수
str_trim('    R      ')
nchar('    R     ')
str_length('    R     ')
str_length(str_trim('    R      '))
str_trim('   R    ',side='both') # side = 'both' 기본값
str_trim('   R    ',side='left')
str_trim('   R    ',side='right')
trimws('   R    ')


text <- c('sql','SQL','Sql100','PLSQL','plsql','R','r','r0','python','PYTHON','pyth0n',
          'python#','100','*100','*','$','^','!','@','#','$','%','(',')','~','?','행복',
          'ㅋㅋㅋㅋ','ㅜㅜㅜㅜ')

grep('[[:digit:]]',text,value=T)
text[str_detect(text,'\\d')]

# str_extract : 문자열에서 지정된 문자열을 찾는 함수
str_extract(text,'[[:digit:]]+')
str_extract(text,'[[:digit:]]{1,}')

unlist(str_extract_all(text,'[[:digit:]]{1,}'))
str_extract_all(text,'[[:digit:]]{1,}',simplify = T)

text <- 'R is programming language PYTHON is programming language'
grep('programming',text,value=T)
x <- unlist(strsplit(text,split=' '))
x
grep('programming',x,value=T)

str_extract(text,'programming') # 문장 내에서 단어를 검색할 때는 처음으로 찾는 단어만 추출한다.
str_extract(x,'programming')
str_extract_all(text,'programming') # 문장 내에서 단어를 검색하는 함수(찾는 단어 모두 추출)


data <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity;[9] as of January 2021, R ranks 9th in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] the official R software environment is written primarily in C, Fortran, and R itself[12] (thus, it is partially self-hosting) and is freely available under the GNU General Public License. Pre-compiled executables are provided for various operating systems. Although R has a command line interface, there are several third-party graphical user interfaces, such as RStudio, an integrated development environment, and Jupyter, a notebook interface.[13][14]"

data1 <- unlist(strsplit(data,split=' '))
[문제187] 첫문자가 대문자로 시작되는 단어를 찾으세요.
str_extract_all(data,'^[A-Z]{1,}')
str_extract_all(data,'^[[:upper:]]')
grep('^[A-Z]',data1, value=T)

#----------------------------- 강사님
str_extract_all(data,'[[:upper:]]{1,}[[:alpha:]]{0,}')
str_extract_all(data,'[A-Z]\\w*')

[문제188] 숫자를 찾아주세요.
grep('\\d',unlist(strsplit(data,split=' ')),value=T)
data1[str_detect(data1,'\\d')]

str_extract_all(data,'\\d{1,}')

#----------------------------- 강사님
str_extract_all(data,'[[:digit:]]{1,}')
str_extract_all(data,'\\d+')

[문제189] 숫자 앞과 뒤에 있는 문자도 찾아주세요.

str_extract_all(data,'[[:alpha:]]{0,}[[:digit:]]{1,}[[alpha:]]{0,}')
str_extract_all(data,'\\w*\\d+\\w*')
str_extract_all(data,'\\w{0,}\\d+\\w{0,}')

[문제190] 관사 a, A, the, The 함께 사용되는 단어을 출력해주세요.

str_extract_all(data,'a [a-z]')

#----------------------강사님
str_extract_all(data,'(a|A|the|The) [[:alpha:]]{1,}')
str_extract_all(data,'(a|A|the|The) \\w+')
str_extract_all(data,'(a|A|the|The)\\s\\w+') # \\s : 공백문자
str_extract_all(data,'(a|A|the|The)[[:space:]]\\w+') # [[:space:]] : 공백문자


[문제191] 숫자 앞과 뒤에 있는 문자 또는 숫자들은 전부 공백문자로 수정한 후 text1 변수에 저장하세요.
str_replace_all(data,'.\\d{1,}.')

#----------------------강사님
str_extract_all(data,'\\w{0,}\\d+\\w{0,}')
text1 <- str_replace_all(data,'\\w{0,}\\d+\\w{0,}',' ')
str_extract_all(text1,'\\w{0,}\\d+\\w{0,}')

[문제192] text1변수에 특수문자만 찾아주세요.
str_extract_all(text1,'[[:punct:]]')
str_extract_all(text1,'\\W')

[문제193] text1변수에 특수문자 앞과 뒤에 문자가 있는 문자를 찾아주세요.
str_extract_all(text1,'\\w+[[:punct:]]\\w+')
#str_extract_all(text1,'\\w*[[:punct:]]\\w*')  다른 특수문자까지 다 나와버림

[문제194] 특수문자 앞과 뒤에 문자가 있는 문자를 찾아서 특수문자를 제거한 단어로 변환해주세요.
"self-hosting" "Pre-compiled" "third-party"
text1 <- str_replace(text1,"self-hosting",'selfhosting')
text1 <- str_replace(text1,"Pre-compiled","Precompiled")
text1 <- str_replace(text1,"third-party","thirdparty")
text1
text1 <- str_replace_all(text1,'[[:punct:]]',' ')
str_extract_all(text1,'[[:punct:]]')

text1 <- str_replace(text1,"selfhosting",'self-hosting')
text1 <- str_replace(text1,"Precompiled","Pre-compiled")
text1 <- str_replace(text1,"thirdparty","third-party")
text1
str_extract_all(text1,'\\w+[[:punct:]]\\w+')

[문제195] text1 변수에 있는 문장의 단어의 빈도수를 구하세요.
text1 <- tolower(text1)
word <- unlist(str_split(text1,' '))
sum(word=='')
word <- word[!nchar(word)==0]
df <- data.frame(table(word))
head(df)

wordcloud(df$word,df$Freq,colors=rainbow(NROW(df)),
          random.order=F,
          scale = c(3,1),
          min.freq = 1,
          max.words = 50)

library(ggplot2)
library(dplyr)
df%>%
  filter(!word %in% c('and','the','is','of','a','in','as','are'))%>%
  filter(Freq>=2)%>%
  ggplot(aes(x=reorder(word,Freq),y=Freq))+
  geom_col()+
  coord_flip()
[문제196] data 변수에 있는 문장에서 [숫자] 대괄호 안에 있는 숫자들을 추출해주세요.
str_extract_all(data,'\\[\\d+\\]')

[문제197] data 변수에 있는 문장에서 (문자) 괄호안에 있는 문자를 추출해 주세요.
str_extract_all(data,'\\([^)]+\\)')

[문제198] data 변수에 있는 문장에서 콤마 앞에 문자와 같이 추출해 주세요
str_extract_all(data,'\\w+,')
str_extract_all(data,'\\w+\\.') # 마침표로 끝나는 단어들
str_extract_all(data,'\\w+;')
str_extract_all(data,'\\w+[.,;]') # 위 세게를 한번에 추출, 대괄호로 표현할 때 
str_extract_all(data,'\\w+(\\.|,|;)') # 위 세게를 한번에 추출, 괄호로 표현할 때
