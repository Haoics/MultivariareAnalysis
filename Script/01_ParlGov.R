library(tidyverse)
pgovs <- rio::import(here::here("Dataset/", "cabinet.xlsx"))
party <- rio::import(here::here("Dataset/","party.xlsx"))
#pandemic cabinets----
parl_fil <- pgovs[
      pgovs$cabinet_name == "Conte II" |
      pgovs$cabinet_name == "Merkel V" |
      pgovs$cabinet_name == "Lofven III" |
      pgovs$cabinet_name == "Sanchez III" |
      pgovs$cabinet_name == "Johnson II" |
      pgovs$cabinet_name ==  "Morawiecki II" |
        pgovs$cabinet_name ==  "Wilmes II" | 
        pgovs$cabinet_name ==  "Costa II" |
        pgovs$cabinet_name ==  "Bierlein II" |
        pgovs$cabinet_name ==  "Skvernelis III" |
        pgovs$cabinet_name ==  "Mitsotakis Kyr" |
        pgovs$cabinet_name ==  "Frederiksen" |
        pgovs$cabinet_name ==  "Ratas II" |
        pgovs$cabinet_name ==  "Bettel II" |
        pgovs$cabinet_name ==  "Jansa III" |
        pgovs$cabinet_name ==  "Matovic" |
        pgovs$cabinet_name ==  "Abela" |
        pgovs$cabinet_name ==  "Babis II" |
        pgovs$cabinet_name ==  "Orban IV" |
        pgovs$cabinet_name ==  "Anastasiades IV" |
        pgovs$cabinet_name ==  "Rutte V" |
        pgovs$cabinet_name ==  "Plenkovic II" |
        pgovs$cabinet_name ==  "Borisov III" |
        pgovs$cabinet_name ==  "Philippe II" |
        pgovs$cabinet_name ==  "Varadkar II" |
        pgovs$cabinet_name ==  "Orban II" , ]
        


        
control_party <- parl_fil[parl_fil$cabinet_party ==1,]

unique(control_party$cabinet_party)
str(control_party)
str(party)
#party_short <- party[
    #party$party_name_short == "CDU+CSU" |
    #party$party_name_short == "SPD" |
    #party$party_name_short == "ECP" |
    #party$party_name_short == "EM|GCE" |
    #party$party_name_short == "P" |
    #party$party_name_short == "PSOE" |
    #party$party_name_short == "UP" |
    #party$party_name_short == "Con" |
    #party$party_name_short == "IV" |
    #party$party_name_short == "M5S" |
    #party$party_name_short == "PC" |
    #party$party_name_short == "PD" |
    #party$party_name_short == "S" |
    #party$party_name_short == "MP" |
    #party$party_name_short == "SAP" ,
#]
#Problem resolution----
#M5S
control_party$party_id <- ifelse(control_party$party_name_short == "M5S",  2155, control_party$party_id)
control_party$country_id <- ifelse(control_party$party_name_short == "M5S",  26, control_party$country_id)
control_party$left_right <- ifelse(control_party$party_name_short == "M5S",  4, control_party$left_right)
party$left_right <- ifelse(party$party_name_short == "M5S",  4, party$left_right)
party$state_market <- ifelse(party$party_name_short == "M5S",  4, party$state_market)
party$liberty_authority <- ifelse(party$party_name_short == "M5S",  4, party$liberty_authority)


control_party_clean <- drop_na(control_party)

merged <- merge(party, control_party_clean, id = party_name)


#variables selection----
party_short <- select(merged, country_name_short, country_name, cabinet_name, left_right, 
                      state_market, liberty_authority, seats, election_seats_total )

#calculating seats shares and weighted means----
govs <- party_short %>%  
  group_by(country_name_short) %>% 
  mutate(share_seats = (sum(seats)/election_seats_total*100))

govs <- govs %>%
  group_by(country_name_short) %>% 
  mutate(weighted_lr = weighted.mean(left_right, seats))

govs <- govs %>%
  group_by(country_name_short) %>% 
  mutate(weighted_sm = weighted.mean(state_market, seats))

govs <- govs %>%
  group_by(country_name_short) %>% 
  mutate(weighted_la = weighted.mean(liberty_authority, seats))

is.na(govs)
library(imputeTS)
govs_cl0 <- na_replace(govs, 0)
govs[28, ] <- NA
govs[30, ] <- NA
govs_cl <- drop_na(govs)

#Dataset Unique building
data <- govs_cl %>%
  group_by(country_name_short, cabinet_name) %>%
  slice(1) %>%
  ungroup()





