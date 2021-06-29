setwd("/Users/tomasruzza/Desktop/MultivariareAnalysis/Dataset")
library(tidyverse)
library(lubridate)

parlgov <- rio::import("parlgov.xlsx")

parlgov$start_date <- lubridate::as_date(parlgov$start_date) 

sub2 <- parlgov[
    parlgov$cabinet_name == "Conte II" | 
    parlgov$cabinet_name == "Sanchez III" |
    parlgov$cabinet_name == "Merkel V" |  
    parlgov$cabinet_name == "Lofven III" | 
    parlgov$cabinet_name == "Johnson II",]

cabinet <- sub2[sub2$cabinet_party ==1,]            



  for (i in 1 : length(sub2$cabinet_party)) {
  if (sub2$cabinet_party[i] == 1) {
    seats[i] <- sum(sub2$seats[i])
  } else {
    seats[i] <- 0
  }
}
  seats <- data.frame(seats)
  seats <- sum(seats)
