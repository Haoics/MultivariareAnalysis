library(plm)
library(lubridate)
library(tidyverse)
library(tidyr)

data <- rio::import(here::here("Dataset/", "PanelSet.csv"))

#DF as panel
data <- pdata.frame(data) 

#Date management
data <- data %>% 
  mutate(date = str_c(data$month, "/", data$year))

data$date <- my(data$date)
data <- arrange(data, by = date)

#Add wave categorical variable
data$wave <- ifelse(data$date >= as.Date("2020-03-01") & data$date < as.Date("2020-09-01"), 1,
                    ifelse(data$date >= as.Date("2020-09-01") & data$date < as.Date("2021-03-01"), 2, 3))

data$period <- ifelse(data$date == as.Date("2020-03-01"), 1,
               ifelse(data$date == as.Date("2020-04-01"), 2,
               ifelse(data$date == as.Date("2020-05-01"), 3,
               ifelse(data$date == as.Date("2020-06-01"), 4,
               ifelse(data$date == as.Date("2020-07-01"), 5,
               ifelse(data$date == as.Date("2020-08-01"), 6,
               ifelse(data$date == as.Date("2020-09-01"), 7,
               ifelse(data$date == as.Date("2020-10-01"), 8,
               ifelse(data$date == as.Date("2020-11-01"), 9,
               ifelse(data$date == as.Date("2020-12-01"), 10,
               ifelse(data$date == as.Date("2021-01-01"), 11,
               ifelse(data$date == as.Date("2021-02-01"), 12,
               ifelse(data$date == as.Date("2021-03-01"), 13,
               ifelse(data$date == as.Date("2021-04-01"), 14,
               ifelse(data$date == as.Date("2021-05-01"), 15, 16)))))))))))))))

data.pan <- select(data, period, wave, iso_code, cabinet_name, string_mean, incidence_mean, share_seats,
               weighted_lr, weighted_la, weighted_sm, ICU, debt_share_on_gdp)


data.pan %>% 
  is.pbalanced()

data.pan <- make.pbalanced(data.pan)

table(index(data), useNA = "ifany")


pl <- plm(data = data.pan, string_mean ~ weighted_lr + incidence_mean + share_seats + 
    ICU + debt_share_on_gdp, index = c("period", "wave"))

summary(pl)

a <- c(names(data))
a <- c(a[2:11])

