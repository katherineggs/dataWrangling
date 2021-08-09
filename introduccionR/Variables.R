## Instalar librerias

install.packages("dplyr")
install.packages("RMySQL")
install.packages("lubridate")
install.packages("openxlsx")
install.packages("stringr")
install.packages("readr")

install.packages("tidyverse")

## cargar librerias

library(dplyr)
require(dplyr)

## folder / location
getwd()
setwd("../Documents/")

## Data types and Structures in R

### String - Character
string <- "this is a string"
class(string) # clase de la variable
typeof(string)# tipo de la variable
length(string)# elementos en la variable -> 1
nchar(string) # numero de caracteres y espacios -> 16 


### Double
number <- 23334
class(number)
typeof(number)
length(number)

### Integers
integer <- 3L
class(integer)
typeof(integer)

### Logical
logical <- FALSE # tambien puede ser F
class(logical)
typeof(logical)

### Vector
vector <- c("hola", "a", "todos")
length(vector)
vector[2] # lo que este en esta posicion

### Factores
vector2 <- c("hola", "a", "todos", "como", "estan", "hola", "a", "todos", "como", "estan", "hola", "a",)
factor <- factor(vector2)

### Factores Ordenados
factor2 <- ordered(factor, levels = c("hola", "a", "todos", "como", "estan"))


### Data Frames
df <- data.frame(
  c1 = c("this", "is", "a", "vector", "of", "things"),
  c2 = 1:6,
  c3 = letters[1:6],
  stringsAsFactors = FALSE
)

View(df) # para visualizar

dfCopy <- data.frame(
  c1 = c("this", "is", "a", "vector", "of", "things"),
  c2 = 1:6,
  c3 = letters[1:6]
)

str(df)

names(df) # para ver nombres de las columnas
names(df) <- c("Columna 1", "Columna 2", "Columna 3") # para hacer overwrite pero debe ser de la misma longitud
names(df)

colnames(df)
head(df, 3)
tail(df, 1)
nrow(df)
ncol(df)

# ADD new columns
df$`Columna 1` # $ para accesar a lo que haya en df
df$`Columna 4` <- 11:16 # 11:16 n. de 11 a 16 & debe tener la misma cantidad de filas que el original

df[,4] # [fila, columna]

# ADD new rows
new_elements <- c("new", 7, "g", 17) #creamos un vector
rbind(df, new_elements) # agrega la columna y mantiene los tipos de datos

dfCopy$c1 <- factor(dfCopy$c1) #cambiar tipo de dato
rbind(dfCopy, c("new", 7, "g"))





