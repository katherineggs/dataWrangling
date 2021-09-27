library(lubridate)
library(nycflights13)
library(dplyr)

# Hoy y ahora
today()
now()

# Parsear fechas de texto

k <- "2001 October 10th"
ymd(k)

h <- "oct, 10th 2001 10:23"
mdy_hm(h)

# Operaciones con tiempo

## Fecha de aterrizaje y el primer paso en la luna
dateLanding <- mdy("July 20, 1969")
momentStep <- mdy_hms("July 20, 1969, 02:56:15", tz = "UTC")

difftime(now(), momentStep, units = "days")

# Suma de tiempos
mon1pm <- dmy_hm("27, Sep 2021 13:00")
mon1pm + weeks()

# Durations - cronometro
# Periods - general
feb <- dmy("28 feb 2020")
feb + dyears()
feb + years()

# add with roll back
jan <- dmy("31 Jan 2021")
add_with_rollback(jan, months(1), roll_to_first = FALSE)
add_with_rollback(jan, months(1), roll_to_first = TRUE)

# Generar secuencias de fechas
jan31 <- ymd("2021-01-31")
oct31 <- ymd("2021-10-31")

## 12 meses
monthSeq <- 1:12 * months(1)
monthSeq + jan31
monthSeq

seq(jan31,oct31,"weeks")

#Flights
flights %>%
  select(year,month,day,hour,minute,arr_time)

# make_date
make_date(year = 1955, month = 11, day = 21)
flights <- flights %>%
  mutate(departure = make_datetime(year,month,day,minute))








