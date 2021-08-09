#FORMAS DE CARGAR ARCHIVOS

install.packages("readxl")
library(readxl)
library(readr)

### Archivos txt

text_file <- "data/quijote.txt"
readLines(text_file, n=10, encoding = "UTF-8", skipNul = TRUE)

quijoteLines <- read_lines(text_file)
str(quijoteLines)


### Archivos CSVs

horas <- read_csv("data/hour.csv")
view(horas)

read_delim("data/hour.csv", delim = ";") # para delimitar el csv ; en vez de , etc...

### Archivos de Excel

bancosActivos <- read_excel("data/bancos.xlsx")
bancosAgencias <- read_excel("data/bancos.xlsx", sheet=2)
bancosAgencias

