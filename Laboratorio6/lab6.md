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

# 2. Archivo es de tipo .pdf o .jpg

``` r
archivo <- "^[A-Za-z0-9_$]+.(pdf|jpg)$"
ejemplo <- c("hola.jpg","confidencial.pdf","123$.jpg")
validarArchivo <- grep(archivo, ejemplo)
validarArchivo
```

    ## [1] 1 2 3

# 3. Contraseñas de correo

``` r
pw <- "^[A-Za-z0-9$%#_]{8}[A-Za-z0-9]*[$%#&_]*$"
ejemplo <- c("hola123$","plantAs44#","12345678")
validarConts <- grep(pw, ejemplo)
validarConts
```

    ## [1] 1 2 3

# 4. Carnet de la Universidad Galileo

``` r
carnet <- "^(([1-3][0-9])|(0[1-9])){1}00((11[1-9][0-9])|(1[2-9][0-9][0-9])|([2-7][0-9][0-9][0-9])|(8[0-8][0-9][0-9])|(89[0-6][0-9])|(8970)){1}$"
ejemplo <- c("03001865", "25007770", "01008727","30008970")
validarCarnet <- grep(carnet, ejemplo)
validarCarnet
```

    ## [1] 1 2 3 4

# 5. Palabras

``` r
encuentra <- "^((pit)|(spot)|(spate)|(slap two)|(respite))$"
ejemplo <- c("pit", "part", "spate", "two", "respite", "pt", "Pot", "spot", "slap", "peat", "part")
encuentraPalabras <- grep(encuentra, ejemplo)
encuentraPalabras
```

    ## [1] 1 3 5 8

# 6. números telefónicos de Guatemala

``` r
telefonos <- "^(\\+?(502)( |-))?(2|4|5|6){1}[0-9]{7}$"
ejemplo <- c("+502-21234567", "502 45678901", "+502 51234567", "21234567", "41234567", "51234567", "61234567")
validarNums <- grep(telefonos, ejemplo)
validarNums
```

    ## [1] 1 2 3 4 5 6 7

\#7. Correos UFM

``` r
correos <- "[a-z0-9_]+@ufm.edu"
ejemplo <- c("kath_123@ufm.edu", "toms@ufm.edu", "hello@ufm.edu", "ups@ufm.edu")
validarCorreos <- grep(correos, ejemplo)
validarCorreos
```

    ## [1] 1 2 3 4

# 8. Eurasia, Big Brother

``` r
id <- "[a-z]{0,3}[0-9]{2,9}[A-Z]{3}[A-Z]*$"
ejemplo <- c("z401BKVXXV","aue41047HEZSZLP","bz99LKOKT", "wz7947VGIVMFOXYN", "d16736431VXMWERQL")
validarID <- grep(id, ejemplo)
validarID
```

    ## [1] 1 2 3 4 5
