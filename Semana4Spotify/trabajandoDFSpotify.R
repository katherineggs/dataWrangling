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

# Canciones que se repiten
df %>%
  summarise(cancionesRepetidas = n() - n_distinct(title))

# otra solucion

df %>% 
  group_by(title) %>%
  summarise(freq=n()) %>%
  group_by(freq) %>%
  summarise(n())

# canciones repetidas y nombre repetido 
canciones_repetidas <- df %>% 
  group_by(artist,title) %>%
  summarise(canciones = ifelse(n()>1,n(),NA)) %>%
  na.omit()

canciones_repetidas

## CANCIONES QUE SE LLAMAN IGUAL DIFERENTE ARTISTA
df %>%
  group_by(artist,title) %>%
  summarise(n())

# Que canciones de que artistas aparecen mas de un año 
dta <- df %>%
  group_by(artist,title) %>%
  summarise(veces = ifelse(n_distinct(year)>1,n_distinct(year),NA)) %>%
  na.omit()

View(dta)

# Cuales artistas han tenido mas de una cancion popular en mas de un año
dt <- df %>%
  group_by(artist,title) %>%
  summarise(count = n_distinct(year)) %>%
  filter(count>1) %>%
  group_by(artist)%>%
  summarise(arts = n()) %>%
  filter(arts>1)

View(dt)

# HIGH CHARTER --------------------------------------------------------------------
df <- mutate_if(df, is.character, as.factor)
df$title <- iconv(df$title, to="UTF-8")
df$artist <- iconv(df$artist, to="UTF-8")

# Que canciones de que artistas aparecen mas de un año 
df %>%
  select(year,artist) %>%
  group_by(year) %>%
  summarise(n = n_distinct(artist)) %>%
  hchart("column", hcaes(x = year, y = n)) %>%
  hc_title(text="<b>ARTISTAS DISTINTOS POR AÑ0</b>") %>%
  hc_subtitle(text="<i> 2019 tuvo la menor variedad, mientras 2015 ha sido el año con mas variedad de artistas </i>")








