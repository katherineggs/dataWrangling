# Lab
install.packages("xlsx")

## Librerias

library(readxl)
# library(xlsx)

## Problema 1

# path
mes9 <- 01:9
mes11 <- 10:11
year <- "-2018"

list9 <- paste("0", mes9, year, sep = "")
list11 <- paste(mes11, year, sep = "")

fechas <- c(list9, list11)

mes1  <- read_excel("01-2018.xlsx")
mes1$Fecha <- fechas[1]

mes2  <- read_excel("02-2018.xlsx")
mes2$Fecha <- fechas[2]

mes3  <- read_excel("03-2018.xlsx")
mes3$Fecha <- fechas[3]

mes4  <- read_excel("04-2018.xlsx")
mes4$Fecha <- fechas[4]

mes5  <- read_excel("05-2018.xlsx")
mes5$Fecha <- fechas[5]

mes6  <- read_excel("06-2018.xlsx")
mes6$Fecha <- fechas[6]

mes7  <- read_excel("07-2018.xlsx")
mes7clean <- mes7[,1:8]
mes7clean$Fecha <- fechas[7]

mes8  <- read_excel("08-2018.xlsx")
mes8clean <- mes8[,1:8]
mes8clean$Fecha <- fechas[8]

mes9  <- read_excel("09-2018.xlsx")
mes9clean <- mes9[,1:8]
mes9clean$Fecha <- fechas[9]

mes10 <- read_excel("10-2018.xlsx")
mes10clean <- mes10[,1:8]
mes10clean$Fecha <- fechas[10]

mes11 <- read_excel("11-2018.xlsx")
mes11clean <- mes11[,1:8]
mes11clean$Fecha <- fechas[11]

unifiedData <- rbind(mes1, mes2, mes3, mes4, mes5, mes6, mes7clean, mes8clean, mes9clean, mes10clean, mes11clean)
head(unifiedData)













