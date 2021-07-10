library(ggplot2)
install.packages("forcats")

library(forcats)


#scatterplot of incidence and stringency
ggplot(data_rebuild, aes(x=stringency, y=incidence_c, group = country_name_short)) + geom_point() + facet_wrap(~waves) + theme_bw()

#showing incidences
ggplot(data_rebuild, aes(x = reorder(country_name_short, incidence_c, function(x) mean(x, na.rm = T)), y = incidence_c)) +
  geom_violin(fill = "gray50", trim = F, scale = "width") +
  facet_wrap(~waves)+
  geom_boxplot(fill = "white", width = 0.2) +
  coord_flip() +
  ylab("Incidence of the virus") +
  xlab("Country") +
  theme_bw()

#showing stringencies
ggplot(data_rebuild, aes(x = reorder(country_name_short, stringency, function(x) mean(x, na.rm = T)), y = stringency)) +
  geom_violin(fill = "gray50", trim = F, scale = "width") +
  facet_wrap(~waves)+
  geom_boxplot(fill = "white", width = 0.2) +
  coord_flip() +
  ylab("Stringency Index") +
  xlab("Country") +
  theme_bw()


##debito

is.numeric(data_main$debt_share_on_gdp)
data_main$debt_share_on_gdp<-as.numeric(data_main$debt_share_on_gdp)

ggplot(data_main, aes(x= reorder(country_name_short, -debt_share_on_gdp), y = debt_share_on_gdp)) +
  geom_bar(stat="identity", color='skyblue',fill='steelblue') + 
  ylab("Percentage of Debt on GDP") +
  xlab("Country") +
  theme_bw()


##numero icu
is.numeric(data_main$ICU)

ggplot(data_main, aes(x= reorder(country_name_short, -ICU), y = ICU)) +
  geom_bar(stat="identity", color='black',fill='dark red') + 
  ylab("Number of ICU") +
  xlab("Country") +
  theme_bw()

##LR Scales pgov
is.numeric(data_main$weighted_lr)

ggplot(data_main, aes(x= reorder(country_name_short, weighted_lr), y = weighted_lr)) +
  geom_bar(stat="identity", color='black',fill='yellow') + 
  ylab("Left Right scale") +
  xlab("Country") +
  theme_bw()

#SM SCALE pgov
ggplot(data_main, aes(x= reorder(country_name_short, weighted_sm), y = weighted_sm)) +
  geom_bar(stat="identity", color='black',fill='light blue') + 
  ylab("State Market scale") +
  xlab("Country") +
  theme_bw()

##LA SCALE pgov
ggplot(data_main, aes(x= reorder(country_name_short, weighted_la), y = weighted_la)) +
  geom_bar(stat="identity", color='black',fill='orange') + 
  ylab("Liberty Authority scale") +
  xlab("Country") +
  theme_bw()


##stringencies by country and wave
ggplot(data_rebuild, aes(x= reorder(waves, -stringency), y = stringency)) +
  geom_bar(stat="identity") + 
  facet_wrap(~country_name_short)+
  ylab("Strimgency Index") +
  xlab("Waves") +
  theme_bw()

##incidence by country and wave
ggplot(data_rebuild, aes(x= reorder(waves, -incidence_c), y = incidence_c)) +
  geom_bar(stat="identity", color = "light blue", fill = "light blue") + 
  facet_wrap(~country_name_short)+
  ylab("Incidence") +
  xlab("Waves") +
  theme_bw()


##seggi maggioranza
ggplot(data_main, aes(x=reorder(country_name_short, share_seats), y = share_seats))+
  geom_bar(stat="identity", color='black',fill='orange') + 
  ylab("Percentage of seats") +
  xlab("Country") +
  theme_bw()




