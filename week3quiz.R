library(data.table)
if (!file.exists('data')){dir.create('data')}
#bajar CSV
#https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD
#############################################################
###QUIZ 1
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileurl, destfile = "./data/week3quiz_1.csv", method="curl")
list.files("./data")
datedownloaded <- date()
datedownloaded
data <- read.csv("./data/week3quiz_1.csv", sep = ",", header = TRUE)
agricultureLogical <- data$ACR ==3 & data$AGS == 6
head(which(agricultureLogical), 3)

# [1] 125 238 262

######################################################
### QUIZ 2
########3
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(fileurl, destfile = "./data/jeff.jpg", mode='wb')
picture <- jpeg::readJPEG('./data/jeff.jpg', native=TRUE)
quantile(picture, probs = c(0.3, 0.8) )

#    30%       80% 
# -15258512 -10575416 

##################################################
##### QUIZ 3
#########
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(fileurl, destfile = "./data/GDP.csv", method="curl")
#list.files("./data")
#datedownloaded <- date()
#datedownloaded
data <- read.csv("./data/GDP.csv", sep = ",", header = TRUE)
FGDP <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip=4
                          , nrows = 190
                          , select = c(1, 2, 4, 5)
                          , col.names=c("CountryCode", "Rank", "Economy", "Total")
)
FEDSTATS_Country <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
mergedDT <- merge(FGDP, FEDSTATS_Country, by = 'CountryCode')
# How many of the IDs match?
nrow(mergedDT)
## 189
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
mergedDT[order(-Rank)][13,.(Economy)]

# Answer: 

#                Economy
# 1: St. Kitts and Nevis
####################################################################
###QUIZ 4
######
# "High income: OECD" 
mergedDT[`Income Group` == "High income: OECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]

# Answer:
#
#         Income Group     Rank
# 1: High income: OECD 32.96667

# "High income: nonOECD"
mergedDT[`Income Group` == "High income: nonOECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]

# Answer
#            Income Group     Rank
# 1: High income: nonOECD 91.91304
#####################################################################
###QUIZ 5
####
library('dplyr')

breaks <- quantile(mergedDT[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
mergedDT$quantileGDP <- cut(mergedDT[, Rank], breaks = breaks)
mergedDT[`Income Group` == "Lower middle income", .N, by = c("Income Group", "quantileGDP")]
# Answer 
#           Income Group quantileGDP  N
# 1: Lower middle income (38.6,76.2] 13
# 2: Lower middle income   (114,152]  9
# 3: Lower middle income   (152,190] 16
# 4: Lower middle income  (76.2,114] 11
# 5: Lower middle income    (1,38.6]  5

