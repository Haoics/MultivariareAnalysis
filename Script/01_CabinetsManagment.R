setwd("/Users/tomasruzza/Desktop/MultivariareAnalysis/Dataset")
library(tidyverse)
parlgov <- rio::import("cabinet.xlsx")
#pandemic cabinets----
parl_fil <- parlgov[
    parlgov$cabinet_name == "Conte II" |
    parlgov$cabinet_name == "Merkel V" |
    parlgov$cabinet_name == "Lofven III" |
    parlgov$cabinet_name == "Sanchez III" |
    parlgov$cabinet_name == "Johnson II",
]
cabs <- parl_fil[parl_fil$cabinet_party == 1,]

#calculating seats shares----


