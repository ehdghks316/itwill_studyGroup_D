[¹®Á¦199] ÀüÈ­¹øÈ£¸¦ ÃßÃâÇØÁÖ¼¼¿ä.

message = '¾È³çÇÏ¼¼¿ä. ÀüÈ­¹øÈ£´Â 02-123-4567 ÀÔ´Ï´Ù.
¹®ÀÇ»çÇ×ÀÌ ÀÖÀ¸¸é 031-1234-0000 À¸·Î ¿¬¶ôÁÖ½Ã±â ¹Ù¶ø´Ï´Ù.
Æù ¹øÈ£´Â 010-1234-1004 °í°´¼¾ÅÍ ÀüÈ­¹øÈ£ 1588-3600  ´ëÇ¥ÀüÈ­ : 031)777-1140'

library(stringr)
str_extract_all(message,'(\\d+\\W|)\\d+\\W\\d+')

#--------------------------°­»ç´Ô
str_extract_all(message,'(\\d{2,3})?(-|\\))?\\W\\d{3,4}-\\d{4}')

[¹®Á¦200] ÀÌ¸ŞÀÏ ÁÖ¼Ò¸¦ ÃßÃâÇØÁÖ¼¼¿ä.

message = '´ã´çÀÚ ÀÌ¸ŞÀÏÁÖ¼Ò´Â webmaster@itwill.co.kr  
           ÀÌ¸ŞÀÏ ÁÖ¼Ò´Â happy.o@gmail.com   
           ÀÌ¸ŞÀÏ ÁÖ¼Ò´Â happy123@naver.com ÀÔ´Ï´Ù. info_search@joins.com'

str_extract_all(message,'(\\w+|\\w+\\W\\w+)\\@(\\w+.\\w+|\\w+.\\w+.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+\\W\\w)\\@(\\w+\\.\\w+|\\w+\\.\\w+\\.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+\\W\\w+)\\@(\\w+\\.\\w+\\.\\w+|\\w+\\.\\w+)')
str_extract_all(message,'([a-z0-9]+|[a-z0-9]+[[:punct:]]\\w+)\\@(\\w+\\.\\w+\\.\\w+|\\w+\\.\\w+)')
#--------------------------°­»ç´Ô
str_extract_all(message,'[\\w.]+@[\\w.]+') 
str_extract_all(message,'[A-z0-9.]+@[A-z.]+') # _ Ç¥½Ã´Â A-z¿¡µµ Æ÷ÇÔÀÌ µÈ´Ù?

[¹®Á¦201] seoul.txt ÆÄÀÏÀ» ³¯Â¥¸¦ ÃßÃâÇØ¼­ ¿ùº° ºóµµ¼ö¸¦ È®ÀÎ ÇÏ°í ½Ã°¢È­ ÇØÁÖ¼¼¿ä.
seoul <- readLines('c:/data/seoul.txt')
seoul

data <- str_extract_all(seoul,'\\d{4}-\\d{2}-\\d{2}')
df <- data.frame(table(as.integer(format(as.Date(unlist(data)),'%m'))))
library(wordcloud)
wordcloud(df$Var1,df$Freq,
          colors=rainbow(NROW(df)),
          random.order=F)


#_-------------------------------°­»ç´Ô
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
  scale_x_continuous(breaks=c(1:9),labels=paste0(month_freq$month,'¿ù'))


[¹®Á¦202] seoul.txt ÆÄÀÏÀ» ´Ü¾îº° ºóµµ¼ö¸¦ È®ÀÎ ÇÏ°í ½Ã°¢È­ ÇØÁÖ¼¼¿ä.

word <- str_extract_all(seoul,'[°¡-ÆR]+') # ÇÑ±Û ÃßÃâ

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

#-------------------------°­»ç´Ô                
  #³¯Â¥Á¤º¸ Á¦°Å
str_extract(seoul,'\\d{4}-\\d{2}-\\d{2}')
data <- str_replace(seoul,'\\d{4}-\\d{2}-\\d{2}','')
data

  #¹®Àå ¾Õ¿¡ ¼ıÀÚ Á¦°Å
str_extract(data,'^\\d{1,3}')
data <- str_replace(data,'^\\d{1,3}','')

  #¹®Àå ¾Õ µÚ °ø¹é¹®ÀÚÁ¦°Å
data <- str_trim(data)

  #¹®Àå ¸Ç µÚ¿¡ ¼ıÀÚ Á¦°Å
str_extract(data,'\\d{1,3}$')
data <- str_replace(data,'\\d{1,3}$','')


  #¹®Àå ¾Õ µÚ °ø¹é¹®ÀÚÁ¦°Å
data <- str_trim(data)
data

  #[]¹®ÀÚ ÃßÃâ
x <- str_extract(data,'\\[\\w+\\]')
x[!is.na(x)]

unlist(str_extract_all(data,'\\[\\w+\\]'))

grep('\\[\\w+\\]',data,value=T)

data <- str_replace(data,'(\\[|\\])','')

grep('\\[|\\]',data,value=T)

  #()¹®ÀÚ ÃßÃâ
x <- str_extract(data,'\\(\\w+\\)')
x[!is.na(x)]

unlist(str_extract_all(data,'\\(\\w+\\)'))

grep('\\(\\w+\\)',data,value=T)

data <- str_replace(data,'(\\(|\\))',' ')
data

##
grep('O+',data,value=T)
unlist(str_extract_all(data,'O+'))

# OOOOO OO OOO Á¦°Å
data <- str_replace_all(data,'O+','')
data
grep('O+',data,value=T)

data <- paste(data,collapse = ' ') # collapse=' ' °ø¹é¹®ÀÚ·Î °¢ ¹®ÀÚ¸¦ ÇÕÇÏ¿© ÁØ´Ù.
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

[¹®Á¦203] review.txtÆÄÀÏ ÀüÃ³¸® ÀÛ¾÷À» ¼öÇàÇØÁÖ¼¼¿ä.
library(stringr)
readLines('c:/data/review.txt')
review <- read.csv('c:/data/review.txt')
View(review)

review[1,2]
review$point <- ÆòÁ¡¸¸ µé¾î°¡µµ·Ï
review$°¨»óÆò <- °¨»óÆò¸¸
review$±Û¾´ÀÌ <- ±Û¾´ÀÌ¸¸
review$³¯Â¥ <- ³¯Â¥¸¸

# °¨»óÆòÀÇ Æ÷¸Ë¹®ÀÚµé ´Ù Á¦°Å
str_extract_all(review[,2],'\\\n+|\\\t')
review$°¨»óÆò <- str_replace_all(review[,2],'\\\n+|\\\t+','')
review

# ÆòÁ¡¸¸ ÃßÃâÇÏ¿© »õ·Î¿î ¿­¿¡ »ğÀÔ (Âü°í»çÇ× : 'Áß'¿À¸¥ÂÊ ¼ıÀÚ, ÆòÁ¡°ú ÇÔ²² ºÙ¾îÀÖ´Â ¼ıÀÚ ±¸ºĞ(26Çà,97Çà¿¡¼­ ÆòÁ¡¿·¿¡ 1ÆíÀÌ ºÙ¾îÀÖÀ½))
unlist(str_extract_all(review[,2],'Áß\\d{1,2}')) # ÆòÁ¡ ÃßÃâÇÏ±âÀ§ÇØ ¿·¿¡ Áß±îÁö ÃßÃâ
review$poing <- gsub('Áß','',unlist(str_extract_all(review[,2],'Áß\\d{1,2}'))) #'Áß'À» ¾ø¾Ö±â
review$poing <- as.integer(review$poing) # integerÇüÀ¸·Î º¯È¯ 10Á¡º¸´Ù Å« ¼ö(ÆòÁ¡°ú °°ÀÌ ºÙ¾î¼­ µé¾î¿Â ¼ıÀÚ ¾ø¾Ö±âÀ§ÇÑ ÀÛ¾÷1)
review$poing <- ifelse(review$poing > 10, review$poing%%10,review$poing) 

# °¨»óÆòÀÇ ÇÊ¿ä¾ø´Â ¹®ÀÚµé Á¦°Å
str_extract_all(review$°¨»óÆò,'ÇØÀû: µµ±úºñ ±ê¹ßº°Á¡ - ÃÑ 10Á¡ Áß\\d') # ÇÊ¿ä¾ø´Â ¾ÕºÎºĞ ÃßÃâ
review$°¨»óÆò <- str_replace_all(review$°¨»óÆò,'ÇØÀû: µµ±úºñ ±ê¹ßº°Á¡ - ÃÑ 10Á¡ Áß\\d','') # ÇÊ¿ä¾ø´Â ¾ÕºÎºĞ Á¦°Å(10Á¡Â¥¸® ÆòÁ¡µéÀº 0ÀÌ ³²À½, ¼ıÀÚ·Î ½ÃÀÛÇÏ´Â °¨»óÆòÀÌ ÀÖ±â¶§¹®)
str_extract_all(review$°¨»óÆò,'^0') # °¨»óÆò¿¡ ¸Ç¾Õ¿¡ ÆòÁ¡ 10Á¡µéÀÇ ³²Àº 0µé ÃßÃâ
review$°¨»óÆò <- str_replace_all(review$°¨»óÆò,'^0','') # ³²Àº 0µé Á¦°Å
str_extract_all(review$°¨»óÆò,'½Å°í$')
review$°¨»óÆò <- str_trim(str_replace_all(review$°¨»óÆò,'½Å°í$','')) # ¸ÇµÚÀÇ ÇÊ¿ä¾ø´Â ±ÛÀÚ ½Å°í Á¦°ÅÇÏ°í ¸¶Áö¸·¿¡ °ø¹éºÎºĞ Á¦°Å

# ±Û¾´ÀÌ¶û ³¯Â¥ ¼­·Î ´Ù¸¥¿­·Î ºĞ¸®ÇÏ±â
review$±Û¾´ÀÌ.³¯Â¥
review$±Û¾´ÀÌ <- str_extract_all(review$±Û¾´ÀÌ.³¯Â¥,'\\w+\\*+') # ±Û¾´ÀÌ ÃßÃâ
review$³¯Â¥ <- str_extract_all(review$±Û¾´ÀÌ.³¯Â¥,'\\d{2}.\\d{2}.\\d{2}') # ³¯Â¥ ÃßÃâ
review <- review[,c('¹øÈ£','°¨»óÆò','poing','±Û¾´ÀÌ','³¯Â¥')] 

#---°¨»óÆò ´õ º¸°í wordcloud2±×¸®±â
review$°¨»óÆò
str_extract_all(review$°¨»óÆò,'\\W')
str_extract_all(review$°¨»óÆò,'[[:space:]]{2}')
str_replace_all(review$°¨»óÆò,'[[:space:]]{2}',' ')
str_extract_all(review$°¨»óÆò,'[¤¡-¤Ó]')
str_extract_all(review$°¨»óÆò,'[A-z]')
str_extract_all(review$°¨»óÆò,'[A-z]+')


test <- paste(review$°¨»óÆò,collapse=' ')
test <- strsplit(test,split=' ')
test <- data.frame(table(test))
wordcloud2(test)
?wordcloud2

wordcloud2(test, color = ifelse(test[,2] > 5,'red','skyblue'))



#-------------------------------- °­»ç´Ô 

review <- read.csv('c:/data/review.txt')

# \n \t Á¦°Å
review$°¨»óÆò[1]
grep('\n',review$°¨»óÆò,value=T)
str_extract_all(review$°¨»óÆò,'\n|\t')
sum(str_count(review$°¨»óÆò,'\n|\t'))

review$°¨»óÆò <- gsub('\n',' ',review$°¨»óÆò)
review$°¨»óÆò <- gsub('\t',' ',review$°¨»óÆò)
review$°¨»óÆò[1]

# µÎ °³ ÀÌ»óÀÇ °ø¹é¹®ÀÚ¸¦ ÇÑ °³ °ø¹é¹®ÀÚ·Î º¯°æ
grep('\\s{2,}',review$°¨»óÆò,value=T)
str_extract_all(review$°¨»óÆò,'\\s{2,}')

# review$°¨»óÆò <- gsub('\\s{2,}',' ', review$°¨»óÆò)
review$°¨»óÆò <- str_squish(review$°¨»óÆò) # µÎ°³ ÀÌ»óÀÇ °ø¹éÀ» ÇÏ³ªÀÇ °ø¹éÀ¸·Î º¯°æÇÏ´Â ÇÔ¼ö str_squish
review$°¨»óÆò[1]

# ºÒÇÊ¿äÇÑ ±ÛÀÚ Áö¿ì±â
str_extract_all(review$°¨»óÆò,'ÇØÀû: µµ±úºñ ±ê¹ß º°Á¡ - ÃÑ 10Á¡ Áß')
str_extract_all(review$°¨»óÆò,'½Å°í$')
review$°¨»óÆò <- gsub('ÇØÀû: µµ±úºñ ±ê¹ß º°Á¡ - ÃÑ 10Á¡ Áß','',review$°¨»óÆò)
review$°¨»óÆò <- gsub('½Å°í$','',review$°¨»óÆò)

review$°¨»óÆò[1]

View(review)

review$point <- as.integer(str_extract(review$°¨»óÆò,'^\\d{1,2}'))
str(review)
boxplot(review$point)

review$°¨»óÆò <- str_replace(review$°¨»óÆò,'^\\d{1,2}','')
View(review)

review[1:10,3]

review$id <- str_extract(review$±Û¾´ÀÌ.³¯Â¥,'\\w{1,}\\*{1,}')
review$date <- str_extract(review$±Û¾´ÀÌ.³¯Â¥,'\\d{2}\\.\\d{2}\\.\\d{2}')
View(review)

review$evaluation <- ifelse(review$point>=8, '±àÁ¤','ºÎÁ¤')
View(review)

positive <- paste(review[review$evaluation=='±àÁ¤','°¨»óÆò'],collapse=' ')
negative <- paste(review[review$evaluation=='ºÎÁ¤','°¨»óÆò'],collapse=' ')

positive <- data.frame(table(str_split(positive,' ')))
negative <- data.frame(table(str_split(negative,' ')))

wordcloud2(positive)
wordcloud2(negative)

