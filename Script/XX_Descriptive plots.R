library(ggplot2)
install.packages("forcats")

library(forcats)


data_rebuild$debt_share_on_gdp <- as.numeric(data_rebuild$debt_share_on_gdp)
#scatterplot of incidence and stringency
ggplot(data_rebuild, aes(x=incidence_c, y=stringency, group = country_name_short)) + geom_point() + facet_wrap(~waves) + theme_bw()

#showing incidences
#ggplot(data_rebuild, aes(x = reorder(country_name_short, incidence_c, function(x) mean(x, na.rm = T)), y = incidence_c)) +
 # geom_violin(fill = "gray50", trim = F, scale = "width") +
  #facet_wrap(~waves)+
 # geom_boxplot(fill = "white", width = 0.2) +
 # coord_flip() +
 # ylab("Incidence of the virus") +
 # xlab("Country") +
 # theme_bw()

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
#ggplot(data_rebuild, aes(x= reorder(waves, -stringency), y = stringency)) +
  #geom_bar(stat="identity") + 
  #facet_wrap(~country_name_short)+
 # ylab("Strimgency Index") +
 # xlab("Waves") +
 # theme_bw()

##incidence by country and wave
#ggplot(data_rebuild, aes(x= reorder(waves, -incidence_c), y = incidence_c)) +
 # geom_bar(stat="identity", color = "light blue", fill = "light blue") + 
  #facet_wrap(~country_name_short)+
  #ylab("Incidence") +
  #xlab("Waves") +
  #theme_bw()


##majority share
ggplot(data_main, aes(x=reorder(country_name_short, share_seats), y = share_seats))+
  geom_bar(stat="identity", color='black',fill='orange') + 
  ylab("Percentage of seats") +
  xlab("Country") +
  theme_bw()

##preds plot

data <- rio::import(here::here("Dataset/", "Data_new.csv"))
View(data)
#Incidence Values simulation----

#wls_model <- lm(stringency ~ waves + weighted_lr + share_seats + ICU + 
                  #debt_share_on_gdp + incidence_c,
               # data = data, weights=wt)

incidence.values <- seq(from = min(data$incidence_c, na.rm = TRUE),
                      to = max(data$incidence_c, na.rm = TRUE),
                      length.out = 1000)



##icu and incidence

matr.df <- data.frame(weighted_lr = median(data$weighted_lr, na.rm = TRUE),
                     ICU = median(data$ICU, na.rm = TRUE),
                     incidence_c = incidence.values,
                     share_seats = median(data$share_seats, na.rm = TRUE),
                     debt_share_on_gdp = median(data$debt_share_on_gdp, na.rm = TRUE)
                       )

preds.v <- predict(lm(stringency ~ weighted_lr + share_seats + ICU + 
                     debt_share_on_gdp + incidence_c,
                     data = data,),
                 newdata = matr.df,
                 interval = "confidence",
                 level = 0.95 )

plot(incidence.values,
     preds.v[, 1],
     type = "l",
     lwd = 2,
     xlab = "Total Incidence",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Incidence on Stringency Index Values",
     ylim = c(min(preds.v[, 2]),
              max(preds.v[, 3])
     )
)

lines(incidence.values,
      preds.v[, 2],
      lty = 2,
      col = "red"
)

lines(incidence.values,
      preds.v[, 3],
      lty = 2,
      col = "red"
)

#ICU vals. simulation----
icu.values <- seq(from = min(data$ICU, na.rm = TRUE),
                to = max(data$ICU, na.rm = TRUE),
                length.out = 1000)

matr.df2 <- data.frame(ICU = icu.values,
                      weighted_lr = median(data$weighted_lr, na.rm = TRUE),
                      incidence_c = median(data$incidence_c, na.rm = TRUE),
                      share_seats = median(data$share_seats, na.rm = TRUE),
                      debt_share_on_gdp = median(data$debt_share_on_gdp, na.rm = TRUE))

preds2.v <- predict(lm(stringency ~ weighted_lr + share_seats + ICU + 
                       debt_share_on_gdp + incidence_c,
                     data = data),
                  newdata = matr.df2,
                  interval = "confidence",
                  level = 0.95 )

plot(icu.values,
     preds2.v[, 1],
     type = "l",
     lwd = 2,
     xlab = "ICU",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Intensive Care Units number on Stringency Index Values",
     ylim = c(min(preds2.v[, 2]),
              max(preds2.v[, 3])
     )
)

lines(icu.values,
      preds2.v[, 2],
      lty = 2,
      col = "blue"
)

lines(icu.values,
      preds2.v[, 3],
      lty = 2,
      col = "blue"
)

#Left-right vals. simulation----
lr.values <- seq(from = min(data$weighted_lr, na.rm = TRUE),
               to = max(data$weighted_lr, na.rm = TRUE),
               length.out = 1000)

matr.df3 <- data.frame(ICU = median(data$ICU, na.rm = TRUE) ,
                      weighted_lr = lr.values ,
                      incidence_c = median(data$incidence_c, na.rm = TRUE),
                      share_seats = median(data$share_seats, na.rm = TRUE),
                      debt_share_on_gdp = median(data$debt_share_on_gdp, na.rm = TRUE))

preds3.v <- predict(lm(stringency ~ weighted_lr + share_seats + ICU + 
                         debt_share_on_gdp + incidence_c,
                       data = data),
                  newdata = matr.df3,
                  interval = "confidence",
                  level = 0.95 )

plot(lr.values,
     preds3.v[, 1],
     type = "l",
     lwd = 2,
     xlab = "Left Right scale",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Left-Right Scale on Stringency Index Values",
     ylim = c(min(preds3.v[, 2]),
              max(preds3.v[, 3])
     )
)

lines(lr.values,
      preds3.v[, 2],
      lty = 2,
      col = "red"
)

lines(lr.values,
      preds3.v[, 3],
      lty = 2,
      col = "red"
)

#debt simulation----
debt.values <- seq(from = min(data$debt_share_on_gdp, na.rm = TRUE),
                 to = max(data$debt_share_on_gdp, na.rm = TRUE),
                 length.out = 1000)

matr.df4 <- data.frame(weighted_sm = median(data$weighted_sm, na.rm = TRUE),
                      ICU = median(data$ICU, na.rm = TRUE),
                      incidence_c = median(data$incidence_c, na.rm = TRUE),
                      share_seats = median(data$share_seats, na.rm = TRUE),
                      debt_share_on_gdp = debt.values)

preds4.v <- predict(lm(data = data, stringency ~ weighted_sm + ICU + 
                       incidence_c + debt_share_on_gdp),
                  newdata = matr.df4,
                  interval = "confidence",
                  level = 0.95 )

plot(debt.values,
     preds4.v[, 1],
     type = "l",
     lwd = 2,
     xlab = "Total Debt",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Debt share on Stringency Index Values",
     ylim = c(min(preds4.v[, 2]),
              max(preds4.v[, 3])
     )
)
lines(debt.values,
      preds4.v[, 2],
      lty = 2,
      col = "red"
)

lines(debt.values,
      preds4.v[, 3],
      lty = 2,
      col = "red"
)


#indidences in the countries
data <- rio::import(here::here("Dataset/", "PanelSet.csv"))

is.numeric(data$incidence_mean)

ggplot(data, aes(x= reorder(iso_code, -incidence_mean), y = incidence_mean)) +
 geom_bar(stat="identity", color = "light blue", fill = "light blue") + 
ylab("Incidence Index") +
xlab("Country") +
theme_bw()

##stringencies in the country, again.
is.numeric(data$string_mean)
ggplot(data, aes(x= reorder(iso_code, -string_mean), y = string_mean)) +
  geom_bar(stat="identity", color = "dark blue", fill = "dark blue") + 
  ylab("Stringency Index") +
  xlab("Country") +
  theme_bw()

##time series stringency
data_str<-rio::import(here::here("Dataset/", "PanelPlot.csv"))

##facet strincencies over months in european countries
ggplot(data_str, aes(x= period, y = string_mean, group = iso_code)) +
  geom_line() + facet_wrap(~iso_code, ncol = 5)


## heatmap strincency for countries
ggplot(filter(data_str, !is.na(string_mean)), 
       aes(x = period, y = reorder(iso_code, string_mean, function(x) mean(x, na.rm = T)))) +
  geom_tile(aes(fill = string_mean)) +
  scale_fill_gradient(low = "green", high = "red", "Stringency Index") +
  ylab("") +
  xlab("Monthly Stringency Index") +
  ggtitle("Stringency Index in European Countries from March 2020 to June 2021")

##facet incidences over months in european countries
ggplot(data_str, aes(x= period, y = incidence_mean, group = iso_code)) +
  geom_line() + facet_wrap(~iso_code, ncol = 5)


summary(data_rebuild)



