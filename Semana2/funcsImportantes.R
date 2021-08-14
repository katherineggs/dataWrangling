
df <- data.frame(
  col1 = c("this", "is", "a", "vector", "of", "strings"),
  col2 = 1:6,
  col3 = letters[1:6],
  stringsAsFactors = FALSE
)

# Funciones importantes

is.na(df)   # filtar missing data
colSums(df) # sumar columnas - total

df[,2] # filtar filas o columnas
sum(df[,2])

df$col4 <- 11:16
df[,c("col2", "col4")] 

df <- rbind(df, c(NA, 7, "g", 17))

# para saber si hay un NA

is.na(df$col1) # vector tipo logico (T/F)
df[!is.na(df$col1),] # != para que muestre todas menos las que sean NA

# Crear Funciones 

findSample <- function(x,s){
  # cualquier procedimiento 
  # debemos poner return para que sea funcion
  # sino es un procedimiento
  
  forIndex <- sample(1:nrow(x), size = s, replace = FALSE) # replace = false no pueden haber repetidos
  newDf <- x[forIndex, ]
  
  return(newDf)
}

data <- data.frame(
  a = 1:10,
  b = sample(c("gt", "us", "ca"), size = 10, replace = TRUE)
)

findSample(x=data, s= 4)


# apply

generateDf <- function(x){
  return(
    data.frame(
      a = sample(letters, size = 10, replace = TRUE),
      b = sample(1:10, size = 10, replace = TRUE)
    )
  )
}

generateDf()

# lapply returns a list object of same length of original set
lista <- lapply(1:400, generateDf)

lista














