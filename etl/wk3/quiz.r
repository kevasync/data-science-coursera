library(dplyr)

#1
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "idahoHousingData.csv")
idahoHousingData = tbl_cube(read_csv("idahoHousingData.csv"))
meetsCriteria = mutate(idahoHousingData, x = AGS == 6 & ACR == 3) %>% select(x)
head(which(meetsCriteria$x), 3)