library(tidyverse)
library(highcharter)
library(readr)

# Cargar DF Spotify 
df <- read_delim("spotify.csv", delim = ";",
                 escape_double = FALSE, trim_ws = TRUE)
# Ver DF
View(df)

# Info Dataset
str(df)     # -- baseR
glimpse(df) # -- deplyr

# Renombrar COLUMNAS
names(df)[4] <- "topGenre"         # -- baseR

rename(df, topGenre = `top genre`) # -- deplyr 

df %>% 
  rename(topGenre = `top genre`)   # -- deplyr con PIPE


# %>% "pipe" - ASIGNA este otro parametro - mas oragnizado

df %>%
  select(artist,year) %>%
  head()

# Sin pipe
head(select(df,artist,year))


# VER ciertas columnas
df %>% 
  select(1,2) %>%
  head() %>%
  View()
 
# VER todas excepto una 
head(df[-1])
# deplyr
df %>%
  select(-1) %>% # puede ser -numero o -nombre
  head()
  
# volver columnas de texto a factores 
df <- mutate_if(df, is.character, as.factor)

glimpse(df)

# FILTER
df %>% 
  select(artist,title,year) %>%
  filter(year == 2010) %>%
  head() %>%
  View()

# CUANTOS ARTISTAS TENEMOS POR AÑO ---- group_by
df %>%
  select(year,artist) %>%
  group_by(year) %>%
  summarise(qArtists = n_distinct(artist))

# CANCIONES UNICAS 
df %>%
  summarise(songs = n_distinct(title))




