#1
csvFileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(csvFileUrl, 'americanCommunitySurvey.csv', 'curl')
d = read.csv('americanCommunitySurvey.csv')
length(which(d$VAL == "24"))

#2 contains more than one datum in the column

#3
excelFileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
download.file(excelFileUrl, 'natruralGasAquisitionProgram.xlsx', 'curl')
xl = read.xlsx('natruralGasAquisitionProgram.xlsx', sheetIndex = 1, header = TRUE)
dat = xl[18:23, 7:15]
sum(dat$Zip*dat$Ext,na.rm=T)

#4
xmlFileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
download.file(xmlFileUrl, 'resterauntdata.xml', 'curl')
xdoc  = xmlTreeParse('resterauntdata.xml', useInternal = TRUE)
root = xmlRoot(xdoc)
xf = xmlToDataFrame(root[[1]])
length(which(xf$zipcode == 21231))

#q5: F