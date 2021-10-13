library(dplyr)
library(lubridate)

# leer csv
data <- read.csv("c1.csv")
rename(data, ID = `idPoste`)
View(data)

data <- data %>%
  mutate(factura = gsub("^ Q-   ", "",factura)) %>% mutate(factura = gsub("^ Q", "",factura)) %>%
  
  mutate(Camion_5 = gsub("^ Q-   ", "",Camion_5)) %>% mutate(Camion_5 = gsub("^ Q", "",Camion_5)) %>%
  mutate(fijoCamion_5 = gsub("^ Q-   ", "",fijoCamion_5)) %>% mutate(fijoCamion_5 = gsub("^ Q", "",fijoCamion_5)) %>%
  mutate(directoCamion_5 = gsub("^ Q-   ", "",directoCamion_5)) %>% mutate(directoCamion_5 = gsub("^ Q", "",directoCamion_5)) %>%
  mutate(Pickup = gsub("^ Q-   ", "",Pickup)) %>% mutate(Pickup = gsub("^ Q", "",Pickup)) %>%
  mutate(fijoPickup = gsub("^ Q-   ", "",fijoPickup)) %>% mutate(fijoPickup = gsub("^ Q", "",fijoPickup)) %>%
  mutate(directoPickup = gsub("^ Q-   ", "",directoPickup)) %>% mutate(directoPickup = gsub("^ Q", "",directoPickup)) %>%
  mutate(Moto = gsub("^ Q-   ", "",Moto)) %>% mutate(Moto = gsub("^ Q", "",Moto)) %>%
  mutate(fijoMoto = gsub("^ Q-   ", "",fijoMoto)) %>% mutate(fijoMoto = gsub("^ Q", "",fijoMoto)) %>%
  mutate(directoMoto = gsub("^ Q-   ", "",directoMoto)) %>% mutate(directoMoto = gsub("^ Q", "",directoMoto)) %>%
  
  mutate(Camion_5 = as.integer(Camion_5)) %>% mutate(Pickup = as.numeric(Pickup)) %>% mutate(Moto = as.numeric(Moto)) %>%
  mutate(fijoCamion_5 = as.numeric(fijoCamion_5)) %>% mutate(fijoPickup = as.numeric(fijoPickup)) %>%
  mutate(fijoMoto = as.numeric(fijoMoto)) %>%
  
  mutate(directoCamion_5 = as.numeric(directoCamion_5)) %>%
  mutate(directoPickup = as.numeric(directoPickup)) %>%
  mutate(directoMoto = as.numeric(directoMoto)) %>%
  mutate(factura = as.integer(factura)) %>%
  
  mutate(Fecha = sub("(.{6})(.*)", "\\120\\2", Fecha)) %>%
  mutate(Fecha = as_date(Fecha, format = "%d-%m-%Y")) %>%
  
  replace(is.na(.), 0) %>%
  mutate(tipoVehiculo = ifelse((Camion_5 != 0),"Camion",
                               ifelse((Pickup != 0),"Pickup",
                                      ifelse((Moto != 0),"Moto","")))) %>%
  mutate(distancia = ifelse(X5.30 == " x ", "5-30",
                            ifelse(X30.45 == " x ", "30-45",
                                   ifelse(X45.75 == " x ", "45-75",
                                          ifelse(X75.120 == " x ", "75-120",
                                                 ifelse(X120. == " x ", "120+", ""))))))

data$X <- NULL
data$X.1 <- NULL
data$X.2 <- NULL
data$X.3 <- NULL
data$X.4 <- NULL
data$X.5 <- NULL  

# ●	Estado de resultados breve del 2017.
ingresos <- data %>%
  select(factura) %>%
  summarise(ingresos = sum(factura))
  #select(Camion_5, Pickup, Moto) %>%
  #summarise(ingresos = sum(Camion_5)+sum(Pickup)+sum(Moto))

cstDir <- data %>%
  select(directoCamion_5, directoPickup, directoMoto) %>%
  summarise(cst = sum(directoCamion_5)+sum(directoPickup)+sum(directoMoto))

cstFijos <- data %>%
  select(fijoCamion_5, fijoPickup, fijoMoto) %>%
  summarise(cst = sum(fijoCamion_5)+sum(fijoPickup)+sum(fijoMoto))

impts <- data %>%
  select(Camion_5, Pickup, Moto, factura) %>%
  summarise(ingresos = sum(Camion_5)+sum(Pickup)+sum(Moto), fact = sum(factura))%>%
  summarise(impt = fact - ingresos) %>%
  summarise(impt)

data %>%
  select(Cod,origen) %>%
  group_by(Cod) %>%
  summarise(cant = n()) %>%
  arrange(desc(cant)) %>%
  View()

data %>%
  select(Cod,origen,Fecha,factura) %>%
  group_by(Cod, month(Fecha)) %>%
  filter(Cod == "REVISION") %>%
  summarise(money = sum(factura)) %>%
  summarise(mean(money)) %>%
  #arrange(desc(cant)) %>%
  View()

data %>%
  select(Fecha) %>%
  group_by(year(Fecha)) %>%
  summarise(n()) %>%
  View()

# vehiculo con mas entradas
data %>%
  select(Camion_5, Pickup, Moto, origen, factura) %>%
  group_by(origen, tipoVehiculo) %>%
  filter(tipoVehiculo == "Pickup") %>%
  summarise(Q = sum(factura)) %>%
  summarise(mean(Q))%>%
  #summarise(camion = sum(Camion_5), pick = sum(Pickup), mot = sum(Moto)) %>%
  View()

data %>%
  select(tipoVehiculo,distancia) %>%
  group_by(tipoVehiculo, distancia) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  View()

data %>%
  select(tipoVehiculo, Cod) %>%
  group_by(tipoVehiculo, Cod) %>%
  summarise(n = n()) %>%
  #summarise(mean(Q))%>%
  #summarise(camion = sum(Camion_5), pick = sum(Pickup), mot = sum(Moto)) %>%
  arrange(desc(n)) %>%
  View()

# vehiculo con menos distancias
data %>%
  select(Cod, tipoVehiculo, distancia) %>%
  group_by(tipoVehiculo, distancia) %>%
  #filter(tipoVehiculo == "Camion") %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  View()

View(data)

# estado de resultados 2017
ventas <- data %>%
  select(factura, Pickup, Camion_5, Moto) %>%
  summarise(ventas = sum(factura))

costoVenta <- data %>%
  select(directoCamion_5, directoMoto, directoPickup, fijoCamion_5, fijoPickup, fijoMoto) %>%
  summarise(ctV = sum(fijoCamion_5) + sum(fijoPickup) + sum(fijoMoto)
            +sum(directoCamion_5) + sum(directoPickup) + sum(directoMoto))

ut <- ventas - costoVenta
ut # EN QUETZALEEEES

# 2018
ventas18 <- data %>%
  select(factura, Fecha) %>%
  filter(month(Fecha) <= 9) %>%
  #group_by(month(Fecha)) %>%
  summarise(ventas = sum(factura)*0.75)

View(ventas18)

costoVenta18 <- data %>%
  select(Camion_5, Moto, Pickup, Fecha) %>%
  #select(directoCamion_5, directoMoto, directoPickup, fijoCamion_5, fijoPickup, fijoMoto, Fecha) %>%
  filter(month(Fecha) <= 9) %>%
  #group_by(month(Fecha)) %>%
  summarise(ctV = (sum(Camion_5) + sum(Pickup) + sum(Moto))*0.97)
  #summarise(ctV = sum(fijoCamion_5) + sum(fijoPickup) + sum(fijoMoto)
            #+sum(directoCamion_5) + sum(directoPickup) + sum(directoMoto))

costoVenta18

ut18 <- ventas18 - costoVenta18
ut18 # EN QUETZALEEEES

utDeseada19 <- ut18 * 1.1
utDeseada19

# Tarifario por servicio
factTVehiculo <- data %>%
  select(tipoVehiculo, factura, Cod) %>%
  group_by(Cod) %>%
  summarise(servicios = sum(factura), cant = n()) %>%
  summarise(precioUnidad = servicios/cant, Cod) %>%
  View()


View(factTVehiculo)

# distancias
data %>%
  select(origen, distancia) %>%
  group_by(origen, distancia) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  View()

# costos por mes
data %>%
  select(Camion_5, Moto, Pickup, Fecha) %>%
  group_by(month(Fecha)) %>%
  summarise(costos = sum(Camion_5) + sum(Pickup) + sum(Moto)) %>%
  summarise(fluct = 100 - ((costos*100)/2345269)) %>%
  summarise(sum(fluct)) %>%
  View()

# Perdidas
#  Costo max y fact min (por codgo) resto fact – costo  cuanto le npodemos perder 
data %>%
  select(Camion_5, Moto, Pickup, factura, Cod) %>%
  group_by(Cod) %>%
  mutate(costo = ifelse(Camion_5 != 0, Camion_5, ifelse(Pickup != 0, Pickup, ifelse(Moto != 0, Moto, 0)))) %>%
  summarise(costoMax = max(costo), factMin = min((factura)) ) %>%
  summarise(Cod, perdida = factMin - costoMax) %>%
  View()
  
# abrir mas centros 
data %>%
  select(distancia) %>%
  group_by(distancia) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  View()

# 80 -20
ventasTotales <- sum(data$factura)
data %>%
  select(Cod, factura) %>%
  group_by(Cod) %>%
  summarise(ingresoServicio = sum(factura)) %>%
  summarise(`%Utilidad` = (ingresoServicio * 100)/ventasTotales, Cod) %>%
  arrange(desc(`%Utilidad`)) %>%
  View()

# recorridos mas efectivos
data %>%
  select(distancia, Cod) %>%
  group_by(distancia, Cod) %>%
  filter(distancia == "5-30" || distancia == "30-45") %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  View()

# 10%
margenGanancia <- (ut / ventas) * 100
margenGanancia

margenPrecio <- 


