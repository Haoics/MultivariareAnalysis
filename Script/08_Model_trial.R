data <- rio::import(here::here("Dataset/", "DATA_PG.csv"))

mod.mult <- lm(data = data, wave1_stringency ~ weighted_lr + ICU + 
                  incidence_w1 + debt_share_on_gdp)
summary(mod.mult)

#Incidence Values simulation----
incidence.vals <- seq(from = min(data$incidence_w1, na.rm = TRUE),
                  to = max(data$incidence_w1, na.rm = TRUE),
                  length.out = 1000)

mat.df <- data.frame(weighted_sm = median(data$weighted_sm, na.rm = TRUE),
                     ICU = median(data$ICU, na.rm = TRUE),
                     incidence_w1 = incidence.vals)

preds <- predict(lm(data = data, wave1_stringency ~ weighted_sm + ICU + 
                       incidence_w1 + debt_share_on_gdp),
                 newdata = mat.df,
                 interval = "confidence",
                 level = 0.95 )

plot(incidence.vals,
     preds[, 1],
     type = "l",
     lwd = 2,
     xlab = "Total Incidence",
     ylab = "Predicted Stringecy Index",
     main = "Effect of Incidence on Stringency Index Values",
     ylim = c(min(preds[, 2]),
              max(preds[, 3])
     )
)

lines(incidence.vals,
      preds[, 2],
      lty = 2,
      col = "red"
)

lines(incidence.vals,
      preds[, 3],
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

linear <- lm(data = data, wave1_stringency ~ weighted_lr)
summary(linear)
























