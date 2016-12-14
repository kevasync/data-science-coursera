library(dplyr)
library(jpeg)
library(dplyr)

#1
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "idahoHousingData.csv")
idahoHousingData = tbl_cube(read_csv("idahoHousingData.csv"))
meetsCriteria = mutate(idahoHousingData, x = AGS == 6 & ACR == 3) %>% select(x)
head(which(meetsCriteria$x), 3)

#2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "instructorPic.jpg")
pic = readJPEG("instructorPic.jpg", native = T)
c(quantile(pic, probs = .30), quantile(pic, probs = .80))

#3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "gdpData.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "eduData.csv")
eduData = read_csv("eduData.csv")
gdpData = read_csv("gdpData.csv")
cleanedEduData = mutate(eduData, Name = `Long Name` ) %>% select (CountryCode, Name, `Income Group`)
cleanedGdpData = mutate(gdpData, CountryCode = X1, GDP = as.numeric(`Gross domestic product 2012`)) %>% filter(!is.na(CountryCode) & !is.na(GDP)) %>% select(CountryCode, GDP)
joined = inner_join(cleanedEduData, cleanedGdpData) %>% arrange(desc(GDP))
c(dim(joined)[1], joined$Name[13])

#4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "gdpData.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "eduData.csv")
eduData = read_csv("eduData.csv")
gdpData = read_csv("gdpData.csv")
cleanedGdpData = mutate(gdpData, CountryCode = X1, GDP = as.numeric(`Gross domestic product 2012`)) %>% filter(!is.na(GDP)) %>% select(CountryCode, GDP)
cleanedEduData = mutate(eduData, Name = `Long Name` ) %>% select (CountryCode, Name, `Income Group`)
joined = inner_join(cleanedEduData, cleanedGdpData) %>% arrange(desc(GDP))
gdpByIncomeGroup = group_by(joined, `Income Group`)
aggregatedData = summarize(gdpByIncomeGroup, mean(GDP))
c(aggregatedData[2:1, 2])
