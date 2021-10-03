library(readxl)
library(dplyr)
library(lubridate)
library(nycflights13)


data <- read_excel("data.xlsx")

# Predecir un eclipse solar

## inició el 21 de agosto del 2017 a las 18:26:40.
ultimoEclipse <- ymd_hms("2017 aug 21 18:26:40", tz="GMT")
ultimoEclipse <- with_tz(ultimoEclipse, "GMT")

synodicMonth <- days(29) + hours(12) + minutes(44) + seconds(3)
saros <- 223 * synodicMonth

proximoEclipse <- ultimoEclipse + saros
proximoEclipse

# Agrupaciones y operaciones con fechas

data <- data %>%
  mutate(`Fecha Creación` = dmy(`Fecha Creación`)) %>%
  mutate(`Fecha Final` = dmy(`Fecha Final`))

# 1. ¿En qué meses existe una mayor cantidad de llamadas por código? - Mayo

data %>%
  select(`Fecha Final`, Call, Cod) %>%
  group_by(month = lubridate::floor_date(`Fecha Final`, "month"), Cod) %>%  
  filter(Call == 1) %>%
  summarise(cantLlamadas = sum(Call)) %>%
  filter(!is.na(month)) %>%
  arrange(desc(cantLlamadas)) %>%
  View()

# 2. ¿Qué día de la semana es el más ocupado? - Miercoles

data %>%
  select(`Fecha Final`, Call) %>%
  mutate(dia = weekdays(`Fecha Final`)) %>%
  group_by(dia) %>%  
  filter(Call == 1) %>%
  summarise(sum(Call)) %>%
  View()

# 3. ¿Qué mes es el más ocupado? 
#     - Mayo - Enero - Octubre

data %>%
  select(`Fecha Final`, Call, Email, SMS) %>%
  group_by(month = lubridate::floor_date(`Fecha Final`, "month")) %>%  
  summarise(sum(Call), sum(Email), sum(SMS)) %>%
  View()

# 4. ¿Existe una concentración o estacionalidad en la cantidad de llamadas?
#    - Media noche Fall

data %>%
  select(`Fecha Final`, Call,`Hora Final`) %>%
  mutate(hora = hour(`Hora Final`)) %>%
  mutate(mes = month(`Fecha Final`)) %>%
  filter(!is.na(mes)) %>%
  mutate(season = ifelse(mes %in% c(month(10), month(11), month(12)) , "Fall",
                         ifelse(mes %in% c(month(1), month(2), month(3)), "Winter",
                                ifelse(mes %in% c(month(4), month(5), month(6)), "Spring",
                                       ifelse(mes %in% c(month(7), month(8), month(9)), "Summer",
                                              ""))))) %>%
  group_by(season, hora) %>%
  summarise(sum(Call)) %>%
  View()

# 5. ¿Cuántos minutos dura la llamada promedio?
#    - 14.5579 minutos

data %>%
  select(Call, `Hora Creación`, `Hora Final`) %>%
  filter(Call == 1) %>%
  mutate(duracion = `Hora Final` - `Hora Creación`) %>%
  mutate(duracion = minute(seconds_to_period(duracion))) %>%
  summarise(promedio = mean(duracion)) %>%
  View()

# 6. Realice una tabla de frecuencias con el tiempo de llamada. ----- FALTA
data %>% 
  select(Call, `Hora Creación`, `Hora Final`) %>%
  filter(Call == 1) %>%
  mutate(duracion = `Hora Final` - `Hora Creación`) %>% # segundos
  mutate(duracion = minute(seconds_to_period(duracion))) %>% # minutos
  mutate(cantidad = )%>%
  mutate(rango = c(5,10,15)) %>% # minutos
  #mutate(rango = duracion) %>%
  View()

# Signo Zodiacal

fecha = ymd("2001-1-21")
fecha

zodiac <- function(fecha){
  if (month(fecha) == 1  & day(fecha) >= 20){ return("Aquarius") }
  if (month(fecha) == 2  & day(fecha) <= 19){ return("Aquarius") }
  
  if (month(fecha) == 2  & day(fecha) >= 20){ return("Pisces") }
  if (month(fecha) == 3  & day(fecha) <= 19){ return("Pisces") }
  
  if (month(fecha) == 3  & day(fecha) >= 21){ return("Aries") }
  if (month(fecha) == 4  & day(fecha) <= 20){ return("Aries") }
  
  if (month(fecha) == 4  & day(fecha) >= 21){ return("Taurus") }
  if (month(fecha) == 5  & day(fecha) <= 20){ return("Taurus") }
  
  if (month(fecha) == 5  & day(fecha) >= 21){ return("Gemini") }
  if (month(fecha) == 6  & day(fecha) <= 20){ return("Gemini") }
  
  if (month(fecha) == 6  & day(fecha) >= 21){ return("Cancer") }
  if (month(fecha) == 7  & day(fecha) <= 22){ return("Cancer") }
  
  if (month(fecha) == 7  & day(fecha) >= 23){ return("Leo") }
  if (month(fecha) == 8  & day(fecha) <= 22){ return("Leo") }
  
  if (month(fecha) == 8  & day(fecha) >= 23){ return("Virgo") }
  if (month(fecha) == 9  & day(fecha) <= 22){ return("Virgo") }
  
  if (month(fecha) == 9  & day(fecha) >= 23){ return("Libra") }
  if (month(fecha) == 10  & day(fecha) <= 22){ return("Libra") }
  
  if (month(fecha) == 10 & day(fecha) >= 23){ return("Scorpio") }
  if (month(fecha) == 11 & day(fecha) <= 22){ return("Scorpio") }
  
  if (month(fecha) == 11 & day(fecha) >= 23){ return("Sagittarius") }
  if (month(fecha) == 12 & day(fecha) <= 21){ return("Sagittarius") }
  
  if (month(fecha) == 12 & day(fecha) >= 22){ return("Capricorn") }
  if (month(fecha) == 1 & day(fecha) <= 19){ return("Capricorn") }
  return("Date is not right")
}  

sign <- zodiac(fecha)
sign
# Flights

flightsTimes <- flights %>%
  mutate(departure = substr(as.POSIXct(sprintf("%04.0f", dep_time), format='%H%M'), 12, 16)) %>%
  mutate(arrival = substr(as.POSIXct(sprintf("%04.0f", arr_time), format='%H%M'), 12, 16)) %>%
  mutate(schedDept = substr(as.POSIXct(sprintf("%04.0f", sched_dep_time), format='%H%M'), 12, 16)) %>%
  mutate(schedArr = substr(as.POSIXct(sprintf("%04.0f", sched_arr_time), format='%H%M'), 12, 16)) 


# Delays
delay <- flightsTimes %>%
  select(flight, departure, schedDept, arrival, schedArr) %>%
  mutate(delayDept = hm(schedDept) - hm(departure) ) %>%
  mutate(delayArr = hm(schedArr) - hm(arrival) ) %>%
  mutate(delay = delayArr + delayDept)

View(delay)









