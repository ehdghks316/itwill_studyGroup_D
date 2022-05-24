¡Ú data mining
¼ö¸¹Àº µ¥ÀÌÅÍ Áß ÀÇ¹ÌÀÖ´Â Á¤º¸¸¦ ÃßÃâÇØ ³»´Â ºĞ¼®°úÁ¤

¡Ú text mining
ÅØ½ºÆ®·ÎºÎÅÍ ÀÇ¹ÌÀÖ´Â Á¤º¸¸¦ ÃßÃâÇÏ´Â µ¥ÀÌÅÍ ºĞ¼® ±â¹ıÀ¸·Î text analytics, text analysis¶ó°í ÇÑ´Ù.

È°¿ë
- ¹®¼­ºĞ·ù
- ¹®¼­³ª ´Ü¾î °£ÀÇ ¿¬°ü¼º ºĞ¼®
- °¨¼º ºĞ¼®

¡Ú corpus(¸»¹¶Ä¡)
- ¾ğ¾î ¿¬±¸¸¦ À§ÇØ ÅØ½ºÆ®¸¦ ÄÄÇ»ÅÍ°¡ ÀĞÀ» ¼ö ÀÖ´Â ÇüÅÂ·Î ¸ğ¾Æ ³õÀº ¾ğ¾îÁıÇÕ

¡Ú ÅØ½ºÆ® ¸¶ÀÌ´×À» ÇÏ±âÀ§ÇÑ ´Ü°è
¹®¼­(ºñÁ¤Çüµ¥ÀÌÅÍ) -> corpus -> ±¸Á¶È­µÈ ¹®¼­ -> ºĞ¼®

install.packages("tm")
library(tm)

data <- readLines('c:/data/Mommy_I_love_you.txt')
data

class(data)
mode(data)

#character(vector) -> corpus º¯È¯
corp1 <- VCorpus(VectorSource(data))
class(corp1)

# ÄÚÆÛ½º ¿ä¾àÁ¤º¸
corp1
inspect(corp1) #¸®½ºÆ®µµ °°ÀÌ °¡Áö°í ÀÖÀ½
inspect(corp1[1])  #°ø¹éÆ÷ÇÔ ±ÛÀÚ °³¼ö±îÁö ¾Ë·ÁÁÖ°í ¹®¼­³»¿ëÀºx
inspect(corp1[[1]]) #¹Ì¸®º¸±â Ã³·³ ¹®¼­³»¿ë±îÁö º¼ ¼ö ÀÖÀ½

# ¹®¼­È®ÀÎ
as.character(inspect(corp1[[1]]))
as.character(inspect(corp1[[2]]))
lapply(corp1,as.character)
sapply(corp1,as.character)

corp1[[1]]$content
lapply(corp1,content)
sapply(corp1,content)

as.vector(unlist(lapply(corp1,content)))
as.vector(sapply(corp1,content))

paste(as.vector(sapply(corp1,content)),collapse = ' ') # °³º°À» ÇÏ³ªÀÇ ¹®ÀåÀ¸·Î º¯È¯

# ¸ŞÅ¸Á¤º¸ È®ÀÎ
corp1[[1]]$meta
meta(corp1[[1]])
lapply(corp1,meta)
sapply(corp1,meta)

meta(corp1[[1]],tag='author')
meta(corp1[[1]],tag='id')
meta(corp1[[1]],tag='datetimestamp')

meta(corp1[[1]],tag='author', type = 'local') <- 'james'
meta(corp1[[1]],tag='author')

lapply(corp1,meta)
meta(corp1,tag='author',type='local') <- paste0(1:9,'¹®¼­')
lapply(corp1,meta)

meta(corp1,tag='author',type='local') <- NA # NA·Î ¼öÁ¤
lapply(corp1,meta)

meta(corp1,tag='author',type='local') <- NULL #Ç×¸ñ»èÁ¦
lapply(corp1,meta)

meta(corp1,tag='author',type='local') <- paste0(1:9,'¹®¼­') # ´Ù½Ã Ç×¸ñ »ı¼º(»õ·Î¿îÀÌ¸§À¸·Î)
lapply(corp1,meta)

# tm ÆĞÅ°Áö¿¡¼­ Á¦°øÇÏ´Â Á¤Á¦ÀÛ¾÷¿¡¼­ »ç¿ëµÇ´Â ÇÔ¼ö
getTransformations()
removeNumbers - ¼ıÀÚÁ¦°Å
removePunctuation - Æ¯¼ö¹®ÀÚ Á¦°Å
removeWords - ºÒ¿ë¾îÁ¦°Å(ÀÇ¹Ì¾ø´Â ´Ü¾îµé Á¦°Å)
stemDocument - ¾î±Ù ÅëÇÕ
stripWhitespace - ¿¬¼ÓµÇ´Â 2°³ÀÌ»óÀÇ °ø¹éÀ» ÇÏ³ªÀÇ °ø¹éÀ¸·Î º¯È¯ÇÏ´Â ÇÔ¼ö

corp1[[1]]$content

# stripWhitespace - ¿¬¼ÓµÇ´Â 2°³ÀÌ»óÀÇ °ø¹éÀ» ÇÏ³ªÀÇ °ø¹éÀ¸·Î º¯È¯ÇÏ´Â ÇÔ¼ö
corp2 <- tm_map(corp1,stripWhitespace)
corp1[[1]]$content
corp2[[1]]$content
lapply(corp2,content)

# removePunctuation - Æ¯¼ö¹®ÀÚ Á¦°Å
corp2 <- tm_map(corp2,removePunctuation)
lapply(corp2,content)

# removeNumbers - ¼ıÀÚÁ¦°Å
corp2 <- tm_map(corp2,removeNumbers)
lapply(corp2,content)

# ÀÏ¹İÇÔ¼ö¸¦ tm_map¿¡¼­ »ç¿ëÇÒ ¶§´Â content_transformer ÇÔ²² »ç¿ëÇØ¾ß ÇÑ´Ù.

corp2 <-tm_map(corp2,content_transformer(tolower))
lapply(corp2,content)

corp2 <-tm_map(corp2,content_transformer(trimws))
lapply(corp2,content)

# ºÒ¿ë¾î
tm::stopwords()
tm::stopwords('english')
tm::stopwords('en')
tm::stopwords('smart') # Á» ´õ ¸¹Àº ºÒ¿ë¾îµéÀÌ ÀÖÀ½

tm::stopwords()[tm::stopwords()=='me']
tm::stopwords()[tm::stopwords()=='makes']

stopword2 <- c(tm::stopwords(),'makes','want')
stopword2

# removeWords : ´Ü¾î¸¦ Á¦°ÅÇÏ´Â ÇÔ¼ö
tm_map(corp2,removeWords,tm::stopwords())
corp2 <- tm_map(corp2,removeWords,stopword2)
lapply(corp2,content)

# ¾î±ÙÅëÀÏÈ­(stemming)
install.packages("SnowballC")
library(SnowballC)
corp2 <- tm_map(corp2,stemDocument)
lapply(corp2,content)

mommi -> mommy ¼öÁ¤
#gsub('mommi','mommy',¿ø½Ãµ¥ÀÌÅÍº¯¼ö)

corp2 <- tm_map(corp2,content_transformer(function(x) gsub('mommi','mommy',x)))
lapply(corp2,content)

¡Ú ÅØ½ºÆ® ±¸Á¶È­
- Bag-of-word (´Ü¾î ÁÖ¸Ó´Ï)¿¡ ÀÇÇÑ ÅØ½ºÆ® ±¸Á¶È­
- ÅØ½ºÆ®¸¦ ´Ü¾îÀÇ ÁıÇÕÀ¸·Î Ç¥Çö
- ´Ü¾îÀÇ ¼ø¼­³ª ¹®¹ıÀº ¹«½ÃµÇ°í ´Ü¾î ºóµµ¼ö¸¸À» ÀÌ¿ë
- ¹®¼­-¿ë¾î Çà·Ä(Document - Term Matrix)Àº ´Ü¾îÁÖ¸Ó´Ï·ÎºÎÅÍ ºñ±¸Á¶È­µÈ ÅØ½ºÆ®¸¦ ±¸Á¶È­µÈ µ¥ÀÌÅÍ·Î º¯È¯

      mommy love want say thank happy everyday give ...
¹®¼­1   1     1   0    1    1     0       0      0 
¹®¼­2   0     1   0    0    1     0       1      1 

# corpus -> ¹®¼­-¿ë¾îÇà·Ä·Î º¯È¯
corp1_dtm <- DocumentTermMatrix(corp1)
corp1_dtm
'''
<<DocumentTermMatrix (documents: 9, terms: 40)>> #360°³ÀÇ ¼¿
Non-/sparse entries: 57/303 #57°³ÀÇ ¼¿¸¸ ºóµµ¼ö°¡ Ã¤¿öÁ®ÀÖ°í ³ª¸ÓÁö303°³´Â 0À¸·Î Ã¤¿öÁ®ÀÖ´Ù.
Sparsity           : 84% # 84(ÆÛ¼¾Æ®)°¡ 0À¸·Î Ã¤¿öÁ®ÀÖ´Ù.
Maximal term length: 10 #°¡Àå ±ä ±ÛÀÚ±æÀÌ´Â 10±ÛÀÚ
Weighting          : term frequency (tf)
'''
inspect(corp1_dtm) # È®ÀÎÇÏ±â

corp2_dtm <- DocumentTermMatrix(corp2)
corp2_dtm
inspect(corp2_dtm)

# ´Ü¾î¼ö
nTerms(corp2_dtm)
nTerms(corp1_dtm)

# ´Ü¾î
Terms(corp2_dtm)
Terms(corp1_dtm)

# ¹®¼­ÀÇ ¼ö 
nDocs(corp2_dtm)

# ¹®¼­ÀÇ ÀÌ¸§
Docs(corp2_dtm)
rownames(corp2_dtm)

# ÀÏºÎºĞ¸¸ È®ÀÎ
inspect(corp2_dtm)
inspect(corp2_dtm[1:3,1:5])

termfreq <- colSums(as.matrix(corp2_dtm)) #tableÇÔ¼öÃ³·³ °á°ú°¡ ³ª¿È
termfreq
names(termfreq)

library(wordcloud) #wordcloud2´Â µ¥ÀÌÅÍÇÁ·¹ÀÓÀ¸·Î º¯È¯ÀÛ¾÷ÇØ¾ß »ç¿ë°¡´É
wordcloud(words=names(termfreq),freq=termfreq,
          min.freq=1, random.order=F,random.color=T,
          colors=brewer.pal(9,'Blues'))

termfreq_df <- data.frame(word=names(termfreq),freq=termfreq)
library(wordcloud2)
wordcloud2(termfreq_df)

library(ggplot2)
ggplot(data=termfreq_df,aes(x=reorder(word,freq),y=freq,fill=word))+
  geom_col(show.legend=F)+
  coord_flip()

[¹®Á¦211] ¹Ì±¹ ¹ÙÀÌµç ´ëÅë·É ÃëÀÓ»ç Àü¹®À» ¼öÁıÇÏ¼Å¼­ ¸»¹¶Ä¡·Î º¯È¯ÇÑ ÈÄ 
Á¤Á¦ÀÛ¾÷À» ÅëÇØ document-term matrix¸¦ »ı¼ºÇÑ ÈÄ ½Ã°¢È­ ÇØÁÖ¼¼¿ä.

#-----------------------------Ã¹¹øÂ° À¥¿¡¼­ ºÒ·¯¿Í¼­ ¹Ù·Î ½ÇÇè
1. À¥¿¡¼­ ½ºÅ©·¦ÇØ¿À±â 
library(rvest)
library(xml2)
html <-read_html('https://news.mt.co.kr/mtview.php?no=2021012104568299464',encoding='EUC-KR')
html
text <- html_nodes(html,'div#textBody')
xml2::xml_remove(text%>%html_nodes('table.article_photo')) # ÀÌ¹ÌÁö°¡ ÀÖ´Â tableÅÂ±× Á¦°Å
text <- text%>%html_text()

2. ¸»¹¶Ä¡·Î º¯È¯ÇÏ±â
corp <- VCorpus(VectorSource(text))
corp

corp[[1]]$meta
meta(corp[[1]],tag='author') <- 'biden'
meta(corp[[1]])
inspect(corp)
inspect(corp[1])
inspect(corp[[1]]) # ±Û³»¿ë, ±ÛÀÚ°³¼ö º¸¿©ÁÖ±â

3. Á¤Á¦ÀÛ¾÷
library(stringr)
getTransformations()

#ÇÑ±ÛÁ¦°Å
corp1 <- tm_map(corp,content_transformer(function(x) str_replace_all(x,'[°¡-ÆR]+',' '))) 
inspect(corp1[[1]]) #È®ÀÎ
corp1[[1]]$content #È®ÀÎ

# ¼ıÀÚÁ¦°Å
corp1 <- tm_map(corp1,removeNumbers)
corp1[[1]]$content

# Æ¯¼ö¹®ÀÚÁ¦°Å
corp1 <- tm_map(corp1,removePunctuation)
corp1[[1]]$content

corp1 <- tm_map(corp1,content_transformer(function(x) str_replace_all(x,'\n',' ')))
corp1[[1]]$content

corp1 <- tm_map(corp1,removeWords,'DC') #ÇÊ¿ä¾ø´Â ´Ü¾î DCÁ¦°Å

# °ø¹éÁ¦°Å
corp1 <- tm_map(corp1,content_transformer(trimws))
corp1[[1]]$content

# ¸ğµÎ ¼Ò¹®ÀÚ·Î º¯°æ
corp1 <- tm_map(corp1,content_transformer(tolower))
corp1[[1]]$content

# µÑ ÀÌ»ó °ø¹é ÇÏ³ªÀÇ °ø¹éÀ¸·Î
corp1 <- tm_map(corp1,stripWhitespace)
corp1[[1]]$content

# ºÒ¿ë¾î Á¦°Å
corp2 <- tm_map(corp1,removeWords,tm::stopwords())
corp2[[1]]$content

# µÑ ÀÌ»ó °ø¹é ÇÏ³ªÀÇ °ø¹éÀ¸·Î
corp2 <- tm_map(corp2,stripWhitespace)
corp2[[1]]$content

''' ¾È ¹Ù²î¾îµµ µÉ ´Ü¾îµéÀÌ ³Ê¹« ¸¹ÀÌ ¹Ù²ñ
# ¾î±ÙÅëÀÏÈ­
corp2 <- tm_map(corp2,stemDocument)
corp2[[1]]$content
'''

# document-term matrix·Î º¯È¯
corp2_m <- DocumentTermMatrix(corp2)
inspect(corp2_m)

nTerms(corp2_m)
Terms(corp2_m)

# wordcloud
corpfreq <- colSums(as.matrix(corp2_m)) # corpusÇüÅÂ¿¡¼­´Â wordcloud¸¦ ¸¸µé ¼ö ¾ø±â¿¡ matrixÇüÅÂ·Î º¯È¯
wordcloud(words=names(corpfreq),freq=corpfreq)

# wordcloud2
df <- data.frame(word=names(corpfreq),freq=corpfreq)
wordcloud2(df)

# barplot
ggplot(data=df,aes(x=df$word,y=df$freq))+
  geom_col()+
  coord_flip()

#------------- µÎ¹øÂ° txt·Î dataÆú´õ¿¡ ÀúÀåÇÏ°í ºÒ·¯¿Í¼­ ½ÇÇèÇÏ±â
html <- read_html('https://news.mt.co.kr/mtview.php?no=2021012104568299464',encoding = 'EUC-KR')
text <- html_nodes(html,'div#textBody')
xml_remove(text%>%html_nodes('table.article_photo'))
xml_remove(text%>%html_nodes('div.util_box'))
text <- text%>%html_text()

write.csv(text,file='c:/data/biden_talking.csv',row.names = F )

biden <- readLines('c:/data/biden_talking.csv')

# ¸»¹¶Ä¡
corp <- VCorpus(VectorSource(biden))
corp
corp[[10]]
inspect(corp[[10]])

# Á¤Á¦ÀÛ¾÷
corp_t <- tm_map(corp,content_transformer(function(x) str_replace_all(x,'[°¡-ÆR]+','')))
lapply(corp_t,content)
sapply(corp_t,content)

corp_t <- tm_map(corp_t,removeNumbers)
lapply(corp_t,content)

corp_t <- tm_map(corp_t,removePunctuation)
lapply(corp_t,content)

corp_t <- tm_map(corp_t,removeWords,c('x','DC'))
lapply(corp_t,content)

corp_t<- tm_map(corp_t,content_transformer(trimws))
lapply(corp_t,content)

corp_t <- tm_map(corp_t,content_transformer(tolower))
lapply(corp_t,content)

corp_t <- tm_map(corp_t,removeWords,tm::stopwords('smart'))
lapply(corp_t,content)

corp_t <- tm_map(corp_t,stripWhitespace)
lapply(corp_t,content)

corp_t<- tm_map(corp_t,content_transformer(trimws))
lapply(corp_t,content)

'''
corp_t2 <- tm_map(corp_t,stemDocument)
lapply(corp_t2,content)
'''

corp_dtm <- DocumentTermMatrix(corp_t)
inspect(corp_dtm)

corp_dtm2 <- colSums(as.matrix(corp_dtm))
names(corp_dtm2)

wordcloud(words=names(corp_dtm2), freq=corp_dtm2)

df <- data.frame(word=names(corp_dtm2),freq=corp_dtm2)
df
wordcloud2(df)

#------------------------------------------r°­»ç´Ô
library(tm)
library(rvest)
library(stringr)

html <- read_html('https://www.whitehouse.gov/briefing-room/speeches-remarks/2021/01/20/inaugural-address-by-president-joseph-r-biden-jr/')
html

biden <- html_nodes(html,xpath='//*[@id="content"]/article/section/div/div/p')%>%
  html_text()

biden <- biden[c(-1,-2,-211,-212)]
head(biden)
tail(biden)

biden <- paste(biden,collapse=' ')
biden

write(biden,file='c:/data/biden_raw.txt')
readLines('c:/data/biden_raw.txt')

corpus.biden <- VCorpus(VectorSource(biden))
inspect(corpus.biden)
str(corpus.biden)

lapply(corpus.biden,content)

# ÄÚÆÛ½º ÆÄÀÏ ÀúÀå
writeCorpus(corpus.biden,path='c:/data',filenames='corpus_biden.txt')

# Æ¯Á¤ÇÑ µğ·ºÅä¸®¿¡ ÀÖ´Â ÆÄÀÏ Á¶È¸
list.files(path='c:/data',pattern = '\\.txt')

#ÆÄÀÏÀ» ÄÚÆÛ½º·Î ÀĞ¾î¿À´Â ¹æ¹ı
biden_corpus <- Corpus(URISource('c:/data/biden_raw.txt'))
biden_corpus
lapply(biden_corpus,content)

# ¼Ò¹®ÀÚº¯È¯
tm_map(biden_corpus,content_transformer(tolower)) # corpus¿¡¼­ Á¦°øÇÏ´Â ¸Ş¼­µå ¿Ü¿¡ ´Ù¸¥ ¸Ş¼­µå(ÇÔ¼ö)¸¦ »ç¿ëÇÒ ¶§ content_transformer(Àû¿ëÇÒÇÔ¼ö) »ç¿ë
lapply(biden_corpus,content)

# Æ¯¼ö¹®ÀÚ ¿À¸¥ÂÊ°ú ¿ŞÂÊÀÇ ¹®ÀÚµé Ã¼Å©
"i'm"
lapply(tm_map(biden_corpus,
              content_transformer(function(x) str_extract_all(x,'[A-z]+[[:punct:]]+[A-z]+'))),content) # º¸±â ºÒÆíÇÔ

lapply(biden_corpus,function(x) str_extract_all(x$content,'[A-z]+[[:punct:]]+[A-z]+')) # º¸±â ÁÁÀ½

# ºÒ¿ë¾î Á¦°Å

biden_corpus <- tm_map(biden_corpus,removeWords,stopwords())
lapply(biden_corpus,function(x) str_extract_all(x$content,'[A-z]+[[:punct:]]+[A-z]+')) # º¸±â ÁÁÀ½

tm::stopwords()[tm::stopwords() == "don't"]
tm::stopwords()[tm::stopwords() == "can¡¯t"]

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("doesn¡¯t | don¡¯t | can¡¯t",' ',x)))

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("co-workers",'coworkers',x)))

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("¡¯s",' ',x)))

lapply(biden_corpus,function(x) str_extract_all(x$content,'[A-z]+[[:punct:]]+[A-z]+')) # º¸±â ÁÁÀ½

biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub("[[:punct:]]",' ',x)))

lapply(biden_corpus,function(x) str_extract_all(x$content,'[[:punct:]]+')) 

# ¼ıÀÚÃ¼Å©
lapply(biden_corpus,function(x) str_extract_all(x$content,'[^0-9\\s]*\\d+\\W\\d*')) 
<U+2013>
lapply(biden_corpus,function(x) str_extract_all(x$content,'<[A-z0-9\\+]+>'))   

# <U+2013> Çü½Ä Á¦°Å
biden_corpus <- tm_map(biden_corpus,content_transformer(function(x) gsub('<[A-z0-9\\+]+>',' ',x)))
lapply(biden_corpus,function(x) str_extract_all(x$content,'<[A-z0-9\\+]+>')) 

#biden_corpus <- tm_map(biden_corpus,removeNumbers) ¼ıÀÚ ÀüºÎÁ¦°Å(ÀÇ¹ÌÀÖ´Â ¼ıÀÚ±îÁö ÀüºÎ)

# ¿¬¼ÓµÇ´Â 2°³ ÀÌ»óÀÇ °ø¹éÀ» ÇÏ³ªÀÇ °ø¹éÀ¸·Î º¯È¯
biden_corpus <- tm_map(biden_corpus,stripWhitespace)
lapply(biden_corpus,content)

biden_dtm <- DocumentTermMatrix(biden_corpus)
biden_dtm
inspect(biden_dtm)
termfreq <- colSums(as.matrix(biden_dtm))

library(wordcloud)
wordcloud(words=names(termfreq),freq=termfreq)

library(wordcloud2)
termfreq_df <- data.frame(word=names(termfreq),freq=termfreq)
wordcloud2(df)

library(ggplot2)

top_50 <- head(termfreq_df[order(termfreq_df$freq,decreasing=T),],n=50)
top_50

ggplot(data=top_50,aes(x=reorder(word,freq),y=freq,fill=word))+
  geom_col(show.legend=F)+
  coord_flip()

Terms(biden_dtm) #´Ü¾îÃßÃâ

#ÃÖ¼Ò ºóµµ¼ö°¡ 10 ÀÌ»óÀÎ ´Ü¾îµé¸¸ ÃßÃâ
termfreq_df[termfreq_df$freq>=10,'word']

#lowfreq : ÃÖ¼Ò ÀÌ»ó ÃâÇö È½¼ö(ºóµµ¼ö)
tm::findFreqTerms(biden_dtm,lowfreq=10)

# highfreq : ÃÖ´ë ÀÌÇÏ ºóµµ¼ö
termfreq_df[termfreq_df$freq<10,'word']
tm::findFreqTerms(biden_dtm,highfreq=10)

termfreq_df[termfreq_df$freq>=10 & termfreq_df$freq<=15,]

tm::findFreqTerms(biden_dtm,lowfreq=10, highfreq=15)


¡Ú °¨¼ººĞ¼®
°¨¼ººĞ¼®(sentiment analysis) ¶Ç´Â opinion miningÀº ÅØ½ºÆ®¿¡ ³»Àç µÇ¾î ÀÖ´Â
°¨Á¤Àû »óÅÂ³ª ÁÖ°üÀû Æò°¡¸¦ ½Äº°ÇÏ°í ÃßÃâÇÏ´Â ÅØ½ºÆ® ºĞ¼® ±â¹ı

install.packages("tidytext")
install.packages("textdata")
library(tidytext)
library(textdata)

# bing
tidytext::sentiments%>%
  head()

tidytext::sentiments%>%
  tail()

#bing
#positive, negative ºĞ·ù
get_sentiments('bing')

get_sentiments('bing')$word
unique(get_sentiments('bing')$sentiment)

# afinn -5Á¡(ºÎÁ¤) ~ +5Á¡(±àÁ¤)ÀÇ ¹üÀ§¸¦ °®´Â Á¡¼ö·Î Ç¥Çö
get_sentiments('afinn')
get_sentiments('afinn')$word
unique(get_sentiments('afinn')$value)

# nrc
# 10°³ÀÇ °¨¼º »óÅÂ ºĞ·ù
#"trust"        "fear"         "negative"     "sadness"     "anger"        "surprise"     "positive"     "disgust"     "joy"          "anticipation"
get_sentiments('nrc')
get_sentiments('nrc')$word
unique(get_sentiments('nrc')$sentiment)

# loughran
# 6°³ÀÇ °¨¼º »óÅÂ ºĞ·ù, ±İÀ¶ºĞ¾ßÀÇ ÅØ½ºÆ®¿¡ ÀûÇÕ
# "negative"     "positive"     "uncertainty"  "litigious"   "constraining" "superfluous"
get_sentiments('loughran')
get_sentiments('loughran')$word
unique(get_sentiments('loughran')$sentiment)

biden_sentiment <- merge(termfreq_df,get_sentiments('bing'),by='word')
head(biden_sentiment)
aggregate(word ~ sentiment,biden_sentiment,length)


biden_sentiment <- merge(termfreq_df,get_sentiments('nrc'),by='word')
head(biden_sentiment)
aggregate(word ~ sentiment,biden_sentiment,length)


[¹®Á¦ 212] ¹Ì±¹ Æ®·³ÇÁ ´ëÅë·É ÃëÀÓ»ç Àü¹®À» ¼öÁıÇÏ¼Å¼­ ¸»¹¶Ä¡·Î º¯È¯ÇÑ ÈÄ 
Á¤Á¦ ÀÛ¾÷À» ÅëÇØ document-term matrix¸¦ »ı¼ºÇÑ ÈÄ ½Ã°¢È­ ÇÏ°í °¨¼ººĞ¼®µµ ¼öÇàÇØº¸¼¼¿ä.

library(xml2)

1. Àü¹® ¼öÁı(½ºÅ©·¦)
html <- read_html('https://www.joongang.co.kr/article/21157192#home')
trump <- html_nodes(html,xpath='//*[@id="article_body"]')%>%
  html_text()

# txtÆÄÀÏ·Î ÀúÀå
write(trump,file='c:/data/trump_raw.txt')
trump <- readLines('c:/data/trump_raw.txt')
trump <- paste(trump,collapse=' ')

2. ¸»¹¶Ä¡º¯È¯
trump_cor <- VCorpus(VectorSource(trump))

inspect(trump_cor)#È®ÀÎ
inspect(trump_cor[[1]])#³»¿ëÈ®ÀÎ

3. ÀüÃ³¸® ÀÛ¾÷
#ÇÑ±Û Á¦°Å
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('[°¡-ÆR]+','',x)))
inspect(trump_cor[[1]])

#°ıÈ£¾È¿¡ ¹®ÀÚµéÀÌ ÀÖ´Â Çü½Ä Á¦°Å
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('<[0-9A-z+\\+]+>','',x)))
inspect(trump_cor[[1]])

#ÀÌ¸ŞÀÏ Á¦°Å
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('[a-z]+.[a-z]+@[a-z]+.[a-z]+','',x)))

#ÇÊ¿ä¾ø´Â ¾Õ ´Ü¶ô¿¡ ´Ü¾î Á¦°Å
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('FTA','',x)))
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('US','',x)))

#¼ıÀÚ Á¦°Å
trump_cor <- tm_map(trump_cor,removeNumbers)
inspect(trump_cor[[1]])

# ºÒ¿ë¾î Á¦°Å
trump_cor <- tm_map(trump_cor,removeWords,tm::stopwords())
inspect(trump_cor[[1]])

trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub("It\\'s" ,'',x)))
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub("\\'s" ,'',x)))

lapply(trump_cor,function(x) str_extract_all(x$content,"\\w+\\'s ")) #È®ÀÎÇÏ±â

#Æ¯¼ö¹®ÀÚÁ¦°Å
trump_cor <- tm_map(trump_cor,content_transformer(function(x) gsub('[[:punct:]]',' ',x)))
inspect(trump_cor[[1]])

#°ø¹é 2°³ÀÌ»óÀ» ÇÏ³ªÀÇ °ø¹éÀ¸·Î º¯È¯
trump_cor <- tm_map(trump_cor,stripWhitespace)
inspect(trump_cor[[1]])

#¼Ò¹®ÀÚ·Î º¯È¯
trump_cor <- tm_map(trump_cor,content_transformer(tolower))
inspect(trump_cor[[1]])

4. document-term matrix º¯È¯
trump_dtm <- DocumentTermMatrix(trump_cor)
inspect(trump_dtm)

5. ½Ã°¢È­ 
trump_dtm <- colSums(as.matrix(trump_dtm)) # matrixÇüÅÂ·Î º¯È¯ÇØ¾ß wordcloud»ı¼º °¡´É

wordcloud(word=names(trump_dtm),freq=trump_dtm,
          random.order = F, random.color = T,
          colors = rainbow(length(trump_dtm)))

trump_df <- data.frame(word=names(trump_dtm),freq=trump_dtm)
wordcloud2(trump_df)

library(dplyr)
trump_df2 <- trump_df%>%
  arrange(desc(freq))%>%
  filter(freq>=6)

ggplot(data=trump_df2,aes(x=reorder(word,freq),y=freq,fill=word))+
  geom_col(show.legend=F)+
  coord_flip()

6. °¨¼ººĞ¼®
trump_sentiment <- merge(trump_df,get_sentiments('bing'),by='word')
aggregate(word ~ sentiment,trump_sentiment,length)


[¹®Á¦213] Æ®·³ÇÁ, ¹ÙÀÌµç ±àÁ¤´Ü¾î¸¦ ÀÌ¿ëÇØ¼­ compare wordcloud »ı¼ºÇØÁÖ¼¼¿ä.
biden_sentiment
trump_sentiment

          biden  trump
±àÁ¤´Ü¾î ºóµµ¼ö ºóµµ¼ö
# °¢ µ¥ÀÌÅÍÇÁ·¹ÀÓ¿¡¼­ ±àÁ¤¸¸ ÃßÃâ
biden_p <- biden_sentiment[biden_sentiment$sentiment=='positive',]
trump_p <- trump_sentiment[trump_sentiment$sentiment=='positive',]

#°ãÄ¡Áö ¾Êµµ·Ï freq ¿­ÀÇ ÀÌ¸§À» º¯°æ
names(biden_p)[2] <- 'biden'
names(trump_p)[2] <- 'trump'

# mergeÇÔ¼ö·Î Á¶ÀÎ
#merge(biden_p,trump_p,by=c('sentiment','word')) ÀÌ·¸°Ô Á¶ÀÎÇÏ¸é ³ª¸ÓÁö ±àÁ¤´Ü¾îµéÀÌ ¾È³ª¿È
biden_trump <- merge(biden_p,trump_p,by=c('sentiment','word'),all.x = T,all.y = T)
biden_trump[is.na(biden_trump$biden),'biden'] <- 0 #na°ªÀº 0À¸·Î º¯È¯
biden_trump[is.na(biden_trump$trump),'trump'] <- 0 #na°ªÀº 0À¸·Î º¯È¯

biden_trump <- biden_trump[,c('word','biden','trump')]
biden_trump

# word°¡ ÇàÀÌ¸§À¸·Î °¡µµ·Ï ÇÏ±â (compare wordcloud»ı¼ºÇÏ±âÀ§ÇÑ ±¸Á¶)
rownames(biden_trump) <- biden_trump$word
biden_trump <- biden_trump[,c('biden','trump')]
biden_trump

#compare wordcloud »ı¼º
windows(width = 13,height=13)
wordcloud::comparison.cloud(biden_trump, random.order = F,
                            colors=brewer.pal(3,"Set1"),
                            title.colors = 'black',
                            title.bg.colors = 'white',
                            scale = c(3,0.5),
                            rot.per=0.001)

#-----------------------Æ®·³ÇÁ´ëÅë·ÉÀÇ ¿¬¼³ ¿ø¹®¸¸ write ÇÏ±â ¹öÀü

html <- read_html('https://www.joongang.co.kr/article/21157192#home')
html_nodes(html,'div.article_body')

#¿¬¼³ ³»¿ë ¿ø¹®,ÇÑ±Û¹öÀü¿¡¼­ ¿ø¹®¸¸ ½ºÅ©·¦ÇÏ±â
trump_test <- c()
for(i in 27:54){
  trump_test <- c(trump_test,html_nodes(html,xpath=paste0('//*[@id="article_body"]/p[',i,']'))%>%
    html_text()) #pÅÂ±× 1~26±îÁö´Â ¿ø¹® ÇØ¼®º», 27~54±îÁö ¿ø¹®
}
trump_test

trump_test <- paste(trump_test,collapse=' ')
trump_test
write(trump_test,file='c:/data/trump_talking.txt')
trump_test <-readLines('c:/data/trump_talking.txt')

#¸»¹¶Ä¡ º¯È¯
trump_corpus <- VCorpus(VectorSource(trump_test))
inspect(trump_corpus[[1]])

# ¼ıÀÚ Á¦°Å
trump_corpus <- tm_map(trump_corpus,removeNumbers)
trump_corpus[[1]]$content

# ºÒ¿ë¾î Á¦°Å
trump_corpus <- tm_map(trump_corpus,removeWords,stopwords())
trump_corpus[[1]]$content

# 's Á¦°Å------------------------ÁøÇàÁß
tm_map(trump_corpus,content_transformer(function(x) gsub()))

# Æ¯¼ö¹®ÀÚ Á¦°Å
trump_corpus <- tm_map(trump_corpus,removePunctuation)
trump_corpus[[1]]$content

[¹®Á¦213 ´Ù½Ã] Æ®·³ÇÁ, ¹ÙÀÌµç ±àÁ¤´Ü¾î¸¦ ÀÌ¿ëÇØ¼­ compare wordcloud »ı¼ºÇØÁÖ¼¼¿ä. ´Ù½Ã
d <- rbind()
biden_p$sentiment <- 'biden'
trump_p$sentiment <- 'trump'
names(biden_p)[2] <- 'freq'
names(trump_p)[2] <- 'freq'
biden_trump2 <- rbind(biden_p,trump_p)
biden_trump2 <- acast(biden_trump2,word~sentiment,value.var='freq',fill=0)

wordcloud::comparison.cloud(biden_trump2)

.



                            
'''
if(require(tm)){
  data(SOTU)
  corp <- SOTU
  corp <- tm_map(corp, removePunctuation)
  corp <- tm_map(corp, content_transformer(tolower))
  corp <- tm_map(corp, removeNumbers)
  corp <- tm_map(corp, function(x)removeWords(x,stopwords()))
  
  term.matrix <- TermDocumentMatrix(corp)
  term.matrix <- as.matrix(term.matrix)
  colnames(term.matrix) <- c("SOTU 2010","SOTU 2011")
  comparison.cloud(term.matrix,max.words=40,random.order=FALSE)
  comparison.cloud(term.matrix,max.words=40,random.order=FALSE,
                   title.colors=c("red","blue"),title.bg.colors=c("grey40","grey70"))
  comparison.cloud(term.matrix,max.words=40,random.order=FALSE,
                   match.colors=TRUE)
  
}
'''

#-----------------------------------°­»ç´Ô
//*[@id="main"]/div[2]/div/article/div[1]/section[2]/div/div

html <- read_html('https://www.politico.com/story/2017/01/full-text-donald-trump-inauguration-speech-transcript-233907')
trump <- html_nodes(html,xpath='//*[@id="main"]/div[2]/div/article/div[1]/section[2]/div/div/p')%>%
  html_text()
trump <- paste(trump,collapse=' ')

trump_corpus <- VCorpus(VectorSource(trump))
lapply(trump_corpus,content)

# ¼Ò¹®ÀÚ º¯È¯
trump_corpus <- tm_map(trump_corpus,content_transformer(tolower))
lapply(trump_corpus,content)

# ºÒ¿ë¾î Á¦°Å
trump_corpus <- tm_map(trump_corpus,removeWords,stopwords())
lapply(trump_corpus,content)

# Æ¯¼ö¹®ÀÚ Á¦°Å
trump_corpus <- tm_map(trump_corpus,removePunctuation)
lapply(trump_corpus,content)

# ¼ıÀÚ Á¦°Å
trump_corpus <- tm_map(trump_corpus,removeNumbers)
lapply(trump_corpus,content)

# °ø¹é Á¶Àı
trump_corpus <- tm_map(trump_corpus,stripWhitespace)

trump_dtm <- DocumentTermMatrix(trump_corpus)
trump_freq <- colSums(as.matrix(trump_dtm))

trump_df <- data.frame(word=names(trump_freq),freq=trump_freq)

trump_sentiment <- merge(trump_df,get_sentiments('bing'),by='word')

#compare wordcloud

head(biden_sentiment)
head(trump_sentiment)

trump_df <- trump_sentiment[trump_sentiment$sentiment=='positive',]
biden_df <- biden_sentiment[biden_sentiment$sentiment=='positive',]

trump_df
biden_df

trump_df$president <- 'trump'
biden_df$president <- 'biden'

trump_df$sentiment <- NULL # ¿­»èÁ¦
biden_df$sentiment <- NULL

trump_biden <- rbind(trump_df,biden_df)
trump_biden

trump_biden <- acast(trump_biden,word~president,value.var = 'freq',fill=0)

wordcloud::comparison.cloud(trump_biden,
                            colors=c('blue','red'),
                            title.bg.colors = 'white',
                            title.size = 3,
                            title.colors = c('blue','red'),
                            scale = c(2,0.5))

#--------------------------------------------------------

Sys.getenv('JAVA_HOME')
library(rJava)

install.packages("openNLP")
library(openNLP)
library(NLP)

text <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing."
text
nchar(text)

# NLP::annotate() : ÅØ½ºÆ® µ¥ÀÌÅÍ¿¡ ÁÖ¼® ÀÛ¾÷À» ¼öÇàÇÏ´Â ÇÔ¼ö
# openNLP::Maxent_Sent_Token_Annotator() : ¹®Àå´ÜÀ§ ÁÖ¼®ÀÛ¾÷À» ÇÏ´Â ÇÔ¼ö
# openNLP::Maxent_Word_Token_Annotator() : ´Ü¾î´ÜÀ§ ÁÖ¼®ÀÛ¾÷À» ÇÏ´Â ÇÔ¼ö
# openNLP::Maxent_POS_Tag_Annotator() : Ç°»çÅÂ±ëÇÏ´Â ÇÔ¼ö

text_sent <- NLP::annotate(text, openNLP::Maxent_Sent_Token_Annotator())
text_word <- NLP::annotate(text, openNLP::Maxent_Word_Token_Annotator(),text_sent)
postag <- NLP::annotate(text,openNLP::Maxent_POS_Tag_Annotator(),text_word)


id type     start end features
1 sentence     1 153 constituents=<<integer,23>>
  2 word         1   1 POS=NN #1¹øÂ° ÀÎµ¦½º, ´Ü¼ö¸í»ç
3 word         3   4 POS=VBZ #3ÀÎÄª ÇöÀçÇü ´Ü¼öµ¿»ç
4 word         6   6 POS=DT # ÇÑÁ¤»ç
5 word         8  18 POS=NN
6 word        20  27 POS=NN
7 word        29  31 POS=CC # µîÀ§Á¢¼Ó»ç
8 word        33  36 POS=JJ # Çü¿ë»ç
9 word        38  45 POS=NN
10 word        47  57 POS=NN
11 word        59  61 POS=IN # ÀüÄ¡»ç
12 word        63  73 POS=JJ
13 word        75  83 POS=NN
14 word        85  87 POS=CC
15 word        89  96 POS=NNS # º¹¼ö¸í»ç
16 word        98 106 POS=VBN # °ú°ÅÁøÇàÇü
17 word       108 109 POS=IN
18 word       111 113 POS=DT
19 word       115 115 POS=NN
20 word       117 126 POS=NNP #´Ü¼ö´ë¸í»ç
21 word       128 130 POS=IN
22 word       132 142 POS=NNP
23 word       144 152 POS=NNP
24 word       153 153 POS=.

NNPS : º¹¼ö´ë¸í»ç
NNP : ´Ü¼ö´ë¸í»ç
JJR : ºñ±³±Ş Çü¿ë»ç
JJS : ÃÖ»ó±Ş Çü¿ë»ç
MD : Á¶µ¿»ç
...

[¹®Á¦214] textº¯¼ö¿¡ ÀÖ´Â ¹®Àå¿¡¼­ ¸í»ç(NN), º¹¼ö¸í»ç(NNS), ´Ü¼ö´ë¸í»ç(NNP)¸¦ ÃßÃâÇØÁÖ¼¼¿ä.
class(postag)

postag_df <- data.frame(postag[postag$type=='word'])
str(postag_df)
postag_df$features <- unlist(postag_df$features)
postag_df

pos_nn <- postag_df[postag_df$features %in% c('NN','NNS','NNP'),]

p <- c()
for(i in 1:nrow(pos_nn)){
  p <- c(p, substr(text,pos_nn$start[i],pos_nn$end[i]))
}
p

