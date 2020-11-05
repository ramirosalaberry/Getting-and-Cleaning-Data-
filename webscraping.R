library(XML)
library(RCurl)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
#html2 <- getURL(url, useInternalNodes = T)
xpathSApply(html2, "//title", xmlValue)
xpathSApply(html2, "//td[@id='col-citedby']", xmlValue)

library(XML)
library(RCurl)
library(httr)
url <-"https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 <- GET(url)
content2=content(html2, as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)


