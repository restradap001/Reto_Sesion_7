library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

# Ahora en RStudio crea un script llamado 'queries.R' en donde se conecte a la BDD 'shinydemo'

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Generar una busqueda con 'dplyr' que devuelva el porcentaje de personas que hablan español en todos los países
dbListTables(MyDataBase)
dbListFields(MyDataBase, 'Country')
dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "SELECT C.Name AS 'Country', CL.* FROM Country C JOIN CountryLanguage CL ON C.Code = CL.CountryCode")
DataDB.SL <- DataDB %>% filter(Language == "Spanish")

# Realizar una gráfica con 'ggplot' que represente este porcentaje de tal modo que en el eje de las _Y_ aparezca el país y en _X_ el porcentaje, y que diferencíe entre aquellos que es su lengua oficial y los que no con diferente color (puedes utilizar la _geom_bin2d()_ y _coord_flip()_)
ggplot(DataDB.SL, aes(x = Percentage, y = Country, colour = IsOfficial)) +
  geom_point() +
  theme_grey() + 
  ggtitle("Gráfico de Dispersión") +
  xlab("Porcentaje") +
  ylab("País")

# Una vez hecho esto hacer el _commit_ y _push_ para mandar tu archivo al repositorio de Github 'Reto_Sesion_7'