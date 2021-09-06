library(readr)
library(dplyr)
library(highcharter)


data <- read.csv("tabla_completa.csv")

data <- data %>% 
  mutate(CLIENTE = gsub(" ?/ ?Despacho a cliente", "", CLIENTE)) %>%
  mutate(CLIENTE = gsub(" ?\\|\\|.*", "", CLIENTE))

# Mas personal?

# Cantidad de empleados ------------------------------- 9
data %>%
  summarise(empleados = n_distinct(PILOTO)) %>%
  View()

# Viajes por piloto ----------------------------------- 242 promedio
data %>% 
  select(PILOTO, COD_VIAJE) %>%
  group_by(PILOTO) %>%
  summarise(viajes = n_distinct(COD_VIAJE)) %>%
  arrange(desc(viajes)) %>%
  View()

# Ingreso --------------------------------------------- 598,848
data %>%
  summarise(ingrsos = sum(Q)) %>%
  View()

# Ingreso por piloto ---------------------------------- 66,538.69 promedio
data %>%
  select(PILOTO, Q) %>%
  group_by(PILOTO) %>%
  summarise(ingresoPiloto = sum(Q)) %>%
  arrange(desc(ingresoPiloto)) %>%
  View()

# Cantidad de clientes -------------------------------- 13
data %>%
  select(CLIENTE,Q) %>%
  group_by(CLIENTE) %>%
  summarise(totalClientes = n()) %>%
  View()

# DECISION ------------------------------------------- 
# SI
# en 11 meses hacen un promedio de 242 viajes 
# en 11 meses hay 240 dias laborales

# ¿Debemos invertir en la compra de más vehículos de distribución? ¿Cuántos y de que tipo?

# Vehiculos cual da mas ingresos ----------------------- grande, peque panel
data %>%
  select(Q, UNIDAD, MES) %>%
  group_by(UNIDAD, MES) %>%
  summarise(ingresoVehiculo = sum(Q)) %>%
  View()

# Vehiculos cual tiene mas viajes ---------------------- grande, peque, panel
data %>%
  select(COD_VIAJE, UNIDAD, MES) %>%
  group_by(UNIDAD, MES) %>%
  summarise(viajes = n()) %>%
  View()

# Vehiculos cual tiene mas cantidad -------------------- grande, peque, panel
data %>%
  select(CANTIDAD, UNIDAD, MES) %>%
  group_by(UNIDAD, MES) %>%
  summarise(CANTIDAD = n()) %>%
  View()

# Las tarifas actuales ¿son aceptables por el cliente?

# Ingresos por mes
data %>%
  select(MES, Q) %>%
  group_by(MES) %>%
  summarise(ingresosMes = sum(Q)) %>%
  View()

# Cantidad por mes
data %>%
  select(MES, CANTIDAD) %>%
  group_by(MES) %>%
  summarise(ingresosMes = sum(CANTIDAD)) %>%
  View()

# ¿Nos están robando los pilotos
# ¿Qué estrategias debo seguir?

# 80-20 de clientes
# Cual es el 20% de los clientes que generan el 80% de nuestros ingresos

# Ingresos 80% - 479,000
# Clientes 20% - 3
# Ingreso --------------------------------------------- 598,848
# Clientes -------------------------------------------- 13

data %>%
  select(CLIENTE, Q) %>%
  group_by(CLIENTE) %>%
  summarise(ingresos = sum(Q)) %>%
  arrange(desc(ingresos)) %>%
  View()

# HIGH CHARTER --------------------------------------------------------------------
data <- mutate_if(data, is.character, as.factor)
data$CLIENTE <- iconv(data$CLIENTE, to="UTF-8")

# 
data %>%
  select(CLIENTE, Q) %>%
  group_by(CLIENTE) %>%
  summarise(ingresos = sum(Q)) %>%
  hchart("column", hcaes(x = CLIENTE, y = ingresos)) %>%
  hc_title(text="<b>CLIENTES</b>") %>%
  hc_subtitle(text="<i> El Pinche, Taqueria El Chinito, El Gallo Negro, Pollo Pinulito y Ubiquo Labs. Forman el 40% de clientes los cuales representan el 60% de los ingresos de la empresa. </i>")

data %>%
  select(PILOTO, COD_VIAJE) %>%
  group_by(PILOTO) %>%
  summarise(viajes = n_distinct(COD_VIAJE)) %>%
  hchart("column", hcaes(x = PILOTO, y = viajes)) %>%
  hc_title(text="<b>VIAJES POR PILOTO</b>") %>%
  hc_subtitle(text="<i> El mejor puesto como mejor piloto se otorga a Fernando Mariano Berreiro que es el piloto con más viajes en el año y con mayor cantidad de ingresos por dichos viajes.  </i>")






