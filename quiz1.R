library(data.table)
if (!file.exists('data')){dir.create('data')}
#bajar CSV
#https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD
fileurl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(fileurl, destfile = "./data/cameras.csv", method="curl")
list.files("./data")
datedownloaded <- date()
datedownloaded
cameradata <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
# Se puede usar read.csv default sep and header
cameradata <-  read.csv("./data/cameras.csv")
## Bajar y leer Excell files
# URL para excell
#https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true
#https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true&delimiter=;
fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileurl, destfile = "./data/cameras.xlsx", method = "curl")
#install.packages("xlsx")
# install.packages("XLConnect")
library(XLConnect)
library(xlsx)
cameradata <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameradata)
# leer algunas filas y columnas Usar fread para esto
colindex <- 2:3
rowindex <- 1:4
cameradatasubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, colIndex = colindex, rowIndex = rowindex, header = TRUE)
cameradatasubset
##########################################################
#111111111111111111111111111111111
install.packages("curl")

library(data.table)
housing <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# VAL attribute says how much property is worth, .N is the number of rows
# VAL == 24 means more than $1,000,000
housing[VAL == 24, .N]

# Answer: 
# 53
###########################################
#2222222222222222222222222222222
#Tidy data one variable per column
###################################
#333333333333333333333333333333333
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = paste0(getwd(), '/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'), method = "curl")

dat <- xlsx::read.xlsx(file = "getdata%2Fdata%2FDATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# Answer:
# 36534720


#######################################
#4444444444444444444444444444444444444
install.packages("XML")
library("XML")
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- XML::xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- XML::xmlRoot(doc)

zipcodes <- XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)
xmlZipcodeDT <- data.table::data.table(zipcode = zipcodes)
xmlZipcodeDT[zipcode == "21231", .N]
###########################################
#5555555555555555555555555555555555555555555555
DT <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

# Answer (fastest):
system.time(DT[,mean(pwgtp15),by=SEX])
#########################################

