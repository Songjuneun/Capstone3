install.packages("KoNLP")
install.packages("wordcloud")
install.packages("ggplot2")
install.packages("tm")  
install.packages("SnowballC") # for text stemming(어근추출)

# library(SnowballC) #stemDocument어근추출위해
# library(tm)
library(dplyr)
library(RMySQL)
library(wordcloud)
library(RColorBrewer)
library(KoNLP)
library(ggplot2)

con <- dbConnect(MySQL(), 
                 dbname="capstonedb", 
                 user = "root", 
                 password="rootpass")

dbGetQuery(con,"set names euckr")
sql = "select pass_answer from passInfo where pass_gno = 1 and pass_company = '롯데'"
rows <- dbGetQuery(con, sql)
rows

# 명사추출
data <- sapply(rows, extractNoun, USE.NAMES = F)
pword <- unlist(data)
pword 

wordcount <- table(pword)
wordcount_top <- head(sort(wordcount, decreasing = T), 200)
wordcount_top
wordcloud(names(wordcount_top), wordcount_top)

# 단어 사전에 넣어주기
# mergeUSerDic(data.frame(c("노잼", "ncn")))

#전처리 filter, 2글자 이상의 단어만 걸러주는 함수
pword <- Filter(function(x){nchar(x)>=2}, pword)

#★★불용어(의미가 없는 단어) gsub(찾을 단어, 바꿀 단어, 찾을 곳)
pword <- str_trim(pword)
pword <- gsub(" ","",pword)
pword<- gsub('[~!@#$%&*()_+=?<>]','',pword)
pword <- gsub("\\‘","",pword)
pword <- gsub("\\“","",pword)
pword <- gsub("\\”","",pword)
pword <- gsub("\\’","",pword)
pword <- gsub("\\.","",pword)
pword <- gsub("\\[","",pword)
#pword <- gsub('[ㄱ-ㅎ]', '', pword)
#pword <- gsub('(ㅜ|ㅠ)코', '', pword)
pword <- gsub("\\d+", "", pword)  #숫자
pword <- gsub("는", "", pword)
pword <- gsub("은", "", pword)
pword <- gsub("에서", "", pword)
pword <- gsub("에", "", pword)
#pword <- gsub("이", "", pword)
pword <- gsub("를", "", pword)
pword <- gsub("을", "", pword)
pword <- gsub("\\s것", "", pword)
pword <- gsub("하자", "", pword)
pword <- gsub("관련", "", pword)
pword <- gsub("온", "", pword)
pword <- gsub("라는", "", pword)
pword <- gsub("때문", "", pword)
pword <- gsub("그럴", "", pword)
pword <- gsub("거야", "", pword)
pword <- gsub("개의", "", pword)
pword <- gsub("해서", "", pword)
pword <- gsub("드림", "", pword)
pword <- gsub("이라고", "", pword)
#pword = gsub("박열\\s*", "박열", pword)  #"박열~"이라는 말 -> 박열pword

# 추출한 명사 list를 문자열 벡터로 변환
wordc <- table(pword)
wordc

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordc, decreasing=T,  stringAsFactors = F)
df_word
top100 <- df_word %>% arrange(desc(Freq)) %>% head(100)

nrow(top100)

# 100번 반복
pcompany <- rep('롯데', times = nrow(top100))
pcompany
top100$pcompany <- pcompany
top100


# 워드 클라우드 생성
display.brewer.all()  # 전체 제공하는 색깔을 보기 위해서 
color <- brewer.pal(9,"Set2")
wordcloud(names(wordc), wordc,  random.order = TRUE,  random.color = FALSE, colors = color, family = "font")

#삽입할 테이블의 필드명 지정(동일할 경우 시행x)
#names(top100) <- c('pword','Freq','pcompany')

# 인코딩 방법 예시
#top100 <- iconv(as.character(top100), "CP949", "UTF-8") 
#top100 <- iconv(as.character(top100), from='UTF-8')
#top100 <- enc2utf8(top100)


# insert db
dbWriteTable(con, "dInfo",
             top100, overwirte=F, append=T,
             row.names =F)
dbCommit(con)
