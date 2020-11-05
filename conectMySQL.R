library(data.table)
if (!file.exists('data')){dir.create('data')}
library(RMySQL)
dbcon <- dbConnect(MySQL(),user="genome",host= "genome-mysql.cse.ucsc.edu" )
result <- dbGetQuery(dbcon, "show databases;");
dbDisconnect(dbcon) # NO OLVIDAR CERRAR LA CONEXION
hg19 <- dbConnect(MySQL(),user="genome",db= "hg19",host= "genome-mysql.cse.ucsc.edu" )
alltables <- dbListTables(hg19)
length(alltables)
#alltables es una lista
alltables[1:5] #muestra las primeras 5 tablas
dbListFields(hg19, "affyU133Plus2") # ver campos de una tabla dentro de una DB
dbGetQuery(hg19, "select count(*) from affyU133Plus2") # contar las filas de la tabla 
#get de table
affydata <- dbReadTable(hg19, "affyU133Plus2")
head(affydata)
# select a subset of the DB donde la vble misMatches esta entre 1 y 3. Trae todas las columnas y las filas donde cumple
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query);quantile(affyMis$misMatches)
# sacar solo 10 records de la DB
affyMisSmall <- fetch(query, n=10)
# No olvidar cerrar la query
dbClearResult(query) #retorna TRUE si todo OK
dbDisconnect(hg19)
## RMySQL Vignette RMySQL.PDF


