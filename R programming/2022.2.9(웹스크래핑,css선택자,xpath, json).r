
¡Ü ÆäÀÌÁö¸¦ ¹Ù²Ù´Âµ¥ ÁÖ¼Ò°¡ º¯ÇÏÁö ¾ÊÀ» ¶§ ±×ÁÖ¼Ò·Î ½ºÅ©·¡ÇÎÀ» ÇÒ ¼ö ¾ø´Âµ¥ ´Ù¸¥ ¹æ¹ıÀÌÀÖ´Ù.
f12¿¡ ³×Æ®¿öÅ©¿¡ name,preview¿¡¼­ Ã£¾Æ¾ßÇÑ´Ù. Ã£¾Æ¼­ header¿¡ ÀÖ´Â ÁÖ¼Ò¸¦ º¹»çÇØ¼­ »ç¿ë
±×·±µ¥ À¥ÆäÀÌÁö º¹»çÇØ¼­ µé¾î°¬À» ¶§ 1ÆäÀÌÁö¿¡¼­ 2ÆäÀÌÁö °¬´Ù°¡ ´Ù½Ã 1ÆäÀÌÁö °¡¸é ÁÖ¼Ò°¡ ¹Ù²î´Âµ¥ ±× ÁÖ¼Ò¸¦ »ç¿ëÇÏÀÚ

https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false
https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1

¡Ú css¼±ÅÃÀÚ »ç¿ë¹æ¹ı
library(rvest)
library(stringr)
# ÁÖ¼Ò·Î ¿äÃ»ÇÏ°í ÀÀ´ä¹ŞÀ½
html <- read_html('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1')

# divÅÂ±×¿¡ score_repleÅ¬·¡½º¸¦ °¡Á®¿À´Âµ¥ text¸¸ °¡Á®¿À±â
review <- html_nodes(html,'div.score_reple')%>%
  html_text()

# °ø¹é Áö¿ì±â(Á¦ÀÏ ¾Õ°ú µÚ¸¦ Áö¿ì±â)
trimws(review) 
str_trim(review)

#\n\t\r Áö¿ì±â
review <- str_trim(review)
#gsub('\n|\t|\r',' ',review)
review <- str_replace_all(review,'\n|\t|\r',' ')

# Á¦ÀÏ ¾Õ¿¡ °ü¶÷°´°ú Á¦ÀÏ µÚ¿¡ ½Å°í ´Ü¾î »èÁ¦
review <- gsub('^°ü¶÷°´',' ',review)
review <- gsub('½Å°í$',' ',review)
review <- str_trim(review)

# 2°³ÀÌ»óÀÇ °ø¹éÀ» ÇÏ³ªÀÇ °ø¹éÀ¸·Î º¯È¯
#gsub('\\s{2,}',' ',review)
review <- str_squish(review)

#¾ÆÀÌµğ ³¯Â¥,½Ã°£ ÀüºÎ ¼öÁıÇÏ±â , °¨»óÆò±îÁö
·ê·çºñ(lulu****) 2022.01.27 22:36
#str_extract_all(review,'[^[:space:]]\\w+\\(\\w{4}\\*{4}\\) \\d{4}.\\d{2}.\\d{2} \\d{2}:\\d{2}')
x <- str_extract_all(review,'\\w+\\(.+\\)\\s\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}')

id <- str_extract(x,'\\w+\\(.+\\)')
date <- str_extract(x,'\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}')
review <- str_replace_all(review,'\\w+\\(.+\\)\\s\\d{4}\\.\\d{2}\\.\\d{2}\\s\\d{2}\\:\\d{2}','')

# ¤Ğ¤Ğ , . ! ¤¾¤¾ ÀÌ·± °Íµé Á¦°ÅÇÏ±â
review <- str_replace_all(review,'[¤¡-¤¾¤¿-¤Ó\\.,!?]',' ')

#str_replace_all(review,'[^°¡-ÆR]',' ') ÇÑ±ÛÀÌ ¾Æ´Ñ °Í Á¦°Å

# ÆòÁ¡ ¼öÁı  - divÅÂ±×¿¡ star_scoreÅ¬·¡½º¿¡ ÀÖ´Â emÅÂ±×¿¡¼­ text¸¸ »Ì±â
point <- html_nodes(html,'div.star_score > em')%>%
  html_text()

View(data.frame(id=id,date=date,point=point,review=review))

#---------------------------------------------------------------



¡Ú xpath »ç¿ë ¹æ¹ı

html <- read_html('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1')

¡Ü Àı´ë°æ·Î¸¦ ÀÌ¿ëÇØ¼­ °Ë»ö (xpath) , ¿ä¼Ò¼±ÅÃÇØ¼­ copy XPath ºÙ¿©³Ö±â

#html_node(html,xpath='/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span') <span>¾ÕÀÇ span±îÁö ³ª¿È ÁÖÀÇ </span>
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span')
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[2]/div[2]/dl/dt/em[1]/a/span')
html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li[3]/div[2]/dl/dt/em[1]/a/span')

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[1]/a/span')%>%
  html_text() #liÀÎµ¦½º¸¦ Áö¿ì¸é ¸ğµç li¸¦ Ã£¾Æ¿È(¾ÆÀÌµğ °ª ´Ù Ã£¾Æ¿À±â)

/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[1]/a/span
/html/body/div/div/div[5]/ul/li[5]/div[2]/dl/dt/em[1]/a/span

¡Ü »ó´ë°æ·Î¸¦ ÀÌ¿ëÇØ¼­ °Ë»ö

html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[1]/a/span')%>%
  html_text() # div classÀÌ¸§ÀÌ score_repleÀÎ °ÍÀ» Ã£°Ú´Ù -> div[@class] -> class°¡ ¾Æ´Ñ id¸é id·Î


# ³¯Â¥ ÃßÃâ

/html/body/div/div/div[5]/ul/li[1]/div[2]/dl/dt/em[2]
/html/body/div/div/div[5]/ul/li[2]/div[2]/dl/dt/em[2]

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[2]')%>%
  html_text()

html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[2]')%>%
  html_text()

# ÆòÁ¡ ÃßÃâ
/html/body/div/div/div[5]/ul/li[1]/div[1]/em
/html/body/div/div/div[5]/ul/li[2]/div[1]/em

html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[1]/em')%>%
  html_text()

html_nodes(html,xpath='//div[@class="star_score"]/em')%>%
  html_text()


# ¸®ºä ÃßÃâ

  # copy xpath Çß´Âµ¥ »ó´ë°æ·Î, ¾ÆÀÌµğ °ªµµ Æ²¸²
//*[@id="_unfold_ment0"]/a #Ã¹¹øÂ° ¸®ºä
//*[@id="_filtered_ment_1"]/text() # µÎ¹øÂ°¸®ºä

# Àı´ë°æ·Î (copy full XPath)
/html/body/div/div/div[5]/ul/li[1]/div[2]/p/span[2]/span/a
/html/body/div/div/div[5]/ul/li[2]/div[2]/p/span[2]/text()
/html/body/div/div/div[5]/ul/li[3]/div[2]/p/span[2]/text()

review <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/p/span[2]')%>%
  html_text()

trimws(review)


review <- html_nodes(html,xpath='//div[@class="score_reple"]/p/span[2]')%>%
  html_text()

trimws(review)

[¹®Á¦207] ³×ÀÌ¹ö¿¡¼­ ¿µÈ­¸®ºäÁ¤º¸¸¦ ¼öÁıÇÑ ÈÄ µ¥ÀÌÅÍÇÁ·¹ÀÓÀ¸·Î ÀúÀåÇØÁÖ¼¼¿ä.
ÄÃ·³Àº id, date, point,comment·Î »ı¼ºÇØÁÖ¼¼¿ä.

html <- read_html('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=3')

(1) xpath¸¦ ÀÌ¿ëÇØ¼­ µ¥ÀÌÅÍ ¼öÁıÇÏ¼¼¿ä.

#±Û¾´ÀÌ 
//*[@id="old_content"]/table/tbody/tr[1]/td[3]/a # 1¹øÂ° ±Û¾´ÀÌ, xpath
//*[@id="old_content"]/table/tbody/tr[2]/td[3]/a # 2¹øÂ° ±Û¾´ÀÌ, xpath
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[3]/a # 1¹øÂ° ±Û¾´ÀÌ, full xpath
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[3]/a # 2¹øÂ° ±Û¾´ÀÌ, full xpath

id <- html_nodes(html,xpath='//td[@class="num"]/a')%>%
  html_text()

# ³¯Â¥
//*[@id="old_content"]/table/tbody/tr[1]/td[3]/text()
//*[@id="old_content"]/table/tbody/tr[2]/td[3]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[3]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[3]/text()

date <- html_nodes(html,xpath='//td[@class="num"]/text()')%>%
  html_text()
  
# °¨»óÆò
//*[@id="old_content"]/table/tbody/tr[1]/td[2]/text()
//*[@id="old_content"]/table/tbody/tr[2]/td[2]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[2]/text()
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[2]/text()

#html_nodes(html,xpath='//td[@class="title"]/text()')%>% html_text()
#html_nodes(html,xpath='/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr/td[2]/text()')%>%  html_text()

library(xml2)
title <- html_nodes(html,xpath='//td[@class="title"]')
xml2::xml_remove(title%>%html_nodes('a'))
xml2::xml_remove(title%>%html_nodes('div'))
comment <- title%>% html_text()
comment <- str_trim(comment)
comment <- str_replace_all(comment,'\\.|!|~|^',' ')
comment <- str_repalce_all(comment,'[¤¡-¤¾¤¿-¤Ó]',' ')
comment <- str_replace_all(comment,'//s{2,}',' ')
#str_extract_all(comment,'\\.|\\?')

# ÆòÁ¡
//*[@id="old_content"]/table/tbody/tr[1]/td[2]/div/em
//*[@id="old_content"]/table/tbody/tr[2]/td[2]/div/em
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[1]/td[2]/div/em
/html/body/div/div[4]/div/div/div/div/div[1]/table/tbody/tr[2]/td[2]/div/em

point <- html_nodes(html,xpath='//div[@class="list_netizen_score"]/em')%>%
  html_text()

# µ¥ÀÌÅÍÇÁ·¹ÀÓ
View(data.frame(id=id,point=point,comment=comment,date=date))

#--------10ÆäÀÌÁö±îÁö 

movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/point/af/list.naver?st=mcode&sword=57095&target=after&page=',i))
  
  id <- html_nodes(html,xpath='//td[@class="num"]/a')%>%
    html_text()   
  
  date <- html_nodes(html,xpath='//td[@class="num"]/text()')%>%
    html_text()
  
  point <- html_nodes(html,xpath='//div[@class="list_netizen_score"]/em')%>%
    html_text()
  
  title <- html_nodes(html,xpath='//td[@class="title"]')
  xml2::xml_remove(title%>%html_nodes('a'))
  xml2::xml_remove(title%>%html_nodes('div'))
  comment <- title%>% html_text()
  comment <- str_trim(comment)
  comment <- str_replace_all(comment,'\\.|!|~|^|,|\\?',' ')
  comment <- str_replace_all(comment,'[¤¡-¤¾¤¿-¤Ó]',' ')
  comment <- str_replace_all(comment,'//s{2,}',' ')
  
  temp <- data.frame(id=id,point=point,comment=comment,date=date)
  movie <- rbind(movie,temp)
  Sys.sleep(1)
}
View(movie)


(2) ¼öÁıÇÑ ³»¿ëÀ» ÇüÅÂ¼Ò ºĞ¼®À» ÇØº¸¼¼¿ä.
library(KoNLP)
useNIADic()
x <- SimplePos09(movie$comment)
movie$tagging1 <- sapply(x, function(arg){paste(unlist(arg),collapse=' ')})
movie$tagging2 <- sapply(str_match_all(movie$tagging1,'(\\w+)/N'),function(arg){paste(unlist(arg)[,2],collapse=' ')})
View(movie)

(3) ÆòÁ¡À» ±âÁØÀ¸·Î 1~4 ºÎÁ¤, 5~7 Áß¸³, 8~10 ±àÁ¤À¸·Î ·¹ÀÌºíÀ» »ı¼ºÇØÁÖ¼¼¿ä.
movie$evaluation <- ifelse(movie$point >= 8,'±àÁ¤',ifelse(movie$point>=5,'Áß¸³','ºÎÁ¤'))
View(movie)

(4) ·¹ÀÌºíÀ» ±âÁØÀ¸·Î ¸í»ç¸¸compare wordcloud¸¦ »ı¼ºÇØÁÖ¼¼¿ä.

pos <- movie[movie$evaluation == '±àÁ¤','tagging2']
neg <- movie[movie$evaluation == 'ºÎÁ¤','tagging2']
mid <- movie[movie$evaluation == 'Áß¸³','tagging2']

p <- data.frame(table(unlist(str_split(pos,' '))))
n <- data.frame(table(unlist(str_split(neg,' '))))
m <- data.frame(table(unlist(str_split(mid,' '))))

names(p) <- c('word','freq')
names(n) <- c('word','freq')
names(m) <- c('word','freq')

p$sentiment <- 'positive'
n$sentiment <- 'negative'
m$sentiment <- 'middle'

df <- rbind(p,n,m)
df



library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq', fill=0)
df_compar

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df_compar)


#--------------------------°­»ç´Ô
movie <- data.frame()
for(i in 1:10){
  html <- read_html(paste0('https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=194204&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=',i))
  id <- html_nodes(html,xpath='//div[@class="score_reple"]/dl/dt/em[1]/a/span')%>%
    html_text()
  date <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/dl/dt/em[2]')%>%
    html_text()
  point <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[1]/em')%>%
    html_text()
  review <- html_nodes(html,xpath='/html/body/div/div/div[5]/ul/li/div[2]/p/span[2]')%>%
    html_text()
  movie <- rbind(movie,data.frame(id=id,date=date,point=point,review=review))
  Sys.sleep(1)  
}
View(movie)
write.csv(movie,file='c:/data/movie_raw.csv',row.names=F)
movie$review <- str_trim(movie$review)

movie$revie[grep(CG|cg',movie$review')]
unlist(str_extract_all(movie$review,'[¤¡-¤¾¤¿-¤Ó\\.,!?]'))
unlist(str_extract_all(movie$review,'CG|cg'))

movie$review <- str_replace_all(movie$review,'[¤¡-¤¾¤¿-¤Ó\\.,!?]',' ')
movie$review <- str_replace_all(movie$review,'CG|cg','±×·¡ÇÈ')
movie$review <- str_squish(movie$review)
movie$review

library(KoNLP)
useNIADic()

pos <- SimplePos22(movie$review)
pos

noun <- str_match_all(pos,"([°¡-ÆR]+)/NC")
noun[[1]][,2]
movie$review[1]

#ÇÑ »ç¶÷ÀÌ ¾´ °¨»óÆò¿¡ ¶È°°Àº ´Ü¾î°¡ ³Ê¹« ¸¹À» ¶§ ´ëÇ¥ ´Ü¾îµé¸¸(À¯´ÏÅ©ÇÑ ´Ü¾î)»Ì°Ú´Ù -> ¹«Á¶°Ç ÇÏ´Â °ÍÀº ¾Æ´Ô »óÈ²¿¡ µû¶ó ÆÇ´Ü
noun_unique <- sapply(noun,unique)
noun_unique[[1]][,2]
noun
movie$noun <- sapply(noun,function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse=' ')) # 2±ÛÀÚ ÀÌ»ó¸¸ »Ì°Ú´Ù.
View(movie)

str(movie)
movie$point <- as.integer(movie$point)
str(movie)
movie$evaluation <- ifelse(movie$point>=8,'±àÁ¤',ifelse(movie$point>=5 & movie$point<=7,'Áß¸³','ºÎÁ¤'))

positive <- movie[movie$evaluation=='±àÁ¤','noun']
negative <- movie[movie$evaluation=='ºÎÁ¤','noun']
neutral <- movie[movie$evaluation=='Áß¸³','noun']

head(sort(table(unlist(strsplit(positive,' '))),decreasing=T))
head(sort(table(unlist(strsplit(negative,' '))),decreasing=T))

positive_df <- data.frame(table(unlist(strsplit(positive,' '))))
negative_df <- data.frame(table(unlist(strsplit(negative,' '))))
neutral_df <- data.frame(table(unlist(strsplit(neutral,' '))))

names(positive_df) <- c('word','freq')
names(negative_df) <- c('word','freq')
names(neutral_df) <- c('word','freq')

positive_df$sentiment <- '±àÁ¤'
negative_df$sentiment <- 'ºÎÁ¤'
neutral_df$sentiment <- 'Áß¸³'

head(positive_df)
head(negative_df)
head(neutral_df)

df <- rbind(positive_df,negative_df,neutral_df)
head(df)
tail(df)

library(reshape2)
df_compar <- acast(df,word~sentiment,value.var='freq',fill=0) #acast(µ¥ÀÌÅÍ,ÇàÀ¸·Î°¥°Å~¿­·Î°¥°Å,value.var=µé¾î°¥ °ªµé,fill=°ªÀÌ ¾øÀ» ¶§ µé¾î°¥ °ª)
head(df_compar)
tail(df_compar)

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df_compar,colors=c('red','blue','purple'),
                            title.colors=c('red','blue','purple'),
                            title.bg.colors = 'white',
                            title.size=2,
                            scale = c(2,0.5))


head(sort(table(unlist(strsplit(positive,' '))),decreasing=T))
head(sort(table(unlist(strsplit(negative,' '))),decreasing=T))


library(dplyr)
df%>%
  group_by(sentiment)%>%
  mutate(rank=dense_rank(desc(freq)))%>%
  filter(rank==1)%>%
  arrange(sentiment,rank)

df%>%
  group_by(sentiment)%>%
  slice_max(freq) # slice_max : ºóµµ¼ö°¡ Á¦ÀÏ ³ôÀº °ªµé¸¸ ÃßÃâ

df%>%
  group_by(sentiment)%>%
  mutate(rank=dense_rank(freq))%>%
  filter(rank==1)%>%
  arrange(sentiment,rank)%>%
  print(n=1000)

df%>%
  group_by(sentiment)%>%
  slice_min(freq)%>% # slice_max : ºóµµ¼ö°¡ Á¦ÀÏ ³·Àº °ªµé¸¸ ÃßÃâ
  print(n=400)
  
¡Ú JSON(JAVA OBJECT NOTATION)
- ÀÚ¹Ù½ºÅ©¸³Æ®¿¡¼­ »ç¿ëÇÏ´Â °´Ã¼ Ç¥±â ¹æ¹ıÀ» ±â¹İÀ¸·Î ÇÑ´Ù.
- ÅØ½ºÆ® µ¥ÀÌÅÍ¸¦ ±â¹İÀ¸·Î ÇÑ´Ù.
- ´Ù¾çÇÑ ¼ÒÇÁÆ®¿ş¾î¿Í ÇÁ·Î±×·¡¹Ö¾ğ¾î³¢¸® µ¥ÀÌÅÍ¸¦ ±³È¯ÇÒ ¶§ ¸¹ÀÌ »ç¿ëµÈ´Ù.

install.packages('jsonlite')
library(jsonlite)

json1 <- fromJSON('https://comment.daum.net/apis/v1/posts/149671721/comments?parentId=0&offset=0&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j1 <- json[,c('rating','content','createdAt')]

json2 <- fromJSON('https://comment.daum.net/apis/v1/posts/149671721/comments?parentId=0&offset=101&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j2 <-json2[,c('rating','content','createdAt')]

json3 <- fromJSON('https://comment.daum.net/apis/v1/posts/149671721/comments?parentId=0&offset=201&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j3 <-json3[,c('rating','content','createdAt')]

View(rbind(j1,j2,j3))


#-------------------------------------

#daum¿µÈ­ ÇØ¸®Æ÷ÅÍ ºÒ»çÁ¶±â»ç´Ü jsonÀ¸·Î ¸®ºä ÀĞ¾î¿À±â

js1 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=0&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j1 <- js1[,c('rating','content','createdAt')]

js2 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=101&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j2 <- js2[,c('rating','content','createdAt')]

js3 <- fromJSON('https://comment.daum.net/apis/v1/posts/149508559/comments?parentId=0&offset=201&limit=100&sort=RECOMMEND&isInitial=true&hasNext=true')
j3 <- js3[,c('rating','content','createdAt')]

movie_df <- rbind(j1,j2,j3)
View(movie_df)

# content(°¨»óÆò/¸®ºä)ºÎºĞ ÀüÃ³¸® ÀÛ¾÷
movie_df$content

library(stringr)

str_extract_all(movie_df$content,'\n|\r|\t')
movie_df$content <- str_replace_all(movie_df$content,'\n|\r|\t',' ')

str_extract_all(movie_df$content,'[¤¡-¤¾¤¿-¤Ó\\.!?,^><_;:~/)*(&\\-]')
movie_df$content <- str_replace_all(movie_df$content,'[¤¡-¤¾¤¿-¤Ó\\.!?,^><_;:~/)*(&\\-]',' ')

movie_df$content <- str_squish(movie_df$content)
movie_df$content

# ¸í»ç¸¸ ÃßÃâ
library(KoNLP)
useNIADic()
unlist(str_match_all(a[[1]],'(\\w+)/NC')[,2])
a <- sapply(SimplePos22(movie_df$content),function(x) paste(unlist(x),collapse = ' '))
movie_df$noun <- sapply(str_match_all(a,'(\\w+)/NC'),function(x) paste(unique(unlist(x)[,2][str_length(x[,2])>=2]),collapse = ' '))
View(movie_df)

movie_df$evaluation <- ifelse(movie_df$rating>=9,'¾ÆÁÖÀç¹ÌÀÖ´Ù',ifelse(movie_df$rating>=7,'Àç¹ÌÀÖ´Ù',ifelse(movie_df$rating>=5,'º¸Åë',ifelse(movie_df$rating>=3,'Àç¹Ì¾ø´Ù','¾ÆÁÖÀç¹Ì¾ø´Ù'))))
View(movie_df)

x1 <- movie_df[movie_df$evaluation=='¾ÆÁÖÀç¹ÌÀÖ´Ù','noun']
x2 <- movie_df[movie_df$evaluation=='Àç¹ÌÀÖ´Ù','noun']
x3 <- movie_df[movie_df$evaluation=='º¸Åë','noun']
x4 <- movie_df[movie_df$evaluation=='Àç¹Ì¾ø´Ù','noun']
x5 <- movie_df[movie_df$evaluation=='¾ÆÁÖÀç¹Ì¾ø´Ù','noun']

x1_df <- data.frame(table(str_split(paste(x1,collapse = ' '),' ')))
x2_df <- data.frame(table(str_split(paste(x2,collapse = ' '),' ')))
x3_df <- data.frame(table(str_split(paste(x3,collapse = ' '),' ')))
x4_df <- data.frame(table(str_split(paste(x4,collapse = ' '),' ')))
x5_df <- data.frame(table(str_split(paste(x5,collapse = ' '),' ')))

names(x1_df) <- c('word','freq')
names(x2_df) <- c('word','freq')
names(x3_df) <- c('word','freq')
names(x4_df) <- c('word','freq')
names(x5_df) <- c('word','freq')

x1_df$sentiment <- '¾ÆÁÖÀç¹ÌÀÖ´Ù'
x2_df$sentiment <- 'Àç¹ÌÀÖ´Ù'
x3_df$sentiment <- 'º¸Åë'
x4_df$sentiment <- 'Àç¹Ì¾ø´Ù.'
x5_df$sentiment <- '¾ÆÁÖÀç¹Ì¾ø´Ù'

df <- rbind(x1_df,x2_df,x3_df,x4_df,x5_df)
df

library(reshape2)
df <- reshape2::acast(df,word~sentiment,value.var = 'freq',fill=0)

library(wordcloud)
windows(width=10,height=10)
wordcloud::comparison.cloud(df)
