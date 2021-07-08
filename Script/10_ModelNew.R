#10 new model

data <- rio::import(here::here("Dataset/", "Data_new.csv"))

data$waves <- as.factor(data$waves)
data$country_name_short <- as.factor(data$country_name_short)

#ols----
lpm <- lm(stringency ~ waves + weighted_lr + share_seats + ICU + debt_share_on_gdp + incidence,
          data = data
)
summary(lpm)

library(lmtest)
bptest(lpm)


b <- lpm$coef
u <- lpm$resid

fit <- lpm$fitted.values

sum(u)

plot(fit,
     u,
     pch = 19,
     col = "darkblue",
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Plot of Residual Variance"
)

#wls----
#we have detected heterosckedasticity in the model, therefore we perform a 
# weighted least square model to keep under control the weights of the obs.


#define weights to use
wt <- 1 / lm(abs(lpm$residuals) ~ lpm$fitted.values)$fitted.values^2
#perform weighted least squares regression
wls_model <- lm(stringency ~ waves + weighted_lr + share_seats + ICU + 
                debt_share_on_gdp + incidence,
                data = data, weights=wt)
#view summary of model
summary(wls_model)

b <- wls_model$coefficients
u <- wls_model$residuals
wlsfit <- wls_model$fitted.values
plot(wls_model)

plot(wlsfit,
     u,
     pch = 19,
     col = "darkblue",
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Plot of Residual Variance"
)

install.packages("olsrr")
library(olsrr)

bptest(lpm)
car::ncvTest(lpm)
ols_test_breusch_pagan(lpm)







