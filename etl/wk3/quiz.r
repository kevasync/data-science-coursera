library(dplyr)
library(jpeg)
library(tidyr)

#1 Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical)
# What are the first 3 values that result?
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "idahoHousingData.csv")
idahoHousingData = tbl_cube(read_csv("idahoHousingData.csv"))
meetsCriteria = mutate(idahoHousingData, x = AGS == 6 & ACR == 3) %>% select(x)
head(which(meetsCriteria$x), 3)

#2 Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "instructorPic.jpg")
pic = readJPEG("instructorPic.jpg", native = T)
c(quantile(pic, probs = .30), quantile(pic, probs = .80))

#3 Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "gdpData.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "eduData.csv")
eduData = read_csv("eduData.csv")
gdpData = read_csv("gdpData.csv")
cleanedEduData = mutate(eduData, Name = `Long Name` ) %>% select (CountryCode, Name, `Income Group`)
cleanedGdpData = mutate(gdpData, CountryCode = X1, GDP = as.numeric(`Gross domestic product 2012`)) %>% filter(!is.na(CountryCode) & !is.na(GDP)) %>% select(CountryCode, GDP)
joined = inner_join(cleanedEduData, cleanedGdpData) %>% arrange(desc(GDP))
c(dim(joined)[1], joined$Name[13])

#4 What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
cleanedGdpData = mutate(gdpData, CountryCode = X1, GDP = as.numeric(`Gross domestic product 2012`)) %>% filter(!is.na(GDP)) %>% select(CountryCode, GDP)
cleanedEduData = mutate(eduData, Name = `Long Name` ) %>% select (CountryCode, Name, `Income Group`)
joined = inner_join(cleanedEduData, cleanedGdpData) %>% arrange(desc(GDP))
gdpByIncomeGroup = group_by(joined, `Income Group`)
aggregatedData = summarize(gdpByIncomeGroup, mean(GDP))
c(aggregatedData[2:1, 2]) #High income: OECD is row 2, High income: nonOECD 1

#5
#Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
as.numeric(summarize(filter(gdpByIncomeGroup, GDP <= 38), length(GDP))[3, 2]) #row 3 is lower middle income