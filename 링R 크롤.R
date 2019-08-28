install.packages("rvest")
install.packages("dplyr")
library(rvest)
library(dplyr)

# 지역
basic_url <- "http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&loc_mcd=4"
urls <- NULL


for(x in 4:9){
  
  urls[x] <- paste0(basic_url, '0') # 0붙여보기
  urls[x] <- paste0(basic_url, x)
  
}
for(x in 10:17){
  
  urls[x] <- paste0(basic_url, x)
  
}
urls
# read_html(urls[1])  # 코드 읽기

html_nodes(html, 'span')
html2 <- html_nodes(html, 'a')
html2

html <- read_html(urls[10])
region <- html %>% html_nodes('.job_condition') %>% html_nodes('a') %>% html_text() # unique()
region

company <- html %>% html_nodes('.area_corp') %>% html_nodes('span') %>% html_text()# 상세히 다시
company

#------------------------------------------------
html_nodes(html, '.searchCont')
html2 <- html_nodes(html, '.searchCont')
html3 <- html_nodes(html2, 'a')

links <- html_attr(html3, 'href')
links # 링크 출력