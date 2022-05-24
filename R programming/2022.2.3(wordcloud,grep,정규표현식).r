install.packages('wordcloud')
library(wordcloud)

word <- c('°Ç°­','Ãë¾÷','ºñÀü','Èñ¸Á','ºñÀü','°øºÎ','¿­Á¤','Çàº¹','°áÈ¥','¼îÇÎ','ÁÖ½Ä','·Î¶Ç')
freq <- c(100,200,300,340,500,300,200,100,50,250,350,20)
length(word)
length(freq)

wordcloud(word,freq,colors = rainbow(length(word)),
          random.order = F, # T´Â ·£´ı¹èÄ¡, F´Â ºóµµ¼ö°¡ Å« ´Ü¾î¸¦ Áß¾Ó¿¡ ¹èÄ¡
          scale = c(5,2), # Å©±â Á¤ÇÏ±â
          min.freq = 300, #300ÀÌ»ó¸¸ Ãâ·Â 
          max.words = 100) #´Ü¾î ¼ö¸¦ Á¶Á¤


[¹®Á¦182] °ø¹é¹®ÀÚ¸¦ ±âÁØÀ¸·Î ºĞ¸® ÇÑ ÈÄ ´Ü¾îÀÇ ºóµµ¼ö¸¦ ±¸ÇÏ°í wordcloud¸¦ ÀÌ¿ëÇØ¼­ ½Ã°¢È­ ÇØÁÖ¼¼¿ä.
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

#_------------------------------------ °­»ç´Ô
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

¡Ú grep
- µ¿ÀÏÇÑ ¹®ÀÚ¿­À» º¤ÅÍ¿¡¼­ Ã£¾Æ¼­ ÀÎµ¦½º¹øÈ£, ¹®ÀÚ¿­À» ¸®ÅÏÇÏ´Â ÇÔ¼ö

text <- c('a','ab','acb','accb','acccb','accccb')
'a' %in% text
text %in% 'a'
text[text %in% 'a']
text[which(text %in% 'a')]

grep('a',text)
grep('ab',text)
grep('acb',text)
text[grep('c',text)]
grep('c',text,value=T) # value=T c¶ó´Â ±ÛÀÚ°¡ ÀÖ´Â ÀÎµ¦½º¸¦ Ã£¾Æ¼­ ´Ü¾î¸¦ º¸¿©ÁÜ

¡Ú Á¤±ÔÇ¥Çö½Ä(Regular Expression)

* -> Àû¾îµµ 0¹ø ÀÌ»óÀÇ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ac*b',text,value=T) #ab´Â ¹«Á¶°Ç ÀÖ´Âµ¥ c´Â ¿Ã ¼öµµ ÀÖ°í ¾È ¿Ã¼öµµ ÀÖ´Ù

+ -> Àû¾îµµ 1¹ø ÀÌ»óÀÇ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ac+b',text,value=T)

? -> 0¹ø ¶Ç´Â 1¹øÀÇ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ac?b',text,value=T)

{n} -> n¹øÀÇ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ac{2}b',text,value=T)
grep('ac{0}b',text,value=T)
grep('ac{3}b',text,value=T)

{n,} -> n¹ø ÀÌ»óÀÇ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ac{2,}b',text,value=T)

{n,m} -> n¹øºÎÅÍ m¹ø±îÁöÀÇ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ac{2,3}b',text,value=T)

text <- c('abcd','cdab','cabd','c abd')
grep('ab',text,value=T)

^ -> ½ÃÀÛ, ½ÃÀÛµÇ´Â ¹®ÀÚ¸¦ Ã£´Â´Ù.
grep('^ab',text,value=T)

$ -> ³¡, ³¡³ª´Â ¹®ÀÚ¸¦ Ã£´Â´Ù.
grep('ab$',text,value=T)

\\b -> ½ÃÀÛµÇ´Â ¹®ÀÚ¸¦ Ã£´Âµ¥ ºó¹®ÀÚ¿­ µÚ¿¡ ½ÃÀÛµÇ´Â ¹®ÀÚµµ Ã£´Â´Ù.
grep('\\bab',text,value=T)

text <- c('^ab','ab','abc','abd','abe','ab 12','$ab','ca^bd','ab','abcd','abcfd','abfd')

\\*,\\+,\\?,\\^,\\$ -> ¼ø¼öÇÑ ¹®ÀÚ·Î Ç¥ÇöÇÒ ¶§ »ç¿ë
grep('\\^ab',text,value=T)  #¹®ÀÚÀÇ ÀÇ¹Ì·Î ^¸¦ Ã£À»¶§ \\¸¦ »ç¿ë

. -> ¾î¶² ¹®ÀÚ ÇÏ³ª¸¦ ÀÇ¹ÌÇÑ´Ù.
grep('.',text,value=T)
grep('ab.',text,value=T) # ab. Á¡Àº ÀÌ»óÀÇ ÀÇ¹Ì
grep('ab..',text,value=T) # ab.. abÆ÷ÇÔ 4±ÛÀÚ ÀÌ»ó
grep('ab...',text,value=T) # ab... abÆ÷ÇÔ 5±ÛÀÚ ÀÌ»ó

grep('abc',text,value=T)
grep('^abc$',text,value=T)

grep('abc',text,value=T)

[...] -> ¸®½ºÆ® ¾È¿¡ ÀÖ´Â ¹®ÀÚÆĞÅÏÀ» Ã£´Â´Ù.
grep('ab[c,d]',text,value=T) # ab´ÙÀ½¿¡ c ¶Ç´Â d°¡ ÀÖ´Â °ªÀ» Ã£°Ú´Ù.


[n-m] -> ¸®½ºÆ® ¾È¿¡ nºÎÅÍ m±îÁö ¹®ÀÚ ÆĞÅÏÀ» Ã£´Â´Ù.
grep('ab[c-e]',text,value=T)

[^] -> ¸®½ºÆ® ¾È¿¡ ÀÖ´Â ^´Â notÀ» ÀÇ¹ÌÇÑ´Ù.
grep('ab[^c]', text,value=T) # abµÚ¿¡ c°¡ ¾Æ´Ñ °ª¸¸ ÃßÃâ

grep('ab[^c,d,e]',text,value=T) # abµÚ¿¡ c,d,e°¡ ³ª¿ÀÁö ¾Ê´Â °ª¸¸ ÃßÃâ

text <- c('sql','SQL','Sql100','PLSQL','plsql','R','r','r0','python','PYTHON','pyth0n',
          'python#','100','*100','*','$','^','!','@','#','$','%','(',')','~','?','Çàº¹',
          '¤»¤»¤»¤»','¤Ì¤Ì¤Ì¤Ì')
text

# ¼ıÀÚ¸¦ Ã£´Â ¹æ¹ı
grep('[0-9]',text,value=T)
grep('\\d',text,value=T)
grep('[[:digit:]]',text,value=T)

# ´ë¹®ÀÚ¸¦ Ã£´Â ¹æ¹ı
grep('[A-Z]',text,value=T)
grep('[[:upper:]]',text,value=T)

# ¼Ò¹®ÀÚ¸¦ Ã£´Â ¹æ¹ı
grep('[a-z]',text,value=T)
grep('[[:lower:]]',text,value=T)

# ´ë¼Ò¹®ÀÚ ´Ù Ã£±â
grep('[A-Za-z]',text,value=T)
grep('[A-z]',text,value=T) # Æ¯¼ö¹®ÀÚ ^Æ÷ÇÔÇØ¼­ Ã£´Â´Ù.
grep('[A-Za-z\\^]',text,value=T)# Æ¯¼ö¹®ÀÚ ^Æ÷ÇÔÇØ¼­ Ã£´Â´Ù.

# ÇÑ±ÛÀ» Ã£´Â´Ù
grep('[°¡-ÆR]',text,value=T)
grep('[¤¡-¤Ó]',text,value=T) # ÀÚÀ½ºÎÅÍ ¸ğÀ½¸¸ ÃßÃâ
grep('[°¡-ÆR¤¡-¤Ó]',text,value=T)

grep('[A-Za-z°¡-ÆR¤¡-¤Ó]',text,value=T)
grep('[[:alpha:]]',text,value=T)

# ¹®ÀÚ, ¼ıÀÚ°¡ ÀÖ´Â ¹®ÀÚ ÆĞÅÏÀ» Ã£´Â ¹æ¹ı
grep('[A-Za-z°¡-ÆR¤¡-¤Ó0-9]',text,value=T)
grep('[[:alnum:]]',text,value=T)
grep('\\w',text,value=T)

# Æ¯¼ö¹®ÀÚ°¡ ÀÖ´Â ¹®ÀÚ ÆĞÅÏÀ» Ã£´Â ¹æ¹ı
grep('\\W',text,value=T)
grep('[[:punct:]]',text,value=T)

# ¼ıÀÚÁ¦¿Ü
grep('[^0-9]',text,value=T) # ¼ıÀÚ¸¸ µé¾îÀÖ´Â °ªµé Á¦¿Ü , ¹®ÀÚ+¼ıÀÚ´Â ÃßÃâµÊ
grep('\\D',text,value=T)
grep('[^[:digit:]]',text,value=T)

employees <- read.csv('c:/data/employees.csv',header=T)
employees[employees$FIRST_NAME=='Steven','FIRST_NAME']
employees[employees$FIRST_NAME=='Stephen','FIRST_NAME']

grep('Steven',employees$FIRST_NAME,value=T)
grep('Stephen',employees$FIRST_NAME,value=T)

| -> ¶Ç´Â ÀÇ¹Ì
grep('Steven|Stephen',employees$FIRST_NAME,value=T)
name <- c('Steven','Stephen')
grep(name,employees$FIRST_NAME,value=T)

grep(paste(name,collapse='|'),employees$FIRST_NAME,value=T)

(±ÛÀÚ1|±ÛÀÚ2) -> ±ÛÀÚ1 ¶Ç´Â ±ÛÀÚ2ÀÇ ¹®ÀÚÆĞÅÏÀ» Ã£´Â ¹æ¹ı
grep('Ste(v|ph)en',employees$FIRST_NAME,value=T)


data <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity;[9] as of January 2021, R ranks 9th in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] the official R software environment is written primarily in C, Fortran, and R itself[12] (thus, it is partially self-hosting) and is freely available under the GNU General Public License. Pre-compiled executables are provided for various operating systems. Although R has a command line interface, there are several third-party graphical user interfaces, such as RStudio, an integrated development environment, and Jupyter, a notebook interface.[13][14]"

data <- strsplit(data,split=' ')
data <- data.frame(table(data))
data <- data[,-2]

x <- unlist(strsplit(data,split=' '))
x
[¹®Á¦183] Ã¹¹®ÀÚ°¡ ´ë¹®ÀÚ·Î ½ÃÀÛµÇ´Â ´Ü¾î¸¦ Ã£À¸¼¼¿ä.

data[grep('[A-Z]',substr(data,1,1))]

#----------°­»ç´Ô
grep('^[A-Z]{1,}',x,value=T)
grep('^[[:upper:]]{1,}',x,value=T)

[¹®Á¦184] ¼ıÀÚ°¡ ÀÖ´Â ´Ü¾î¸¦ Ã£¾ÆÁÖ¼¼¿ä.

grep('\\d',data,value=T)
grep('[[:digit:]]',data,value=T)
grep('[0-9]',data,value=T)

[¹®Á¦185] Æ¯¼ö¹®ÀÚ°¡ ÀÖ´Â ´Ü¾î¸¦ Ã£¾ÆÁÖ¼¼¿ä.

grep('\\W',data,value=T)
grep('[[:punct:]]',data,value=T)

[¹®Á¦186] [¼ıÀÚ]°¡ ÀÖ´Â ´Ü¾î¸¦ Ã£¾ÆÁÖ¼¼¿ä.
grep('\\[\\d+\\]',data,value=T)
grep('\\[\\d{1,}\\]',data,value=T)


#----------------------------------------------

text <- c('sql','SQL','Sql100','PLSQL','plsql','R','r','r0','python','PYTHON','pyth0n',
          'python#','100','*100','*','$','^','!','@','#','$','%','(',')','~','?','Çàº¹',
          '¤»¤»¤»¤»','¤Ì¤Ì¤Ì¤Ì')
text
library(stringr)
text %in% 'SQL'

grep('SQL',text,value=T)

#str_detect : Æ¯Á¤ÇÑ ¹®ÀÚ°¡ ÀÖ´ÂÁö °Ë»çÇØ¼­ TRUE,FALSE¸¦ ¸®ÅÏÇÏ´Â ÇÔ¼ö
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

# str_count : ÁÖ¾îÁø ´Ü¾î¿¡¼­ ÇØ´ç ±ÛÀÚ°¡ ¸î¹ø ³ª¿À´ÂÁö¸¦ ¸®ÅÏÇÏ´Â ÇÔ¼ö
str_count(text,'s')
str_count(text,'S')
str_count(text,'sql')

# str_c : ¹®ÀÚ¿­À» ÇÕÃÄ¼­ Ãâ·ÂÇÏ´Â ÇÔ¼ö
paste('R','ºòµ¥ÀÌÅÍºĞ¼®')
paste('R','ºòµ¥ÀÌÅÍºĞ¼®',sep='')
paste0('R','ºòµ¥ÀÌÅÍºĞ¼®')
str_c('R','ºòµ¥ÀÌÅÍºĞ¼®')

paste('R','ºòµ¥ÀÌÅÍºĞ¼®',sep=',')
str_c('R','ºòµ¥ÀÌÅÍºĞ¼®',sep=',')
x <- c('R','ºòµ¥ÀÌÅÍºĞ¼®')
x
paste(x[1],x[2],sep=' ') # sep=' ' ±âº»°ª
str_c(x[1],x[2],sep='') # sep='' ±âº»°ª

paste(x,collapse= ' ')
str_c(x,collapse= ' ')

# str_dup : ÁÖ¾îÁø ¹®ÀÚ¿­À» ÁÖ¾îÁø È½¼ö¸¸Å­ ¹İº¹ÇØ¼­ Ãâ·ÂÇÏ´Â ÇÔ¼ö
str_dup('ÆÄµµ ¼Ò¸® µ¸°í ½Í´Ù.',10)

# str_length : ÁÖ¾îÁø ¹®ÀÚ¿­ÀÇ ±æÀÌ¸¦ ¸®ÅÏÇÏ´Â ÇÔ¼ö
nchar('ÇØ¿î´ë °¡°í ½Í´Ù')
str_length('ÇØ¿î´ë °¡°í ½Í´Ù')

# str_locate : ÁÖ¾îÁø ¹®ÀÚ¿­¿¡¼­ Æ¯Á¤ÇÑ ¹®ÀÚ°¡ Ã³À½À¸·Î ³ª¿À´Â À§Ä¡¸¦ ¸®ÅÏÇÏ´Â ÇÔ¼ö
str_locate('january','an')

# str_locate_all : ÁÖ¾îÁø ¹®ÀÚ¿­¿¡¼­ Æ¯Á¤ÇÑ ¹®ÀÚ°¡ ³ª¿À´Â ¸ğµç À§Ä¡¸¦ ¸®ÅÏÇÏ´Â ÇÔ¼ö
str_locate_all('january','a')
str_locate_all('january','a')[[1]][1]
str_locate_all('january','a')[[1]][2]

str_locate_all('january','a')[[1]][1,][1]
str_locate_all('january','a')[[1]][2,][1]

# str_replace : ÁÖ¾îÁø ¹®ÀÚ¿­¿¡¼­ ¹®ÀÚ¸¦ »õ·Î¿î ¹®ÀÚ·Î ¹Ù²Ù´Â ÇÔ¼ö, Ã¹¹øÂ° ÀÏÄ¡ÇÏ´Â ¹®ÀÚ¸¸ ¹Ù²Û´Ù.
sub('a','*','banana')
str_replace('banana','a','*')

# str_replace_all : ÁÖ¾îÁø ¹®ÀÚ¿­¿¡¼­ ¹®ÀÚ¸¦ »õ·Î¿î ¹®ÀÚ·Î ¹Ù²Ù´Â ÇÔ¼ö, ÀÏÄ¡ÇÏ´Â ¸ğµç ¹®ÀÚ¸¦ ¹Ù²Û´Ù.
gsub('a','*','banana')
str_replace_all('banana','a','*')

# str_split : ÁÖ¾îÁø ¹®ÀÚ¿­¿¡¼­ ÁöÁ¤µÈ ¹®ÀÚ¸¦ ±âÁØÀ¸·Î ºĞ¸®ÇÏ´Â ÇÔ¼ö
strsplit('R,Developer',split=',')
str_split('R,Developer',',')

strsplit('R Developer',split=' ')
str_split('R Developer',' ')

# str_sub :  ÁÖ¾îÁø ¹®ÀÚ¿­¿¡¼­ ÁöÁ¤µÈ ½ÃÀÛÀÎµ¦½ººÎÅÍ ³¡ÀÎµ¦½º±îÁö ¹®ÀÚ¸¦ ÃßÃâÇÏ´Â ÇÔ¼ö
substr('RDeveloper',1,1)
str_sub('RDeveloper',1,1)
str_sub('RDeveloper',start=1,end=1)
str_sub('RDeveloper',start=1,end=5)

substr('RDeveloper',2,nchar('RDeveloper')) # ½ÃÀÛ°ú ³¡À» ÇÊ¼öÀûÀ¸·Î Àû¾î¾ßÇÔ
substring('RDeveloper',2)
str_sub('RDeveloper',start=2) # ½ÃÀÛÁ¡¸¸ Àû¾îµµ ÃßÃâµÊ

# ¹®ÀÚ¿­¿¡¼­ µÚ¿¡ ±ÛÀÚ¸¦ ÃßÃâÇÏ´Â ¹æ¹ı
substr('RDeveloper',nchar('RDeveloper')-1,nchar('RDeveloper'))
str_sub('RDeveloper',start=-2)

# str_trim : Á¢µÎ, Á¢¹ÌºÎºĞ¿¡ ¿¬¼ÓµÇ´Â °ø¹é¹®ÀÚ¸¦ Á¦°ÅÇÏ´Â ÇÔ¼ö
str_trim('    R      ')
nchar('    R     ')
str_length('    R     ')
str_length(str_trim('    R      '))
str_trim('   R    ',side='both') # side = 'both' ±âº»°ª
str_trim('   R    ',side='left')
str_trim('   R    ',side='right')
trimws('   R    ')


text <- c('sql','SQL','Sql100','PLSQL','plsql','R','r','r0','python','PYTHON','pyth0n',
          'python#','100','*100','*','$','^','!','@','#','$','%','(',')','~','?','Çàº¹',
          '¤»¤»¤»¤»','¤Ì¤Ì¤Ì¤Ì')

grep('[[:digit:]]',text,value=T)
text[str_detect(text,'\\d')]

# str_extract : ¹®ÀÚ¿­¿¡¼­ ÁöÁ¤µÈ ¹®ÀÚ¿­À» Ã£´Â ÇÔ¼ö
str_extract(text,'[[:digit:]]+')
str_extract(text,'[[:digit:]]{1,}')

unlist(str_extract_all(text,'[[:digit:]]{1,}'))
str_extract_all(text,'[[:digit:]]{1,}',simplify = T)

text <- 'R is programming language PYTHON is programming language'
grep('programming',text,value=T)
x <- unlist(strsplit(text,split=' '))
x
grep('programming',x,value=T)

str_extract(text,'programming') # ¹®Àå ³»¿¡¼­ ´Ü¾î¸¦ °Ë»öÇÒ ¶§´Â Ã³À½À¸·Î Ã£´Â ´Ü¾î¸¸ ÃßÃâÇÑ´Ù.
str_extract(x,'programming')
str_extract_all(text,'programming') # ¹®Àå ³»¿¡¼­ ´Ü¾î¸¦ °Ë»öÇÏ´Â ÇÔ¼ö(Ã£´Â ´Ü¾î ¸ğµÎ ÃßÃâ)


data <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity;[9] as of January 2021, R ranks 9th in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] the official R software environment is written primarily in C, Fortran, and R itself[12] (thus, it is partially self-hosting) and is freely available under the GNU General Public License. Pre-compiled executables are provided for various operating systems. Although R has a command line interface, there are several third-party graphical user interfaces, such as RStudio, an integrated development environment, and Jupyter, a notebook interface.[13][14]"

data1 <- unlist(strsplit(data,split=' '))
[¹®Á¦187] Ã¹¹®ÀÚ°¡ ´ë¹®ÀÚ·Î ½ÃÀÛµÇ´Â ´Ü¾î¸¦ Ã£À¸¼¼¿ä.
str_extract_all(data,'^[A-Z]{1,}')
str_extract_all(data,'^[[:upper:]]')
grep('^[A-Z]',data1, value=T)

#----------------------------- °­»ç´Ô
str_extract_all(data,'[[:upper:]]{1,}[[:alpha:]]{0,}')
str_extract_all(data,'[A-Z]\\w*')

[¹®Á¦188] ¼ıÀÚ¸¦ Ã£¾ÆÁÖ¼¼¿ä.
grep('\\d',unlist(strsplit(data,split=' ')),value=T)
data1[str_detect(data1,'\\d')]

str_extract_all(data,'\\d{1,}')

#----------------------------- °­»ç´Ô
str_extract_all(data,'[[:digit:]]{1,}')
str_extract_all(data,'\\d+')

[¹®Á¦189] ¼ıÀÚ ¾Õ°ú µÚ¿¡ ÀÖ´Â ¹®ÀÚµµ Ã£¾ÆÁÖ¼¼¿ä.

str_extract_all(data,'[[:alpha:]]{0,}[[:digit:]]{1,}[[alpha:]]{0,}')
str_extract_all(data,'\\w*\\d+\\w*')
str_extract_all(data,'\\w{0,}\\d+\\w{0,}')

[¹®Á¦190] °ü»ç a, A, the, The ÇÔ²² »ç¿ëµÇ´Â ´Ü¾îÀ» Ãâ·ÂÇØÁÖ¼¼¿ä.

str_extract_all(data,'a [a-z]')

#----------------------°­»ç´Ô
str_extract_all(data,'(a|A|the|The) [[:alpha:]]{1,}')
str_extract_all(data,'(a|A|the|The) \\w+')
str_extract_all(data,'(a|A|the|The)\\s\\w+') # \\s : °ø¹é¹®ÀÚ
str_extract_all(data,'(a|A|the|The)[[:space:]]\\w+') # [[:space:]] : °ø¹é¹®ÀÚ


[¹®Á¦191] ¼ıÀÚ ¾Õ°ú µÚ¿¡ ÀÖ´Â ¹®ÀÚ ¶Ç´Â ¼ıÀÚµéÀº ÀüºÎ °ø¹é¹®ÀÚ·Î ¼öÁ¤ÇÑ ÈÄ text1 º¯¼ö¿¡ ÀúÀåÇÏ¼¼¿ä.
str_replace_all(data,'.\\d{1,}.')

#----------------------°­»ç´Ô
str_extract_all(data,'\\w{0,}\\d+\\w{0,}')
text1 <- str_replace_all(data,'\\w{0,}\\d+\\w{0,}',' ')
str_extract_all(text1,'\\w{0,}\\d+\\w{0,}')

[¹®Á¦192] text1º¯¼ö¿¡ Æ¯¼ö¹®ÀÚ¸¸ Ã£¾ÆÁÖ¼¼¿ä.
str_extract_all(text1,'[[:punct:]]')
str_extract_all(text1,'\\W')

[¹®Á¦193] text1º¯¼ö¿¡ Æ¯¼ö¹®ÀÚ ¾Õ°ú µÚ¿¡ ¹®ÀÚ°¡ ÀÖ´Â ¹®ÀÚ¸¦ Ã£¾ÆÁÖ¼¼¿ä.
str_extract_all(text1,'\\w+[[:punct:]]\\w+')
#str_extract_all(text1,'\\w*[[:punct:]]\\w*')  ´Ù¸¥ Æ¯¼ö¹®ÀÚ±îÁö ´Ù ³ª¿Í¹ö¸²

[¹®Á¦194] Æ¯¼ö¹®ÀÚ ¾Õ°ú µÚ¿¡ ¹®ÀÚ°¡ ÀÖ´Â ¹®ÀÚ¸¦ Ã£¾Æ¼­ Æ¯¼ö¹®ÀÚ¸¦ Á¦°ÅÇÑ ´Ü¾î·Î º¯È¯ÇØÁÖ¼¼¿ä.
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

[¹®Á¦195] text1 º¯¼ö¿¡ ÀÖ´Â ¹®ÀåÀÇ ´Ü¾îÀÇ ºóµµ¼ö¸¦ ±¸ÇÏ¼¼¿ä.
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
[¹®Á¦196] data º¯¼ö¿¡ ÀÖ´Â ¹®Àå¿¡¼­ [¼ıÀÚ] ´ë°ıÈ£ ¾È¿¡ ÀÖ´Â ¼ıÀÚµéÀ» ÃßÃâÇØÁÖ¼¼¿ä.
str_extract_all(data,'\\[\\d+\\]')

[¹®Á¦197] data º¯¼ö¿¡ ÀÖ´Â ¹®Àå¿¡¼­ (¹®ÀÚ) °ıÈ£¾È¿¡ ÀÖ´Â ¹®ÀÚ¸¦ ÃßÃâÇØ ÁÖ¼¼¿ä.
str_extract_all(data,'\\([^)]+\\)')

[¹®Á¦198] data º¯¼ö¿¡ ÀÖ´Â ¹®Àå¿¡¼­ ÄŞ¸¶ ¾Õ¿¡ ¹®ÀÚ¿Í °°ÀÌ ÃßÃâÇØ ÁÖ¼¼¿ä
str_extract_all(data,'\\w+,')
str_extract_all(data,'\\w+\\.') # ¸¶Ä§Ç¥·Î ³¡³ª´Â ´Ü¾îµé
str_extract_all(data,'\\w+;')
str_extract_all(data,'\\w+[.,;]') # À§ ¼¼°Ô¸¦ ÇÑ¹ø¿¡ ÃßÃâ, ´ë°ıÈ£·Î Ç¥ÇöÇÒ ¶§ 
str_extract_all(data,'\\w+(\\.|,|;)') # À§ ¼¼°Ô¸¦ ÇÑ¹ø¿¡ ÃßÃâ, °ıÈ£·Î Ç¥ÇöÇÒ ¶§
