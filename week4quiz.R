library(data.table)
if (!file.exists('data')){dir.create('data')}
#bajar CSV
#https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD
#############################################################
###QUIZ 1

fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileurl, destfile = "./data/week3quiz_1.csv", method="curl")
data <- read.csv("./data/week3quiz_1.csv", sep = ",", header = TRUE)
names <- names(data)
ans <- strsplit(names, 'wgtp')
ans[123]

#[[1]]
#[1] ""   "15"

######################################################
### QUIZ 2
########3

GDP <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                         , skip=5, nrows=190, select = c(1, 2, 4, 5), col.names=c("countrycode", "rank", "country", "gdp"))

GDP$gdp <- gsub(',','',GDP$gdp)
GDP$gdp <- as.integer(GDP$gdp)
mean(GDP$gdp)

# answer
#[1] 377652.4

##################################################
##### QUIZ 3
#########
grep('^United',GDP[,country])
#[1]  1  6 32

####################################################################
###QUIZ 4
######
gdpdata <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                         , skip=5, nrows=190, select = c(1, 2, 4, 5), col.names=c("countrycode", "rank", "country", "gdp")) 
edudata <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
#paso a minuscula los nombres
names(edudata) <- tolower(names(edudata))
mergeddata <- merge(gdpdata, edudata, by = 'countrycode')
ans <- grepl(pattern = 'Fiscal year end: June 30', x = mergeddata$'special notes' )
nrow(mergeddata[ans])
##[1] 13


#####################################################################
###QUIZ 5
####

#install.packages("quantmod")
library(quantmod) 
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE) 
sampleTimes = index(amzn)
length(sampleTimes)
#[1] 3486

year <- year(sampleTimes)
day <- wday(sampleTimes, label=TRUE)
ans <- data.table(sample=sampleTimes, year=year, weekdays=day)
nrow(ans[year==2012])
#[1] 250
nrow(ans[year==2012 & weekdays=='lun\\.'])
#[1] 47

