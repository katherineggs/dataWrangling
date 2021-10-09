Laboratorio 6
================
Katherine Garcia 20190418
10/8/2021

# 1. Placas de un vehículo particular guatemalteco.

``` r
placas <- "^P[0-9]{3}[A-Z]{3}$"
ejemplo <- c("P123ABC","P456DEF","P789GHI")
detectarPlacas <- grep(placas, ejemplo)
detectarPlacas
```

    ## [1] 1 2 3
