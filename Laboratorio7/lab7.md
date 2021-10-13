Laboratorio 7
================
Katherine Garcia - 20190418

# Información obtenida

-   Utilidad superior a US$1 Millón. - 2017
-   Han tenido una baja del 25% con respecto al año anterior. Septiembre
    2018
-   Estudio del mercado, para que el siguiente año la empresa pueda
    crecer el 10% con respecto al 2018. - 2019
-   Entender cómo funcionó el 2017.

## Existen 4 tiendas que cubren los 10 servicios que ofrecen

``` r
data %>%
  select(Cod,origen) %>%
  group_by(tiendaNo. =origen) %>%
  summarise(cantServicios = n_distinct(Cod))
```

    ## # A tibble: 4 × 2
    ##   tiendaNo. cantServicios
    ##       <int>         <int>
    ## 1    150224            10
    ## 2    150277            10
    ## 3    150278            10
    ## 4    150841            10

## Estado de Resultados - 2017 en Quetzales

``` r
data %>%
  select(factura, fijoPickup, fijoCamion_5, fijoMoto, directoPickup, directoCamion_5, directoMoto) %>%
  summarise(ventas = sum(factura), ctV = sum(fijoCamion_5) + sum(fijoPickup) + sum(fijoMoto)
            + sum(directoCamion_5) + sum(directoPickup) + sum(directoMoto)) %>%
  summarise(Utilidad = ventas - ctV) # EN QUETZALES
```

    ##   Utilidad
    ## 1  8383552

## Como fue el 2018 en Quetzales

``` r
data %>%
  select(Fecha, factura, fijoPickup, fijoCamion_5, fijoMoto, directoPickup, directoCamion_5, directoMoto) %>%
  filter(month(Fecha) <= 9) %>%
  summarise(ventas = sum(factura) * 0.75, ctV = (sum(fijoCamion_5) + sum(fijoPickup) + sum(fijoMoto)
            + sum(directoCamion_5) + sum(directoPickup) + sum(directoMoto)) *0.97) %>%
  summarise(Utilidad = ventas - ctV) # EN QUETZALES
```

    ##   Utilidad
    ## 1 66769.18

## Tarifario por servicio

``` r
 data %>%
  select(tipoVehiculo, factura, Cod) %>%
  group_by(Servicio = Cod) %>%
  summarise(servicios = sum(factura), cant = n()) %>%
  summarise(precioUnidad = servicios/cant, Servicio) 
```

    ## # A tibble: 10 × 2
    ##    precioUnidad Servicio                
    ##           <dbl> <chr>                   
    ##  1         124. CAMBIO_CORRECTIVO       
    ##  2         153. CAMBIO_FUSIBLE          
    ##  3         176. CAMBIO_PUENTES          
    ##  4         176. OTRO                    
    ##  5         132. REVISION                
    ##  6         157. REVISION_TRANSFORMADOR  
    ##  7         141. VERIFICACION_INDICADORES
    ##  8         131. VERIFICACION_MEDIDORES  
    ##  9         128. VISITA                  
    ## 10         176. VISITA_POR_CORRECCION

## ¿Cuándo podríamos perderle a un mantenimiento y/o reparación?

``` r
data %>%
  select(Camion_5, Moto, Pickup, factura, Cod) %>%
  group_by(Servicio = Cod) %>%
  mutate(costo = ifelse(Camion_5 != 0, Camion_5, ifelse(Pickup != 0, Pickup, ifelse(Moto != 0, Moto, 0)))) %>%
  summarise(costoMax = max(costo), factMin = min((factura)), factMax = max(factura)) %>%
  summarise(Servicio, Perdida = (factMin - costoMax))
```

    ## # A tibble: 10 × 2
    ##    Servicio                 Perdida
    ##    <chr>                      <dbl>
    ##  1 CAMBIO_CORRECTIVO           -401
    ##  2 CAMBIO_FUSIBLE              -446
    ##  3 CAMBIO_PUENTES              -363
    ##  4 OTRO                        -420
    ##  5 REVISION                    -420
    ##  6 REVISION_TRANSFORMADOR      -451
    ##  7 VERIFICACION_INDICADORES    -447
    ##  8 VERIFICACION_MEDIDORES      -381
    ##  9 VISITA                      -387
    ## 10 VISITA_POR_CORRECCION       -409

## Abrir más centros?

``` r
data %>%
  select(distancia) %>%
  group_by(distancia) %>%
  summarise(cantViajes = n()) %>%
  arrange(desc(cantViajes))
```

    ## # A tibble: 5 × 2
    ##   distancia cantViajes
    ##   <chr>          <int>
    ## 1 75-120        110764
    ## 2 30-45          52745
    ## 3 5-30           39559
    ## 4 45-75          34284
    ## 5 120+           26373

## 80 - 20 de lo facturado

``` r
ventasTotales <- sum(data$factura)
data %>%
  select(Cod, factura) %>%
  group_by(Cod) %>%
  summarise(ingresoServicio = sum(factura)) %>%
  summarise(`%Utilidad` = (ingresoServicio * 100)/ventasTotales, Cod) %>%
  arrange(desc(`%Utilidad`))
```

    ## # A tibble: 10 × 2
    ##    `%Utilidad` Cod                     
    ##          <dbl> <chr>                   
    ##  1      32.6   REVISION                
    ##  2      17.0   VERIFICACION_MEDIDORES  
    ##  3      12.3   VERIFICACION_INDICADORES
    ##  4      12.2   CAMBIO_CORRECTIVO       
    ##  5       8.01  CAMBIO_FUSIBLE          
    ##  6       7.94  VISITA_POR_CORRECCION   
    ##  7       5.37  REVISION_TRANSFORMADOR  
    ##  8       2.83  OTRO                    
    ##  9       0.887 CAMBIO_PUENTES          
    ## 10       0.829 VISITA

## Recorridos mas efectivos

``` r
data %>%
  select(distancia, Cod) %>%
  group_by(distancia, Cod) %>%
  filter(distancia == "5-30" || distancia == "30-45") %>%
  summarise(n = n()) %>%
  arrange(desc(n))
```

    ## `summarise()` has grouped output by 'distancia'. You can override using the `.groups` argument.

    ## # A tibble: 20 × 3
    ## # Groups:   distancia [2]
    ##    distancia Cod                          n
    ##    <chr>     <chr>                    <int>
    ##  1 30-45     REVISION                 18901
    ##  2 5-30      REVISION                 14362
    ##  3 30-45     VERIFICACION_MEDIDORES    9784
    ##  4 30-45     CAMBIO_CORRECTIVO         8242
    ##  5 5-30      VERIFICACION_MEDIDORES    7451
    ##  6 30-45     VERIFICACION_INDICADORES  6389
    ##  7 5-30      CAMBIO_CORRECTIVO         6315
    ##  8 5-30      VERIFICACION_INDICADORES  4683
    ##  9 30-45     CAMBIO_FUSIBLE            3694
    ## 10 5-30      CAMBIO_FUSIBLE            3341
    ## 11 30-45     VISITA_POR_CORRECCION     2107
    ## 12 30-45     REVISION_TRANSFORMADOR    2035
    ## 13 5-30      REVISION_TRANSFORMADOR    1373
    ## 14 5-30      VISITA_POR_CORRECCION     1182
    ## 15 30-45     OTRO                       821
    ## 16 30-45     VISITA                     500
    ## 17 5-30      VISITA                     413
    ## 18 5-30      OTRO                       295
    ## 19 30-45     CAMBIO_PUENTES             272
    ## 20 5-30      CAMBIO_PUENTES             144

# Incremento del 10%
