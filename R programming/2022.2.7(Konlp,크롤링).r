¡Ú ÅØ½ºÆ® ÀüÃ³¸® °úÁ¤
1. ÅäÅ«È­(Tokenization) : ÅØ½ºÆ®¸¦ Á¤ÇØÁø ´ÜÀ§·Î ³ª´©´Â ÀÛ¾÷
- ´Ü¾î : ºóÄ­À» ±âÁØÀ¸·Î ³ª´«´Ù.
- ÇüÅÂ¼Ò : ÀÇ¹Ì¸¦ °¡Áö´Â ÃÖ¼Ò´ÜÀ§, Ç°»ç¸¦ ±âÁØÀ¸·Î ³ª´©´Â ÀÛ¾÷
- ±ÛÀÚ : ÇÑ±ÛÀÚ±âÁØÀ¸·Î ³ª´©´Â ÀÛ¾÷
- ÃÊ¼Û(ÀÚÀ½), Áß¼º(¸ğÀ½), Á¾¼º(ÀÚÀ½)

2. ºÒ¿ë¾î Ã³¸®(stopword)
- ÀÇ¹Ì¾ø´Â ´Ü¾î¸¦ Á¦°ÅÇÏ´Â ÀÛ¾÷

3. ÀÇ¹Ì¾ø´Â Æ¯¼ö¹®ÀÚ, ¼ıÀÚ Á¦°Å
s&p - > sandp
sandp -> s&p
...

4. ´ë¼Ò¹®ÀÚ ÅëÀÏ
Trump - > Trump_unique
...

5. ¾î±ÙÃßÃâ
- ´Ü¾î Ç¥Çö¿¡ ´ëÇÑ ÅëÀÏ ÀÛ¾÷À» ÇØ¾ßÇÑ´Ù.
¿¹) ³î¾Æ¿ä, ³î¾Æ, ³î°í½Í¾î¿ä, ³î´Ù¿Ô¾î¿ä -> ³î´Ù.
- Lemmatization : »çÀüÀûÀ¸·Î Ç¥Çö
- Stemming : ¾Ë°í¸®ÁòÀ» ÅëÇØ¼­ ±â°èÀûÀ¸·Î º¯È¯, ½ÅÁ¶¾î, Àº¾î

6. ÅØ½ºÆ® ÀÎÄÚµù : ÅØ½ºÆ®¸¦ º¤ÅÍ·Î Ç¥Çö
- Bag of Words, tf-idf

¡Ú KONLP

1. JAVA_HOME À§Ä¡È®ÀÎ
Sys.getenv('JAVA_HOME')
# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_271')

2. rJava ¼³Ä¡
install.packages('rJava')
library(rJava)

3. konlp ÇÁ·Î±×·¥°ú °ü·ÃÀÖ´Â ÇÁ·Î±×·¥À» ¼³Ä¡
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages('remotes')

4. konlp ¼³Ä¡
remotes::install_github('haven-jeon/KoNLP', upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))

library(KoNLP)
#useSejongDic()
useNIADic()

text <- 'RÀº ¿ÀÇÂ¼Ò½º·Î Åë°è, ±â°èÇĞ½À, ±İÀ¶, »ı¹°Á¤º¸ÇĞ, ±×·¡ÇÈ½º¿¡ ÀÌ¸£´Â ´Ù¾çÇÑ Åë°è ÆĞÅ°Áö¸¦ °®Ãß´Â ÁÁÀº ÇÁ·Î±×·¥ÀÌ´Ù.'

¡Ü¸í»ç ÃßÃâ
extractNoun(text)

¡Ü Ç°»çÅÂ±ë
?SimplePos09
SimplePos09(text)

SimplePos22(text)

[¹®Á¦204] SimplePos22(text) Ç°»çÅÂ±ëÀÇ º¸Åë¸í»ç¸¸ ÃßÃâÇØÁÖ¼¼¿ä.
SimplePos22(text)

library(stringr)

a <- unlist(str_extract_all(SimplePos22(text), '\\w+\\WNC'))
#a <- unlist(str_extract_all(SimplePos22(text), '[°¡-ÆR]+/NC'))

gsub('\\WNC','',a)
str_replace_all(a,'\\WNC','')
#str_replace_all(a,'/NC','')

unlist(str_match_all(SimplePos22(text),'[°¡-ÆR]+/NC'))
as.vector(na.omit(str_match(SimplePos22(text),'[°¡-ÆR]+/NC')))

[¹®Á¦205]review$tagging ¿­À» »ı¼ºÇØ¼­ °¨»óÆò¿¡ ´ëÇÑ Ç°»ç ÅÂ±ëÁ¤º¸°¡ ÀÔ·ÂµÇµµ·Ï ÇÏ¼¼¿ä.

review <- read.csv('c:/data/review.txt')
review
View(review)
str_extract_all(review$°¨»óÆò,'\n|\t')
review$°¨»óÆò <- str_replace_all(review$°¨»óÆò,'\n|\t','')
review$°¨»óÆò <- str_replace_all(review$°¨»óÆò,'ÇØÀû: µµ±úºñ ±ê¹ßº°Á¡ - ÃÑ 10Á¡ Áß','')
review$°¨»óÆò
review$Á¡¼ö <- str_extract_all(review$°¨»óÆò,'^\\d{1,2}')
review$°¨»óÆò <- str_replace_all(review$°¨»óÆò,'^\\d{1,2}','')
review$°¨»óÆò <- gsub('½Å°í$','',review$°¨»óÆò)
x <- SimplePos22(review$°¨»óÆò)

paste(unlist(x[1]),collapse=' ')
review$tagging <- sapply(x,function(arg){paste(unlist(arg),collapse=' ')})

View(review)

review$noun <- review$tagging ³»¿ëÁß¿¡ º¸Åë¸í»ç¸¸ ÃßÃâÇØ¼­ »õ·Î¿î ¿­¿¡ ÀúÀå
a <- str_extract_all(review$tagging,'[°¡-ÆR]+/NC')
review$noun <- sapply(a,function(arg){paste(str_replace_all(arg,'/NC',''),collapse = ' ')})
#review$noun <- sapply(a,function(arg){paste(unlist(arg),collapse = ' ')})
#review$noun <- str_replace_all(review$noun,'/NC','')
View(review)


¡Ú Å©·Ñ¸µ(crawling)
- ÀÚµ¿È­µÈ ¹æ¹ıÀ¸·Î À¥À» Å½»öÇÏ´Â ÄÄÇ»ÅÍÇÁ·Î±×·¥
- ÀÎÅÍ³İ »çÀÌÆ®ÀÇ À¥ÆäÀÌÁö¸¦ ¼öÁöÇØ¼­ ºĞ·ùÇÏ´Â ÇÁ·Î±×·¥


¡Ú ½ºÅ©·¡ÇÎ(scraping)
- À¥ºê¶ó¿ìÀú È­¸é¿¡ Ç¥½ÃµÇ´Â html¹®¼­¿¡¼­ »ç¿ëÀÚ°¡ ÇÊ¿äÇÑ Á¤º¸¸¸ ÃßÃâÇÏ¿© ¼öÁıÇÏ´Â ±â¼ú

1. »ç¿ëÀÚ°¡ À¥ºê¶ó¿ìÀúÀÇ ÁÖ¼ÒÃ¢¿¡¼­ urlÀ» ÀÔ·ÂÇÑ´Ù.
2. request : À¥ºê¶ó¿ìÀú´Â ¿äÃ»ÇÑ ¸Ş½ÃÁö¸¦ ÀÛ¼ºÇØ À¥¼­¹ö·Î Àü¼ÛÇÑ´Ù. 
3. response : À¥¼­¹ö´Â ¿äÃ»¹Ş´Â Á¤º¸¸¦ Å¬¶óÀÌ¾ğÆ®¿¡°Ô º¸³½´Ù.(HTML)
4. À¥ºê¶ó¿ìÀú´Â ÀÀ´ä¸Ş½ÃÁö¸¦ ÇØ¼®ÇØ »ç¿ëÀÚ¿¡°Ô Á¤º¸¸¦ Ãâ·ÂÇÑ´Ù.


install.packages('rvest')
library(rvest)

html <- rvest::read_html("https://www.joongang.co.kr/article/25045987")
html

str_extract_all(html,'<title>.+</title>') # ³ª¿È
str_extract_all(html,'<body>.+</body>') # ¾È³ª¿È

html_node(html,'title') #titleÀÌ¶ó´Â Å×±× Ã³À½À¸·Î ³ª¿À´Â ÇÏ³ª¸¸ Ãâ·Â
html_nodes(html,'title') #

html_node(html,'p') # Ã³À½pÅÂ±×¸¸ Ã£´Â´Ù.
html_nodes(html,'p') # p ÅÂ±× ÀüºÎ¸¦ Ã£´Â´Ù.

html_node(html,'h1')
html_nodes(html,'h1')%>%
  html_text()

html_nodes(html,'div#article_body') #id #, class .
html_nodes(html,'div#article_body')%>%
  html_text()

html_nodes(html,'div.article_body.fs3')%>%
  html_text()

html <- rvest::read_html("https://www.joongang.co.kr/article/25045958")

html_nodes(html,'div.article_body.fs3')%>%
  html_text()

# ÀÎÄÚµù(encoding) ASCII¹®ÀÚ(16Áø°ª)
ÀÎ°øÁö´É -> %EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5 
#ELZHELD (decoding)
ÀÎ°øÁö´É <- %EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5 

# Æ¯Á¤ÇÑ ´º½º ±â»ç °Ë»öÀÇ url ¼öÁı
html <- rvest::read_html("https://www.joongang.co.kr/search?keyword=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5") #À¥¼­¹öÇÏ°í request, responseÀÛ¾÷
html # r¿¡¼­ µ¿ÀÛ(À¥¼­¹öx)

url <- html_nodes(html,'h2.headline')%>%
  html_nodes('a')%>% #h2ÅÂ±×¾È¿¡ a¶ó´Â Å×±×¸¸ »Ì¾Æ¿À±â
  html_attr('href') #href¶ó´Â ¼Ó¼º¸¸ »Ì¾Æ³»±â(ÁÖ¼Ò)

length(url)

# ¼öÁıµÈ urlÀ» ÀÌ¿ëÇØ¼­ º»¹® ´º½º ³»¿ë ¼öÁı

news <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  
  temp <- html_nodes(html,'div.article_body.fs3')%>%
    html_text()
  news <- c(news,temp)
  Sys.sleep(2) #À¥¼­¹ö¿¡ ºÎÇÏ¸¦ ÁÖÁö ¾Ê±âÀ§ÇØ¼­ Á¶±İ¾¿ ¶äÀ» ÁÖ±â
}

str_trim(news[1])
news

write(str_trim(news),'c:/data/news.txt')

ai_news <- readLines('c:/data/news.txt')
ai_news


[¹®Á¦206] µ¿¾ÆÀÏº¸ 'ÀÎ°øÁö´É' ´º½º±â»ç °Ë»öÀ» ÅëÇØ º»¹®±â»ç ³»¿ëÀ» donga_ai.txt·Î ÀúÀåÇÏ°í
º»¹® ´º½º ±â»ç ³»¿ëÀ» ¸í»ç¸¸ ÃßÃâÇØ¼­ wrodcloud·Î ½Ã°¢È­ ÇØÁÖ¼¼¿ä. ´Ü ´º½º±â»ç´Â 5ÆäÀÌÁö±îÁö
https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=16&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=31&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=46&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1
https://www.donga.com/news/search?p=61&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1


html <- read_html('https://www.donga.com/news/search?check_news=1&more=1&sorting=1&range=1&search_date=&v1=&v2=&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5')
html

html_nodes(html,'p.tit')%>%
  html_nodes('a')%>% # pdfÆÄÀÏÀÇ ÁÖ¼Ò±îÁö °¡Á®¿Í¹ö¸² °Å±â¿¡µµ aÅ×±×·Î µÇ¾îÀÖ±â¶§¹®
  html_attr('href')

url <- html_nodes(html,'p.tit')%>%
  html_node('a')%>%
  html_attr('href')

url[1]


À¥»çÀÌÆ®¿¡¼­ ¿øÇÏ´Â ÆäÀÌÁö¿¡ ÀÖ´Â ±â»çµéÀ» ÃßÃâÇÏ°í ½Í´Ù. À¥»çÀÌÆ®ÀÇ ÁÖ¼Ò¸¦ È®ÀÎ -> 
  ÁÖ¼Ò¸¦ read_htmlÇÔ¼ö¸¦ »ç¿ëÇØ¼­ ÀĞ¾î¿À±â ->
  À¥»çÀÌÆ®¿¡¼­ f12¹øÅ°¸¦ ´­·¯¼­ ±â»ç°¡ ¾î¶² ÅÂ±×¸¦ »ç¿ëÇÏ¿© ÀÛ¼ºµÇ¾îÀÖ´ÂÁö È®ÀÎ 
±â»çµé¸¶´Ù º¸Åë °°Àº ÅÂ±×¸¦ ÀÌ¿ëÇÏ±â¶§¹®¿¡ ÅÂ±×¸¦ È®ÀÎ 

#±â»ç Ã¹ ÆäÀÌÁö ÀĞ¾î¿Í¼­ htmlº¯¼ö¿¡ ÀúÀå  
html <- read_html('https://www.donga.com/news/search?p=1&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')
#±â»ç ³ª¸ÓÁö2,3,4,5ÆäÀÌÁö ÀĞ¾î¿Í¼­ htmlº¯¼ö¿¡ ÀúÀå
for(i in 1:4){
  html <- c(html,read_html(paste0('https://www.donga.com/news/search?p=',1+i*15,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')))
  Sys.sleep(2)

}

html

# ÁÖ¼Ò¸¸ ÃßÃâÇÏ´Â Á¤Á¦ÀÛ¾÷
url <- html_nodes(html,'p.tit')%>%
  html_nodes('a')%>%
  html_attr('href')
#urlµé¾î°¡¼­ ¸Â´ÂÁö È®ÀÎ
url[1]

#°¢ ÁÖ¼Òº°·Î ±â»çµé ¼öÁıÇÏ´Â ÀÛ¾÷
news <- c()
for (i in 1:length(url)){
  html <- read_html(url[i])
  
  temp <- html_nodes(html,'div.article_txt')%>%
          html_text()
  news <- c(news,temp)
  Sys.sleep(2)
}

donga_ai <- str_trim(str_replace_all(news,'\n|\r|\t',' '))
donga_ai
donga_ai <- str_squish(donga_ai)
donga_ai <- str_replace_all(donga_ai,'Copyright ¨Ï µ¿¾ÆÀÏº¸ & donga.com','')
SimplePos22(donga_ai)

write(str_trim(news),'c:/data/donga_ai.txt')
readLines('c:/data/donga_ai.txt')


#------------------------------------------------------------------2022.2.8 /°­»ç´Ô
library(rvest)
url <- c()
for(i in seq(1,61,by=15)){
  url_text <- paste0('https://www.donga.com/news/search?p=',i,'&query=%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1')
  html <- read_html(url_text)
  temp <- html_nodes(html,'p.tit')%>%
    html_node('a')%>%
    html_attr('href')
  
  url <- c(url,temp)
  
  #print(i'°³ ±â»ç ÃßÃâ')
  Sys.sleep(1)
}

html <-read_html(url[4])
article <- html_node(html,'div.article_txt') #div.article_txt¾È¿¡´Â Àâ´ÙÇÑ div,ÇÊ¿ä¾ø´Â ±¤°í¼º ÀÌ¹ÌÁö³ª ±ÛÀÚµéÀÌ ÀÖ´Ù

html_nodes(article,'div')

article%>%html_nodes('div') # ÇÊ¿ä¾ø´Â Å×±×µé

library(stringr)
library(xml2)
¡Üxml2::xml_remove() : Æ¯Á¤ÇÑ ÅÂ±×¸¦ Á¦°ÅÇÒ ¶§ »ç¿ëÇÏ´Â ÇÔ¼ö, Á¦°ÅÇØ¼­ ¹Ù·Î Àû¿ëµÈ´Ù.

xml2::xml_remove(article%>%html_nodes('div')) #º¯¼ö¿¡ ÀúÀå¾ÈÇØµµ ¹Ù·Î Àû¿ëÀÌµÊ, xmlÇü½Ä¿¡¼­ articleº¯¼ö¿¡ ÀÖ´Â ÇÊ¿ä¾ø´Â divÅ×±×µé ´Ù »èÁ¦
article%>%html_nodes('div')
article%>%html_text()
str_trim(article%>%html_text()) # °ø¹é¹®ÀÚ Á¦°Å
txt <-str_trim(article%>%html_text())
str_extract_all(txt,'\\[¼­¿ï=´º½Ã½º\\]')
str_replace_all(txt,'\\[¼­¿ï=´º½Ã½º\\]','')

txt
"Àü³²Çõ ±âÀÚ forward@donga.com"
"µ¿¾Æ´åÄÄ ITÀü¹® ±ÇÅÃ°æ ±âÀÚ tikitaka@donga.com"
str_extract_all(txt,'[^\\.]+ [A-z0-9._]+@[A-z0-9._]+')

news <- c()
for(i in 1:length(url)){
  html <- read_html(url[i])
  article <- html_node(html,'div.article_txt')
  xml2::xml_remove(article%>%html_nodes('div'))
  text <- article%>%html_text()
  text <- str_trim(text)  
  text <- str_replace_all(text,'\\[¼­¿ï=´º½Ã½º\\]','')
  text <- str_replace_all(text,'[^\\.]+ [A-z0-9._]+@[A-z0-9._]+','')
  news <- c(news,text)
  Sys.sleep(1)
}
news[1]
length(news)

write(news,'c:/data/donga_ai.txt')
ai <- readLines('c:/data/donga_ai.txt')
length(ai)

ai <- paste(ai,collapse=' ')
length(ai)
ai

library(KoNLP)

ai_pos <- SimplePos09(ai)
ai_pos

str_match(ai_pos,'([°¡-ÆR]+)/N') # '[°¡-ÆR]+/N', [°¡-ÆR]+ -> °ıÈ£¸¦ »ç¿ëÇØ¼­ µÑ´Ù ÃßÃâÇÔ'/N'À» Á¦°Å ¾ÈÇØµµ µÊ
word <- str_match(ai_pos,'([°¡-ÆR]+)/N')[,2]
word <- word[nchar(word) >= 2]
word_df <- data.frame(table(word))
names(word_df)

library(wordcloud2)
wordcloud2(word_df)


news <- readLines('c:/data/donga_ai.txt')
grep('¸£¿Ï´Ù',,news)


[¹®Á¦207] ³×ÀÌ¹ö¿¡¼­ ¿µÈ­¸®ºäÁ¤º¸¸¦ ¼öÁıÇÑ ÈÄ µ¥ÀÌÅÍÇÁ·¹ÀÓÀ¸·Î ÀúÀåÇØÁÖ¼¼¿ä.
ÄÃ·³Àº id, date, point,comment·Î »ı¼ºÇØÁÖ¼¼¿ä.
#--------------------1ÆäÀÌÁö¸¸!!!
html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after')
html <- html_nodes(html,'tbody')%>%
  html_nodes('tr')

# ¹øÈ£ (id)
id <- html_nodes(html,'td.ac.num')

id <- unlist(str_extract_all(id,'[0-9]+'))

# ÆòÁ¡ (point)
point <- html_nodes(html,'td.title')%>%
  html_nodes('div.list_netizen_score')%>%
  html_nodes('em')

point <- unlist(str_extract_all(point,'[0-9]+'))

# °¨»óÆò(comment)????????
html_nodes(html,'td.title')
xml_remove(html_nodes(html,'td.title')%>%html_nodes('a'))
xml_remove(html_nodes(html,'td.title')%>%html_nodes('div'))
comment <- str_trim(html_nodes(html,'td.title')%>%html_text())

# ±Û¾´ÀÌ
author <- html_nodes(html,'td.num')%>%
  html_nodes('a.author')

author <- unlist(str_extract_all(author,'\\w{4}\\*{4}'))

# ³¯Â¥
date <- html_nodes(html,'td.num')
date <- unlist(str_extract_all(date,'\\d{2}\\.\\d{2}.\\d{2}'))

movie_df <- data.frame(id = id,
           point = point,
           comment=comment,
           author = author,
           date = date)
View(movie_df)

#----------------------------10ÆäÀÌÁö±îÁö
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after&page=',i))
  # ¹øÈ£ (id)
  id <- html_nodes(html,'td.ac.num')
  
  id <- unlist(str_extract_all(id,'[0-9]+'))
  
  # ÆòÁ¡ (point)
  point <- html_nodes(html,'td.title')%>%
    html_nodes('div.list_netizen_score')%>%
    html_nodes('em')
  
  point <- unlist(str_extract_all(point,'[0-9]+'))
  
  # °¨»óÆò(comment)????????
  #paste(html_nodes(html,'td.title'),collapse = ' ')
  html_nodes(html,'td.title')
  xml_remove(html_nodes(html,'td.title')%>%html_nodes('a'))
  xml_remove(html_nodes(html,'td.title')%>%html_nodes('div'))
  comment <- str_trim(html_nodes(html,'td.title')%>%html_text())
  
  # ±Û¾´ÀÌ
  author <- html_nodes(html,'td.num')%>%
    html_nodes('a.author')
  
  author <- unlist(str_extract_all(author,'\\w{4}\\*{4}'))
  
  # ³¯Â¥
  date <- html_nodes(html,'td.num')
  date <- unlist(str_extract_all(date,'\\d{2}\\.\\d{2}.\\d{2}'))
  
  movie <- rbind(movie,data.frame(id=id,point=point,comment=comment,author=author,date=date))
}

View(movie)

#--------------------------°­»ç´Ô ´ä
html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=177366&target=after&page=1')

#idÃßÃâ
id <- html_nodes(html,'td.num > a')%>%
  html_text()

#³¯Â¥ ÃßÃâ
x <- html_nodes(html,'td.num')%>%
  html_text()

date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))

#z <- unlist(str_extract_all(x,'\\w{1,}\\*{1,}\\d{2}\\.\\d{2}\\.\\d{2}'))
#id <- unlist(str_extract_all(z,'\\w{1,}\\*{1,}'))
#date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))

# ÆòÁ¡ ÃßÃâ
point <- html_nodes(html,'div.list_netizen_score > em')%>%
  html_text()

# °¨»óÆò ÃßÃâ
comment <- html_nodes(html,'td.title')
#comment%>%html_nodes('a')
#comment%>%html_nodes('div')

library(xml2)
xml_remove(comment%>%html_nodes('a'))  
xml_remove(comment%>%html_nodes('div'))
comment <- comment%>%html_text()
comment <- str_trim(comment)
.

View(data.frame(id=id,date=date,point=point, comment=comment))


#-------------------------1~10ÆäÀÌÁö °­»ç´Ô´ä
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=194204&target=after&page=',i))
  #idÃßÃâ
  id <- html_nodes(html,'td.num > a')%>%
    html_text()
  
  #³¯Â¥ ÃßÃâ
  x <- html_nodes(html,'td.num')%>%
    html_text()
  
  date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))
  
  #z <- unlist(str_extract_all(x,'\\w{1,}\\*{1,}\\d{2}\\.\\d{2}\\.\\d{2}'))
  #id <- unlist(str_extract_all(z,'\\w{1,}\\*{1,}'))
  #date <- unlist(str_extract_all(x,'\\d{2}\\.\\d{2}\\.\\d{2}'))
  
  # ÆòÁ¡ ÃßÃâ
  point <- html_nodes(html,'div.list_netizen_score > em')%>%
    html_text()
  
  # °¨»óÆò ÃßÃâ
  comment <- html_nodes(html,'td.title')
  #comment%>%html_nodes('a')
  #comment%>%html_nodes('div')
  #library(xml2)
  xml_remove(comment%>%html_nodes('a'))  
  xml_remove(comment%>%html_nodes('div'))
  comment <- comment%>%html_text()
  comment <- str_trim(comment)
  
  
  movie <- rbind(movie,data.frame(id=id,date=date,point=point,comment=comment))
  Sys.sleep(1)
  
}

View(movie)

# ±àÁ¤,ºÎÁ¤, tagging, wordcloud±îÁö ±×·Áº¸±â

movie$evaluation <- ifelse(movie$point >= 8,'±àÁ¤','ºÎÁ¤')
View(movie)
movie$tagging <- sapply(SimplePos09(movie$comment),
                        function(arg){paste(unlist(arg),collapse=' ')})

x <- str_match(movie$tagging,'([°¡-ÆR]+)/N')[,2]
x <- data.frame(table(na.omit(x)))
wordcloud2(x,backgroundColor = 'black')

# ±àÁ¤,ºÎÁ¤, tagging, wordcloud±îÁö ±×·Áº¸±â °­»ç´Ô
pos <- SimplePos22(movie$comment)
movie$tagging <- sapply(pos,function(x){paste(unlist(x),collapse=' ')})

noun <- sapply(movie$tagging,function(x){str_match_all(x,'([°¡-ÆR]+)/NC')})
movie$noun <- sapply(noun,function(x){paste(unlist(x)[,2],collapse=' ')})

View(movie)

movie$point <- as.integer(movie$point)
movie$evaluation <- ifelse(movie$point >= 8, '±àÁ¤','ºÎÁ¤')  
View(movie)

positive <- movie[movie$evaluation == '±àÁ¤','noun']
negative <- movie[movie$evaluation == 'ºÎÁ¤','noun']

library(wordcloud2)
wordcloud2(data.frame(table(unlist(strsplit(positive,' ')))))
wordcloud2(data.frame(table(unlist(strsplit(negative,' ')))))

p <- data.frame(table(unlist(strsplit(positive,' '))))
n <- data.frame(table(unlist(strsplit(negative,' '))))

head(p)
head(n)

names(p) <- c('word','freq')
names(n) <- c('word','freq')

p$sentiment <- 'positive'
n$sentiment <- 'negative'

head(p)
head(n)

df <- rbind(p,n)
head(df)
tail(df)

    word positive negative
1   °£¸¸    1        0
2   °¨»ó    1        5   
#À§ÀÇ µ¥ÀÌÅÍ¸¦ ¹Ø¿¡ Ã³·³ º¯È¯
      positive negative
°£¸¸      1       9
°¨»ó      1       5
°­ÇÏ´Ã    5       2
      
library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq', fill=0)
df_compar

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df_compar,colors=c('red','blue'),
                            title.colors = c('red','blue'),
                            title.bg.colors='white',
                            title.size=2,
                            scale=c(2,0.5))
