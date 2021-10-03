Laboratorio 5
================
Katherine Garcia - 20190418

# ● Parte 1: Predecir un eclipse solar

### ● Variable eclipse histórico, Saros, Synodic Month.

``` r
ultimoEclipse <- ymd_hms("2017 aug 21 18:26:40", tz="GMT")
ultimoEclipse <- with_tz(ultimoEclipse, "GMT") # Poner TZ

synodicMonth <- days(29) + hours(12) + minutes(44) + seconds(3)
saros <- 223 * synodicMonth
```

### ● La fecha del siguiente eclipse solar

``` r
proximoEclipse <- ultimoEclipse + saros
proximoEclipse
```

    ## [1] "2035-09-02 02:09:49 GMT"

# ● Parte 2: Agrupaciones y operaciones con fechas

### 1. ¿En qué meses existe una mayor cantidad de llamadas por código?

#### – Mayo –

``` r
data %>%
  select(`Fecha Final`, Call, Cod) %>%
  group_by(month = lubridate::floor_date(`Fecha Final`, "month"), Cod) %>%  
  filter(Call == 1) %>%
  summarise(cantLlamadas = sum(Call)) %>%
  filter(!is.na(month)) %>%
  arrange(desc(cantLlamadas)) %>%
  head(1)
```

    ## `summarise()` has grouped output by 'month'. You can override using the `.groups` argument.

    ## # A tibble: 1 × 3
    ## # Groups:   month [1]
    ##   month      Cod                          cantLlamadas
    ##   <date>     <chr>                               <dbl>
    ## 1 2017-05-01 Actualización de Información          314

### 2. ¿Qué día de la semana es el más ocupado?

#### – Miercoles –

``` r
data %>%
  select(`Fecha Final`, Call) %>%
  mutate(dia = weekdays(`Fecha Final`)) %>%
  group_by(dia) %>%  
  filter(Call == 1) %>%
  summarise(cantLlamadas = sum(Call)) %>%
  filter(!is.na(dia)) %>%
  arrange(desc(cantLlamadas)) %>%
  head(1)
```

    ## # A tibble: 1 × 2
    ##   dia       cantLlamadas
    ##   <chr>            <dbl>
    ## 1 Wednesday          532

### 3. ¿Qué mes es el más ocupado? - Segun Cantidad de Emails

#### – Julio –

``` r
data %>%
  select(`Fecha Final`, Call, Email, SMS) %>%
  group_by(month = lubridate::floor_date(`Fecha Final`, "month")) %>%  
  summarise(sum(Call), cantEmails = sum(Email), sum(SMS)) %>%
  filter(!is.na(month)) %>%
  arrange(desc(cantEmails)) %>%
  head(1)
```

    ## # A tibble: 1 × 4
    ##   month      `sum(Call)` cantEmails `sum(SMS)`
    ##   <date>           <dbl>      <dbl>      <dbl>
    ## 1 2017-07-01         289       3310      10140

### 4. ¿Existe una concentración o estacionalidad en la cantidad de llamadas?

#### – Otoño a media noche –

``` r
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
  summarise(cantLlamadas = sum(Call)) %>%
  arrange(desc(cantLlamadas)) %>%
  head(1)
```

    ## `summarise()` has grouped output by 'season'. You can override using the `.groups` argument.

    ## # A tibble: 1 × 3
    ## # Groups:   season [1]
    ##   season  hora cantLlamadas
    ##   <chr>  <int>        <dbl>
    ## 1 Fall       0           62

### 5. ¿Cuántos minutos dura la llamada promedio?

#### – 14.5579 minutos –

``` r
data %>%
  select(Call, `Hora Creación`, `Hora Final`) %>%
  filter(Call == 1) %>%
  mutate(duracion = `Hora Final` - `Hora Creación`) %>%
  mutate(duracion = minute(seconds_to_period(duracion))) %>%
  summarise(promedio = mean(duracion))
```

    ## # A tibble: 1 × 1
    ##   promedio
    ##      <dbl>
    ## 1     14.6

### 6. Realice una tabla de frecuencias con el tiempo de llamada.

#### – FALTA –

``` r
data %>% 
  select(Call, `Hora Creación`, `Hora Final`) %>%
  filter(Call == 1) %>%
  mutate(duracion = `Hora Final` - `Hora Creación`) %>% # segundos
  mutate(duracion = minute(seconds_to_period(duracion))) %>% # minutos
  mutate(cantidad = )%>%
  mutate(rango = c(5,10,15)) # %>% # minutos
  #mutate(rango = duracion)
```

# ● Parte 3: Signo Zodiacal

##### Input

``` r
fecha = ymd("2001-10-10")
```

``` r
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
```

    ## [1] "Libra"

# ● Parte 4: Flights

### Agregar columnas

``` r
flightsTimes <- flights %>%
  mutate(departure = substr(as.POSIXct(sprintf("%04.0f", dep_time), format='%H%M'), 12, 16)) %>%
  mutate(arrival = substr(as.POSIXct(sprintf("%04.0f", arr_time), format='%H%M'), 12, 16)) %>%
  mutate(schedDept = substr(as.POSIXct(sprintf("%04.0f", sched_dep_time), format='%H%M'), 12, 16)) %>%
  mutate(schedArr = substr(as.POSIXct(sprintf("%04.0f", sched_arr_time), format='%H%M'), 12, 16)) 

flightsTimes
```

    ## # A tibble: 336,776 × 23
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     1     1      517            515         2      830            819
    ##  2  2013     1     1      533            529         4      850            830
    ##  3  2013     1     1      542            540         2      923            850
    ##  4  2013     1     1      544            545        -1     1004           1022
    ##  5  2013     1     1      554            600        -6      812            837
    ##  6  2013     1     1      554            558        -4      740            728
    ##  7  2013     1     1      555            600        -5      913            854
    ##  8  2013     1     1      557            600        -3      709            723
    ##  9  2013     1     1      557            600        -3      838            846
    ## 10  2013     1     1      558            600        -2      753            745
    ## # … with 336,766 more rows, and 15 more variables: arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
    ## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>,
    ## #   departure <chr>, arrival <chr>, schedDept <chr>, schedArr <chr>

### Delays

``` r
delay <- flightsTimes %>%
  select(flight, departure, schedDept, arrival, schedArr) %>%
  mutate(delayDept = hm(schedDept) - hm(departure) ) %>%
  mutate(delayArr = hm(schedArr) - hm(arrival) ) %>%
  mutate(delay = delayArr + delayDept)
```

    ## Warning in .parse_hms(..., order = "HM", quiet = quiet): Some strings failed to
    ## parse, or all strings are NAs

    ## Note: method with signature 'Period#ANY' chosen for function '-',
    ##  target signature 'Period#Period'.
    ##  "ANY#Period" would also be valid

    ## Warning in .parse_hms(..., order = "HM", quiet = quiet): Some strings failed to
    ## parse, or all strings are NAs

``` r
delay
```

    ## # A tibble: 336,776 × 8
    ##    flight departure schedDept arrival schedArr delayDept  delayArr   delay     
    ##     <int> <chr>     <chr>     <chr>   <chr>    <Period>   <Period>   <Period>  
    ##  1   1545 05:17     05:15     08:30   08:19    -2M 0S     -11M 0S    -13M 0S   
    ##  2   1714 05:33     05:29     08:50   08:30    -4M 0S     -20M 0S    -24M 0S   
    ##  3   1141 05:42     05:40     09:23   08:50    -2M 0S     -1H 27M 0S -1H 25M 0S
    ##  4    725 05:44     05:45     10:04   10:22    1M 0S      18M 0S     19M 0S    
    ##  5    461 05:54     06:00     08:12   08:37    1H -54M 0S 25M 0S     1H -29M 0S
    ##  6   1696 05:54     05:58     07:40   07:28    4M 0S      -12M 0S    -8M 0S    
    ##  7    507 05:55     06:00     09:13   08:54    1H -55M 0S -1H 41M 0S -14M 0S   
    ##  8   5708 05:57     06:00     07:09   07:23    1H -57M 0S 14M 0S     1H -43M 0S
    ##  9     79 05:57     06:00     08:38   08:46    1H -57M 0S 8M 0S      1H -49M 0S
    ## 10    301 05:58     06:00     07:53   07:45    1H -58M 0S -8M 0S     1H -66M 0S
    ## # … with 336,766 more rows
