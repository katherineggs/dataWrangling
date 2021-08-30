# esto es con dplyr
library(dplyr)

# %>% "pipe" - ASIGNA este otro parametro - mas oragnizado
# ES MAS ESCALABLExs
# EL COMANDO ES
# command - shift - M

df <- read_delim("spotify.csv", delim = ";",
                 escape_double = FALSE, trim_ws = TRUE)

# VER ciertas columnas
df %>% 
  select(1,2) %>%
  head() %>%
  View()

# VER todas excepto una 
df %>%
  select(-1) %>% # puede ser -numero o -nombre
  head()

# volver columnas de texto a factores 
df <- mutate_if(df, is.character, as.factor)

# ---- group_by
df %>%
  select(year,artist) %>%
  group_by(year) %>%
  summarise(qArtists = n_distinct(artist)) # n_distinct() para cuando son unicos
                                           # n() para sumar todo

