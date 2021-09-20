dw-2020-parcial-1
================
KAtherine Garcia - 20190418
9/3/2020

# Examen parcial

Indicaciones generales:

-   Usted tiene el período de la clase para resolver el examen parcial.

-   La entrega del parcial, al igual que las tareas, es por medio de su
    cuenta de github, pegando el link en el portal de MiU.

-   Pueden hacer uso del material del curso e internet (stackoverflow,
    etc.). Sin embargo, si encontramos algún indicio de copia, se
    anulará el exámen para los estudiantes involucrados. Por lo tanto,
    aconsejamos no compartir las agregaciones que generen.

## Sección I: Preguntas teóricas.

-   Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
    deberá responder 5. Las 5 a responder estarán determinadas por un
    muestreo aleatorio basado en su número de carné.

-   Ingrese su número de carné en `set.seed()` y corra el chunk de R
    para determinar cuáles preguntas debe responder.

``` r
set.seed(20190418) 
v<- 1:10
preguntas <-sort(sample(v, size = 5, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 3, 5, 6, 7, 9"

### I. Preguntas teóricas

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

-   Porque el crear un ciclo representa más líneas de código y más
    tiempo de trabajo para un programador. A diferencia de las funciones
    apply que aplican una funcion para cada elemento de una lista.
    Considero que no es por velocidad de ejecución sino por la facidad
    que esta presenta.

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?

-   Para cargar un archivo csv en donde el delimitador es `:` utilizamos
    la función read\_delim de la librería utils de R.

``` r
df <- read_csv("path hacia el .csv")
read_delim("path hacia el .csv", delim = ":") 
```

6.  ¿Qué es un vector y en qué se diferencia en una lista en R?

-   Un vector es un objeto que puede almacenar elementos de un solo
    tipo. Por el lado contrario, una lista puede almacenar diferentes
    tipos de datos.

``` r
vector <- c("hola", "2", "fruta")
lista <- list("Hola", 1010, "Green", 12.2)
```

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

-   Este nuevo elemento afecta todo el factor y deshace todo lo que se
    hizo anteriormente en el factor

``` r
datos = c("fruta", "verdura", "comida", "congelados")
factor1 = factor(datos)
# Lo que no se debe hacer
factor2 <- append(factor1, 22) 
# Lo que se debe hacer 
levels(factor1) <- append(levels(factor1), 22) 
```

``` r
print("FACTOR INICIAL")
```

    ## [1] "FACTOR INICIAL"

``` r
factor1
```

    ## [1] fruta      verdura    comida     congelados
    ## Levels: comida congelados fruta verdura 22

``` r
print("NO HACER")
```

    ## [1] "NO HACER"

``` r
factor2
```

    ## [1]  3  4  1  2 22

``` r
print("HACER")
```

    ## [1] "HACER"

``` r
factor1
```

    ## [1] fruta      verdura    comida     congelados
    ## Levels: comida congelados fruta verdura 22

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

-   Utilizamos `HAVING` en lugar de `WHERE` cuando queremos localizar
    los datos teniendo en cuenta una función como `COUNT`, `SUM`, etc.

``` sql
SELECT edad, COUNT(salario) 
FROM ejemplo 
GROUP BY edad
HAVING COUNT(salario)
```

-   Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
    utilizando como banco las diez acá presentadas?

-   

``` r
N <- 10  
n <- 5 

examenes <- c(1:N)

permutaciones <- combinations(N, n, examenes)
nrow(permutaciones)
```

    ## [1] 252

## Sección II Preguntas prácticas.

## A

A. De los clientes que están en más de un país, ¿cuál cree que es el más
rentable y por qué?

-   El cliente mas rentable es el cliente `a17a7558`. Esto es debido a
    este cliente presenta la mayor cantidad de Ventas y una pequeña
    cantidad de ventas negativas.

Mejores en ventas 1. a17a7558 2. ff122c3f 3. c53868a0

Mejores con ventas negativas 1. c53868a0 2. 044118d4 3. a17a7558

``` r
parcial_anonimo %>%
  select(Cliente, Pais, Venta) %>%
  group_by(Cliente) %>%
  summarise(count = n_distinct(Pais), ventas = sum(Venta)) %>%
  filter(count>1)
```

    ## # A tibble: 7 × 3
    ##   Cliente  count ventas
    ##   <chr>    <int>  <dbl>
    ## 1 044118d4     2  9436.
    ## 2 a17a7558     2 19818.
    ## 3 bf1e94e9     2     0 
    ## 4 c53868a0     2 13813.
    ## 5 f2aab44e     2   400.
    ## 6 f676043b     2  3635.
    ## 7 ff122c3f     2 15359.

``` r
parcial_anonimo %>%
  select(Cliente,Pais,Venta) %>%
  group_by(Cliente) %>%
  filter(Venta<0) %>%
  summarise(ventasNeg = sum(Venta), count = n_distinct(Pais)) %>%
  filter(count>1) 
```

    ## # A tibble: 4 × 3
    ##   Cliente  ventasNeg count
    ##   <chr>        <dbl> <int>
    ## 1 044118d4    -156.      2
    ## 2 a17a7558    -465.      2
    ## 3 c53868a0     -22.4     2
    ## 4 ff122c3f    -695.      2

### Observaciones A

Tengo solo 2 paises y 2147 clientes diferentes. 7 clientes estan en los
dos paises

## B

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

-   Se considera una pérdida considerable si se encuentra en el 75 a
    100% de ventas negativas por territorio. Siendo esta cantidad
    `-748.585`, los principales territorios que quedan para evaluación
    sobre si operar ahí o no son:

1.  f7dfc635
2.  77192d63
3.  72520ba2

``` r
parcial_anonimo %>%
  select(Territorio,Venta) %>%
  group_by(Territorio) %>%
  filter(Venta<0) %>%
  summarise(ventas = sum(Venta)) %>%
  filter(ventas < -748.585) %>%
  arrange(desc(ventas))
```

    ## # A tibble: 20 × 2
    ##    Territorio  ventas
    ##    <chr>        <dbl>
    ##  1 4ca9988b     -758.
    ##  2 23e9d55d     -765.
    ##  3 7a861731     -792.
    ##  4 b97335a1    -1139.
    ##  5 0c169a3b    -1171.
    ##  6 c57e6d42    -1185.
    ##  7 a9e783db    -1189.
    ##  8 fed6647d    -1433.
    ##  9 b50e91fb    -1523.
    ## 10 75298f79    -1568.
    ## 11 a0d39798    -1779.
    ## 12 8f79b7f8    -1858.
    ## 13 67e9cc18    -2721.
    ## 14 2e812869    -3056.
    ## 15 bc8e06ed    -3269.
    ## 16 1d407777    -3300.
    ## 17 69c1b705    -3370.
    ## 18 72520ba2    -3761.
    ## 19 77192d63    -5641.
    ## 20 f7dfc635   -14985.

### Observaciones B

Hay 104 territorios distintos. Hubo un total de ventas negativas de
-67966.3 . El promedio de ventas negativas por territorio es -653.52 .
El cuartil del 75% es de -748.585
