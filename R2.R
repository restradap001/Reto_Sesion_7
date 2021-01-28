library(rvest)

# De la siguiente direcciÃ³n donde se muestran los sueldos para _Data Scientists_ 

# (https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), realiza las siguientes acciones:

# Extraer la tabla del HTML
file <- read_html("https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm")
tables <- html_nodes(file, "table")
table <- na.omit(as.data.frame(html_table(tables[1], fill = TRUE)))

# Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea número), para dejar solamente la cantidad mensual (Hint: la función 'gsub' podría ser de utilidad)
table$Sueldo <- gsub(pattern = "\\D", x = table$Sueldo, replacement = "")

# Asignar ésta columna como tipo numérico para poder realizar operaciones con ella
table$Sueldo <- as.numeric(table$Sueldo)

# Ahora podrás responder esta pregunta, ¿Cuál es la empresa que más paga y la que menos paga?
table$Cargo[which.max(x = table$Sueldo)]
table$Cargo[which.min(x = table$Sueldo)]
