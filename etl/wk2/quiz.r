#1
#appSecret='05cc7a75b042acec5702f4938a58604564d5d5d4'
#clientId='2ee37d8de0f9a7e469e6'
#myapp <- oauth_app("github", key = '2ee37d8de0f9a7e469e6', secret = '05cc7a75b042acec5702f4938a58604564d5d5d4')
#install.packages('httpuv')
#library(httpuv)
#github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
#gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/users/jtleek/repos")
#stop_for_status(req)
#content(req)

library(httr) # the gets n stuff

library(jsonlite)
j = jsonlite::fromJSON("https://api.github.com/users/jtleek/repos")
filtered = j[c('created_at', 'name')]
idx = which(filtered$name == 'datasharing')
filtered[idx,1]

#2
install.packages('sqldf')
library(sqldf)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', 'acs.csv')
acs = read.csv('acs.csv')
sqldf("select pwgtp1 from acs where AGEP < 50")

#3
sqldf("select pwgtp1 from acs where AGEP < 50")

#4
url = url('http://biostat.jhsph.edu/~jleek/contact.html')
html = readLines(url)
sapply(html[c(10,20,30,100)], stringr::str_length)

#4
url = url('http://biostat.jhsph.edu/~jleek/contact.html')
html = readLines(url)
sapply(html[c(10,20,30,100)], stringr::str_length)

#5
url = url('https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for')
data = readLines(url)
m = matrix(nr=0, nc=2)
for(i in 5:length(data)){
  forthVal = as.numeric(stringi::stri_sub(data[i], from =  29, length = 4))
  ninthVal = as.numeric(stringi::stri_sub(data[i],from =  60))
  m = rbind(m, c(forthVal, ninthVal))
}
sum(m[,1])
sum(m[,2])