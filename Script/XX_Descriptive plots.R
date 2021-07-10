library(ggplot2)
install.packages("forcats")

library(forcats)


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
ggplot(data_rebuild, aes(x= reorder(waves, -stringency), y = stringency)) +
  geom_bar(stat="identity") + 
  facet_wrap(~country_name_short)+
  ylab("Strimgency Index") +
  xlab("Waves") +
  theme_bw()

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
                     data = data, weights=wt),
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
icu.vals <- seq(from = min(data$ICU, na.rm = TRUE),
                to = max(data$ICU, na.rm = TRUE),
                length.out = 1000)

mat.df2 <- data.frame(ICU = icu.vals,
                      weighted_lr = median(data$weighted_lr, na.rm = TRUE),
                      incidence_w1 = median(data$incidence_w1, na.rm = TRUE))

preds2 <- predict(lm(data = data, wave1_stringency ~ weighted_lr + ICU + incidence_w1),
                  newdata = mat.df2,
                  interval = "confidence",
                  level = 0.95 )

plot(icu.vals,
     preds2[, 1],
     type = "l",
     lwd = 2,
     xlab = "ICU",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Intensive Care Units number on Stringency Index Values",
     ylim = c(min(preds2[, 2]),
              max(preds2[, 3])
     )
)

lines(icu.vals,
      preds2[, 2],
      lty = 2,
      col = "blue"
)

lines(icu.vals,
      preds2[, 3],
      lty = 2,
      col = "blue"
)

#Left-right vals. simulation----
lr.vals <- seq(from = min(data$weighted_lr, na.rm = TRUE),
               to = max(data$weighted_lr, na.rm = TRUE),
               length.out = 1000)

mat.df3 <- data.frame(ICU = median(data$ICU, na.rm = TRUE) ,
                      weighted_lr = lr.vals ,
                      incidence_w1 = median(data$incidence_w1, na.rm = TRUE))

preds3 <- predict(lm(data = data, wave1_stringency ~ weighted_lr + ICU + incidence_w1),
                  newdata = mat.df3,
                  interval = "confidence",
                  level = 0.95 )

plot(lr.vals,
     preds3[, 1],
     type = "l",
     lwd = 2,
     xlab = "Left Right scale",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Left-Right Scale on Stringency Index Values",
     ylim = c(min(preds2[, 2]),
              max(preds2[, 3])
     )
)

lines(lr.vals,
      preds3[, 2],
      lty = 2,
      col = "red"
)

lines(lr.vals,
      preds3[, 3],
      lty = 2,
      col = "red"
)

#debt simulation----
debt.vals <- seq(from = min(data$debt_share_on_gdp, na.rm = TRUE),
                 to = max(data$debt_share_on_gdp, na.rm = TRUE),
                 length.out = 1000)

mat.df4 <- data.frame(weighted_sm = median(data$weighted_sm, na.rm = TRUE),
                      ICU = median(data$ICU, na.rm = TRUE),
                      incidence_w1 = median(data$incidence_w1, na.rm = TRUE),
                      debt_share_on_gdp = debt.vals)

preds4 <- predict(lm(data = data, wave1_stringency ~ weighted_sm + ICU + 
                       incidence_w1 + debt_share_on_gdp),
                  newdata = mat.df4,
                  interval = "confidence",
                  level = 0.95 )

plot(debt.vals,
     preds4[, 1],
     type = "l",
     lwd = 2,
     xlab = "Total Debt",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Debt share on Stringency Index Values",
     ylim = c(min(preds4[, 2]),
              max(preds4[, 3])
     )
)
lines(debt.vals,
      preds4[, 2],
      lty = 2,
      col = "red"
)

lines(debt.vals,
      preds4[, 3],
      lty = 2,
      col = "red"
)




