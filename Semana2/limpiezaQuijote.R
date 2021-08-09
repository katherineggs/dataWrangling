
# Limpiar e importar textos .TXT

text_file <- "data/quijote.txt"

readLines(text_file, n=10)
?readLines # para saber que tiene la libreria

readLines(text_file, n=10, encoding = "UTF-8", skipNul = TRUE)
# utf-8 para tildes y así
# skipNul para ignorar las lineas en blanco

install.packages("readr")
library(readr)

quijoteLines <- read_lines(text_file)
str(quijoteLines)

substr(quijoteLines, 1, 150)  

read_lines(text_file, n_max = 20)  

install.packages("tidytext")  
install.packages("tidyverse")  

library(tidytext)
library(tidyverse)

quijoteFrame <- data_frame(txt = quijoteLines)
quijoteTibble <- tibble(txt = quijoteLines)

#cuales son las palabras mas utilizadas en este archivo de texto

quijoteWords <- unnest_tokens(quijoteFrame, output = word, input = txt, token = "words")
view(quijoteWords)

quijoteCount <- count(quijoteWords, word, sort = TRUE)
view(quijoteCount)

install.packages("quanteda")  
library(quanteda)

spanishStopWords <- data_frame(word=quanteda::stopwords(language = "es"))

quijoteWordsClean <- anti_join(quijoteWords, spanishStopWords)
quijoteCountClean <- count(quijoteWordsClean, word, sort = TRUE)

view(quijoteCountClean)
