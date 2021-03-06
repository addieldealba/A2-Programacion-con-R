#Cargamos el DS de NBA en un objeto llamado nba.
nba <- NBA_players_by_season
head(nba)
#Obtener la cantidad de jugadores por nacionalidad.
naciones <- nba %>%
  group_by(Nationality) %>%
  summarize(count=n())
print(naciones)

#Eliminar estados unidos y nulos
naciones <- naciones[-c(1),]
naciones <- naciones[-c(68),]
#Filtrar nacionalidades con menos de 10 jugadores.
naciones <- naciones %>% 
  filter(count > 50)
#Obtener la suma total de los jugadores.
totalPlayers <- sum(naciones$count)
print(totalPlayers)

#Crear una nueva columna con los porcentajes del total de jugadores
naciones$percentage <- (naciones$count * 100)/totalPlayers
label.percentage <- paste(naciones$percentage, '%')

#piechart
ggplot(naciones, aes(x="", y=percentage, fill=Nationality)) +
  geom_bar(stat="identity") +
  coord_polar("y", start = 0) +
    theme(axis.ticks = element_blank(), panel.grid  = element_blank(), axis.text = element_blank()) +
     geom_text(aes(label = paste(round(percentage, digits = 2), '%')), position =  position_stack())

