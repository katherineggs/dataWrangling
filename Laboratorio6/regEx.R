
# 1. Genere una regEx que sea capaz de detectar las placas de un vehículo particular guatemalteco.
placas <- "P [0 - 9] {3} [A - Z] {3}"

# 2. Genere una regEx que valide si un archivo es de tipo .pdf o jpg.
archivo <- "[A - Z a - z 0 - 9 _ $ ]+ . ( pdf | jpg )"

# 3. Genere una regEx para validar contraseñas de correo. ----- REVISAR
pw <- "[A - Z a - z 0 - 9 $%#_] {8} [A - Z]+ [ $ % # & _ ]+"

# 4. Cree una regEx para validar un numero de carnet de la Universidad Galileo
carnet <- "^(([1-3][0-9])|(0[1-9])){1}00((11[1-9][0-9])|(1[2-9][0-9][0-9])|([2-7][0-9][0-9][0-9])|(8[0-8][0-9][0-9])|(89[0-6][0-9])|(8970)){1}$"

# 5. Cree una regEx que encuentre todas las palabras de la primera línea, pero ninguna de la segunda.
# a. pit, spot, spate, slap two, respite
# b. pt,Pot,peat,part
encuentra <- ""

# 6. Cree una regEx para obtener los números telefónicos de Guatemala. 
num <- "+? (502)? (' '| - )? (2 | 4 | 5 | 6){1} [0 - 9]{7}"

# 7. Genere una expresión regular que sea capaz de obtener correos de la UFM.
correos <- "[a-z 0-9 _]+ @ ufm.edu"

# 8. Genere una expresión regular que valide las identificaciones. Eurasia, Big Brother 
id <- "[a-z]{0,3}[0-9]{2-9}[A-Z]{3}[A-Z]*$"




