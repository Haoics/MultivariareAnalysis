library(plm)
library(lubridate)

data <- rio::import(here::here("Dataset/", "PanelSet.csv"))

data <- data[
    data$iso_code != "SVK" &
    data$iso_code != "HUN" &
    data$iso_code != "BGR" &
    data$iso_code != "ROU" ,
]

data <- pdata.frame(data) 

data <- data %>% 
  mutate(date = str_c(data$month, "/", data$year))

data$date <- my(data$date)
data <- arrange(data, by = date)

data <- select(data, date, iso_code, cabinet_name, string_mean, incidence_mean, share_seats,
               weighted_lr, weighted_la, weighted_sm, ICU, debt_share_on_gdp, )
data %>% 
  is.pbalanced()
table(index(data), useNA = "ifany")

pl <- lm(data = data, string_mean ~ weighted_lr + incidence_mean + share_seats + 
    ICU + debt_share_on_gdp, index = c("date", "iso_code"))
summary(pl)
