data <- rio::import(here::here("Dataset/", "DATA_PG.csv"))

mod.mult <- lm(data = data, wave1_stringency ~ weighted_sm + ICU + incidence_w1)
summary(mod.mult)

incidence.vals <- seq(from = min(data$incidence_w1, na.rm = TRUE),
                  to = max(data$incidence_w1, na.rm = TRUE),
                  length.out = 1000)

mat.df <- data.frame(weighted_sm = median(data$weighted_sm, na.rm = TRUE),
                     ICU = median(data$ICU, na.rm = TRUE),
                     incidence_w1 = incidence.vals)

preds <- predict(lm(data = data, wave1_stringency ~ weighted_sm + ICU + incidence_w1),
                 newdata = mat.df,
                 interval = "confidence",
                 level = 0.95 )

plot(incidence.vals,
     preds[, 1],
     type = "l",
     lwd = 2,
     xlab = "Total Incidence",
     ylab = "Predicted CINC Score",
     main = "Effect of Incidence on Stringency Index",
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


